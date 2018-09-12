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
            ->order('sort ASC,id ASC')
            ->value('id');
        if(empty($last_id)){
            return '没有上一题了';
        }
        return $last_id;
    }

    /**
     * 添加用户答题记录
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
            return false;
        }
        $res = $user_doask->insert([
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
        $ask_option = new AskOptionModel();
        $ask_analysis = new AskAnalysisModel();
        //选项
        $info['option'] = $ask_option
            ->field('id as option_id,option_content')
            ->where('ask_id',$info['id'])
            ->select()->toArray();
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
    public static function collectionHandle($askinfo,$user_collection_id,$user_id,$all_cate_id)
    {
        $user_collection = new UserCollectionModel();
        //上一题id
        $last_id = $user_collection
            ->where([
                'user_id' => $user_id,
                'cate_id' => ['in',$all_cate_id],
                'id' => ['gt',$user_collection_id]
            ])
            ->order('id DESC')
            ->value('id');
        $askinfo['last_id'] = empty($last_id)?'没有上一题了':$last_id;
        //下一题id
        $next_id = $user_collection
            ->where([
                'user_id' => $user_id,
                'cate_id' => ['in',$all_cate_id],
                'id' => ['lt', $user_collection_id]
            ])
            ->order('id DESC')
            ->value('id');
        $askinfo['next_id'] = empty($next_id)?'没有下一题了':$next_id;
        //总题数
        $askinfo['total_ask_num'] = $user_collection
            ->where([
                'user_id' => $user_id,
                'cate_id' => ['in',$all_cate_id],
            ])
            ->count();
        //第几题
        $askinfo['this_ask_num'] = $user_collection
            ->where([
                'user_id' => $user_id,
                'cate_id' => ['in',$all_cate_id],
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
        $info = $ask->where('id',$user_exam_detail_info['ask_id'])->find()->toArray();
        //获取整个题目详细信息
        $info = Self::askDetail($info);
        //上一题
        $info['last_id'] = $user_exam_detail
            ->where([
                'is_right' =>0,
                'exam_id' => $user_exam_detail_info['exam_id'],
                'id' => ['lt',$user_exam_detail_id]
            ])->value('id');
        if(empty($info['last_id'])){
            $info['last_id'] = '没有上一题了';
        }
        //下一题
        $info['next_id'] = $user_exam_detail
            ->where([
                'is_right' =>0,
                'exam_id' => $user_exam_detail_info['exam_id'],
                'id' => ['gt',$user_exam_detail_id]
            ])->value('id');
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

}