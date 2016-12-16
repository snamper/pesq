<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2016 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------

return [
    'category/:openid' => 'index/lists/index',
    'topic/:openid' => 'index/article/index',
    'goods/:openid' => 'mshop/index/goods',
    'product/:openid' => 'index/product/index',
    'shop/:openid' => 'index/shop/index',
    'home/:openid' => 'user/home/index',
    'user_api_user_account' => 'common/helper/api_user_account',
    'api_user_follow_user' => 'common/user/api_user_follow_user',
    'api_user_posts' => 'user/posts/index',
    'api_posts_article' => 'user/posts/posts_article',
    'api_get_article_lists' => 'index/index/api_get_article_lists',
    'tags/:tag' => 'index/search/tags',
    'search' => 'index/search/index',

    //手机文章页面 //微信ui界面
    'appmsg/:openid'    =>  'mobile/appmsg/index',
    'applist/:openid'    =>  'mobile/applist/index',
];
