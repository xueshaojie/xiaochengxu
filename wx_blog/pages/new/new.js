// pages/blog/blog.js

var app = getApp()

Page({
  data: {
    categories: ["生活", "工作", "随笔", "其他"],
    categoryIndex: 0,

    status: ["草稿", "发布"],
    statusIndex: 0
  },

  bindViewTap: function() {
    wx.switchTab({
      url: '../list/list'
    })
  },


  formSubmit: function(e) {
    console.log('onLoad 生命周期函数--监听页面加载')
    var that = this;
    var wx_user_id = wx.getStorageSync('wx_user_id');
    this.setData({
      statusIndex:e.detail.value.selector
    })

    wx.request({

      url: 'https://gentle-springs-10865.herokuapp.com/articles?wx_user_id=' + wx_user_id,
      header: {
        // 'Content-Type': 'application/json'
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      method: 'POST',
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

  bindCategoryChange: function(e) {
      console.log('picker category 发生选择改变，携带值为', e.detail.value);

      this.setData({
          categoryIndex: e.detail.value
          // article.category: e.detail.value
      })
  },

  bindStatusChange: function(e) {
      console.log('picker status 发生选择改变，携带值为', e.detail.value);
      wx.setStorageSync('status', e.detail.value);
      this.setData({
          statusIndex: e.detail.value
          // article.status: e.detail.value
      })
  },

  onToastChanged: function() {
    that.setData( { toastHidden: true });
  }

})




var that;
var Util = require( '../../utils/util.js' );
