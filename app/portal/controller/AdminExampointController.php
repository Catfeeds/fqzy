<?php
/*
 * 考点提炼
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/7/19 17:35
 */
namespace app\portal\controller;

use cmf\controller\AdminBaseController;
use app\portal\model\ExaminationModel;

class AdminExampointController extends AdminBaseController
{
    /**
     *
     * @adminMenu(
     *     'name'   => '考点提炼',
     *     'parent' => 'Portal/AdminAsk/default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 10000,
     *     'icon'   => '',
     *     'remark' => '考点提炼',
     *     'param'  => ''
     * )
     */
    public function index()
    {
        $examination = new ExaminationModel();
        $list = $examination
            ->alias('e')
            ->field('e.*,c.name')
            ->join('__PORTAL_CATEGORY__ c','c.id = e.cate_id')
            ->where('e.type',1)
            ->select();

        $this->assign('list',$list);
        return $this->fetch();
    }

    /**
     * 添加
     */
    public function add()
    {
        $this->assign('type',1);
        return $this->fetch('admin_examintro/add');
    }


}