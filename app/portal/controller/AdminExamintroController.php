<?php
/*
 * 考试介绍
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/7/19 17:20
 */
namespace app\portal\controller;

use app\portal\model\ExaminationModel;
use cmf\controller\AdminBaseController;
use think\Db;

class AdminExamintroController extends AdminBaseController
{
    /**
     *
     * @adminMenu(
     *     'name'   => '考试介绍',
     *     'parent' => 'Portal/AdminAsk/default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 10000,
     *     'icon'   => '',
     *     'remark' => '考试介绍',
     *     'param'  => ''
     * )
     */
    public function index()
    {
        $exam = new ExaminationModel();
        $list = $exam->where('type',0)->select();

        $this->assign('list',$list);
        return $this->fetch();
    }


}