<?php
/*
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/10/22 11:05
 */
namespace app\portal\model;

use think\Model;

class AllaskModel extends Model
{

    /**
     * 获取第一题
     * @param array $arr_cate_id
     */
    public function getFirst($arr_cate_id)
    {
        $ask = new AskModel();
        $info = $ask
            ->where('cate_id','in',$arr_cate_id)
            ->order('id ASC')
            ->find();
        return $info;
    }

    /**
     * 获取下一题
     * @param array $arr_cate_id
     * @param int $ask_id
     */
    public function getNext($arr_cate_id,$ask_id)
    {
        $where['cate_id'] = ['in',$arr_cate_id];
        $where['id'] = ['gt',$ask_id];
        $ask = new AskModel();
        $info = $ask
            ->where($where)
            ->order('id ASC')
            ->find();
        return $info;
    }

    /**
     * 获取上一题id
     * @param array $arr_cate_id
     * @param int $ask_id
     */
    public function getLastAskId($arr_cate_id,$ask_id)
    {
        $where['cate_id'] = ['in',$arr_cate_id];
        $where['id'] = ['lt',$ask_id];
        $ask = new AskModel();
        $last_ask_id = $ask
            ->where($where)
            ->order('id DESC')
            ->value('id');
        if(empty($last_ask_id)){
            return '没有上一题了';
        }
        return $last_ask_id;
    }

    /**
     * 获取下一题id
     * @param array $arr_cate_id
     * @param int $ask_id
     */
    public function getNextAskId($arr_cate_id,$ask_id)
    {
        $where['cate_id'] = ['in',$arr_cate_id];
        $where['id'] = ['gt',$ask_id];
        $ask = new AskModel();
        $next_ask_id = $ask
            ->where($where)
            ->order('id ASC')
            ->value('id');
        if(empty($next_ask_id)){
            return '没有下一题了';
        }
        return $next_ask_id;
    }

    /**
     * 是否做过该题（全部题目部分）
     * @param $ask_id 题目id
     * @param $allask_id allask表id
     */
    public function isDoAllask($ask_id,$allask_id)
    {
        $allask_detail = new AllaskDetailModel();
        $info = $allask_detail->where([
            'ask_id' => $ask_id,
            'allask_id' => $allask_id,
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
}