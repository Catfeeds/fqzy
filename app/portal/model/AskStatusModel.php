<?php
/*
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/10/17 11:42
 */
namespace app\portal\model;

use think\Model;

class AskStatusModel extends Model
{
    /**
     * 设置答题状态
     * 0->关闭，1->答对自动下一题，2->只显示正确答案
     */
    public function setAskStatus($user_id , $status)
    {
        /*查询是否已添加过*/
        $info = $this->where('user_id',$user_id)->find();
        if(empty($info)){
            /*添加*/
            $res = $this->insert([
                'user_id' => $user_id,
                'status' => $status
            ]);
        }else{
            /*修改*/
            $res = $this->where('id',$info['id'])->setField('status',$status);
        }
        if($res){
            return true;
        }
        return false;
    }

    /**
     * 获取答题状态
     */
    public function getAskStatus($user_id)
    {
        /*查询是否已添加过*/
        $info = $this->where('user_id',$user_id)->find();
        if(empty($info)){
            $data['status'] = 0;
        }else{
            $data['status'] = $info['status'];
        }
        return $data;
    }

}