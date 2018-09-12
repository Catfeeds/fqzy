<?php
/*
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/16 9:34
 */
namespace app\portal\validate;

use think\Validate;

class UserAskValidate extends Validate
{
    protected $rule = [
        'user_id' => 'require',
        'cate_id' => 'require|number',
        'ask_content' => 'require',
        'right_option' => 'require',
        'one_option' => 'require',
        'two_option' => 'require',
        'analysis_content' => 'require',
    ];

    protected $message = [
        'user_id.require' => '缺少必要参数:USER_ID',
        'cate_id.require' => '缺少必要参数:CATE_ID',
        'cate_id.number' => '参数CATE_ID必须是整数',
        'ask_content.require' => '缺少必要参数:ASK_CONTENT',
        'right_option.require' => '缺少必要参数:RIGHT_OPTION',
        'one_option.require' => '缺少必要参数:ONE_OPTION',
        'two_option.require' => '缺少必要参数:TWO_OPTION',
        'analysis_content.require' => '缺少必要参数:ANALYSIS_CONTENT',
    ];
}