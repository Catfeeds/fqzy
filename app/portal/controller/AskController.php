<?php
/*
 * 题目相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/15 17:41
 */
namespace app\portal\controller;

use app\portal\model\AskAnalysisModel;
use app\portal\model\AskModel;
use app\portal\model\AskOptionModel;
use app\portal\model\AskStatusModel;
use app\portal\model\ErrorAskModel;
use app\portal\model\PortalCategoryModel;
use app\portal\model\UserAskModel;
use app\portal\model\UserCollectionModel;
use app\portal\model\UserDoaskDetailModel;
use app\portal\model\UserDoaskModel;
use app\portal\model\UserExamDetailModel;
use app\portal\model\UserExamModel;
use app\portal\model\UsersModel;
use app\portal\service\AskService;
use cmf\controller\HomeBaseController;
use think\console\output\Ask;
use think\Db;
use think\Loader;

/**
 * @title 题目相关
 * @description 项目所有与题目相关内容
 * 9f3073d844d0016b051c076ee62f6e36f9026609309cb4e7624f6926b7a8963d
 */

class AskController extends HomeBaseController
{
    /**
     * @title 反馈新题
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Ask/uask
     * @method POST
     * @param name: ken type:string require:1 default: false other: desc:token
     * @param name:cate_id type:int require:1 default: false other: desc:分类id，类型返回的id
     * @param name:ask_content type:string require:1 default: false other: desc:问题
     * @param name:right_option type:string require:1 default: false other: desc:正确答案
     * @param name:one_option type:string require:1 default: false other: desc:答案1
     * @param name:two_option type:string require:1 default: false other: desc:答案2
     * @param name:analysis_content type:string require:0 default: false other: desc:解析
     */
    public function uask()
    {
        $post = $this->request->param();
        $user_ask = new UserAskModel();
        $post['user_id'] = $this->tokenToUid($post['token']);
        $post['create_time'] = date('Y-m-d H:i:s');
        unset($post['token']);
        $validate = Loader::validate('UserAsk');
        if(!$validate->check($post)){
            $this->apiResponse(0,$validate->getError(),'');
        }
        $res = $user_ask->insert($post);
        if($res){
            $this->apiResponse(1,'提交成功','');
        }
    }

    /**
     * @title 首次答题/重新答题（平时练习）
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Ask/beginAsk
     * @method POST
     * @param name:cate_id type:int require:1 default: false other: desc:二级分类id
     * @param name:token type:string require:1 default: false other: desc:token
     */
    public function beginAsk()
    {
        $token = $this->request->param('token', '');
        $cate_id = $this->request->param('cate_id','','intval');//题目所在分类id
        $ask = new AskModel();
        $this->isEmptyArray([
            'token' => $token,
            'cate' => $cate_id
        ]);
        $user_id = $this->tokenToUid($token);
        //添加用户答题记录,如果已有则结束重新添加,$add_doask是新添加的user_doask表的id
        $add_doask = AskService::addDoAsk($cate_id,$user_id);
        $info = $ask->where('cate_id',$cate_id)->order('sort ASC,id ASC')->find();
        if(empty($info)){
            $this->apiResponse(0,'没有上传题目','');
        }
        //查询下一题id
        $info['next_id'] = AskService::nextAskId($cate_id,$info['id']);
        //查询上一题
        $info['last_id'] = AskService::lastAskId($cate_id,$info['id']);
        //查询此题是否被收藏
        $info['is_collection'] = AskService::isCollection($user_id,$info['id']);
        //获取整个题目详细信息
        $info = AskService::askDetail($info);
        /*新加记录，标记为没有做过该题*/
        $info['doinfo']['is_do'] = 0;
        /*获取该题库下的所有题目数量，以及用户答过的题目的数量*/
        $info['need_num'] = AskService::getNeedNum($cate_id,$add_doask['id']);
        $this->apiResponse(1,'获取第一题成功',$info);
    }

