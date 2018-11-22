<?php
/*
 * 定时任务相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/10/27 09:27
 */
namespace app\portal\controller;

use app\portal\model\UserExamModel;
use cmf\controller\HomeBaseController;

/**
 * @title 分类相关
 * @description 项目所有分类相关内容
 */

class TimeController extends HomeBaseController
{

    /**
     * 每分钟执行
     * 自动结束考试
     */
    public function end_exam()
    {
        $user_exam = new UserExamModel();
        $date = date('Y-m-d H:i:s');
        $where['is_end'] = 0;
        $where['force_end_time'] = ['lt',$date];
        $res = $user_exam->where($where)->data([
            'is_end' => 1,
            'end_time' => $date
        ])->update();
    }

}
