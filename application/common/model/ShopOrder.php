<?php
namespace app\common\model;
use think\Model;

/**
 * Created by PhpStorm.
 * User: imdante
 * Date: 2016/12/12
 * Time: 9:40
 */
class ShopOrder extends Model {
    /**
     * 关联商品模型
     * @return \think\model\relation\HasOne
     */
    public static function datalist($status){
        $user = get_uerinfo();
        $map['openid'] = $user['openid'];
        switch ($status){
            case 'all':
                $map['trade_state'] = ['lt',9999];
                break;
            default:
                $map['trade_state'] = $status;
        }
        $list = db('shop_order')->where($map)->order('id','desc')->paginate(10);
        return $list;
    }
}