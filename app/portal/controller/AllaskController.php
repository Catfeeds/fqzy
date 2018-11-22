<?php
/*
 * 全部题目相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/10/22 15:01
 */
namespace app\portal\controller;

use app\portal\model\AllaskDetailModel;
use app\portal\model\AllaskModel;
use app\portal\model\AskModel;
use app\portal\model\CateModel;
use app\portal\model\PortalCategoryModel;
use app\portal\model\UsersModel;
use app\portal\service\AskService;
use cmf\controller\HomeBaseController;

/**
 * @title 全部题目相关
 * @description 全部题目相关内容
 */

class AllaskController extends HomeBaseController
{
    /**
     * @title 开始答题
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Allask/begin
     * @method POST
     * @param name:cate_id type:int require:1 default: false other: desc:一级分类id
     * @param name:token type:string require:1 default: false other: desc:token
     */
    public function begin()
    {
        $param = $this->request->param();
        $allask = new AllaskModel();
        $allask_detail = new AllaskDetailModel();
        $cate = new PortalCategoryModel();
        $user_id = $this->tokenToUid($param['token']);
        $this->isEmptyArray([
            'cate_id' => $param['cate_id'],
            'token' => $param['token'],
        ]);
        /*查询上次是否结束*/
        $is_has = $allask->where([
            'user_id' => $user_id,
            'cate_id' => $param['cate_id'],
            'if_end' => 0,
        ])->find();
        /*没有结束，继续上次的*/
        if(!empty($is_has)){
            $cate_id = $cate->getTwoCate($param['cate_id']);//数组
            $ask_id = $allask_detail->where([
                'allask_id' => $is_has['id']
            ])->order('id DESC')->value('ask_id');
            $ask_id = empty($ask_id)?0:$ask_id;
            $next_ask_id = $allask->getNextAskId($cate_id,$ask_id);
            $this->apiResponse(0,'ok',[
                'allask_id'=>$is_has['id'],
                'next_ask_id' => $next_ask_id
            ]);
        }
        /*已结束，添加新的*/
        $res = $allask->insertGetId([
            'user_id' => $user_id,
            'cate_id' => $param['cate_id'],
            'if_end' => 0,
            'create_time' =>date('Y-m-d H:i:s')
        ]);
        if($res){
            $this->apiResponse(1,'ok',['allask_id'=>$res]);
        }
    }


    /**
     * @title 获取题目
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Allask/get
     * @method POST
     * @param name:cate_id type:int require:1 default: false other: desc:一级分类id
     * @param name:token type:string require:1 default: false other: desc:token
     * @param name:allask_id type:int require:1 default: false other: desc:begin()接口返回的allask_id
     * @param name:ask_id type:int require:0 default: false other: desc:ask_id,ask表id
     */
    public function get()
    {
        $param = $this->request->param();
        $ask = new AskModel();
        $allask = new AllaskModel();
        $cate = new PortalCategoryModel();
        $this->isEmptyArray([
            'cate_id' => $param['cate_id'],
            'allask_id' => $param['allask_id'],
            'token' => $param['token']
        ]);
        $user_id = $this->tokenToUid($param['token']);
        $cate_id = $cate->getTwoCate($param['cate_id']);//数组
        if(empty($param['ask_id'])){
            /*获取第一题*/
            $info = $allask->getFirst($cate_id);
        }else{
            /*获取所传ask_id的题*/
            $info = $ask->find($param['ask_id']);
        }
        /*获取整个题目详细信息*/
        $info = AskService::askDetail($info);
        /*获取上一题id*/
        $info['last_ask_id'] = $allask->getLastAskId($cate_id,$info['id']);
        /*获取下一题id*/
        $info['next_ask_id'] = $allask->getNextAskId($cate_id,$info['id']);
        /*查询是否收藏*/
        $info['is_collection'] = AskService::isCollection($user_id,$info['id']);
        /*查询该题目是否做过*/
        $info['doinfo'] = $allask->isDoAllask($info['id'],$param['allask_id']);
        $this->apiResponse(1,'ok',$info);
    }


    /**
     * @title 记录
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Allask/record
     * @method POST
     * @param name:allask_id type:int require:1 default: false other: desc:begin()返回的allask_id
     * @param name:ask_id type:int require:1 default: false other: desc:get()返回的id
     * @param name:right_option_id type:int require:1 default: false other: desc:正确答案
     * @param name:user_option_id type:int require:1 default: false other: desc:用户答案
     */
    public function record()
    {
        $param = $this->request->param();
        $allask_detail = new AllaskDetailModel();
        $this->isEmptyArray([
            'allask_id' => $param['allask_id'],
            'ask_id' => $param['ask_id'],
            'right_option_id' => $param['right_option_id'],
            'user_option_id' => $param['user_option_id'],
        ]);
        if($param['right_option_id'] == $param['user_option_id']){
            $param['is_right'] = 1;
        }else{
            $param['is_right'] = 0;
        }
        $param['create_time'] = date('Y-m-d H:i:s');
        /*查询是否记录过*/
        $is_has = $allask_detail->where([
            'allask_id' => $param['allask_id'],
            'ask_id' => $param['ask_id'],
        ])->find();
        if(!empty($is_has)){
            /*更新*/
            $res = $allask_detail->where('id',$is_has['id'])->data($param)->update();
        }else{
            /*添加*/
            $res = $allask_detail->insert($param);
        }
        if($res){
            $this->apiResponse(1,'ok');
        }
    }

    /**
     * @title 全部题目答完时调用
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Allask/end
     * @method POST
     * @param name:allask_id type:int require:1 default: false other: desc:begin()返回的allask_id
     */
    public function end()
    {
        $param = $this->request->param();
        $allask = new AllaskModel();
        $res = $allask->where('id',$param['allask_id'])->setField('if_end',1);
        if($res){
            $this->apiResponse(1,'ok');
        }
    }

    /**
     * @title 计算结果
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Allask/allaskResult
     * @method POST
     * @param name:token type:string require:1 default: false other: desc:token
     * @param name:allask_id type:int require:1 default: false other: desc:begin()返回的allask_id
     */
    public function allaskResult()
    {
        $param = $this->request->param();
        $ask = new AskModel();
        $allask = new AllaskModel();
        $cate = new PortalCategoryModel();
        $allask_detail = new AllaskDetailModel();
        $this->isEmptyArray([
            'token' => $param['token'],
            'allask_id' => $param['allask_id']
        ]);
        $user = new UsersModel();
        $user_id = $this->tokenToUid($param['token']);
        $info = $allask->where('id',$param['allask_id'])->find();
        if(empty($info)){
            $this->apiResponse(0,'ALLASK_ID非法');
        }
        //题目数量
        $two_cate_id = $cate->getTwoCate($info['cate_id']);
        $info['total_ask_num'] = $ask->where('cate_id','in',$two_cate_id)->count();
        //错题数量
        $info['error_ask_num'] = $allask_detail->where(['allask_id' => $param['allask_id'],'is_right' => 0])->count();
        //分类名称
        $info['cate_name'] = $cate->where('id',$info['cate_id'])->value('name');
        /*获取用户信息*/
        $info['userinfo'] = $user->getMyMessage($user_id);
        $this->apiResponse(1,'ok',$info);
    }

}