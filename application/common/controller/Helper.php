<?php
namespace app\common\controller;

use think\Cache;
use think\Controller;
use think\Log;
use org\Verify;
use app\common\model\User;

class Helper extends  Controller
{
    public function clear_cache_log_temp(){
        Cache::clear();
        Log::clear();
        $this->result(null,200,'缓存和日志记录清空成功，正在为您刷新页面，请稍等','json');
    }

    public function uploader(){
        $fileName = input('get.filename');
        $file =request()->file($fileName);
        $info = $file->rule('sha1')->move(ROOT_PATH . 'public' . DS . 'attach');
        if($info){
            echo '/attach/' . $info->getSaveName();
        }else{
            // 上传失败获取错误信息
            echo $file->getError();
        }
    }
    public function unlink_file()
    {
        $file = input('get.file');
        @unlink('.'.$file);
        $this->result('ok',200,'img file destroyed');
    }

    public function account(){
        return $this->fetch('/account');
    }

    //后台用户登录
    public function account_login()
    {
        $data = input('post.');
        $user_login = User::user_login($data, 'admin');
        return $user_login;
    }

    public function api_user_account(){
        $data = input('post.');
        $user_login = User::user_login($data,'user');
        return $user_login;
    }

    /**
     * 验证码
     */
    public function verify(){
        $w = input('w', '174');
        $h = input('h', '39');
        $config = [
            'codeSet'  => '2345678abcdefhijkmnpqrstuvwxyzABCDEFGHJKLMNPQRTUVWXY', // 验证码字符集合
            'expire'   => 160, // 验证码过期时间（s）
            'fontSize' => 20, // 验证码字体大小(px)
            'useCurve' => false, // 是否画混淆曲线
            'useNoise' => true, // 是否添加杂点
            'imageH'   => $h, // 验证码图片高度
            'imageW'   => $w, // 验证码图片宽度
            'length'   => 4, // 验证码位数
        ];
        $verify = new Verify($config);
        $verify->entry();
    }
}