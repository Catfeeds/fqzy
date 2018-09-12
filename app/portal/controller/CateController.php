<?php
/*
 * 分类相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/15 16:14
 */
namespace app\portal\controller;

use app\portal\model\AskModel;
use app\portal\model\OrderModel;
use app\portal\model\PortalCategoryModel;
use app\portal\service\OrderService;
use cmf\controller\HomeBaseController;

/**
 * @title 分类相关
 * @description 项目所有分类相关内容
 */

class CateController extends HomeBaseController
{
    /**
     * @title 获取顶级分类
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Cate/topCate
     * @method POST
     * @param name:limit_num type:int require:0 default: false other: desc:显示的数量，不填默认全部
     */
    public function topCate()
    {
        $limit_num = $this->request->param('limit_num',false);
        $cate = new PortalCategoryModel();
        $list = $cate
            ->field('id as cate_id,name')
            ->where('parent_id',0)
            ->order('list_order ASC')
            ->limit($limit_num)
            ->select();
        $this->apiResponse(1,'获取成功',$list);
    }

    /**
     * @title 获取二级分类（题库）
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Cate/twoCate
     * @method POST
     * @param name:token type:string require:1 default: false other: desc:token
     * @param name:cate_id type:int require:1 default: false other: desc:topCate返回的cate_id
     */
    public function twoCate()
    {
        $post = $this->request->param();
        $cate = new PortalCategoryModel();
        $ask = new AskModel();
        $user_id = $this->tokenToUid($post['token']);
        //判断是否已购买此分类
        $if_mai = OrderService::user_is_mai($user_id,$post['cate_id']);
        if(!$if_mai){
            $this->apiResponse(0,'未购买','');
        }
        $list = $cate
            ->field('id as cate_id,name')
            ->where('parent_id',$post['cate_id'])
            ->order('id DESC')
            ->select();
        foreach ($list as $k=>$v){
            $list[$k]['ask_num'] = $ask->where('cate_id',$v['cate_id'])->count();
        }
        $this->apiResponse(1,'获取成功',$list);
    }

}
