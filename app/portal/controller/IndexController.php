<?php
/*
 * 登录相关
 * By: Phpstorm
 * Author: xiaoJie
 * Datetime: 2018/10/30 17:48
 */
namespace app\portal\controller;

use app\portal\model\OrderModel;
use cmf\controller\HomeBaseController;
use think\Cache;

/**
 * @title 登录相关
 * @description  飞签之音登录相关的操作
 */
class IndexController extends HomeBaseController
{

    public function index()
    {
        $data = Cache::get('data');
        echo "<pre />";
        print_r($data);
        die();
    }

    /**
     * @title 微信登录
     * @description 接口说明
     * @author sgj
     * @url /home/index/wechatLogin
     * @method post
     *
     *
     * @header name:XX-Device-Type require:1 default: desc:设备类型
     *
     * @param name:openid type:int require:1 default:1 other: desc:openid
     *
     */
    public function  wechatLogin()
    {
        $openid=input('openid/s');
        $User=new  UserModel();
        $device_type= $this->request->header('XX-Device-Type');
        $data['token']=$User->getUserByWechat($device_type,$openid);
        //   dump($data);
        if(empty($data['token'])){
            $this->error('请先绑定手机号');
        }else{
            $this->success('',$data);
        }
    }
    /**
     * @title qq登录
     * @description 接口说明
     * @author sgj
     * @url /home/index/qqLogin
     * @method post
     *
     * @header name:XX-Device-Type require:1 default: desc:设备类型
     *
     * @param name:openid type:int require:1 default:1 other: desc:电话号码
     *
     */
    public function qqLogin()
    {
        $openid=input('openid/s');
        $User=new  UserModel();
        $device_type= $this->request->header('XX-Device-Type');
        $data['token']=$User->getUserByQQ($device_type,$openid);
        if(empty($data['token'])){
            $this->error('请先绑定手机号');
        }else{
            $this->success('',$data);
        }

    }
    /**
     * @title 三方注册
     * @description 接口说明
     * @author sgj
     * @url /home/index/secondLogin
     * @method post
     *
     * @header name:XX-Device-Type require:1 default: desc:设备类型
     *
     * @param name:openid type:int require:1 default:1 other: desc:qq或微信的openid
     * @param name:login_type type:int require:1 default:1 other: desc:登录类型1,微信2,qq
     * @param name:tel type:int require:1 default:1 other: desc:电话号码
     * @param name:code type:int require:1 default:1 other: desc:验证码
     * @param name:nickname type:int require:1 default:1 other: desc:昵称
     * @param name:avatar type:int require:1 default:1 other: desc:头像地址
     * @param name:invite_id type:int require:1 default:1 other: desc:邀请码
     * @param name:type type:int require:1 default:1 other: desc:邀请端类型1.用户端2.服务端
     *
     */
    public function secondLogin()
    {
        $tel = input('tel/s');
        $code = input('code/s');
        $openid = input('openid/s');
        $type = input('login_type/d');
        $invite_type = input('type');
        $father_id = base64_decode(input('invite_id'));
        if (empty($openid)) {
            $this->lack();
        }
        if ($type == '1') {
            $type = 'wechat';
            $data['wechat'] = $openid;
        } else {
            $type = 'qq';
            $data['qq'] = $openid;
        }
        $device_type = $this->request->header('XX-Device-Type');
        /*检查验证码信息*/
        $is = cmf_check_verification_code($tel, $code, $clear = true);
        if (!empty($is)) {
            $this->error($is);
        }
        $data['mobile'] = $tel;
        $data['avatar'] = input('avatar');
        $data['create_time'] = time();
        $data['user_nickname'] = $tel;
        $data['user_login'] = $tel;
        $insert['invite_type'] = $invite_type??'';
        $insert['father_id'] = $father_id??'';
        /*检查一下是否有原来的用户名*/
        $isin = \db('user')->where('user_login', $tel)->find();
        if (empty($isin)) {
            $uid = \db('user')->insertGetId($data);
            if ($uid > 1) {
                if ($invite_type == 1) {
                    $this->inviteDiscount($uid, $father_id);
                }
            }
            /*发放新人优惠券*/
            $User=new UserModel();
            $send[]=$uid;
            $option=  cmf_get_option('site_info');
            $welcome=$option['discount'];
            $User->sendDiscount($welcome,$send);

        } else {
            $uid = $isin['id'];
            /*绑定原有用户手机号*/
            if ($isin[$type] == '') {
                if (empty($isin['avatar'])) {
                    $update['avatar'] = input('avatar');
                }
                $update[$type] = $openid;
                \db('user')->where('user_login', $tel)->update($update);
            } else {
                $this->error('此账号已经绑定!');
            }
        }
        $token = cmf_generate_user_token($uid, $device_type);
        $this->success('', $token);
    }

}
