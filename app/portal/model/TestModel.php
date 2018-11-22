<?php
/*
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/10/22 11:05
 */
namespace app\portal\model;

use think\Model;

class TestModel extends Model
{


    /**
     * 判断是否做过该题目
     * @param $test_id
     * @param $ask_id
     * @return int
     */
    public function isDoTest($test_id,$ask_id)
    {
        $test_detail = new TestDetailModel();
        $info = $test_detail->where([
            'test_id' => $test_id,
            'ask_id' => $ask_id
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
     * 获取上一题sort
     * @param $sort
     */
    public function lastSort($sort)
    {
        if($sort == 1){
            return '没有上一题了';
        }
        return $sort - 1;
    }

    /**
     * 获取下一题sort
     * @param $sort
     * @param $cate_id
     */
    public function nextSort($sort,$cate_id)
    {
        $ask = new AskModel();
        $info = $ask->where([
            'cate_id' => $cate_id,
            'sort' => $sort + 1
        ])->find();
        if(empty($info)){
            return '没有下一题了';
        }
        return $sort + 1;
    }

}