    /**
     * @title 继续答题（平时练习）
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Ask/againBeginAsk
     * @method POST
     * @param name:cate_id type:int require:1 default: false other: desc:分类id
     * @param name:token type:string require:1 default: false other: desc:token
     */
    public function againBeginAsk()
    {
        $cate_id = $this->request->param('cate_id','','intval');//题目所在分类id
        $token = $this->request->param('token','');
        $is_end = $this->request->param('is_end',0,'intval');
        $ask = new AskModel();
        $user_doask = new UserDoaskModel();
        $this->isEmptyArray([
            'cate_id' => $cate_id,
            'token' => $token
        ]);
        $user_id = $this->tokenToUid($token);
        /*用户未答完的答题记录*/
        $user_doask_info = $user_doask
            ->where(['user_id' => $user_id, 'cate_id' => $cate_id, 'is_end' => $is_end])
            ->order('id DESC')
            ->find();
        /*查询下一题的id（最近的没做的那道题）*/
        $ask_id = AskService::getNearAskid($user_id,$cate_id,$is_end);
        if(!$ask_id){
            $user_doask->where('id',$user_doask_info['id'])->data([
                'is_end' => 1,
                'end_time' => date('Y-m-d H:i:s')
            ])->update();
            $this->apiResponse(0,'已全部做完，请返回重做');
        }
        /*查询题目*/
        $info = $ask->where('id',$ask_id)->find();
        if(empty($info)){
            $this->apiResponse(0,'没有更多题目了','');
        }
        //查询下一题id
        $info['next_id'] = AskService::nextAskId($cate_id,$info['id']);
        //查询上一题
        $info['last_id'] = AskService::lastAskId($cate_id,$info['id']);
        //查询此题是否被收藏
        $info['is_collection'] = AskService::isCollection($user_id,$info['id']);
        //获取整个题目详细信息
        $info = AskService::askDetail($info);
        /*继续答的是没做过的题，所以都为0*/
        $info['doinfo']['is_do'] = 0;
        /*获取该题库下的所有题目数量，以及用户答过的题目的数量*/
        $info['need_num'] = AskService::getNeedNum($cate_id,$user_doask_info['id']);
        $this->apiResponse(1,'获取此题目成功',$info);
    }

    /**
     * @title 查看记录（平时练习）
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Ask/lookRecord
     * @method POST
     * @param name:cate_id type:int require:1 default: false other: desc:分类id
     * @param name:token type:string require:1 default: false other: desc:token
     */
    public function lookRecord()
    {
        $cate_id = $this->request->param('cate_id','','intval');//题目所在分类id
        $token = $this->request->param('token','');
        $is_end = $this->request->param('is_end',1,'intval');
        $ask = new AskModel();
        $user_doask = new UserDoaskModel();
        $user_doask_detail = new UserDoaskDetailModel();
        $this->isEmptyArray([
            'cate_id' => $cate_id,
            'token' => $token,
            'is_end' => $is_end
        ]);
        $user_id = $this->tokenToUid($token);
        /*用户答完的答题记录*/
        $user_doask_info = $user_doask
            ->where(['user_id' => $user_id, 'cate_id' => $cate_id, 'is_end' => $is_end])
            ->order('id DESC')
            ->find();
        if(empty($user_doask_info)){
            $this->apiResponse(0,'无记录可查看');
        }
        //最后一次答的题目
        $user_doask_detail_info = $user_doask_detail
            ->where('doask_id',$user_doask_info['id'])
            ->order('ask_id ASC')
            ->find();

        //查询题目
        $info = $ask->where('id',$user_doask_detail_info['ask_id'])->find();
        if(empty($info)){
            $this->apiResponse(0,'没有更多题目了','');
        }
        //查询下一题id
        $info['next_id'] = AskService::nextAskId($cate_id,$info['id']);
        //查询上一题
        $info['last_id'] = AskService::lastAskId($cate_id,$info['id']);
        //查询此题是否被收藏
        $info['is_collection'] = AskService::isCollection($user_id,$info['id']);
        /*查询该题目是否做过*/
        $info['doinfo'] = AskService::isDoAsk($info['id'],$user_doask_info['id']);
        //获取整个题目详细信息
        $info = AskService::askDetail($info);
        /*获取该题库下的所有题目数量，以及用户答过的题目的数量*/
        $info['need_num'] = AskService::getNeedNum($cate_id,$user_doask_info['id']);
        $this->apiResponse(1,'获取此题目成功',$info);
    }

