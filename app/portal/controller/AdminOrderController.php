<?php
/*
 * 订单相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/7/19 11:33
 */
namespace app\portal\controller;

use app\portal\model\OrderModel;
use app\portal\model\PortalCategoryModel;
use cmf\controller\AdminBaseController;
use think\Db;

class AdminOrderController extends AdminBaseController
{
    /**
     * @adminMenu(
     *     'name'   => '订单管理',
     *     'parent' => 'Portal/AdminUser/default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 10000,
     *     'icon'   => '',
     *     'remark' => '订单管理',
     *     'param'  => ''
     * )
     */
    public function index()
    {
        $cate_id = $this->request->param('cate_id','','intval');
        $start_time = $this->request->param('start_time','');
        $end_time = $this->request->param('end_time','');
        $keyword = $this->request->param('keyword','');
        if(!empty($keyword)){
            $where['o.order_sn | u.username | u.mobile'] = ['like',"%$keyword%"];
        }
        if(!empty($start_time) and !empty($end_time)){
            $where['o.pay_time'] = ['between',[$start_time,$end_time]];
        }
        if(!empty($cate_id)){
            $where['o.cate_id'] = $cate_id;
        }
        $order = new OrderModel();
        $cate = new PortalCategoryModel();
        $cate_list = $cate
            ->field('id,name')
            ->where('parent_id',0)
            ->select()
            ->toArray();
        $where['o.order_status'] = 1;
        $list = $order
            ->alias('o')
            ->field('o.*,u.username,u.mobile,c.name')
            ->join('__USERS__ u','u.id = o.user_id')
            ->join('__PORTAL_CATEGORY__ c','c.id = o.cate_id')
            ->where($where)
            ->paginate(20);

        $this->assign('list',$list);
        $this->assign('cate_list',$cate_list);
        $this->assign('page',$list->render());
        $this->assign('cate_id',empty($cate_id)?'':$cate_id);
        $this->assign('start_time',empty($start_time)?'':$start_time);
        $this->assign('end_time',empty($end_time)?'':$end_time);
        $this->assign('keyword',empty($keyword)?'':$keyword);
        return $this->fetch();
    }

}