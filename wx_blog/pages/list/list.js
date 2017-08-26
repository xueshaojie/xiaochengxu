//list.js
//获取应用实例
var app = getApp()
var sliderWidth = 96;
Page({
data: {
  // motto: 'Hello World',
  // userInfo: {}
  // //
  tabs: ["全部文章", "草稿", "已发布"],
  activeIndex: 0,
  sliderOffset: 1,
  sliderLeft: 2
},

onLoad: function () {
    var that = this;
    wx.getSystemInfo({
        success: function(res) {
            that.setData({
                sliderLeft: (res.windowWidth / that.data.tabs.length - sliderWidth) / 2,
                sliderOffset: res.windowWidth / that.data.tabs.length * that.data.activeIndex
            });
        }
    });
},
tabClick: function (e) {
    this.setData({
        sliderOffset: e.currentTarget.offsetLeft,
        activeIndex: e.currentTarget.id
    });
    console.log(e.currentTarget.id);
    if (e.currentTarget.id==0) {
      this.onShow();
    } else if (e.currentTarget.id==1) {
      this.bindViewTap1();
    } else {
      this.bindViewTap2();
    }
},

onShow: function () {
  console.log('onLoad 生命周期函数--监听页面加载')
  var that = this;
  var wx_user_id = wx.getStorageSync('wx_user_id');


  wx.request({
    url: app.globalData.blog_url +'/articles/list.json?wx_user_id=' + wx_user_id,
    data: {},
    header: {
      'Content-Type': 'application/json'
    },
    success: function(res) {
      console.log(res.data);

      //把获取到的结果放到数据层
      that.setData({
        articles:res.data.articles
      })
    }
  })
},

bindViewTap1: function() {
  var that = this;
  var wx_user_id = wx.getStorageSync('wx_user_id');


  wx.request({
    url: app.globalData.blog_url +'/articles/list.json?status=0&wx_user_id=' + wx_user_id,
    data: {},
    header: {
      'Content-Type': 'application/json'
    },
    success: function(res) {
      console.log(res.data);

      //把获取到的结果放到数据层
      that.setData({
        articles:res.data.articles
      })
    }
  })
},

bindViewTap2: function() {
  var that = this;
  var wx_user_id = wx.getStorageSync('wx_user_id');


  wx.request({
    url: app.globalData.blog_url +'/articles/list.json?status=1&wx_user_id=' + wx_user_id,
    data: {},
    header: {
      'Content-Type': 'application/json'
    },
    success: function(res) {
      console.log(res.data);

      //把获取到的结果放到数据层
      that.setData({
        articles:res.data.articles
      })
    }
  })
}

})
