<?php
namespace app\common\model;

use think\Model;
use org\Verify;

/**
 * 用户操作
 * Class User
 * @package app\common\model
 */
class User extends Model
{
    /**
     * 用户登录
     * @param $data
     * @param string $type
     * @return array
     */
    public static function user_login($data, $type = 'mp')
    {
        //用户输入安全过滤
        $username = htmlspecialchars(strip_tags($data['username']));
        $password = htmlspecialchars(strip_tags($data['password']));
        if($type == 'mp'){
            $verifycode = htmlspecialchars(strip_tags($data['verify']));
        }
        if (!$username || !$password || ($type=='mp' && !$verifycode))
            return ['code' => 403, 'msg' => '登录名、密码或是验证码不能为空'];
        if ($type == 'mp') {
            $verify = new Verify();
            if (!$verify->check($verifycode)) {
                return ['code' => 403, 'msg' => '验证码错误，请刷新重试'];
            }
        }
        //查询用户
        $user = db('user')->where('status', 1)
            ->whereOr('username', $username)
            ->whereOr('mobile', $username)
            ->find();
        if (!$user)
            return ['code' => 404, 'msg' => '用户不存在或已经被禁用'];
        //对比密码
        $contrastPassword = self::dencrypted($password, $user['openid'], $user['password']);
        if (!$contrastPassword)
            return ['code' => 403, 'msg' => '密码错误，请检查重试或是联系管理员'];
        //登录成功
        //更新登录状态
        $updateUserStatus = [
            'uid' => $user['uid'],
            'last_login_time' => time(),
            'last_login_ip' => request()->ip()
        ];
        User::update($updateUserStatus);
        //写入session
        //session 有效时间1个小时
        session($type, $user);
        return ['code' => 200, 'msg' => '登录成功，欢迎回来'];
    }

    public static function user_register($data)
    {
        return self::encrypted($data['password']);
    }

    /**
     * 加密密码
     * sha1加密用户输入密码 连接openid 二次采用md5加密
     * 最终sha1加密 md5字符串 三重加密密码
     * @param string $str 用户输入密码
     * @return array string 返回加密密码和openid
     */
    private static function encrypted($str)
    {
        $openid = guid(); //用户标识id 参照微信openid
        return ['password' => sha1(md5(sha1($str) . $openid)), 'openid' => $openid];
    }

    /**
     * 用户登录输入密码和数据库密码对比
     * @param string $str 明文密码
     * @param string $openid 用户openid
     * @param string $passwrod 用户存储密码
     * @return bool
     */
    private static function dencrypted($str, $openid, $passwrod)
    {
        $encryPassWord = sha1(md5(sha1($str) . $openid));
        if ($passwrod === $encryPassWord) //严格对比密码
            return true;
        else
            return false;
    }
}