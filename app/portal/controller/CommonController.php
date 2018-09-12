<?php
/*
 * 通用类
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/16 11:43
 */

namespace app\portal\controller;

use app\portal\model\MobileCodeModel;
use cmf\controller\HomeBaseController;

/**
 * @title 通用文件
 * @description 接口说明
 */

class CommonController extends HomeBaseController
{
    /**
     * @title 上传照片
     * @description 接口说明
     * @author 开发者
     * @url /portal/Common/uploadPic
     * @method POST
     * @param name:pic type:file require:1 desc:$_file接收的文件
     */
    public function uploadPic()
    {
        $file = request()->file('pic');
        if(empty($file)){
            $this->apiResponse(0,'上传文件不能为空','');
        }
        if($file){
            $info = $file->move(ROOT_PATH . 'public' . DS . 'upload' . DS . 'header');
            if($info){
                $baseurl = $info->getSaveName();
                $this->apiResponse(1,'上传成功',$baseurl);
            }else{
                $error = $file->getError();
                $this->apiResponse(0,$error,'');
            }
        }
    }

    /**
     * @title 发送手机验证码
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Common/sendMobileCode
     * @method POST
     * @param name:mobile type:string require:1 default: other: desc:手机号
     */
    public function sendMobileCode()
    {
        $mobile = $this->request->param('mobile','');
        $mc = new MobileCodeModel();
        $mobile_code = rand(100000, 999999);
        $search = '/^0?1[3|4|5|6|7|8][0-9]\d{8}$/';
        if (!preg_match($search,$mobile)) {
            $this->apiResponse(0,'手机号格式有误','');
        }
        if(empty($mobile)){
            $this->apiResponse(0,'缺少必要参数:MOBILE','');
        }
        $content = "【飞签之音】您的验证码为".$mobile_code."，如非本人操作请忽略本短信!";
        //发送验证码
//        $this->sendCode($mobile,$content);
        $info = $mc->where('mobile',$mobile)->find();
        if($info){
            if($info['expire_time'] > time() and $info['is_use'] == 0){
                $this->apiResponse(0,'不能频繁发送验证码','');
            }
            $res = $mc->where('id',$info['id'])->data([
                'mobile' => $mobile,
                'mobile_code' => $mobile_code,
                'is_use' => 0,
                'expire_time' => time()+300,
                'count' => $info['count'] +1
            ])->update();
        }else{
            $res = $mc->insert([
                'mobile' => $mobile,
                'mobile_code' => $mobile_code,
                'is_use' => 0,
                'expire_time' => time()+300,
                'count' => 0
            ]);
        }
        if($res){
            $this->apiResponse(1,'发送成功','');
        }
    }

    /**
     * @title 验证手机验证码
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Common/validateMobileCode
     * @method POST
     * @param name:mobile type:string require:1 default: other: desc:手机号
     * @param name:mobile_code type:string require:1 default: other: desc:手机验证码
     */
    public function validateMobileCode()
    {
        $post = $this->request->param();
        $mc = new MobileCodeModel();
        if(empty($post['mobile'])){
            $this->apiResponse(0,'缺少必要参数：MOBILE','');
        }
        if(empty($post['mobile_code'])){
            $this->apiResponse(0,'缺少必要参数：MOBILE_CODE','');
        }
        $res_find = $mc->where([
            'mobile' => $post['mobile'],
            'mobile_code' => $post['mobile_code'],
            'is_use' => 0,
            'expire_time' => ['gt',time()]
        ])->find();
        if($res_find){
            $res_update = $mc->where('id',$res_find['id'])->setField('is_use',1);
            if($res_update){
                $this->apiResponse(1,'验证成功','');
            }
        }else{
            $this->apiResponse(0,'验证未通过','');
        }
    }

}