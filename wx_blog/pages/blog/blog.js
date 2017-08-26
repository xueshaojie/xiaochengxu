// pages/blog/blog.js

var app = getApp()

Page({
  data: {
    // articles:[
    //   {
    //     id: '1',
    //     title: 'ttttt'
    //   },
    //   {
    //     id: '2',
    //     title: 'we'
    //   }
    // ]
  },

  bindViewTap: function() {
    wx.switchTab({
      url: '../new/new'
    })
  },

  onLoad: function () {
    console.log('onLoad 生命周期函数--监听页面加载')
    var that = this;

    wx.request({
      url: app.globalData.blog_url +'/articles.json',
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
