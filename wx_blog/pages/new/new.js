// pages/blog/blog.js

var app = getApp()

Page({
  data: { 
  },

  formSubmit: function(e) {
    console.log('onLoad 生命周期函数--监听页面加载')
    var that = this;

    wx.request({
      url: app.globalData.blog_url +'/articles',
      header: {
        // 'Content-Type': 'application/json'
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      method: 'POST',
      // data: Util.json2Form( { title: 'e.detail.value.title', text: 'e.detail.value.text' }),
      data: Util.json2Form(e.detail.value),
      complete: function( res ) {
        that.setData( {
          toastHidden: false,
          toasttext: res.data.reason,
        });
        if( res == null || res.data == null ) {
          console.error( '网络请求失败' );
          return;
        }
      }
    })
  },
  onToastChanged: function() {
    that.setData( { toastHidden: true });
  }

})

var that;
var Util = require( '../../utils/util.js' );
