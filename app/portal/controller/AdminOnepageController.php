<?php
/*
 * 单个页面文章管理
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/15 13:34
 */
namespace app\portal\controller;

use app\portal\model\OnepageModel;
use cmf\controller\AdminBaseController;

class AdminOnepageController extends AdminBaseController
{
    /**
     * 用户注册协议及免责声明(id为1)
     */
    public function regart()
    {
        $onepage = new OnepageModel();
        if($this->request->isPost()){
            $content = $this->request->param('content','');
            $res = $onepage->where('id',1)->data([
                'content' => $content,
                'update_time' => date('Y-m-d H:i:s')
            ])->update();
            if($res){
                $this->success('数据已更新');
            }
        }else{
            $info = $onepage->find(1);
            $info['content'] = htmlspecialchars_decode($info['content']);

            $this->assign('info',$info);
            return $this->fetch();
        }
    }

    /**
     * 关于我们(id为2)
     */
    public function aboutus()
    {
        $onepage = new OnepageModel();
        if($this->request->isPost()){
            $content = $this->request->param('content','');
            $res = $onepage->where('id',2)->data([
                'content' => $content,
                'update_time' => date('Y-m-d H:i:s')
            ])->update();
            if($res){
                $this->success('数据已更新');
            }
        }else{
            $info = $onepage->find(2);
            $info['content'] = htmlspecialchars_decode($info['content']);

            $this->assign('info',$info);
            return $this->fetch();
        }
    }

}
