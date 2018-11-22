<?php
/*
 * 个人中心
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/16 10:42
 */
namespace app\portal\controller;

use app\portal\model\AdviceModel;
use app\portal\model\OrderModel;
use app\portal\model\ReplyModel;
use app\portal\model\UsersModel;
use cmf\controller\HomeBaseController;

/**
 * @title 个人中心
 * @description 个人中心相关内容
 */

class MineController extends HomeBaseController
{
    /**
     * @title 获取我的信息
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Mine/getmyMessage
     * @method POST
     * @param name:token type:string require:1 default: other: desc:token
     */
    public function getmyMessage()
    {
        $token = $this->request->param('token','');
        $user = new UsersModel();
        $user_id = $this->tokenToUid($token);
        $login_type = $user->where('id',$user_id)->value('login_type');
        if($login_type == 1){
            /*微信登录*/
            $info = $user
                ->field('id,mobile,company,wechat_avatar as avatar,wechat_name as username')
                ->where('id',$user_id)
                ->find();
        }elseif($login_type == 2){
            /*qq登录*/
            $info = $user
                ->field('id,mobile,company,qq_avatar as avatar,qq_name as username')
                ->where('id',$user_id)
                ->find();
        }else{
            /*账号密码登录*/
            $info = $user
                ->field('id,avatar,username,mobile,company')
                ->where('id',$user_id)
                ->find();
        }
        $info['mobile'] = substr_replace($info['mobile'], '****', 3, 4);
        $this->apiResponse(1,'获取成功',$info);
    }

    /**
     * @title 修改个人信息信息
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Mine/editmyMessage
     * @method POST
     * @param name:token type:string require:1 default: other: desc:token
     * @param name:avatar type:string require:0 default: other: desc:头像
     * @param name:mobile type:string require:0 default: other: desc:手机号
     * @param name:username type:string require:0 default: other: desc:用户名
     */
    public function editmyMessage()
    {
        $post = $this->request->param();
        $user = new UsersModel();
        $user_id = $this->tokenToUid($post['token']);
        if(!empty($post['avatar'])){
            $data['avatar'] = $post['avatar'];
        }
        if(!empty($post['mobile'])){
            $data['mobile'] = $post['mobile'];
        }
        if(!empty($post['username'])){
            $data['username'] = $post['username'];
        }
        $data['update_time'] = date('Y-m-d H:i:s');
        $res = $user->where('id',$user_id)->data($data)->update();
        if($res){
            $this->apiResponse(1,'资料已更新','');
        }
    }

    /**
     * @title 在线留言
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Mine/advice
     * @method POST
     * @param name:token type:string require:1 default: other: desc:token
     * @param name:content type:string require:1 default: other: desc:留言内容
     */
    public function advice()
    {
        $post = $this->request->param();
        $advice = new AdviceModel();
        $user_id = $this->tokenToUid($post['token']);
        if(empty($post['content'])){
            $this->apiResponse(0,'缺少必要参数：CONTENT','');
        }
        $res = $advice->insert([
            'user_id' => $user_id,
            'content' => $post['content'],
            'create_time' => date('Y-m-d H:i:s')
        ]);
        if($res){
            $this->apiResponse(1,'提交成功','');
        }
    }

    /**
     * @title 回复列表
     * @description is_look->0代表未查看，1代表已查看
     * @author 开发者
     * @url /Portal/Mine/getReply
     * @method POST
     * @param name:token type:string require:1 default: other: desc:token
     */
    public function getReply()
    {
        $token = $this->request->param('token','');
        $reply = new ReplyModel();
        $user_id = $this->tokenToUid($token);
        $list = $reply
            ->field('id,reply_title,is_look')
            ->where('user_id',$user_id)
            ->order('id DESC')
            ->select();
        $this->apiResponse(1,'获取成功',$list);
    }

    /**
     * @title 回复详情
     * @description 说明
     * @author 开发者
     * @url /Portal/Mine/replyDetail
     * @method POST
     * @param name:id type:int require:1 default: other: getReply接口返回的id
     */
    public function replyDetail()
    {
        $id = $this->request->param('id','');
        $reply = new ReplyModel();
        $reply
            ->where('id',$id)
            ->data([
                'is_look' => 1,
                'look_time' => time()
            ])->update();
        $info = $reply
            ->field('reply_title,reply_content')
            ->where('id',$id)
            ->find();
        $this->apiResponse(1,'获取成功',$info);
    }

    /**
     * @title 我的订单
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Mine/orderList
     * @method POST
     * @param name:token type:string require:1 default: other: desc:token
     * @param name:order_status type:string require:1 default: other: desc:0未支付，1已支付
     */
    public function orderList()
    {
        $post = $this->request->param();
        $order = new OrderModel();
        $user_id = $this->tokenToUid($post['token']);
        if($post['order_status'] != 0 and $post['order_status'] != 1){
            $this->apiResponse(0,'参数ORDER_STATUS不正确','');
        }
        $list = $order
            ->alias('o')
            ->field('o.order_sn,o.cate_id,o.order_status,o.price,o.expire_time,o.pay_time,c.name')
            ->join('__PORTAL_CATEGORY__ c','c.id = o.cate_id')
            ->where([
                'o.user_id' => $user_id,
                'o.order_status' => $post['order_status']
            ])
            ->order('o.id DESC')
            ->select()->toArray();
        foreach ($list as $k=>$v){
            if($v['order_status'] == 1){
                $list[$k]['order_text'] = '已支付';
            }else{
                $list[$k]['order_text'] = '未支付';
            }
            $list[$k]['effect_time'] = date('Y.m.d',strtotime($v['pay_time']))."-".date('Y.m.d',strtotime($v['expire_time']));
            unset($list[$k]['order_status']);
            unset($list[$k]['expire_time']);
            unset($list[$k]['pay_time']);
        }
        $this->apiResponse(1,'获取成功',$list);
    }

    /**
     * @title 取消订单
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Mine/cencelOrder
     * @method POST
     * @param name:order_sn type:string require:1 default: other: desc:订单编号
     */
    public function cencelOrder()
    {
        $order_sn = $this->request->param('order_sn','');
        $order = new OrderModel();
        $res = $order->where('order_sn',$order_sn)->delete();
        if($res){
            $this->apiResponse(1,'取消成功','');
        }
    }

    /**
     * @title 比较用户填写手机号与该账号手机号是否一致
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Mine/compareMobile
     * @method POST
     * @param name:token type:string require:1 default: other: desc:token
     * @param name:user_mobile type:string require:1 default: other: desc:用户填的手机号
     */
    public function compareMobile()
    {
        $token = $this->request->param('token','');
        $user_mobile = $this->request->param('user_mobile','');
        $user = new UsersModel();
        $user_id = $this->tokenToUid($token);
        $mobile = $user
            ->where('id',$user_id)
            ->value('mobile');
        if($user_mobile != $mobile){
            $this->apiResponse(0,'手机号验证不正确','');
        }
        $this->apiResponse(1,'验证通过','');
    }
}