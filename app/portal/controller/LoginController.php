<?php
/*
 * 登录注册相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/15 15:15
 */
namespace app\portal\controller;

use app\portal\model\UsersModel;
use cmf\controller\HomeBaseController;

/**
 * @title 登录注册
 * @description 登录注册授权使用
 */

class LoginController extends HomeBaseController
{
    /**
     * @title 用户注册
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Login/register
     * @method POST
     * @param name:mobile type:string require:1 default: other: desc:手机号
     * @param name:mobile_code type:string require:1 default: other: desc:验证码
     * @param name:company type:string require:1 default: other: desc:所属单位
     */
    public function register()
    {
        $post = $this->request->param();
        $user = new UsersModel();
        if(empty($post['mobile'])){
            $this->apiResponse(0,'缺少必要参数:MOBILE','');
        }
        if(empty($post['mobile_code'])){
            $this->apiResponse(0,'缺少必要参数:MOBILE_CODE','');
        }
        if(empty($post['company'])){
            $this->apiResponse(0,'缺少必要参数:COMPANY','');
        }
        $userinfo = $user->where('mobile',$post['mobile'])->find();
        if($userinfo){
            $this->apiResponse(0,'此用户已注册','');
        }
        $res = $user->insert([
            'mobile' => $post['mobile'],
            'company' => $post['company'],
            'create_time' => date('Y-m-d H:i:s')
        ]);
        if($res){
            $this->apiResponse(1,'注册成功','');
        }
    }

    /**
     * @title 用户登录
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Login/login
     * @method POST
     * @param name:mobile type:string require:1 default: other: desc:手机号
     * @param name:mobile_code type:string require:1 default: other: desc:验证码
     * @return uid:用户id
     */
    public function login()
    {
        $post = $this->request->param();
        $user = new UsersModel();
        if(empty($post['mobile'])){
            $this->apiResponse(0,'缺少必要参数:MOBILE','');
        }
        if(empty($post['mobile_code'])){
            $this->apiResponse(0,'缺少必要参数:MOBILE_CODE','');
        }
        $userinfo = $user->where('mobile',$post['mobile'])->find();
        if(empty($userinfo)){
            $this->apiResponse(0,'请注册后登录','');
        }
        $this->apiResponse(1,'登录成功',$userinfo['id']);
    }

}