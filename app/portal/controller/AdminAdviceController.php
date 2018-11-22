<?php
/*
 * 用户留言相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/7/18 17:14
 */
namespace app\portal\controller;

use app\portal\model\AdviceModel;
use app\portal\model\ErrorAskModel;
use app\portal\model\ReplyModel;
use app\portal\model\UserAskModel;
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
        $table_name = $this->request->param('table_name','');
        $reply = new ReplyModel();
        $info = $reply->where([
            'table_name' => $table_name,
            'toid' => $id
        ])->find();
        if(empty($info)){
            $info['toid'] = $id;
            $info['reply_title'] = '';
            $info['reply_content'] = '';
        }
        $this->assign('info',$info);
        $this->assign('table_name',$table_name);
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
        if($post['table_name'] == 'advice'){
            $bain = new AdviceModel();
        }elseif ($post['table_name'] == 'user_ask'){
            $bain = new UserAskModel();
        }else{
            $bain = new ErrorAskModel();
        }
        $reply = new ReplyModel();
        Db::startTrans();
        $info = $bain->where('id',$post['id'])->find();
        $res = $bain->where('id',$post['id'])->setField('reply_status',1);
        $res2 = $reply->insert([
            'toid' => $post['id'],
            'table_name' => $post['table_name'],
            'reply_title' => $post['reply_title'],
            'reply_content' => $post['reply_content'],
            'user_id' => $info['user_id']
        ]);
        if(!$res or !$res2){
            Db::rollback();
            $this->error('已回复！');
        }
        Db::commit();
        $this->success('回复成功！');
    }

}