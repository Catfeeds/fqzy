<?php
/*
 * 新闻资讯
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/15 16:33
 */
namespace app\portal\controller;

use app\portal\model\NewsModel;
use cmf\controller\AdminBaseController;

class AdminNewsController extends AdminBaseController
{
    public function index()
    {
        $news = new NewsModel();
        $list = $news->order('id DESC')->select();

        $this->assign('list',$list);
        return $this->fetch();
    }

    /**
     * 添加
     */
    public function add()
    {
        if($this->request->isPost()){
            $post = $this->request->param();
            $news = new NewsModel();
            $res = $news->insert($post);
            if($res){
                $this->success('添加成功');
            }
            $this->error('添加失败');
        }else{
            return $this->fetch();
        }
    }

    /**
     * 编辑
     */
    public function edit()
    {
        $news = new NewsModel();
        if($this->request->isPost()){
            $post = $this->request->param();
            $res = $news->update($post);
            if($res){
                $this->success('已更新');
            }
            $this->error('编辑失败');
        }else{
            $id = $this->request->param('id','','intval');
            $info = $news->find($id);
            $info['content'] = htmlspecialchars_decode($info['content']);

            $this->assign('info',$info);
            return $this->fetch();
        }
    }

    /**
     * 删除
     */
    public function delete()
    {
        $id = $this->request->param('id','','intval');
        $news = new NewsModel();
        $res = $news->where('id',$id)->delete();
        if($res){
            $this->success('删除成功');
        }
    }

}