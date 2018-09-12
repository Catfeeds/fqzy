<?php
/*
 * 纠错相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/7/19 16:20
 */
namespace app\portal\controller;

use app\portal\model\ErrorAskModel;
use cmf\controller\AdminBaseController;
use think\Db;

class AdminEaskController extends AdminBaseController
{
    /**
     * @adminMenu(
     *     'name'   => '用户纠错',
     *     'parent' => 'portal/AdminUser/default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 10000,
     *     'icon'   => '',
     *     'remark' => '用户纠错',
     *     'param'  => ''
     * )
     */
    public function index()
    {
        $error_ask = new ErrorAskModel();
        $list = $error_ask
            ->alias('e')
            ->field('e.*,u.username,a.title_text')
            ->join('__USERS__ u','u.id = e.user_id')
            ->join('__ASK__ a','a.id = e.ask_id')
            ->order('e.id DESC')
            ->paginate(30);

        $this->assign('page',$list->render());
        $this->assign('list',$list);
        return $this->fetch();
    }

}