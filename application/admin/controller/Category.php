<?php
namespace app\admin\controller;

class Category extends Common
{
    public function index()
    {
        $category = cache('category');
        if(!$category){
            $category = db('category')->where('status',1)->order('order','asc')->select();
            cache('category',$category,0);
        }
        $this->assign('category',unlimitedForLevel($category));
        return $this->fetch();
    }
    public function add(){
        $data = input('post.');
        $data['openid'] = guid();
        $status = db('category')->insert($data);
        if($status){
            cache('category',null);
            $this->result('ok',200,'添加成功');
        }else{
            $this->result('error',500,'添加失败');
        }
    }
    public function del(){
        $id =input('get.id');
        if(isset($id)){
            $status  =db('category')->where('id',$id)->delete();
            if($status){
                cache('category',null);
                $this->result('ok',200,'删除成功，正在刷新');
            }else{
                $this->result('error',500,'删除失败');
            }
        }
        $this->result('param is error',403,'参数错误');
    }
    public function get_category(){
        $id = input('get.id');
        $data = db('category')->where('id',$id)->find();
        if($data){
            $this->result($data,200,'success');
        }else{
            $this->result('null',500,'数据不存在，请清空缓存');
        }
    }
}