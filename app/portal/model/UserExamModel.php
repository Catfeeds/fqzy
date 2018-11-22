<?php
/*
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/23 17:40
 */
namespace app\portal\model;

use think\Model;

class UserExamModel extends Model
{
    public function isDoExamAsk($exam_id,$ask_id)
    {
        $user_exam_detail = new UserExamDetailModel();
        $info = $user_exam_detail->where([
            'exam_id' => $exam_id,
            'ask_id' => $ask_id
        ])->find();
        if(empty($info['user_option_id'])){
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