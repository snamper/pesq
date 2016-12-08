<?php
namespace app\user\controller;

use think\Controller;
use app\common\model\Api;

class Home extends Controller
{
    public function _initialize()
    {
        $user = session('user');
        if ($user) {
            $user['avatar'] = db('user_avatar')->where('uid', $user['uid'])->find();
        }
        $this->assign('userinfo', $user);
        $this->assign('config', Api::config());
        $this->assign('navigation', unlimitedForChild(Api::navigation())); //全局顶部导航

        //目标用户信息
        $user = self::userInfo();
        $this->assign('user', $user);
    }

    public function index()
    {
        $user = self::userInfo();
        $article = db('article')
            ->alias('a')
            ->join('__USER__ u', 'a.uid = u.uid', 'LEFT')
            ->join('__USER_AVATAR__ ua', 'a.uid = ua.uid', 'LEFT')
            ->field('a.id,a.openid,a.uid,u.username,u.openid uopenid,ua.avatar,a.subject,a.description,a.reply,a.views,a.dateline')
            ->where(['a.status' => 1, 'a.uid' => $user['uid']])
            ->order('a.id', 'desc')
            ->cache(true, 100)
            ->paginate(20);
        $this->assign('list', $article);
        return $this->fetch();
    }

    private static function userInfo()
    {
        $openid = input('openid');
        $user = db('user')
            ->alias('u')
            ->join('__USER_SCORE__ us', 'u.uid = us.uid', 'LEFT')
            ->join('__USER_AVATAR__ ua', 'u.uid = ua.uid', 'LEFT')
            ->where('u.openid', $openid)
            ->cache(true, 600)
            ->find();
        return $user;
    }
}
