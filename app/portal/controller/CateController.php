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
use app\portal\service\AskService;
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
     * @param name:token type:string require:0 default: false other: desc:token
     * @param name:limit_num type:int require:0 default: false other: desc:显示的数量，不填默认全部
     */
    public function topCate()
    {
        $token = $this->request->param('token','');
        if(!empty($token)){
            $user_id = $this->tokenToUid($token);
        }
        $limit_num = $this->request->param('limit_num',false);
        $cate = new PortalCategoryModel();
        $ask = new AskModel();
        $list = $cate
            ->field('id as cate_id,name,more,weekprice,yearprice')
            ->where([
                'parent_id' => 0,
                'id' => ['neq',27]
            ])
            ->order('list_order ASC')
            ->limit($limit_num)
            ->select();
        foreach ($list as $k =>$v){
            $list[$k]['thumb'] = cmf_get_image_preview_url($v['more']['thumbnail']);
            unset($list[$k]['more']);
            if(empty($token)){
                $list[$k]['is_pay'] = 0;
            }else{
                //判断是否已购买此分类
                $if_mai = OrderService::user_is_mai($user_id,$v['cate_id']);
                if($if_mai){
                    $list[$k]['is_pay'] = 1;
                }else{
                    $list[$k]['is_pay'] = 0;
                }
            }
            /*查询此分类下全部题目*/
            $two_cate_arr = $cate->getTwoCate($v['cate_id']);
            $list[$k]['total_count'] = $ask->where('cate_id','in',$two_cate_arr)->count();

        }
        $this->apiResponse(1,'获取成功',$list);
    }

    /**
     * @title 获取二级分类（题库）
     * @description info['status']->0从来没做过，1做过并且已完成，2做过并且未结束
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
            //此题库下的总题目数
            $list[$k]['ask_num'] = $ask->where('cate_id',$v['cate_id'])->count();
            $list[$k]['info'] = AskService::askRecord($user_id,$v['cate_id']);
        }
        $this->apiResponse(1,'获取成功',$list);
    }

}
