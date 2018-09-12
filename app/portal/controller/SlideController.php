<?php
/*
 * 轮播图相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/15 14:28
 */
namespace app\portal\controller;

use app\portal\model\SlideItemModel;
use cmf\controller\HomeBaseController;

/**
 * @title 轮播图
 * @description 整个项目所有的轮播图
 */

class SlideController extends HomeBaseController
{
    /**
     * @title 首页轮播图
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Slide/index
     * @method POST
     * @return image:图片
     * @return url:链接
     */
    public function index()
    {
        $slideitem = new SlideItemModel();
        $list = $slideitem
            ->field('image,url')
            ->where('slide_id',1)
            ->order('list_order ASC')
            ->select();
        $this->apiResponse(1,'获取成功',$list);
    }

}