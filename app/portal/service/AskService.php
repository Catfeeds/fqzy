<?php
/*
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/22 11:54
 */
namespace app\portal\service;

use app\portal\model\AskAnalysisModel;
use app\portal\model\AskModel;
use app\portal\model\AskOptionModel;
use app\portal\model\PortalCategoryModel;
use app\portal\model\UserCollectionModel;
use app\portal\model\UserDoaskDetailModel;
use app\portal\model\UserDoaskModel;
use app\portal\model\UserExamDetailModel;
use app\portal\model\UserExamModel;

class AskService
{
    /**
     * 查询下一题id
     */
    public static function nextAskId($cate_id,$id)
    {
        $ask = new AskModel();
        $where['cate_id'] = $cate_id;
        $where['id'] = ['gt',$id];
        $next_id = $ask
            ->where($where)
            ->order('sort ASC,id ASC')
            ->value('id');
        if(empty($next_id)){
            return '没有下一题了';
        }
        return $next_id;
    }

    /**
     * 查询上一题id
     */
    public static function lastAskId($cate_id,$id)
    {
        $ask = new AskModel();
        $where['cate_id'] = $cate_id;
        $where['id'] = ['lt',$id];
        $last_id = $ask
            ->where($where)
            ->order('sort DESC,id DESC')
            ->value('id');
        if(empty($last_id)){
            return '没有上一题了';
        }
        return $last_id;
    }

    /**
     * 添加用户答题记录,如果已有则结束重新添加
     */
    public static function addDoAsk($cate_id,$user_id)
    {
        $user_doask = new UserDoaskModel();
        $info = $user_doask->where([
            'user_id' => $user_id,
            'cate_id' => $cate_id,
            'is_end' => 0
        ])->find();
        if($info){
            $user_doask->where('id',$info['id'])->data([
                'is_end' => 1,
                'end_time' => date('Y-m-d H:i:s')
            ])->update();
        }
        $res = $user_doask->insertGetId([
            'user_id' => $user_id,
            'cate_id' => $cate_id,
            'is_end' => 0,
            'create_time' => date('Y-m-d H:i:s')
        ]);
        if($res){
            return true;
        }
        return false;
    }

    /**
     * 获取题目选项以及解答
     */
    public static function askDetail($info)
    {
        $info = $info->toArray();
        $ask_option = new AskOptionModel();
        $ask_analysis = new AskAnalysisModel();
        //选项
        $info['option'] = $ask_option
            ->field('id as option_id,option_content')
            ->where('ask_id',$info['id'])
            ->select()->toArray();
        /*判断每个答案是否是正确答案*/
        foreach ($info['option'] as $k=>$v){
            if($info['option_type'] == 1){
                $info['option'][$k]['option_content'] = cmf_get_image_preview_url($v['option_content']);
            }
            if($info['option_id'] == $v['option_id']){
                $info['option'][$k]['is_right'] = true;
            }else{
                $info['option'][$k]['is_right'] = false;
            }
        }
        $abcd = ['0'=>'A',1=>'B',2=>'C',3=>'D'];
        foreach ($info['option'] as $k=>$v){
            $info['option'][$k]['abcd'] = $abcd[$k];
        }
        //解析
        $info['analysis'] = $ask_analysis
            ->where('ask_id',$info['id'])
            ->value('analysis_content');
        if(!empty($info['title_pic'])){
            $info['title_pic'] = json_decode($info['title_pic']);
            foreach ($info['title_pic'] as $k=>$v){
                $info['title_pic'][$k] = cmf_get_image_preview_url($v);
            }
        }
        return $info;
    }

    /**
     * 上一题id，下一题id，多少题，第几题处理(我的收藏)
     */
    public static function collectionHandle($askinfo,$user_collection_id,$user_id,$cate_id)
    {
        $user_collection = new UserCollectionModel();
        //上一题id
        $last_id = $user_collection
            ->where([
                'user_id' => $user_id,
                'cate_id' => $cate_id,
                'id' => ['gt',$user_collection_id]
            ])
            ->order('id ASC')
            ->value('id');
        $askinfo['last_id'] = empty($last_id)?'没有上一题了':$last_id;
        //下一题id
        $next_id = $user_collection
            ->where([
                'user_id' => $user_id,
                'cate_id' => $cate_id,
                'id' => ['lt', $user_collection_id]
            ])
            ->order('id DESC')
            ->value('id');
        $askinfo['next_id'] = empty($next_id)?'没有下一题了':$next_id;
        //总题数
        $askinfo['total_ask_num'] = $user_collection
            ->where([
                'user_id' => $user_id,
                'cate_id' => $cate_id,
            ])
            ->count();
        //第几题
        $askinfo['this_ask_num'] = $user_collection
            ->where([
                'user_id' => $user_id,
                'cate_id' => $cate_id,
                'id' => ['egt',$user_collection_id]
            ])
            ->order('id DESC')
            ->count();
        return $askinfo;
    }

