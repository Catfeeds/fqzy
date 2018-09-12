<?php
/*
 * 题目相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/7/5 13:37
 */
namespace app\portal\controller;

use app\portal\model\AskAnalysisModel;
use app\portal\model\AskOptionModel;
use app\portal\model\PortalCategoryModel;
use cmf\controller\AdminBaseController;
use app\portal\model\AskModel;
use think\Db;

class AdminAskController extends AdminBaseController
{
    public function index(){
        $cate_id = $this->request->param('cate_id', 0, 'intval');
        $keyword = $this->request->param('keyword', '');
        $portalCategoryModel = new PortalCategoryModel();
        $ask = new AskModel();
        $where = '';
        if(!empty($cate_id)){
            $if_topcate = $portalCategoryModel->where('id',$cate_id)->value('parent_id');
            if(empty($if_topcate)){
                $arr_cate_id = $portalCategoryModel->where('parent_id',$cate_id)->column('id');
                $where['a.cate_id'] = ['in',$arr_cate_id];
            }else{
                $where['a.cate_id'] = $cate_id;
            }
        }
        if(!empty($keyword)){
            $where['a.title_text'] = ['like',"%$keyword%"];
        }
        $list = $ask
            ->field('a.*,c.name')
            ->alias('a')
            ->join('__PORTAL_CATEGORY__ c','a.cate_id = c.id')
            ->where($where)
            ->order('a.sort ASC')
            ->paginate(50);
        $page = $list->render();
        $categoryTree        = $portalCategoryModel->adminCategoryTree($cate_id);

        $this->assign('page',$page);
        $this->assign('list',$list);
        $this->assign('categoryTree',$categoryTree);
        $this->assign('keyword',empty($keyword)?'':$keyword);
        return $this->fetch();
    }


    //添加文字题目
    public function addtext()
    {
        return $this->fetch();
    }

    //添加图片题目
    public function addpic()
    {
        return $this->fetch();
    }

    //添加题目(文字和图片两种)
    public function addPost()
    {
        $post = $this->request->param();
        if(empty($post['cate_id'])){
            $this->error('请选择分类！');
        }
        if(empty($post['option_content'][$post['right_option']])){
            $this->error('正确答案不科学！！');
        }
        Db::startTrans();
        $ask = new AskModel();
        $option = new AskOptionModel();
        $analysis = new AskAnalysisModel();
        $res_ask = $ask->insertGetId([
            'cate_id' => $post['cate_id'],
            'sort' => $post['sort'],
            'title_text' => $post['title_text'],
            'title_pic' => isset($post['title_pic'])?json_encode($post['title_pic']):'',
            'option_id' => 0,
            'option_type' => $post['option_type'],
            'create_time' => date('Y-m-d H:i:s')
        ]);
        $error_data = false;
        foreach ($post['option_content'] as $k=>$v){
            if(empty($v)){
                break;
            }
            $res_option = $option->insertGetId([
                'ask_id' => $res_ask,
                'option_content' => $v
            ]);
            if(!$res_option){
                $error_data = true;
                break;
            }
            if($post['right_option'] == $k){
                $res_ask_update = $ask->where('id',$res_ask)->setField('option_id',$res_option);
                if(!$res_ask_update){
                    $error_data = true;
                    break;
                }
            }
        }
        $res_analysis = $analysis->insert([
            'ask_id' => $res_ask,
            'analysis_content' => $post['analysis_content']
        ]);
        if(!$res_ask or $error_data or !$res_analysis){
            Db::rollback();
            $this->error('添加失败!');
        }
        Db::commit();
        $this->success('添加成功!');
    }

    //删除
    public function delete()
    {
        $id = $this->request->param('id','','intval');//ask表id
        Db::startTrans();
        $ask = new AskModel();
        $option = new AskOptionModel();
        $analysis = new AskAnalysisModel();
        $res_ask = $ask->where('id',$id)->delete();
        $res_option = $option->where('ask_id',$id)->delete();
        $res_analysis = $analysis->where('ask_id',$id)->delete();
        if(!$res_ask or !$res_option or !$res_analysis){
            Db::rollback();
            $this->error('删除失败!');
        }
        Db::commit();
        $this->success('删除成功!');
    }

    //编辑
    public function edit()
    {
        $id = $this->request->param('id','','intval');
        $ask = new AskModel();
        $option = new AskOptionModel();
        $info = $ask
            ->field('a.*,a.id as aid,c.name,aa.*')
            ->alias('a')
            ->join('__PORTAL_CATEGORY__ c','a.cate_id = c.id')
            ->join('__ASK_ANALYSIS__ aa','aa.ask_id = a.id')
            ->where('a.id',$id)
            ->find()
            ->toArray();
        $info['option'] = $option->where('ask_id',$id)->order('id ASC')->select()->toArray();
        $info['title_pic'] = json_decode($info['title_pic']);
        $this->assign('info',$info);
        if($info['option_type'] == 0){
            //文字
            return $this->fetch('edittext');
        }else{
//            echo "<pre/>";
//            print_r($info);
//            die;
            //图片
            return $this->fetch('editpic');
        }
    }

    //编辑
    public function editPost()
    {
        $post = $this->request->param();
        if(empty($post['option_content'][$post['right_option']])){
            $this->error('正确答案不科学！！');
        }
        Db::startTrans();
        $ask = new AskModel();
        $option = new AskOptionModel();
        $analysis = new AskAnalysisModel();
        $res_ask = $ask->update([
            'id' => $post['id'],
            'cate_id' => $post['cate_id'],
            'sort' => $post['sort'],
            'title_text' => $post['title_text'],
            'title_pic' => isset($post['title_pic'])?json_encode($post['title_pic']):'',
            'option_id' => 0,
            'option_type' => $post['option_type'],
            'create_time' => date('Y-m-d H:i:s')
        ]);
        $res_option_del = $option->where('ask_id',$post['id'])->delete();
        $error_data = false;
        foreach ($post['option_content'] as $k=>$v){
            if(empty($v)){
                break;
            }
            $res_option = $option->insertGetId([
                'ask_id' => $post['id'],
                'option_content' => $v
            ]);
            if(!$res_option){
                $error_data = true;
                break;
            }
            if($post['right_option'] == $k){
                $res_ask_update = $ask->where('id',$post['id'])->setField('option_id',$res_option);
                if(!$res_ask_update){
                    $error_data = true;
                    break;
                }
            }
        }
        $res_analysis = $analysis
            ->where('ask_id',$post['id'])
            ->data([
                'analysis_content'=>$post['analysis_content'],
                'update_time' => date('Y-m-d H:i:s')
            ])
            ->update();
        if(!$res_ask or $error_data or !$res_analysis or !$res_option_del){
            Db::rollback();
            $this->error('修改失败!');
        }
        Db::commit();
        $this->success('更新成功!');
    }

}
