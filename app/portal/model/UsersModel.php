<?php
/*
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/7/5 10:16
 */
namespace app\portal\model;

use think\Model;

class UsersModel extends Model
{
    /**
     * 获取用户信息
     */
    public function getMyMessage($user_id)
    {
        $login_type = $this->where('id',$user_id)->value('login_type');
        if($login_type == 1){
            /*微信登录*/
            $info = $this
                ->field('id,mobile,company,wechat_avatar as avatar,wechat_name as username')
                ->where('id',$user_id)
                ->find();
        }elseif($login_type == 2){
            /*qq登录*/
            $info = $this
                ->field('id,mobile,company,qq_avatar as avatar,qq_name as username')
                ->where('id',$user_id)
                ->find();
        }else{
            /*账号密码登录*/
            $info = $this
                ->field('id,avatar,username,mobile,company')
                ->where('id',$user_id)
                ->find();
        }
        return $info;
    }

}