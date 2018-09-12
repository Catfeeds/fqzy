<?php
// +----------------------------------------------------------------------
// | ThinkCMF [ WE CAN DO IT MORE SIMPLE ]
// +----------------------------------------------------------------------
// | Copyright (c) 2013-2018 http://www.thinkcmf.com All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +---------------------------------------------------------------------
// | Author: Dean <zxxjjforever@163.com>
// +----------------------------------------------------------------------
namespace cmf\controller;

use think\Config;
use think\Db;
use app\admin\model\ThemeModel;
use think\View;
use think\Session;

//9f3073d844d0016b051c076ee62f6e36f9026609309cb4e7624f6926b7a8963d
class HomeBaseController extends BaseController
{

    public function _initialize()
    {
        // 监听home_init
        hook('home_init');
        parent::_initialize();
        $siteInfo = cmf_get_site_info();
        View::share('site_info', $siteInfo);
    }

    /**
     * 检查用户登录
     */
    protected function check_login()
    {
        $session_user = Session::get('user_id');
        if (empty($session_user)) {
            $code = $this->request->param('code','','string');
            //通过code换取网页授权access_token和openid
            $openidUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=" .
                Config::get('WX_APPID') . "&secret=" . Config::get('WX_APP_SECRET') . "&code=" .
                $code . "&grant_type=authorization_code";
            $openidData = json_decode(file_get_contents($openidUrl), true);
            isset($openidData['access_token'])? $access_token = $openidData['access_token']:$access_token='';
            if($access_token){
                // 通过access_token和openid拉取用户信息
                $userinfoUrl = "https://api.weixin.qq.com/sns/userinfo?access_token=" . $openidData['access_token']
                    . "&openid=" . $openidData['openid'] . "&lang=zh_CN";
                $userinfoData = json_decode(file_get_contents($userinfoUrl), true);
            }
            if (isset($userinfoData) and isset($userinfoData['openid'])) {
                dump($userinfoData);
            } else {
                $url = urlencode('http://' . $_SERVER['HTTP_HOST'] . $_SERVER['REQUEST_URI']);
                header('Location: https://open.weixin.qq.com/connect/oauth2/authorize?appid=' .
                    Config::get('WX_APPID') . '&redirect_uri=' . $url .
                    '&response_type=code&scope=snsapi_userinfo&state=STATE#wechat_redirect');
            }
        }
    }

    public function _initializeView()
    {
        $cmfThemePath    = config('cmf_theme_path');
        $cmfDefaultTheme = cmf_get_current_theme();

        $themePath = "{$cmfThemePath}{$cmfDefaultTheme}";

        $root = cmf_get_root();
        //使cdn设置生效
        $cdnSettings = cmf_get_option('cdn_settings');
        if (empty($cdnSettings['cdn_static_root'])) {
            $viewReplaceStr = [
                '__ROOT__'     => $root,
                '__TMPL__'     => "{$root}/{$themePath}",
                '__STATIC__'   => "{$root}/static",
                '__WEB_ROOT__' => $root
            ];
        } else {
            $cdnStaticRoot  = rtrim($cdnSettings['cdn_static_root'], '/');
            $viewReplaceStr = [
                '__ROOT__'     => $root,
                '__TMPL__'     => "{$cdnStaticRoot}/{$themePath}",
                '__STATIC__'   => "{$cdnStaticRoot}/static",
                '__WEB_ROOT__' => $cdnStaticRoot
            ];
        }

        $viewReplaceStr = array_merge(config('view_replace_str'), $viewReplaceStr);
        config('template.view_base', "{$themePath}/");
        config('view_replace_str', $viewReplaceStr);

        $themeErrorTmpl = "{$themePath}/error.html";
        if (file_exists_case($themeErrorTmpl)) {
            config('dispatch_error_tmpl', $themeErrorTmpl);
        }

        $themeSuccessTmpl = "{$themePath}/success.html";
        if (file_exists_case($themeSuccessTmpl)) {
            config('dispatch_success_tmpl', $themeSuccessTmpl);
        }


    }

    /**
     * 加载模板输出
     * @access protected
     * @param string $template 模板文件名
     * @param array $vars 模板输出变量
     * @param array $replace 模板替换
     * @param array $config 模板参数
     * @return mixed
     */
    protected function fetch($template = '', $vars = [], $replace = [], $config = [])
    {
        $template = $this->parseTemplate($template);
        $more     = $this->getThemeFileMore($template);
        $this->assign('theme_vars', $more['vars']);
        $this->assign('theme_widgets', $more['widgets']);
        return parent::fetch($template, $vars, $replace, $config);
    }

    /**
     * 自动定位模板文件
     * @access private
     * @param string $template 模板文件规则
     * @return string
     */
    private function parseTemplate($template)
    {
        // 分析模板文件规则
        $request = $this->request;
        // 获取视图根目录
        if (strpos($template, '@')) {
            // 跨模块调用
            list($module, $template) = explode('@', $template);
        }

        $viewBase = config('template.view_base');

        if ($viewBase) {
            // 基础视图目录
            $module = isset($module) ? $module : $request->module();
            $path   = $viewBase . ($module ? $module . DS : '');
        } else {
            $path = isset($module) ? APP_PATH . $module . DS . 'view' . DS : config('template.view_path');
        }

        $depr = config('template.view_depr');
        if (0 !== strpos($template, '/')) {
            $template   = str_replace(['/', ':'], $depr, $template);
            $controller = cmf_parse_name($request->controller());
            if ($controller) {
                if ('' == $template) {
                    // 如果模板文件名为空 按照默认规则定位
                    $template = str_replace('.', DS, $controller) . $depr . $request->action();
                } elseif (false === strpos($template, $depr)) {
                    $template = str_replace('.', DS, $controller) . $depr . $template;
                }
            }
        } else {
            $template = str_replace(['/', ':'], $depr, substr($template, 1));
        }
        return $path . ltrim($template, '/') . '.' . ltrim(config('template.view_suffix'), '.');
    }

