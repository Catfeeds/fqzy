<?php
/*
 * 文章相关
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/8/15 14:12
 */
namespace app\portal\controller;

use app\portal\model\ExaminationModel;
use app\portal\model\NewsModel;
use app\portal\model\OnepageModel;
use cmf\controller\HomeBaseController;

/**
 * @title 文章管理
 * @description 项目所有文章相关
 */

class OnepageController extends HomeBaseController
{
    /**
     * @title 用户注册协议及免责声明
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Onepage/regart
     * @method POST
     * @return content:文章内容
     */
    public function regart()
    {
        $onepage = new OnepageModel();
        $content = $onepage->where('id',1)->value('content');
        $content = cmf_replace_content_file_url(htmlspecialchars_decode($content));
        if(empty($content)){
            $this->apiResponse(1,'获取成功','请通知管理员上传用户注册协议及免责声明');
        }
        $this->apiResponse(1,'获取成功',$content);
    }

    /**
     * @title 关于我们
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Onepage/aboutUs
     * @method POST
     * @return content:文章内容
     */
    public function aboutUs()
    {
        $onepage = new OnepageModel();
        $content = $onepage->where('id',2)->value('content');
        $content = cmf_replace_content_file_url(htmlspecialchars_decode($content));
        if(empty($content)){
            $this->apiResponse(1,'获取成功','请通知管理员上传关于我们');
        }
        $this->apiResponse(1,'获取成功',$content);
    }

    /**
     * @title 新闻资讯列表
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Onepage/newsList
     * @method POST
     * @return title:标题
     * @return short_content:简介
     */
    public function newsList()
    {
        $news = new NewsModel();
        $list = $news
            ->field('id,title,short_content')
            ->select();
        $this->apiResponse(1,'获取成功',$list);
    }

    /**
     * @title 新闻资讯详情
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Onepage/newsDetail
     * @method POST
     * @param name:id type:int require:1 default: other: desc:newList接口返回的id
     * @return title:标题
     * @return thumb:缩略图
     * @return content:文章内容
     */
    public function newsDetail()
    {
        $id = $this->request->param('id','','intval');
        if(empty($id)){
            $this->apiResponse(0,'缺少必要参数：ID','');
        }
        $news = new NewsModel();
        $info = $news
            ->field('title,thumb,content')
            ->where('id',$id)
            ->find();
        $info['content'] = cmf_replace_content_file_url(htmlspecialchars_decode($info['content']));
        $this->apiResponse(1,'获取成功',$info);
    }

    /**
     * @title 获取考试介绍/考点提炼
     * @description 接口说明
     * @author 开发者
     * @url /Portal/Onepage/examIntro
     * @method POST
     * @param name:type type:int require:1 default: other: desc:0考试介绍，1考点提炼
     * @param name:cate_id type:int require:1 default: other: desc:一级分类id
     */
    public function examIntro()
    {
        $param = $this->request->param();
        $examination = new ExaminationModel();
        $this->isEmptyArray([
            'cate_id' => $param['cate_id']
        ]);
        $info = $examination->field('content')->where([
            'cate_id' => $param['cate_id'],
            'type' => $param['type']
        ])->find();
        $info['content'] = cmf_replace_content_file_url(htmlspecialchars_decode($info['content']));
        $this->apiResponse(1,'ok',$info);
    }

}