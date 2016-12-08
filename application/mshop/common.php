<?php
function get_uerinfo(){
    $user = session('user_wechat_login');
    return $user;
}