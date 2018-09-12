<?php
/*
 * 测试用
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/27 10:06
 */
namespace app\portal\controller;

use cmf\controller\HomeBaseController;
use think\Config;
use think\Session;

class IndexController extends HomeBaseController
{
    public function index()
    {
        $this->check_login();
        $wxOAuth = new \Yurun\OAuthLogin\Weixin\OAuth2(Config::get('WX_APPID'),Config::get('WX_APP_SECRET'),url('Portal/Index/test','','',true));
        $callbackurl = $wxOAuth->getAuthUrl();
        $_SESSION['YURUN_WX_STATE'] = $wxOAuth->state;
        header('location:' . $callbackurl);
    }

    public function test()
    {
//        $userInfo = $wxOAuth->getUserInfo();
    }


}
