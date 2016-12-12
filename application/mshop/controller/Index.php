<?php
namespace app\mshop\controller;

use app\common\model\Api;
use app\common\model\ShopCart;
use com\wechat\Jssdk;
use think\Controller;

class Index extends Controller
{
    public function _initialize()
    {
        $this->assign('config',Api::config());
        $this->assign('action',strtolower(request()->action()));
        $this->assign('controller',strtolower(request()->controller()));
        $user_agent = $_SERVER['HTTP_USER_AGENT'];
        if (strpos($user_agent, 'MicroMessenger') === false) {
            $this->assign('signStr',['appId'=>'','timestamp'=>'','nonceStr'=>'','signature'=>'']);
        } else {
            $jssdk = new Jssdk();
            $this->assign('signStr',$jssdk::getSignPackage());
        }

    }
    public function index()
    {
        //幻灯片
        $slider =cache('mshop_index_slider');
        if(!$slider){
            $slider = db('shop_slider')->where('status',1)->order('order','desc')->select();
            cache('mshop_index_slider',$slider,0);
        }

        $category =  cache('mshop_index_category');
        if(!$category){
            $category = db('shop_navigation')->where('status',1)->order('order','desc')->select();
            cache('mshop_index_category',$category,0);
        }
        $this->assign('category',$category);


        //商品列表
        $goods = cache('mshop_goods_list');
        if(!$goods){
            $goods = db('shop')->where('status',1)->order('id','desc')->limit(15)->select();
            cache('mshop_goods_list',$goods,0);
        }
        $this->assign('list',$goods);

        $this->assign('slider',$slider);
        return $this->fetch();
    }
    
    public function goodslist()
    {
        $openid = input('get.openid');
        Api::openidValidator($openid);
        $cateInfo = db('category')->where('openid',$openid)->find();
        $this->assign('cateInfo',$cateInfo);
        $this->assign('openid',$openid);


        $category = db('category')->where(['status'=>1,'type'=>'goods'])->order('order','desc')->select();
        $this->assign('category',$category);

        //商品列表
        $goodslist = db('shop')->where(['catid'=>$cateInfo['id'],'status'=>1])->cache(true,600)->paginate(15);
        $this->assign('goodslist',$goodslist);

        return $this->fetch();
    }

    /**
     * 购物车
     * @return mixed
     */
    public function shopcart()
    {
        $data = ShopCart::shopCart();
        $total_fee = 0;
        foreach ($data as $item=>$value){
            $total_fee  = $total_fee + $value['price']*$value['num'];
        }
        $this->assign('list',$data);
        $this->assign('fee',$total_fee);

        return $this->fetch();
    }

    //添加购物车
    public function add_shop_cart(){
        $data = input('post.');
        $user = get_uerinfo();
        if(!$user){
            $this->result('please login',403,'请您选登录授权,正在为您转跳');
        }
        $checkSHopCart = db('shop_cart')->where(['openid'=>$user['openid'],'goods_id'=>$data['goods_id'],'spec_id'=>$data['spec']])->find();
        if($checkSHopCart){
            $this->result('rept',500,'商品已经加入购物车了');
        }else{
            $cart = [
                'goods_id'  =>  $data['goods_id'],
                'openid'    =>  $user['openid'],
                'spec_id'   =>  $data['spec'],
                'price'     =>  $data['price'],
                'num'       =>  $data['num'],
                'dateline'  =>  time()
            ];
            db('shop_cart')->insert($cart);
        }
        $this->result('success',200,'加入购物车成功');
    }
    //从cookie中获取购物车信息
    public function get_shopcart_counts(){
        $user = get_uerinfo();
        $shopcart_number = db('shop_cart')->where('openid',$user['openid'])->count();
        $this->result($shopcart_number,200,'success');
    }

    public function goods()
    {
        $openid = input('get.openid');
        Api::openidValidator($openid);
        $goods = db('shop')->where('openid',$openid)->find();
        $spec = db('shop_goods_spec')->where('openid',$openid)->select();
        $goods['spec'] = specArray($spec);
        $goods['thumb'] = explode(',',$goods['thumb']);
        $this->assign('goods',$goods);
        return $this->fetch();
    }
}
