// pages/blog/blog.js

var app = getApp()

Page({
  data: {
    articles:[
      {
        id: '1',
        title: 'ttttt'
      },
      {
        id: '2',
        title: 'we'
      }
    ]
  },

  bindViewTap: function() {
    wx.navigateTo({
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
  },
  onReady: function () {
    console.log('onReady 生命周期函数--监听页面初次渲染完成')
  },

  onShow: function () {
    console.log('onShow 生命周期函数--监听页面隐藏')
  },


  onHide: function () {
    console.log('onHide 生命周期函数--监听页面隐藏')
  },


  onUnload: function () {
    console.log('onUnload 生命周期函数--监听页面加载')
  }
})