    /**
     * 查询下一题id(考试)
     */
    public static function nextExamAskId($exam_id,$exam_num)
    {
        $user_exam_detail = new UserExamDetailModel();
        $exam_num = $user_exam_detail->where([
            'exam_id' => $exam_id,
            'exam_num' => ['gt',$exam_num]
        ])->value('exam_num');
        if(empty($exam_num)){
            return '没有下一题了';
        }
        return $exam_num;
    }

    /**
     * 根据题目id查所在的大分类
     */
    public static function mateTopCate($ask_id)
    {
        $ask = new AskModel();
        $cate = new PortalCategoryModel();
        $cate_id = $ask->where('id',$ask_id)->value('cate_id');
        $parent_id = $cate->where('id',$cate_id)->value('parent_id');
        $name = $cate->where('id',$parent_id)->value('name');
        return $name;
    }

    /**
     * 上一题id，下一题id，多少题，第几题处理(我的错题)
     */
    public static function examErrorHandle($user_exam_detail_id)
    {
        $ask = new AskModel();
        $user_exam_detail = new UserExamDetailModel();
        $user_exam_detail_info = $user_exam_detail->where('id',$user_exam_detail_id)->find();
        if(empty($user_exam_detail_info)){
            return false;
        }
        $info = $ask->where('id',$user_exam_detail_info['ask_id'])->find();
        if(empty($info)){
            return false;
        }
        //获取整个题目详细信息
        $info = Self::askDetail($info);
        $info['exam_num'] = $user_exam_detail_info['exam_num'];
        $info['user_option_id'] = $user_exam_detail_info['user_option_id'];
        //上一题
        $info['last_id'] = $user_exam_detail
            ->where([
                'is_right' =>0,
                'exam_id' => $user_exam_detail_info['exam_id'],
                'id' => ['lt',$user_exam_detail_id]
            ])->order('id DESC')->value('id');
        if(empty($info['last_id'])){
            $info['last_id'] = '没有上一题了';
        }
        //下一题
        $info['next_id'] = $user_exam_detail
            ->where([
                'is_right' =>0,
                'exam_id' => $user_exam_detail_info['exam_id'],
                'id' => ['gt',$user_exam_detail_id]
            ])->order('id ASC')->value('id');
        if(empty($info['next_id'])){
            $info['next_id'] = '没有下一题了';
        }
        //总题数
        $info['total_error_num'] = $user_exam_detail->where([
            'is_right' => 0,
            'exam_id' => $user_exam_detail_info['exam_id']
        ])->count();
        //第几题
        $info['this_error_num'] = $user_exam_detail->where([
            'is_right' => 0,
            'exam_id' => $user_exam_detail_info['exam_id'],
            'id' => ['elt',$user_exam_detail_id]
        ])->count();
        return $info;
    }

    /**
     * 查询此题库是否有过答题记录（普通答题）
     */
    public static function askRecord($user_id,$cate_id)
    {
        $user_doask = new UserDoaskModel();
        $user_doask_detail = new UserDoaskDetailModel();
        $user_doask_info = $user_doask->where([
            'user_id' => $user_id,
            'cate_id' => $cate_id
        ])->order('id DESC')->find();
        if(empty($user_doask_info)){
            //从来没有做过这个题库
            $data['status'] = 0;
            return $data;
        }
        if($user_doask_info['is_end'] == 1){
            //已结束
            $data['status'] = 1;
            $data['error_num'] = $user_doask_detail->where([
                'doask_id' => $user_doask_info['id'],
                'is_right' => 0
            ])->count();
        }else{
            //未结束
            $data['status'] = 2;
            $data['asked_num'] = $user_doask_detail->where([
                'doask_id' => $user_doask_info['id'],
            ])->count();
        }
        return $data;
    }

    /**
     * 获取答题卡信息（平时练习）
     * status 0->没做过 1->正确 2->错误
     */
    public static function getAskCard($user_id,$cate_id)
    {
        $ask = new AskModel();
        $user_doask = new UserDoaskModel();
        $user_doask_detail = new UserDoaskDetailModel();
        $all_ask = $ask
            ->field('id as ask_id')
            ->where('cate_id',$cate_id)
            ->select()->toArray();
        $doask_id = $user_doask->where([
            'user_id' => $user_id,
            'cate_id' => $cate_id
        ])->order('id DESC')->value('id');
        foreach ($all_ask as $k=>$v){
            $all_ask[$k]['ask_num'] = $k+1;
            //查询做没做过这道题
            $if_do = $user_doask_detail->where([
                'doask_id' => $doask_id,
                'ask_id' => $v['ask_id']
            ])->find();
            if(empty($if_do)){
                $all_ask[$k]['status'] = 0;//没做过
            }elseif($if_do['is_right'] == 1){
                $all_ask[$k]['status'] = 1;//正确
            }else{
                $all_ask[$k]['status'] = 2;//错误
            }
        }
        $data['data'] = $all_ask;
        $data['ask_num'] = $ask->where([
            'cate_id' => $cate_id,
        ])->count();
        $data['asked_num'] = $user_doask_detail->where([
            'doask_id' => $doask_id,
        ])->count();
        $data['rignt_num'] = $user_doask_detail->where([
            'doask_id' => $doask_id,
            'is_right' => 1
        ])->count();
        $data['error_num'] = $data['asked_num'] - $data['rignt_num'];
        return $data;
    }

