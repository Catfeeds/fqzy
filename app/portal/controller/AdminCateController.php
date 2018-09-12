<?php
/*
 * 分类部分(废弃)
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/7/5 11:32
 */
namespace app\portal\controller;

use cmf\controller\AdminBaseController;
use app\portal\model\CateModel;
use think\Db;

class AdminCateController extends AdminBaseController
{
    public function index()
    {
        $cate = new CateModel();
        $list = $cate->field('id,cate_name')->where('pid',0)->select()->toArray();
        dump($list);
    }

}
