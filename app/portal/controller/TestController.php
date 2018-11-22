<?php
/*
 * 测试题目相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/10/22 11:02
 */
namespace app\portal\controller;

use app\portal\model\AskModel;
use app\portal\model\TestDetailModel;
use app\portal\model\TestModel;
use app\portal\model\UseingTestModel;
use app\portal\model\UsersModel;
use app\portal\service\AskService;
use cmf\controller\HomeBaseController;


/**
 * @title 测试题目相关
 * @description 项目所有与测试题目相关内容
 */

class TestController extends HomeBaseController
{
    /**
     * @title 验证邀请码
     * @description 描述
     * @author 开发者
     * @url /Portal/Test/validateCode
     * @method POST
     * @param name:code type:string require:1 default: false other: desc:用户填写的邀请码
     */
    public function validateCode()
    {
        $param = $this->request->param();
        $useing_test = new UseingTestModel();
        $info = $useing_test->getUseingInfo();
        if($param['code'] !== $info['code']){
            $this->apiResponse(0,'验证失败');
        }
        $this->apiResponse(1,'验证通过',['cate_id'=>$info['cate_id']]);
    }

    /**
     * @title 开始答题
     * @description 描述
     * @author 开发者
     * @url /Portal/Test/begin
     * @method POST
     * @param name:token type:string require:1 default: false other: desc:token
     */
    public function begin()
    {
        $param = $this->request->param();
        $test = new TestModel();
        $useing_test = new UseingTestModel();
        /*后台设置的正在进行的测试题库*/
        $test_info = $useing_test->getUseingInfo();
        $user_id = $this->tokenToUid($param['token']);
        /*$add为test表id*/
        $add = $test->insertGetId([
            'user_id' => $user_id,
            'cate_id' => $test_info['cate_id'],
            'create_time' => date('Y-m-d H:i:s')
        ]);
        $this->apiResponse(1,'ok',['test_id'=>$add]);
    }

    /**
     * @title 获取题目
     * @description 描述
     * @author 开发者
     * @url /Portal/Test/getTestAsk
     * @method POST
     * @param name:test_id type:int require:1 default: false other: desc:开始答题(begin())返回的test_id
     * @param name:sort type:int require:1 default: false other: desc:题号，首次传1
     */
    public function getTestAsk()
    {
        $param = $this->request->param();
        $ask = new AskModel();
        $test = new TestModel();
        $useing_test = new UseingTestModel();
        /*后台设置的正在进行的测试题库*/
        $test_info = $useing_test->getUseingInfo();
        /*查询此题目*/
        $info = $ask->where([
            'cate_id' => $test_info['cate_id'],
            'sort' => $param['sort']
        ])->find();
        if(empty($info)){
            $this->apiResponse(0,'没有更多题目了');
        }
        /*获取整个题目详细信息*/
        $info = AskService::askDetail($info);
        /*查询该题目是否做过*/
        $info['doinfo'] = $test->isDoTest($param['test_id'],$info['id']);
        /*获取下一题sort*/
        $info['next_sort'] = $test->nextSort($param['sort'],$test_info['cate_id']);
        /*获取上一题sort*/
        $info['last_sort'] = $test->lastSort($param['sort']);
        $this->apiResponse(1,'ok',$info);
    }

    /**
     * @title 记录题目
     * @description 描述
     * @author 开发者
     * @url /Portal/Test/doTestAsk
     * @method POST
     * @param name:test_id type:int require:1 default: false other: desc:开始答题(begin())返回的test_id
     * @param name:ask_id type:int require:1 default: false other: desc:getTestAsk()接口返回的id
     * @param name:right_option_id type:int require:1 default: false other: desc:getTestAsk()接口返回的
     * @param name:user_option_id type:int require:1 default: false other: desc:用户答案
     */
    public function doTestAsk()
    {
        $param = $this->request->param();
        $test_detail = new TestDetailModel();
        $this->isEmptyArray([
            'test_id' => $param['test_id'],
            'ask_id' => $param['ask_id'],
            'right_option_id' => $param['right_option_id'],
            'user_option_id' => $param['user_option_id'],
        ]);
        if($param['right_option_id'] == $param['user_option_id']){
            $param['is_right'] = 1;
        }else{
            $param['is_right'] = 0;
        }
        $is_has = $test_detail->where([
            'test_id' => $param['test_id'],
            'ask_id' => $param['ask_id']
        ])->find();
        if($is_has){
            $this->apiResponse(0,'已经记录过了');
        }
        $param['create_time'] = date('Y-m-d H:i:s');
        $res = $test_detail->insert($param);
        if($res){
            $this->apiResponse(1,'ok');
        }
    }

    /**
     * @title 测试结束
     * @description 描述
     * @author 开发者
     * @url /Portal/Test/testEnd
     * @method POST
     * @param name:test_id type:int require:1 default: false other: desc:开始答题(begin())返回的test_id
     * @param name:token type:string require:1 default: false other: desc:token
     */
    public function testEnd()
    {
        $param = $this->request->param();
        $user = new UsersModel();
        $ask = new AskModel();
        $useing_test = new UseingTestModel();
        $test_detail = new TestDetailModel();
        $user_id = $this->tokenToUid($param['token']);
        $test_info = $useing_test->getUseingInfo();
        $data['userinfo'] = $user->getMyMessage($user_id);
        $data['error_num'] = $test_detail->where([
            'test_id' => $param['test_id'],
            'is_right' => 0
        ])->count();
        $data['right_num'] = $test_detail->where([
            'test_id' => $param['test_id'],
            'is_right' => 1
        ])->count();
        $data['total_num'] =$ask->where([
            'cate_id' => $test_info['cate_id'],
        ])->count();
        $data['error_nums'] = $data['total_num'] - $data['right_num'];
        $this->apiResponse(1,'ok',$data);
    }

}