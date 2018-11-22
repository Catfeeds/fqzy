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
use think\Request;

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
        $file = $this->request->file();
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
     * @title 上传照片(app)
     * @description 接口说明
     * @author 开发者
     * @url /portal/Common/upAvatar
     * @method POST
     * @param name:file type:file require:1 desc:$_file接收的文件
     */
    public function upAvatar()
    {
        header("content-type:text/html;charset=utf-8");
        $allowedExts = array("gif", "jpeg", "jpg", "png");
        $temp = explode(".", $_FILES["file"]["name"]);
        $extension = end($temp);
        if ((($_FILES["file"]["type"] == "image/gif")
                || ($_FILES["file"]["type"] == "image/jpeg")
                || ($_FILES["file"]["type"] == "image/jpg")
                || ($_FILES["file"]["type"] == "image/pjpeg")
                || ($_FILES["file"]["type"] == "image/x-png")
                || ($_FILES["file"]["type"] == "image/png"))
            && ($_FILES["file"]["size"] < 2048000)
            && in_array($extension, $allowedExts)) {
            if ($_FILES["file"]["error"] > 0) {
                $list['ok'] = 0;
                $list['error'] = "上传错误";
                echo json_encode($list);
            } else {
                if ($_FILES["file"]["type"] == "image/gif") {
                    $img = date('Ymdgi-s') . '.gif';
                } else if ($_FILES["file"]["type"] == "image/jpeg" || $_FILES["file"]["type"] == "image/jpg" || $_FILES["file"]["type"] == "image/pjpeg") {
                    $img = date('Ymdgi-s') . '.jpg';
                } else {
                    $img = date('Ymdgi-s') . '.png';
                }

                $path = ROOT_PATH . 'public' . DS . 'upload' . DS . 'header/' . $img;
                move_uploaded_file($_FILES["file"]["tmp_name"], $path);
                $request = Request::instance();
                $domain = $request->domain();
                $url = $domain . "/upload/header/" . $img;
                $image = \think\Image::open($path);
                $image->thumb(300, 300, \think\Image::THUMB_CENTER)->save($path);
                $msg['url'] = $url;
                $this->apiResponse(1,'上传成功',$msg);
            }
        } else {
            $list['ok'] = 2;
            $list['error'] = "无效的图像";
            $this->apiResponse(0,'无效的图像');
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
            $this->apiResponse(0,'后端手机号格式有误','');
        }
        if(empty($mobile)){
            $this->apiResponse(0,'缺少必要参数:MOBILE','');
        }
        $content = "【飞签之音】您的验证码为".$mobile_code."，如非本人操作请忽略本短信!";
        //发送验证码
        $this->sendCode($mobile,$content);
        $info = $mc->where('mobile',$mobile)->find();
        if($info){
            if(($info['expire_time']-240) > time() and $info['is_use'] == 0){
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
            $this->apiResponse(1,'发送成功',$mobile_code);
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