    /**
     * 获取答题卡信息（考试）
     */
    public static function getExamCard($user_exam_id)
    {
        $user_exam_detail = new UserExamDetailModel();
        $list['data'] = $user_exam_detail
            ->field('exam_num,user_option_id')
            ->where('exam_id',$user_exam_id)
            ->select()->toArray();
        $list['asked_num'] = $user_exam_detail->where([
            'exam_id' => $user_exam_id,
            'user_option_id' => ['neq',0]
        ])->count();
        $list['right_ask_num'] = $user_exam_detail->where([
            'exam_id' => $user_exam_id,
            'user_option_id' => ['neq',0],
        ])->count();
        $list['error_ask_num'] = $list['asked_num'] - $list['right_ask_num'];
        return $list;
    }

    /**
     * 查询题目是否被收藏
     */
    public static function isCollection($user_id,$ask_id)
    {
        $collection = new UserCollectionModel();
        $info = $collection->where([
            'user_id' => $user_id,
            'ask_id' => $ask_id
        ])->find();
        if(empty($info)){
            return 'no';
        }
        return 'yes';
    }


    /**
     * 查询题目是否做过
     * @param int $id  题目id
     * @param int $doask_id  平时答题记录表id
     */
    public static function isDoAsk($id,$doask_id)
    {
        $user_doask_detail = new UserDoaskDetailModel();
        /*查询是否做过该题目*/
        $info = $user_doask_detail->where([
            'doask_id' => $doask_id,
            'ask_id' => $id
        ])->find();
        if(empty($info)){
            /*没做过*/
            return $data['is_do'] = 0;
        }
        /*做过，返回记录*/
        $data['is_do'] = 1;
        $data['user_option_id'] = $info['user_option_id'];
        $data['is_right'] = $info['is_right'];
        return $data;

    }

    /**
     * 获取该题库下的所有题目数量，以及用户答过的题目的数量
     * @param int $cate_id  题库id
     * @param $doask_id 平时答题记录表id
     */
    public static function getNeedNum($cate_id,$doask_id)
    {
        $ask = new AskModel();
        $user_doask_detail = new UserDoaskDetailModel();
        $data['total_num'] = $ask->where('cate_id',$cate_id)->count();
        $data['asked_num'] = $user_doask_detail->where('doask_id',$doask_id)->count();
        return $data;
    }

    /**
     * 获取用户继续答题时的第一个没有答过的题库里面的第一题
     */
    public static function getNearAskid($user_id,$cate_id,$is_end)
    {
        $ask = new AskModel();
        $user_doask = new UserDoaskModel();
        $user_doask_detail = new UserDoaskDetailModel();
        /*用户未答完的答题记录*/
        $user_doask_info = $user_doask->where([
            'user_id' => $user_id,
            'cate_id' => $cate_id,
            'is_end' => $is_end
        ])->order('id DESC')->find();
        /*查询第一道题*/
        $is_has = $ask->where('cate_id',$cate_id)->order('id ASC')->find();
        $user_doask_detail_info = $user_doask_detail->where([
            'ask_id' => $is_has['id'],
            'doask_id' => $user_doask_info['id']
        ])->find();
        /*没有做过该题目时跳出循环*/
        while (!empty($user_doask_detail_info)){
            $where['cate_id'] = $cate_id;
            $where['id'] = ['gt',$is_has['id']];
            $is_has = $ask->where($where)->find();
            if(empty($is_has)){
                return false;//已经全部做完
            }
            $user_doask_detail_info = $user_doask_detail->where([
                'ask_id' => $is_has['id'],
                'doask_id' => $user_doask_info['id']
            ])->find();
        }
        return $is_has['id'];
    }

    /**
     * 获取上次考试信息
     * @param int $user_exam_id
     */
    public static function getLastExamInfo($user_exam_id)
    {
        $user_exam = new UserExamModel();
        $user_exam_detail = new UserExamDetailModel();
        $user_exam_info = $user_exam->find($user_exam_id)->toArray();
        $remain_time = strtotime($user_exam_info['force_end_time']) - time();//剩余时间
        if($remain_time < 0){
            return false;//已超时
        }
        $remain_time = floor($remain_time/60);
        $exam_num = $user_exam_detail->where([
            'exam_id' => $user_exam_id,
            'user_option_id' => ['neq',0]
        ])->order('id ASC')->value('exam_num');//上次答到的题号
        if($exam_num == 100){
            return false;
        }
        $data['user_exam_id'] = $user_exam_id;
        $data['remain_time'] = $remain_time;
        $data['exam_num'] = $exam_num + 1;
        return $data;
    }
}