    /**
     * @title 记录用户答过的题目（平时练习）
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Ask/recordAsk
     * @method POST
     * @param name:cate_id type:int require:1 default: false other: desc:分类id(beginAsk返回的cate_id)
     * @param name:token type:string require:1 default: false other: desc:token
     * @param name:id type:int require:1 default: false other: desc:题目id(beginAsk返回的id)
     * @param name:right_option_id type:int require:1 default: false other: desc:正确答案(beginAsk返回的option_id)
     * @param name:user_option_id type:int require:1 default: false other: desc:用户答案
     */
    public function recordAsk()
    {
        $token = $this->request->param('token', '');
        $id = $this->request->param('id','','intval');//题目id
        $right_option_id = $this->request->param('right_option_id','','intval');//正确答案
        $user_option_id = $this->request->param('user_option_id','','intval');//用户答案
        $cate_id = $this->request->param('cate_id','','intval');//题目分类
        $user_doask = new UserDoaskModel();
        $user_doask_detail = new UserDoaskDetailModel();
        $this->isEmptyArray([
            'token' => $token,
            'id' => $id,
            'right_option_id' => $right_option_id,
            'user_option_id' => $user_option_id,
            'cate_id' => $cate_id,
        ]);
        $user_id = $this->tokenToUid($token);
        $doask_id = $user_doask
            ->where(['user_id' => $user_id, 'cate_id' => $cate_id, 'is_end' => 0])
            ->order('id DESC')
            ->value('id');
        if($right_option_id == $user_option_id){
            $is_right = 1;
        }else{
            $is_right = 0;
        }
        $info = $user_doask_detail->where([
            'doask_id' => $doask_id,
            'ask_id' => $id,
        ])->find();
        if($info){
            $this->apiResponse(0,'此题已做记录','');
        }
        $res = $user_doask_detail->insert([
            'doask_id' => $doask_id,
            'ask_id' => $id,
            'right_option_id' => $right_option_id,
            'user_option_id' => $user_option_id,
            'is_right' => $is_right,
            'create_time' => date('Y-m-d H:i:s')
        ]);
        if($res){
            $this->apiResponse(1,'记录成功','');
        }
        $this->apiResponse(0,'记录失败','');
    }

    /**
     * @title 获取题目（平时练习）
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Ask/getAsk
     * @method POST
     * @param name:token type:string require:1 default: false other: desc:token
     * @param name:cate_id type:int require:1 default: false other: desc:分类id（第一次为beginAsk返回的cate_id,再次为本接口返回的cate_id）
     * @param name:id type:int require:1 default: false other: desc:题目id（第一次为beginAsk返回的next_id/last_id,再次为本接口返回的next_id/last_id）
     */
    public function getAsk()
    {
        $token = $this->request->param('token', '9f3073d844d0016b051c076ee62f6e36f9026609309cb4e7624f6926b7a8963d');
        $user_id = $this->tokenToUid($token);
        $cate_id = $this->request->param('cate_id','','intval');//题目所在分类id
        $id = $this->request->param('id','','intval');//题目id
        $ask = new AskModel();
        $user_doask = new UserDoaskModel();
        $this->isEmptyArray([
            'cate_id' => $cate_id,
            'id' => $id
        ]);
        //查询题目
        $info = $ask->where('id',$id)->find();
        if(empty($info)){
            $this->apiResponse(0,'没有更多题目了','');
        }
        //查询下一题id
        $info['next_id'] = AskService::nextAskId($cate_id,$info['id']);
        //查询上一题
        $info['last_id'] = AskService::lastAskId($cate_id,$info['id']);
        //查询此题是否被收藏
        $info['is_collection'] = AskService::isCollection($user_id,$id);
        /*查询该题目是否做过*/
        $doask_id = $user_doask
            ->where(['user_id' => $user_id, 'cate_id' => $cate_id])
            ->order('id DESC')
            ->value('id');
        $info['doinfo'] = AskService::isDoAsk($id,$doask_id);
        /*获取整个题目详细信息*/
        $info = AskService::askDetail($info);
        /*获取该题库下的所有题目数量，以及用户答过的题目的数量*/
        $info['need_num'] = AskService::getNeedNum($cate_id,$doask_id);
        $this->apiResponse(1,'获取此题目成功',$info);
    }

