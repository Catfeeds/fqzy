<?php
/*
 * 支付宝app支付
 * By: Phpstorm
 * Author: XiaoJie
 * Datetime: 2018/10/27 10:43
 */
namespace app\portal\controller;

use cmf\controller\HomeBaseController;
use think\Cache;
use think\Config;
use Yansongda\Pay\Pay;
use Yansongda\Pay\Log;
use think\Db;

class AlipayController extends HomeBaseController
{
    protected $config;

    public function _initialize()
    {
        parent::_initialize(); // TODO: Change the autogenerated stub
        $this->config = [
            'app_id' => Config::get('ALI_APPID'),
            'notify_url' => 'http://fqzy.w.bronet.cn/portal/alipay/notify',
            'return_url' => 'http://fqzy.w.bronet.cn/portal/alipay/returnhtml',
            'ali_public_key' => Config::get('ALI_PUBLIC_KEY'),
            // 加密方式： **RSA2**
            'private_key' =>Config::get('ALI_PRIVATE_KEY'),
            'log' => [ // optional
                'file' => './logs/alipay.log',
                'level' => 'debug', // 建议生产环境等级调整为 info，开发环境为 debug
                'type' => 'single', // optional, 可选 daily.
                'max_file' => 30, // optional, 当 type 为 daily 时有效，默认 30 天
            ],
            'http' => [ // optional
                'timeout' => 5.0,
                'connect_timeout' => 5.0,
                // 更多配置项请参考 [Guzzle](https://guzzle-cn.readthedocs.io/zh_CN/latest/request-options.html)
            ],
//            'mode' => 'dev', // optional,设置此参数，将进入沙箱模式
        ];
    }

    public function pay($order_sn,$price)
    {

        $order['out_trade_no'] = $order_sn;
        $order['subject'] = '飞签之音';
//        $order['total_amount'] = $price;
        $order['total_amount'] = 0.01;
        $alipay = Pay::alipay($this->config)->app($order);
        return $alipay->getContent(); // laravel 框架中请直接 `return $alipay`
    }

    public function returnhtml()
    {
        $data = Pay::alipay($this->config)->verify(); // 是的，验签就这么简单！

        // 订单号：$data->out_trade_no
        // 支付宝交易号：$data->trade_no
        // 订单总金额：$data->total_amount
    }

    public function notify()
    {
        $alipay = Pay::alipay($this->config);

        try{
            $data = $alipay->verify(); // 是的，验签就这么简单！
            $data = $data->all();
            Db::name('order')->where('order_sn',$data['out_trade_no'])->data([
                'order_status' => 1,
                'pay_time' => date('Y-m-d H:i:s'),
                'transaction_id' => $data['trade_no']
            ])->update();
            Log::debug('Alipay notify', $data->all());
        } catch (Exception $e) {
             $e->getMessage();
            \think\Log::write($e);
        }

        return $alipay->success()->send();// laravel 框架中请直接 `return $alipay->success()`
    }
}