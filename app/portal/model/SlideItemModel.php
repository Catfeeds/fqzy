<?php
/*
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/7/18 17:14
 */
namespace app\portal\model;

use think\Model;

class SlideItemModel extends Model
{
    /**
     * post_content 自动转化
     * @param $value
     * @return string
     */
    public function getImageAttr($value)
    {
        return cmf_get_image_preview_url($value);
    }
}