    /**
     * @title 用户答完回调（平时练习）
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Ask/finishAsk
     * @method POST
     * @param name:token type:string require:1 default: false other: desc:token
     * @param name:cate_id type:int require:1 default: false other: desc:分类id
     */
    public function finishAsk()
    {
        $token = $this->request->param('token', '');
        $cate_id = $this->request->param('cate_id','','intval');//题目分类
        $user_doask = new UserDoaskModel();
        $this->isEmptyArray([
            'token' => $token,
            'cate_id' => $cate_id
        ]);
        $user_id = $this->tokenToUid($token);
        $doask_id = $user_doask
            ->where(['user_id' => $user_id, 'cate_id' => $cate_id, 'is_end' => 0])
            ->order('id DESC')
            ->value('id');
        $res = $user_doask->where('id',$doask_id)->data([
            'is_end' => 1,
            'end_time' => date('Y-m-d H:i:s')
        ])->update();
        if($res){
            $this->apiResponse(1,'执行成功','');
        }
        $this->apiResponse(0,'执行失败','');
    }

    /**
     * @title 收藏/取消
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Ask/collection
     * @method POST
     * @param name:token type:string require:1 default: false other: desc:token
     * @param name:cate_id type:int require:1 default: false other: desc:一级分类id
     * @param name:id type:int require:1 default: false other: desc:题目id
     */
    public function collection()
    {
        $token = $this->request->param('token','');
        $cate_id = $this->request->param('cate_id','','intval');
        $id = $this->request->param('id','','intval');
        $cate = new PortalCategoryModel();
        $user_collection = new UserCollectionModel();
        $this->isEmptyArray([
            'token' => $token,
            'cate_id' => $cate_id,
            'id' => $id
        ]);
        $cate_info = $cate->where('id',$cate_id)->find();
        if($cate_info['parent_id'] != 0){
            $this->apiResponse(0,'CATE_ID非法');
        }
        $user_id = $this->tokenToUid($token);
        $info = $user_collection->where([
            'user_id' => $user_id,
            'cate_id' => $cate_id,
            'ask_id' => $id
        ])->find();
        if($info){
            //取消收藏
            $res = $user_collection->where('id',$info['id'])->delete();
            if($res){
                $this->apiResponse(2,'取消收藏成功','');
            }
        }else{
            //收藏
            $res = $user_collection->insert([
                'user_id' => $user_id,
                'cate_id' => $cate_id,
                'ask_id' => $id,
                'create_time' => date('Y-m-d H:i:s')
            ]);
            if($res){
                $this->apiResponse(1,'收藏成功','');
            }
        }
    }

    /**
     * @title 纠错
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Ask/collectionError
     * @method POST
     * @param name:token type:string require:1 default: false other: desc:token
     * @param name:id type:int require:1 default: false other: desc:题目id
     * @param name:error_content type:string require:1 default: false other: desc:错误内容
     */
    public function collectionError()
    {
        $post = $this->request->param();
        $error_ask = new ErrorAskModel();
        $this->isEmpty($post['token'],'TOKEN');
        $this->isEmpty($post['id'],'ID');
        $this->isEmpty($post['error_content'],'ERROR_CONTENT');
        $user_id = $this->tokenToUid($post['token']);
        $res = $error_ask->insert([
            'user_id' => $user_id,
            'ask_id' => $post['id'],
            'error_content' => $post['error_content'],
            'create_time' => date('Y-m-d H:i:s')
        ]);
        if($res){
            $this->apiResponse(1,'执行成功','');
        }
    }

