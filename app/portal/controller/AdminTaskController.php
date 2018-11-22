<?php
/*
 * 测试题目相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/10/27 11:38
 */
namespace app\portal\controller;

use app\portal\model\PortalCategoryModel;
use app\portal\model\UseingTestModel;
use cmf\controller\AdminBaseController;

class AdminTaskController extends AdminBaseController
{
    public function index()
    {
        $cate = new PortalCategoryModel();
        $useing_test = new UseingTestModel();
        $info = $useing_test->where('id', 1)->find();
        $cate_list = $cate
            ->field('id,name')
            ->where('parent_id', 27)
            ->order('id DESC')
            ->select()->toArray();
        foreach ($cate_list as $k => $v) {
            if ($v['id'] == $info['cate_id']) {
                $cate_list[$k]['is_use'] = 1;
                $cate_list[$k]['code'] = $info['code'];
            } else {
                $cate_list[$k]['is_use'] = 0;
                $cate_list[$k]['code'] = '没有在使用';
            }
        }

        $this->assign('list', $cate_list);
        return $this->fetch();
    }

    /**
     * 使用
     */
    public function use_this()
    {
        $id = $this->request->param('id','','intval');
        $useing_test = new UseingTestModel();
        $res = $useing_test->where('id',1)->data([
            'cate_id' => $id,
            'code' => rand(000000,999999),
            'create_time' => date('Y-m-d H:i:s')
        ])->update();
        if($res){
            $this->success('测试题库已更新');
        }
    }

}