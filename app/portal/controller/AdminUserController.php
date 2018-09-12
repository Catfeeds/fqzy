<?php
/*
 * 会员相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/7/5 9:34
 */
namespace app\portal\controller;

use cmf\controller\AdminBaseController;
use app\portal\model\UsersModel;
use think\Db;

class AdminUserController extends AdminBaseController
{
    //会员列表
    public function index()
    {
        $where = "";
        $keyword = $this->request->param('keyword','');
        if(!empty($keyword)){
            $keyword = trim($keyword);
            $where['username|mobile'] = ['like',"$keyword"];
        }
        $users = new UsersModel();
        $list = $users->order('id DESC')->where($where)->paginate(20);
        $page = $list->render();

        $this->assign('list',$list);
        $this->assign('page',$page);
        return $this->fetch();
    }

    //修改会员信息
    public function edit()
    {
        $id = $this->request->param('id','','intval');//users表id
        $users = new UsersModel();
        $info = $users->find($id);

        $this->assign('info',$info);
        return $this->fetch();
    }

    //修改会员信息提交
    public function editPost()
    {
        $post = $this->request->param();
        $post['update_time'] = date('Y-m-d H:i:s');
        $users = new  UsersModel();
        $res = $users->update($post);
        if(!$res){
            $this->error('修改失败！');
        }
        $this->success('保存成功！');

    }
}