    /**
     * @title 查看我的收藏
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Ask/myCollection
     * @method POST
     * @param name:cate_id type:int require:1 default: false other: desc:分类id(一级)
     * @param name:token type:string require:1 default: false other: desc:token
     * @param name:id type:int require:0 default: false other: desc:收藏表id,再次调用此接口使用
     */
    public function myCollection()
    {
        $post = $this->request->param();
        $ask = new AskModel();
        $user_collection = new UserCollectionModel();
        $this->isEmptyArray([
            'cate_id' => $post['cate_id'],
            'token' => $post['token'],
        ]);
        $user_id = $this->tokenToUid($post['token']);

        if(empty($post['id'])){
            //收藏表信息
            $info = $user_collection
                ->where(['user_id'=>$user_id,'cate_id'=>$post['cate_id']])
                ->order('id DESC')
                ->find();
        }else{
            //收藏表信息
            $info = $user_collection->where(['id'=>$post['id']])->find();
        }
        if(empty($info)){
            $this->apiResponse(1,'暂无收藏','');
        }
        //题目信息
        $askinfo = $ask->where('id',$info['ask_id'])->find();
        //下一题，上一题id，多少题，第几题处理
        $askinfo = AskService::collectionHandle($askinfo,$info['id'],$user_id,$post['cate_id']);
        //获取整个题目详细信息
        $askinfo = AskService::askDetail($askinfo);
        $this->apiResponse(1,'获取此题目成功',$askinfo);
    }

    /**
     * @title 计算结果(平时练习)
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Ask/getResult
     * @method POST
     * @param name:token type:string require:1 default: false other: desc:token
     * @param name:cate_id type:int require:1 default: false other: desc:分类id
     */
    public function getResult()
    {
        $post = $this->request->param();
        $user = new UsersModel();
        $user_doask = new UserDoaskModel();
        $user_doask_detail = new UserDoaskDetailModel();
        $cate = new PortalCategoryModel();
        $this->isEmptyArray([
            'token' => $post['token'],
            'cate_id' => $post['cate_id']
        ]);
        $user_id = $this->tokenToUid($post['token']);
        $doask_id = $user_doask
            ->where(['user_id' => $user_id, 'cate_id' => $post['cate_id']])
            ->order('id DESC')
            ->value('id');
        if(empty($doask_id)){
            $this->apiResponse(0,'ERROR','');
        }
        //题目数量
        $info['total_ask_num'] = $user_doask_detail->where('doask_id',$doask_id)->count();
        //对的题的数量
        $info['right_ask_num'] = $user_doask_detail->where(['doask_id' => $doask_id,'is_right' => 1])->count();
        //错题数量
        $info['error_ask_num'] = $user_doask_detail->where(['doask_id' => $doask_id,'is_right' => 0])->count();
        //没答的题的数量加错题的数量
        $info['error_ask_nums'] = $info['total_ask_num'] - $info['right_ask_num'];
        //分类名称
        $info['cate_name'] = $cate->where('id',$post['cate_id'])->value('name');
        /*获取用户信息*/
        $info['userinfo'] = $user->getMyMessage($user_id);
        $this->apiResponse(1,'获取成功',$info);
    }

    /**
     * @title 获取模拟考试信息
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Ask/getExamInfo
     * @method POST
     * @param name:cate_id type:int require:1 default: false other: desc:分类id(一级)
     * @param name:token type:string require:1 default: false other: desc:string
     */
    public function getExamInfo()
    {
        $cate_id = $this->request->param('cate_id','','intval');
        $token = $this->request->param('token','');
        $user = new UsersModel();
        $user_id = $this->tokenToUid($token);
        $cate = new PortalCategoryModel();
        $this->isEmpty($cate_id,'CATE_ID');
        $cate_info = $cate
            ->field('id,name,exam_time,low_score,parent_id')
            ->where('id',$cate_id)
            ->find();
        if($cate_info['parent_id'] != 0){
            $this->apiResponse(0,'CATE_ID不合法');
        }
        //分类名称
        $info['cate_name'] = $cate_info['name'];
        //题目数量
        $info['ask_num'] = 100;
        //考试时间(分钟)
        $info['exam_time'] = $cate_info['exam_time'];
        //合格分数(分)
        $info['low_score'] = $cate_info['low_score'];
        /*获取用户信息*/
        $info['userinfo'] = $user->getMyMessage($user_id);
        $this->apiResponse(1,'获取成功',$info);
    }

