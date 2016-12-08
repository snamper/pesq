<?php
/**
 * Created by PhpStorm.
 * User: imdante
 * Date: 2016/11/1
 * Time: 9:12
 */

namespace app\common\controller;

use think\Controller;

class User extends Controller
{
    public function api_user_follow_user()
    {
        $uid = input('get.uid');
        return $uid;
    }
}