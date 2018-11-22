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
        $examination = new ExaminationModel();
        $list = $examination
            ->alias('e')
            ->field('e.*,c.name')
            ->join('__PORTAL_CATEGORY__ c','c.id = e.cate_id')
            ->where('e.type',0)
            ->select();

        $this->assign('list',$list);
        return $this->fetch();
    }

    /**
     * 添加
     */
    public function add()
    {
        $this->assign('type',0);
        return $this->fetch('admin_examintro/add');
    }

    /**
     * 添加提交
     */
    public function addPost()
    {
        $param = $this->request->param();
        $examination = new ExaminationModel();
        $param['create_time'] = date('Y-m-d H:i:s');
        if(empty($param['content'])){
            $this->error('内容不能为空');
        }
        if($examination->where(['cate_id'=>$param['cate_id'],'type'=>$param['type']])->find()){
            $this->error('此分类下已有内容，请选择其他分类');
        }
        $res = $examination->insert($param);
        if($res){
            $this->success('添加成功');
        }
    }

    /**
     * 详情
     */
    public function edit()
    {
        $id = $this->request->param('id','','intval');
        $examination = new ExaminationModel();
        $info = $examination->where('id',$id)->find();
        $info['content'] = htmlspecialchars_decode($info['content']);

        $this->assign('info',$info);
        return $this->fetch();
    }

    /**
     * 编辑提交
     */
    public function editPost()
    {
        $param = $this->request->param();
        $examination = new ExaminationModel();
        if(empty($param['content'])){
            $this->error('内容不能为空');
        }
        $res = $examination->where('id',$param['id'])->data([
            'content' => $param['content'],
            'create_time' => date('Y-m-d H;i:s')
        ])->update();
        if($res){
            $this->success('修改成功');
        }
    }

}