    /**
     * @title 开始考试（考试）
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Ask/beginExam
     * @method POST
     * @param name:cate_id type:int require:1 default: false other: desc:分类id(一级)
     * @param name:token type:string require:1 default: false other: desc:token
     */
    public function beginExam()
    {
        //一级分类
        $cate_id = $this->request->param('cate_id','','intval');
        $token = $this->request->param('token');
        $cate = new PortalCategoryModel();
        $ask = new AskModel();
        $user_exam = new UserExamModel();
        $user_exam_detail = new UserExamDetailModel();
        $this->isEmptyArray([
            'cate_id' => $cate_id,
            'token' => $token
        ]);
        $user_id = $this->tokenToUid($token);
        //查询上次考试是否结束
        $last_exam_info = $user_exam->where([
            'user_id' => $user_id,
            'cate_id' => $cate_id,
            'is_end' => 0,
        ])->find();
        if($last_exam_info){
            $last_exam_id = $last_exam_info['id'];//已答完100题时使用
            $last_exam_info = AskService::getLastExamInfo($last_exam_info['id']);
            if(!$last_exam_info){
                /*已答完100道题*/
                $this->apiResponse(0,'已答完100道题或已超时，请结束考试',$last_exam_id);
            }
            $this->apiResponse(1,'上次考试还没有结束',$last_exam_info);
        }
        $cate_info = $cate
            ->field('id,parent_id,exam_time')
            ->where('id',$cate_id)
            ->find();
        if($cate_info['parent_id'] != 0){
            $this->apiResponse(0,'CATE_ID不合法');
        }
        Db::startTrans();
        $user_exam_id = $user_exam->insertGetId([
            'user_id' => $user_id,
            'cate_id' => $cate_id,
            'is_end' => 0,
            'create_time' => date('Y-m-d H:i:s'),
            'all_time' => $cate_info['exam_time'],
            'force_end_time' => date('Y-m-d H:i:s',time()+$cate_info['exam_time']*60)
        ]);
        //二级分类
        $all_cate_id = $cate->getTwoCate($cate_id);
        $all_ask_id = $ask
            ->where('cate_id','in',$all_cate_id)
            ->column('id');
        $count = count($all_ask_id);
        if($count < 100){
            $this->apiResponse(0,'题目数量不足够，无法开始考试');
        }
        $tmp_ask_id = array ();
        while (count($tmp_ask_id) < 100) {
            $random = mt_rand(0,$count-1);
            array_push($tmp_ask_id,$all_ask_id[$random]);
            $tmp_ask_id = array_unique ($tmp_ask_id);
        }
        $tmp_ask_id = array_values($tmp_ask_id);
        $add_ask_info = array();
        foreach ($tmp_ask_id as $k=>$v){
            $right_option_id = $ask->where('id',$v)->value('option_id');
            $add_ask_info[] = array('ask_id'=>$v,'exam_id'=>$user_exam_id,'right_option_id'=>$right_option_id,'exam_num'=>$k+1);
        }
        unset($tmp_ask_id);
        $res = $user_exam_detail->insertAll($add_ask_info);
        if(!$user_exam_id or !$res){
            Db::rollback();
            $this->apiResponse(0,'ERROR','');
        }
        Db::commit();
        $this->apiResponse(1,'初始化成功',['user_exam_id'=>$user_exam_id,'remain_time'=>$cate_info['exam_time']]);
    }

