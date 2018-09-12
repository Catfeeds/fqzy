<?php
/*
 * 用户留言相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/7/18 17:14
 */
namespace app\portal\controller;

use app\portal\model\AdviceModel;
use cmf\controller\AdminBaseController;
use think\Db;

class AdminAdviceController extends AdminBaseController
{
    /**
     * @adminMenu(
     *     'name'   => '用户留言',
     *     'parent' => 'portal/AdminUser/default',
     *     'display'=> true,
     *     'hasView'=> true,
     *     'order'  => 10000,
     *     'icon'   => '',
     *     'remark' => '用户留言',
     *     'param'  => ''
     * )
     */
    public function index()
    {
        $advice = new AdviceModel();
        $list = $advice
            ->field('a.*,u.username,u.mobile,u.company')
            ->alias('a')
            ->join('__USERS__ u','a.user_id = u.id')
            ->order('a.id DESC')
            ->paginate(20);

        $this->assign('page',$list->render());
        $this->assign('list',$list);
        return $this->fetch();
    }

    /**
     * @adminMenu(
     *     'name'   => '留言回复',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> true,
     *     'order'  => 10000,
     *     'icon'   => '',
     *     'remark' => '留言回复',
     *     'param'  => ''
     * )
     */
    public function reply()
    {
        $id = $this->request->param('id','','intval');
        $advice = new AdviceModel();
        $info = $advice->find($id);
        $this->assign('info',$info);
        return $this->fetch();
    }

    /**
     * @adminMenu(
     *     'name'   => '留言回复提交',
     *     'parent' => 'index',
     *     'display'=> false,
     *     'hasView'=> false,
     *     'order'  => 10000,
     *     'icon'   => '',
     *     'remark' => '留言回复提交',
     *     'param'  => ''
     * )
     */
    public function replyPost()
    {
        $post = $this->request->param();
        $advice = new AdviceModel();
        $res = $advice->where('id',$post['id'])->data([
            'reply_content' => $post['reply_content'],
            'reply_time' => date('Y-m-d H:i:s')
        ])->update();
        if(!$res){
            $this->error('回复失败！');
        }
        $this->success('回复成功！');
    }

}