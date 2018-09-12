<?php
/*
 * 分类相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/7/17 16:22
 */
namespace app\portal\controller;

use app\portal\model\PortalCategoryModel;
use cmf\controller\HomeBaseController;
use think\Db;

class AdminPcateController extends HomeBaseController
{
    //判断选择分类是否正确
    public function if_two_cate()
    {
        $cate_id = $this->request->param('cate_id','','intval');
        $cate = new PortalCategoryModel();
        $parent_id = $cate->where('id',$cate_id)->value('parent_id');
        if($parent_id === 0){
            echo 1;die();
        }
    }

}