<?php
namespace app\mshop\controller;
use think\Controller;

/**
 * 前后端数据分离 数据请求控制器
 * Class Api
 * @package app\mshop\controller
 */
class Api extends Controller {
    public function orderList($status=''){
        $status = input('get.status');
        $user = session('user_wechat_login');
        $data = db('shop_order')->where(['openid'=>$user['openid'],'status'=>$status])->order('id','desc')->paginate(10);
        if($data){
            $this->result($data,200,'SUCCESS');
        }else{
            $this->result('null',404,'数据木有找到');
        }
    }
}