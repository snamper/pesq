<?php
namespace app\user\controller;

use think\Controller;
use app\common\model\Api;

class Common extends Controller
{
    public function _initialize()
    {
        $user = session('user');
        if (!$user) {
            $this->error('您没有登录，无法访问用户中心');
        }
        if ($user) {
            $user['avatar'] = db('user_avatar')->where('uid', $user['uid'])->find();
        }
        $this->assign('userinfo', $user);
        $this->assign('config', Api::config());
        $this->assign('navigation', unlimitedForChild(Api::navigation())); //全局顶部导航
    }
}
