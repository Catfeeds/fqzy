<?php
/*
 * 登录注册相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/15 15:15
 */
namespace app\portal\controller;

use app\portal\model\CompanyModel;
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
     * @param name:company type:string require:1 default: other: desc:所属单位
     */
    public function register()
    {
        $post = $this->request->param();
        $user = new UsersModel();
        $company = new CompanyModel();
        if(empty($post['mobile'])){
            $this->apiResponse(0,'缺少必要参数:MOBILE','');
        }
        if(empty($post['company'])){
            $this->apiResponse(0,'缺少必要参数:COMPANY','');
        }
        $post['company'] = $company->where('id',$post['company'])->value('company');
        $userinfo = $user->where('mobile',$post['mobile'])->find();
        if($userinfo){
            $this->apiResponse(0,'此用户已注册','');
        }
        $res = $user->insertGetId([
            'mobile' => $post['mobile'],
            'company' => $post['company'],
            'avatar' => 'http://fqzy.w.bronet.cn/upload/header.png',
            'username' => '飞签之音',
            'create_time' => date('Y-m-d H:i:s'),
            'last_login_time' => date('Y-m-d H:i:s')
        ]);
        $token = cmf_generate_user_token($res);
        if($res){
            $this->apiResponse(1,'注册成功',$token);
        }
    }

    /**
     * @title 用户登录（手机号验证码登录）
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Login/login
     * @method POST
     * @param name:mobile type:string require:1 default: other: desc:手机号
     * @param name:mobile_code type:string require:1 default: other: desc:验证码
     * @return token:token
     */
    public function login()
    {
        $param = $this->request->param();
        $user = new UsersModel();
        $this->isEmptyArray([
            'mobile' => $param['mobile'],
            'mobile_code' => $param['mobile_code']
        ]);
        $userinfo = $user->where('mobile',$param['mobile'])->find();
        if(empty($userinfo)){
            $this->apiResponse(0,'请注册后登录','');
        }
        /*更新登录信息*/
        $user->where('id',$userinfo['id'])->data([
            'last_login_time' => date('Y-m-d H:i:s'),
            'login_type' => 0 //普通的手机号登录
        ])->update();
        $token = cmf_generate_user_token($userinfo['id']);
        $this->apiResponse(1,'登录成功',$token);
    }

    /**
     * @title 获取单位
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Login/getCompany
     * @method POST
     */
    public function getCompany()
    {
        $company = new CompanyModel();
        $list = $company->field('id,company')->select()->toArray();
        $this->apiResponse(1,'获取成功',$list);
    }

    /**
     * @title 三方注册
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Login/secondRegister
     * @method post
     *
     * @param name:login_type type:int require:1 default:1 other: desc:登录类型:1->微信,2->qq
     * @param name:openid type:string require:1 default:1 other: desc:qq或微信的openid
     * @param name:name type:string require:1 default:1 other: desc:qq或微信的昵称
     * @param name:avatar type:string require:1 default:1 other: desc:qq或微信头像地址
     * @param name:mobile type:string require:1 default: other: desc:手机号
     * @param name:company_id type:id require:1 default: other: desc:所属单位id
     *
     */
    public function secondRegister()
    {
        $param = $this->request->param();
        $user = new UsersModel();
        $company = new CompanyModel();
        $this->isEmptyArray([
            'login_type' => $param['login_type'],
            'openid' => $param['openid'],
            'name' => $param['name'],
            'avatar' => $param['avatar'],
            'mobile' => $param['mobile'],
            'company_id' => $param['company_id']
        ]);
        if($param['login_type'] == 1){
            /*微信注册*/
            $threedata = [
                'wechat' => $param['openid'],
                'wechat_name' => $param['name'],
                'wechat_avatar' => $param['avatar']
            ];
            /*查询是否已注册过*/
            $if_has = $user->where(['mobile'=>$param['mobile']])->whereOr(['wechat'=>$param['openid']])->find();
        }elseif ($param['login_type'] == 2){
            /*qq注册*/
            $threedata = [
                'qq' => $param['openid'],
                'qq_name' => $param['name'],
                'qq_avatar' => $param['avatar']
            ];
            /*查询是否已注册过*/
            $if_has = $user->where(['mobile'=>$param['mobile']])->whereOr(['qq'=>$param['openid']])->find();
        }else{
            $this->apiResponse(0,'LOGIN_TYPE非法');
        }
        if($if_has){
            $this->apiResponse(0,'此账号已被注册');
        }
        $company = $company->where('id',$param['company_id'])->value('company');
        if(empty($company)){
            $this->apiResponse(0,'COMPANY_ID非法');
        }
        $publicdata = [
            'avatar' => 'http://fqzy.w.bronet.cn/upload/header.png',
            'username' => '王二狗',
            'mobile' => $param['mobile'],
            'company' => $company,
            'create_time' => date('Y-m-d H:i:s'),
            'last_login_time' => date('Y-m-d H:i:s'),
            'update_time' => date('Y-m-d H:i:s'),
            'login_type' => $param['login_type']
        ];
        $data = array_merge($publicdata,$threedata);
        $user_id = $user->insertGetId($data);
        $token = cmf_generate_user_token($user_id);
        $this->apiResponse(1,'注册成功',['token' => $token]);
    }

    /**
     * @title 用户登录（微信登录）
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Login/loginByWechat
     * @method POST
     * @param name:openid type:string require:1 default: other: desc:微信的openid
     * @return token:token
     */
    public function loginByWechat()
    {
        $param = $this->request->param();
        $user = new UsersModel();
        $this->isEmptyArray([
            'openid' => $param['openid'],
        ]);
        $userinfo = $user->where('wechat',$param['openid'])->find();
        if(empty($userinfo)){
            $this->apiResponse(0,'请注册后登录','');
        }
        /*更新登录信息*/
        $user->where('id',$userinfo['id'])->data([
            'last_login_time' => date('Y-m-d H:i:s'),
            'login_type' => 1 //通过微信登录
        ])->update();
        $token = cmf_generate_user_token($userinfo['id']);
        $this->apiResponse(1,'登录成功',$token);
    }

    /**
     * @title 用户登录（QQ登录）
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Login/loginByQQ
     * @method POST
     * @param name:openid type:string require:1 default: other: desc:QQ的openid
     * @return token:token
     */
    public function loginByQQ()
    {
        $param = $this->request->param();
        $user = new UsersModel();
        $this->isEmptyArray([
            'openid' => $param['openid'],
        ]);
        $userinfo = $user->where('qq',$param['openid'])->find();
        if(empty($userinfo)){
            $this->apiResponse(0,'请注册后登录','');
        }
        /*更新登录信息*/
        $user->where('id',$userinfo['id'])->data([
            'last_login_time' => date('Y-m-d H:i:s'),
            'login_type' => 2 //通过QQ登录
        ])->update();
        $token = cmf_generate_user_token($userinfo['id']);
        $this->apiResponse(1,'登录成功',$token);
    }

    /**
     * @title 判断是否注册
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Login/isRegister
     * @method POST
     * @param name:openid type:string require:1 default: other: desc:QQ的openid
     * @param name:type type:string require:1 default: other: desc:1->QQ 2->wechat
     * @return token:token
     */
    public function isRegister()
    {
        $param = $this->request->param();
        $this->isEmptyArray([
            'openid' => $param['openid'],
            'type' => $param['type']
        ]);
        $user = new UsersModel();
        if($param['type'] == 1){
            $where['qq'] = $param['openid'];
        }elseif ($param['type'] == 2){
            $where['wechat'] = $param['openid'];
        }else{
            $this->apiResponse(0,'ERROR');
        }
        $res = $user->where($where)->find();
        if($res){
            $this->apiResponse(0,'已注册');
        }
        $this->apiResponse(1,'未注册');
    }

}