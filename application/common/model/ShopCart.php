<?php
namespace app\common\model;
use think\Model;

/**
 * Created by PhpStorm.
 * User: imdante
 * Date: 2016/12/12
 * Time: 9:40
 */
class ShopCart extends Model {
    /**
     * 关联商品模型
     * @return \think\model\relation\HasOne
     */
    public function shop(){
        return $this->hasOne('shop','id','goods_id');
    }
    public function spec(){
        return $this->hasOne('shop_spec','id','spec_id');
    }
    public static function shopCart(){
        $user = get_uerinfo();
        $data = db('shop_cart')
            ->alias('sc')
            ->join('shop s','sc.goods_id = s.id','LEFT')
            ->join('shop_goods_spec ss','sc.spec_id = ss.id','LEFT')
            ->field('sc.id,sc.price,s.subject,ss.name,sc.num,s.thumb')
            ->where('sc.openid',$user['openid'])
            ->order('sc.id','desc')
            ->select();

        return $data;
    }
}