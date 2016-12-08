<?php
/**
 * Created by PhpStorm.
 * User: imdante
 * Date: 2016/10/17
 * Time: 14:41
 */

namespace app\common\controller;
use think\Controller;
use com\wechat\Wechat;
use com\wechat\Func;
class Weixin extends Controller
{
    private $appid;
    private $appsecret;
    private $redirect_uri;
    /**
     * 微信验证 和数据接口
     */
    public function api(){
        $wechat = new Wechat();
        $wechat::vaild();
    }

    public function authorize($state='mshop')
    {

        $config = cache('weixin_config');
        if(!$config){
            $config = db('weixin_config')->find();
            cache('weixin_config',$config,0);
        }
        $this->appid =  $config['appid'];
        $this->appsecret =  $config['appsecret'];
        $this->redirect_uri = urlencode('http://' . request()->host() . url('common/weixin/callback'));

        $getCodeUrl = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=$this->appid&redirect_uri=$this->redirect_uri&response_type=code&scope=snsapi_userinfo&state=$state#wechat_redirect";
        header("Location: $getCodeUrl");
    }

    public function callback()
    {
        $config = cache('weixin_config');
        if(!$config){
            $config = db('weixin_config')->find();
            cache('weixin_config',$config,0);
        }
        $this->appid =  $config['appid'];
        $this->appsecret =  $config['appsecret'];
        $code = input('get.code'); //TODO 修正code获取方式
        $state = input('get.state'); //获取返回模型名称
        if (isset($code) && !empty($code)) {
            $acUrl = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=$this->appid&secret=$this->appsecret&code=$code&grant_type=authorization_code";
            $callback = Func::Get($acUrl);
            if (isset($callback->access_token)) {
                $userInfoUrl = "https://api.weixin.qq.com/sns/userinfo?access_token=$callback->access_token&openid=$callback->openid&lang=zh_CN";
                $call = Func::Get($userInfoUrl);
                $findWechatUserIsTrue = db('user_wechat')->where('openid',$call->openid)->find();
                if($findWechatUserIsTrue){
                    session('user_wechat_login',$findWechatUserIsTrue);
                }else{
                    //尝试写入用户记录
                    $user_wechat = [
                        'openid'    =>  $call->openid,
                        'nickname'  =>  $call->nickname,
                        'sex'       =>  $call->sex,
                        'headimgurl'=>  $call->headimgurl,
                        'city'      =>  $call->city,
                        'province'  =>  $call->province
                    ];
                    db('user_wechat')->insert($user_wechat);
                    session('user_wechat_login',$user_wechat);
                }
            }
            if($state =='mshop'){
                $this->redirect(url('mshop/user/index'));
            }
        }
    }
}