    /**
     * @title 获取题目（考试）
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Ask/getExamAsk
     * @method POST
     * @param name:user_exam_id type:int require:1 default: false other: desc:初始化接口返回的user_exam_id
     * @param name:exam_num type:int require:1 default: false other: desc:题号
     */
    public function getExamAsk()
    {
        $post = $this->request->param();
        $ask = new AskModel();
        $user_exam = new UserExamModel();
        $user_exam_detail = new UserExamDetailModel();
        $this->isEmptyArray([
            'user_exam_id' => $post['user_exam_id'],
            'exam_num' => $post['exam_num'],
        ]);
        $exam_detail_info = $user_exam_detail
            ->where([
                'exam_id'=> $post['user_exam_id'],
                'exam_num'=> $post['exam_num']
            ])
            ->find();
        if(empty($exam_detail_info)){
            $this->apiResponse(0,'没有更多题目了');
        }
        $askinfo = $ask->where('id',$exam_detail_info['ask_id'])->find();
        /*获取整个题目详细信息*/
        $askinfo = AskService::askDetail($askinfo);
        /*本题题号*/
        $askinfo['exam_num'] = $exam_detail_info['exam_num'];
        /*本题所属考卷*/
        $askinfo['user_exam_id'] = $exam_detail_info['exam_id'];
        /*上一题题号*/
        $askinfo['last_exam_num'] = empty($exam_detail_info['exam_num']-1)?'没有上一题了':$exam_detail_info['exam_num']-1;
        /*下一题题号*/
        $askinfo['next_exam_num'] = AskService::nextExamAskId($post['user_exam_id'],$post['exam_num']);
        /*强制截止时间*/
        $askinfo['force_end_time'] = $user_exam->where('id',$post['user_exam_id'])->value('force_end_time');
        /*查询是否做过该题*/
        $askinfo['doinfo'] = $user_exam->isDoExamAsk($exam_detail_info['exam_id'],$askinfo['id']);
        $this->apiResponse(1,'获取成功',$askinfo);
    }

    /**
     * @title 做题（考试）
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Ask/doExam
     * @method POST
     * @param name:user_exam_id type:int require:1 default: false other: desc:初始化接口返回的user_exam_id
     * @param name:exam_num type:int require:1 default: false other: desc:题号
     * @param name:user_option_id type:int require:1 default: false other: desc:用户答案
     */
    public function doExam()
    {
        $post = $this->request->param();
        $user_exam_detail = new UserExamDetailModel();
        $this->isEmptyArray([
            'user_exam_id' => $post['user_exam_id'],
            'exam_num' => $post['exam_num'],
            'user_option_id' => $post['user_option_id']
        ]);
        $user_exam_detail_info = $user_exam_detail
            ->where([
                'exam_id' => $post['user_exam_id'],
                'exam_num' => $post['exam_num']
            ])->find();
        if(empty($user_exam_detail_info)){
            $this->apiResponse(0,'查无此题','');
        }
        if($post['user_option_id'] == $user_exam_detail_info['right_option_id']){
            $is_right = 1;
        }else{
            $is_right = 0;
        }
        $res = $user_exam_detail
            ->update([
                'user_option_id' => $post['user_option_id'],
                'is_right' => $is_right,
                'do_time' => date('Y-m-d H:i:s')
            ],[
                'id' => $user_exam_detail_info['id']
            ]);
        if($res){
            $this->apiResponse(1,'记录成功','');
        }
    }

    /**
     * @title 阅卷（考试）
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Ask/checkExam
     * @method POST
     * @param name:user_exam_id type:int require:1 default: false other: desc:初始化接口返回的user_exam_id
     */
    public function checkExam()
    {
        $user_exam_id = $this->request->param('user_exam_id','','intval');
        $user = new UsersModel();
        $user_exam = new UserExamModel();
        $user_exam_detail = new UserExamDetailModel();
        $this->isEmpty($user_exam_id,'USER_EXAM_ID');
        $user_exam_info = $user_exam->where('id',$user_exam_id)->find();
        if($user_exam_info['is_end'] == 1){
            $this->apiResponse(0,'此试卷阅卷结束','');
        }
        $nowtime = time();
        $use_time = round(($nowtime - strtotime($user_exam_info['create_time']))/60);
        $res = $user_exam->update([
            'is_end' => 1,
            'end_time' => date('Y-m-d H:i:s',$nowtime),
            'use_time' => $use_time
        ],['id'=>$user_exam_id]);
        $info['total_ask_num'] = $user_exam_detail->where('exam_id',$user_exam_id)->count();
        $info['use_time'] = $use_time;
        $info['right_num'] = $user_exam_detail->where(['exam_id'=>$user_exam_id,'is_right'=>1])->count();
        //查询分类名称
        $ask_id = $user_exam_detail->where('exam_id',$user_exam_id)->value('ask_id');
        $info['cate_name'] = AskService::mateTopCate($ask_id);
        /*查询用户信息*/
        $info['userinfo'] = $user->getMyMessage($user_exam_info['user_id']);
        if($res){
            $this->apiResponse(1,'阅卷成功',$info);
        }
    }

