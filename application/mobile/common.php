<?php
function default_weixin_thumb($src){
    if($src && is_file($src)){
        return $src;
    }else{
        return '/static/i/default_weixin_thumb.jpg';
    }
}