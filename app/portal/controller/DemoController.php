<?php
/*
 * 登录注册
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/14 17:22
 */
namespace app\portal\controller;

use cmf\controller\HomeBaseController;

/**
 * @title 登录注册
 * @description 登录注册授权使用
 */

class DemoController extends HomeBaseController
{
    /**
     * @title 登录接口
     * @description 接口说明
     * @author 开发者
     * @url /Login/index
     * @method POST
     * @param name:id type:int require:1 default:1 other: desc:唯一ID
     * @return name:名称
     */
    public function index()
    {
        //接口代码
        $device = $this->request->header('device');
        echo json_encode(["code"=>200, "message"=>"success", "data"=>['device'=>$device]]);
    }
}