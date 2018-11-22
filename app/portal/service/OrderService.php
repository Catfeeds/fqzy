<?php
/*
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/16 15:30
 */
namespace app\portal\service;

use app\portal\model\OrderModel;
use app\portal\model\PortalCategoryModel;

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

    /**
     * 根据购买类型返回价格和过期时间
     * buy_type(1两周，2一年)
     */
    public static function get_buy_info($buy_type,$cate_id)
    {
        $cate = new PortalCategoryModel();
        $cate_info = $cate->where('id',$cate_id)->find();
        if(empty($cate_info)){
            return false;
        }
        $cate_info = $cate_info->toArray();
        if($cate_info['parent_id'] != 0){
            //不是一级分类，错误
            return false;
        }
        if($buy_type == 1){
            $data = [
                'price' => $cate_info['weekprice'],
                'expire_time' => date('Y-m-d H:i:s',time()+86400*7),
            ];
        }elseif($buy_type == 2){
            $data = [
                'price' => $cate_info['yearprice'],
                'expire_time' => date('Y-m-d H:i:s',time()+86400*365),
            ];
        }else{
            //不符合购买类型，错误
            return false;
        }
        return $data;
    }

}