    /**
     * @title 查看考试错题
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Ask/lookExamError
     * @method POST
     * @param name:user_exam_id type:int require:1 default: false other: desc: user_exam_id
     * @param name:exam_detail_id type:int require:0 default: false other: desc: exam_detail_id
     */
    public function lookExamError()
    {
        $post = $this->request->param();
        $user_exam = new UserExamModel();
        $user_exam_detail = new UserExamDetailModel();
        $this->isEmpty($post['user_exam_id'],'USER_EXAM_ID');
        if(empty($post['exam_detail_id'])){
            $post['exam_detail_id'] = $user_exam_detail
                ->where([
                    'exam_id' => $post['user_exam_id'],
                    'is_right' => 0
                ])
                ->order('id ASC')
                ->value('id');
        }
        $user_id = $user_exam->where('id',$post['user_exam_id'])->value('user_id');
        $info = AskService::examErrorHandle($post['exam_detail_id']);
        /*查询此题是否被收藏*/
        if(empty($info)){
            $this->apiResponse(1,'无错题');
        }
        $info['is_collection'] = AskService::isCollection($user_id,$info['id']);
        if(!$info){
            $this->apiResponse(0,'请检查EXAM_DETAIL_ID是否正确');
        }
        $this->apiResponse(1,'获取成功',$info);
    }

    /**
     * @title 查看答题卡（平时练习）
     * @description 0->没做过 1->正确 2->错误
     * @author 开发者
     * @url /Portal/Ask/lookAskCard
     * @method POST
     * @param name:token type:string require:1 default: false other: desc: token
     * @param name:cate_id type:int require:1 default: false other: desc: 二级分类id
     */
    public function lookAskCard()
    {
        $param = $this->request->param();
        $this->isEmptyArray([
            'token' => $param['token'],
            'cate_id' => $param['cate_id']
        ]);
        $user_id = $this->tokenToUid($param['token']);
        $data = AskService::getAskCard($user_id,$param['cate_id']);
        $this->apiResponse(1,'获取成功',$data);
    }

    /**
     * @title 查看答题卡（考试）
     * @description asked_num已答数量 user_option_id不为0证明已答过
     * @author 开发者
     * @url /Portal/Ask/lookExamCard
     * @method POST
     * @param name:user_exam_id type:int require:1 default: false other: desc: getExamAsk获取的user_exam_id
     */
    public function lookExamCard()
    {
        $user_exam_id = $this->request->param('user_exam_id','','intval');
        $this->isEmptyArray([
            'user_exam_id' => $user_exam_id
        ]);
        $data = AskService::getExamCard($user_exam_id);
        $this->apiResponse(1,'获取成功',$data);
    }

    /**
     * @title 设置答题状态
     * @description 说明
     * @author 开发者
     * @url /Portal/Ask/setAskStatus
     * @method POST
     * @param name:token type:string require:1 default: false other: desc: tokan
     * @param name:status type:int require:1 default: false other: desc: 0->关闭，1->答对自动下一题，2->只显示正确答案
     */
    public function setAskStatus()
    {
        $param = $this->request->param();
        $ask_status = new AskStatusModel();
        $user_id = $this->tokenToUid($param['token']);
        if($param['status'] != 0 and $param['status'] != 1 and $param['status'] != 2){
            $this->apiResponse(0,'STATUS非法');
        }
        $res = $ask_status->setAskStatus($user_id,$param['status']);
        if(!$res){
            $this->apiResponse(0,'设置失败');
        }
        $this->apiResponse(1,'ok',$param['status']);
    }

    /**
     * @title 获取答题状态
     * @description 说明
     * @author 开发者
     * @url /Portal/Ask/getAskStatus
     * @method POST
     * @param name:token type:string require:1 default: false other: desc: tokan
     */
    public function getAskStatus()
    {
        $param = $this->request->param();
        $ask_status = new AskStatusModel();
        $user_id = $this->tokenToUid($param['token']);
        $data = $ask_status->getAskStatus($user_id);
        $this->apiResponse(1,'ok',$data['status']);
    }

}