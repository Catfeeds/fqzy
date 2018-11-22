<?php
/*
 * 搜索相关
 * By: Phpstorm
 * Author: xiaoJie
 * Datetime: 2018/11/02 11:01
 */
namespace app\portal\controller;

use app\portal\model\AskModel;
use app\portal\model\OrderModel;
use app\portal\model\PortalCategoryModel;
use app\portal\service\AskService;
use cmf\controller\HomeBaseController;
use think\console\output\Ask;


/**
 * @title 搜索相关
 * @description 搜索相关
 */

class SearchController extends HomeBaseController
{
    /**
     * @title 搜索
     * @description 接口说明
     * @author 开发者
     * @url /portal/search/search
     * @method POST
     * @param name:token type:string require:1 default: false other: desc:token
     * @param name:keyword type:string require:1 default: false other: desc:搜索关键词
     */
    public function search()
    {
        $param = $this->request->param();
        $cate = new PortalCategoryModel();
        $order = new OrderModel();
        $ask = new AskModel();
        $this->isEmptyArray([
            'token' => $param['token'],
            'keyword' => $param['keyword']
        ]);
        $buy = [];
        $nobuy = [];
        $user_id = $this->tokenToUid($param['token']);
        $map['parent_id'] = ['neq',0];
        $map['name'] = ['like',"%".$param['keyword']."%"];
        /*全部相关*/
        $list = $cate
            ->field('id,parent_id,name')
            ->where($map)
            ->select()->toArray();
        /*是否已购买*/
        foreach ($list as $k=>$v){
            $v['total_num'] = $ask->where('cate_id',$v['id'])->count();
            $info = $cate->where('id',$v['parent_id'])->find();
            $v['first_name'] = $info['name'];
            $v['weekprice'] = $info['weekprice'];
            $v['yearprice'] = $info['yearprice'];
            $if_buy = $order->where([
                'user_id' => $user_id,
                'cate_id' => $v['parent_id'],
                'order_status' => 1
            ])->find();
            if($if_buy){
                array_push($buy,$v);
            }else{
                array_push($nobuy,$v);
            }
        }
        $data['buy'] = $buy;
        $data['nobuy'] = $nobuy;
        $this->apiResponse(1,'ok',$data);
    }

    /**
     * @title 获取第一题
     * @description 接口说明
     * @author 开发者
     * @url /portal/search/getFirst
     * @method POST
     * @param name:cate_id type:string require:1 default: false other: desc:search()接口返回的id,这是二级分类id
     */
    public function getFirst()
    {
        $param = $this->request->param();
        $this->isEmptyArray([
            'cate_id' => $param['cate_id']
        ]);
        $ask = new AskModel();
        $ask_info = $ask
            ->where(['cate_id' => $param['cate_id']])
            ->order('id ASC')
            ->find();
        if(empty($ask_info)){
            $this->apiResponse(0,'没有第一题','');
        }
        $ask_info = AskService::askDetail($ask_info);
        //查询下一题id
        $ask_info['next_id'] = AskService::nextAskId($param['cate_id'],$ask_info['id']);
        //查询上一题
        $ask_info['last_id'] = AskService::lastAskId($param['cate_id'],$ask_info['id']);
        $this->apiResponse(1,'ok',$ask_info);
    }

}