    /**
     * 获取模板文件变量
     * @param string $file
     * @param string $theme
     * @return array
     */
    private function getThemeFileMore($file, $theme = "")
    {

        //TODO 增加缓存
        $theme = empty($theme) ? cmf_get_current_theme() : $theme;

        // 调试模式下自动更新模板
        if (APP_DEBUG) {
            $themeModel = new ThemeModel();
            $themeModel->updateTheme($theme);
        }

        $themePath = config('cmf_theme_path');
        $file      = str_replace('\\', '/', $file);
        $file      = str_replace('//', '/', $file);
        $file      = str_replace(['.html', '.php', $themePath . $theme . "/"], '', $file);

        $files = Db::name('theme_file')->field('more')->where(['theme' => $theme])->where(function ($query) use ($file) {
            $query->where(['is_public' => 1])->whereOr(['file' => $file]);
        })->select();

        $vars    = [];
        $widgets = [];
        foreach ($files as $file) {
            $oldMore = json_decode($file['more'], true);
            if (!empty($oldMore['vars'])) {
                foreach ($oldMore['vars'] as $varName => $var) {
                    $vars[$varName] = $var['value'];
                }
            }

            if (!empty($oldMore['widgets'])) {
                foreach ($oldMore['widgets'] as $widgetName => $widget) {

                    $widgetVars = [];
                    if (!empty($widget['vars'])) {
                        foreach ($widget['vars'] as $varName => $var) {
                            $widgetVars[$varName] = $var['value'];
                        }
                    }

                    $widget['vars']       = $widgetVars;
                    $widgets[$widgetName] = $widget;
                }
            }
        }

        return ['vars' => $vars, 'widgets' => $widgets];
    }

    public function checkUserLogin()
    {
        $userId = cmf_get_current_user_id();
        if (empty($userId)) {
            if ($this->request->isAjax()) {
                $this->error("您尚未登录", cmf_url("user/Login/index"));
            } else {
                $this->redirect(cmf_url("user/Login/index"));
            }
        }
    }

    /**
     *  API返回信息格式函数 ；0失败，1成功
     * @param string $code
     * @param string $message
     * @param array $data
     */
    public function apiResponse($code = '', $msg = '',$data = array()){
        header('Access-Control-Allow-Origin: *');
        header('Content-Type:application/json; charset=utf-8');
        $result = array(
            'code'=>$code,
            'msg'=>$msg,
            'data'=>$data,
        );
        die(json_encode($result,JSON_UNESCAPED_UNICODE));
    }

    /**
     * 发送手机验证码
     * @param $mobile
     * @param $code
     * @return mixed
     */
    public function sendCode($mobile,$content){
        date_default_timezone_set('PRC');//设置时区
        $url 		= "http://www.ztsms.cn/sendNSms.do";//提交地址
        $username 	= Config::get('MB_USERNAME');//用户名
        $password 	= Config::get('MB_PASSWORD');//原密码
        $data = array(
            'content' 	=> $content,//短信内容
            'mobile' 	=> $mobile,//手机号码
            'productid' => '676767',//产品id
            'xh'		=> ''//小号
        );
        $isTranscoding = false;
        $timeout = 30;
        $data['content'] = $isTranscoding === true ? mb_convert_encoding($data['content'], "UTF-8") : $data['content'];
        $data['username']=$username;
        $data['tkey'] 	= date('YmdHis');
        $data['password'] = md5(md5($password) . $data['tkey']);
        $curl = curl_init();// 启动一个CURL会话
        curl_setopt($curl, CURLOPT_URL, $url); // 要访问的地址
        curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false); // 对认证证书来源的检查
        curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false); // 从证书中检查SSL加密算法是否存在
        curl_setopt($curl, CURLOPT_POST, true); // 发送一个常规的Post请求
        curl_setopt($curl, CURLOPT_POSTFIELDS,  http_build_query($data)); // Post提交的数据包
        curl_setopt($curl, CURLOPT_TIMEOUT, $timeout); // 设置超时限制防止死循环
        curl_setopt($curl, CURLOPT_HEADER, false); // 显示返回的Header区域内容
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true); // 获取的信息以文件流的形式返回
        $result = curl_exec($curl); // 执行操作
        return $result;
    }

    /**
     * @param $token
     * @return mixed
     */
    public function tokenToUid($token)
    {
        if(empty($token)){
            $this->apiResponse(0,'缺少必要参数：TOKEN','');
        }
        $info = Db::name('user_token')->where('token',$token)->find();
        if($info['expire_time'] < time()){
            $this->apiResponse(0,'TOKEN已过期，请重新授权','');
        }
        return $info['user_id'];
    }

    /**
     * 判断是否为空
     */
    public function isEmpty($post,$param)
    {
        if(empty($post)){
            $this->apiResponse(0,'缺少必要参数:'.$param,'');
        }
    }

    /**
     * 判断是否为空（数组）
     */
    public function isEmptyArray($post)
    {
        foreach ($post as $k=>$v){
            if(empty($v)){
                $this->apiResponse(0,'缺少必要参数:'.strtoupper($k),'');
            }
        }
    }
}