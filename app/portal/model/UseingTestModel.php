<?php
/*
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/10/22 11:05
 */
namespace app\portal\model;

use think\Model;

class UseingTestModel extends Model
{

    /**
     * 获取正在使用的测试题库信息
     */
    public function getUseingInfo()
    {
        $info = $this
            ->field('cate_id,code')
            ->where('is_use',1)
            ->find();
        return $info;
    }

}