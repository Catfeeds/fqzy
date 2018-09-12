<?php
/*
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/16 15:30
 */
namespace app\portal\service;

use app\portal\model\OrderModel;

class OrderService
{
    /**
     * 判断用户是否购买此分类
     */
    public static function user_is_mai($user_id,$cate_id)
    {
        $order = new OrderModel();
        $info = $order->where([
            'user_id' => $user_id,
            'cate_id' => $cate_id,
            'order_status' => 1,
            'expire_time' => ['gt',date('Y-m-d H:i:s')]
        ])->find();
        if($info){
            return true;
        }
        return false;
    }

}