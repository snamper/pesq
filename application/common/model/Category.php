<?php
/**
 * Created by PhpStorm.
 * User: imdante
 * Date: 2016/11/15
 * Time: 11:27
 */

namespace app\common\model;


use think\Model;

class Category extends Model
{
    public static function datalist(){
        $category = cache('category');
        if(!$category){
            $category = db('category')->where(['status'=>1])->order('order','asc')->select();
            cache('category',$category,0);
        }
        return unlimitedForLevel($category);
    }
    public static function search($k,$v){
        $data = self::datalist();
        $result= [];
        foreach ($data as $item=>$value){
            if($value[$k] == $v){
                $result[] = $value;
            }
        }
        return $result;
    }
}