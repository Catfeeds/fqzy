<?php
/*
 * 订单相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/9/29 13:11
 */
namespace app\portal\controller;

use app\portal\model\OrderModel;
use app\portal\service\OrderService;
use cmf\controller\HomeBaseController;

/**
 * @title 订单相关
 * @description 购买两周和一年，每个分类价格不一样
 */

class OrderController extends HomeBaseController
{
    /**
     * @title 下订单
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Order/putOrder
     * @method POST
     * @param name:token type:string require:1 default: false other: desc:token
     * @param name:cate_id type:int require:1 default: false other: desc:一级分类
     * @param name:buy_type type:int require:1 default: false other: desc:1两周2一年
     * @param name:pay_type type:int require:0 default: 1 other: desc:1->微信支付，2->支付宝支付
     */
    public function putOrder()
    {
        $param = $this->request->param();
        $order = new OrderModel();
        $wechat = new WechatpayController();
        $ali = new AlipayController();
        $this->isEmptyArray([
            'token' => $param['token'],
            'cate_id' => $param['cate_id'],
            'buy_type' => $param['buy_type']
        ]);
        $user_id = $this->tokenToUid($param['token']);
        //查询是否已买过此分类
        $if_mai = $order->where([
            'user_id' => $user_id,
            'cate_id' => $param['cate_id'],
            'order_status' => 1,
            'expire_time' => ['gt',date('Y-m-d H:i:s')]
        ])->find();
        if($if_mai){
            $this->apiResponse(0,'您已购买过此分类');
        }
        $order_sn = cmf_get_order_sn();
        $buy_info = OrderService::get_buy_info($param['buy_type'],$param['cate_id']);
        if(!$buy_info){
            $this->apiResponse(0,'BUY_TYPE类型不合法');
        }
        $data = [
            'user_id' => $user_id,
            'order_sn' => $order_sn,
            'cate_id' => $param['cate_id'],
            'order_status' => 0,
            'create_time' => date('Y-m-d H:i:s'),
            'price' => $buy_info['price'],
            'expire_time' => $buy_info['expire_time']
        ];
        $res = $order->insert($data);
        if(empty($param['pay_type']) or $param['pay_type'] == 1){
            /*微信支付*/
            $pay_data = $wechat->pay($order_sn,$buy_info['price']);
        }else{
            /*支付宝支付*/
            $pay_data = $ali->pay($order_sn,$buy_info['price']);
        }
        if($res){
            $this->apiResponse(1,'ok',$pay_data);
        }
    }

    /**
     * @title 取消订单
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Order/delOrder
     * @method POST
     * @param name:order_sn type:string require:1 default: false other: desc:order_sn

     */
    public function delOrder()
    {
        $order_sn = $this->request->param('order_sn','');
        $order = new OrderModel();
        $res = $order->where('order_sn',$order_sn)->delete();
        if($res){
            $this->apiResponse(1,'ok');
        }
    }

    /**
     * @title 直接支付
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Order/topay
     * @method POST
     * @param name:order_sn type:string require:1 default: false other: desc:order_sn
     * @param name:pay_type type:int require:0 default: 1 other: desc:1->微信支付，2->支付宝支付
     */
    public function topay()
    {
        $param = $this->request->param();
        $wechat = new WechatpayController();
        $ali = new AlipayController();
        $order = new OrderModel();
        $this->isEmptyArray([
            'order_sn' => $param['order_sn'],
            'pay_type' => $param['pay_type']
        ]);
        $order_info = $order->where('order_sn',$param['order_sn'])->find();
        if($param['pay_type'] == 1){
            /*微信支付*/
            $pay_data = $wechat->pay($order_info['order_sn'],$order_info['price']);
        }elseif($param['pay_type'] == 2){
            /*支付宝支付*/
            $pay_data = $ali->pay($order_info['order_sn'],$order_info['price']);
        }else{
            $this->apiResponse(0,'error');
        }
        $this->apiResponse(1,'ok',$pay_data);
    }
}
