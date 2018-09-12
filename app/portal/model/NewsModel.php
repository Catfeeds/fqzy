<?php
/*
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/15 16:42
 */
namespace app\portal\model;

use think\Model;

class NewsModel extends Model
{
    /**
     * post_content 自动转化
     * @param $value
     * @return string
     */
    public function getThumbAttr($value)
    {
        return cmf_get_image_preview_url($value);
    }
}