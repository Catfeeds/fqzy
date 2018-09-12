<?php
/*
 * 用户反馈新题相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/7/19 14:40
 */
namespace app\portal\controller;

use app\portal\model\UserAskModel;
use cmf\controller\AdminBaseController;
use think\Db;

class AdminUaskController extends AdminBaseController
{
    /**
     * @adminMenu(
     *     'name'   => '反馈管理',
     *     'parent' => 'Portal/AdminUser/default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 10000,
     *     'icon'   => '',
     *     'remark' => '反馈管理',
     *     'param'  => ''
     * )
     */
    public function index()
    {
        $user_ask = new UserAskModel();
        $list = $user_ask
            ->alias('a')
            ->field('a.*,u.username,c.name')
            ->join('__USERS__ u','u.id = a.user_id')
            ->join('__PORTAL_CATEGORY__ c','c.id = a.cate_id')
            ->order('a.id DESC')
            ->select();

        $this->assign('list',$list);
        return $this->fetch();
    }

}