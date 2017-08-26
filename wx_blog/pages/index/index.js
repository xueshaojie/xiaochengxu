  //index.js
//获取应用实例
var app = getApp()
Page({
  data: {
    motto: '点击这里，体验小程序！',
    userInfo: {}
  },

  bindViewTap: function() {
    wx.switchTab({
      url: '../blog/blog'
    })
  },

  onLoad: function () {
    console.log('onLoad')
    var that = this
     //调用应用实例的方法获取全局数据
    app.getUserInfo(function(userInfo){
       //更新数据
    that.setData({
       userInfo:userInfo
     })
   })
  },

  onShow: function () {
  console.log("iv");
    wx.login({//login流程
      success: function (res) {//登录成功
        if (res.code) {
          var code = res.code;
          wx.getUserInfo({//getUserInfo流程
            success: function (res2) {//获取userinfo成功
            console.log(res2.encryptedData);
            console.log(res2);
            var encryptedData = res2.encryptedData;//一定要把加密串转成URI编码
            var iv = res2.iv;
              //请求自己的服务器
             Login(code,encryptedData,iv);
            }
          })

        } else {
          console.log('获取用户登录态失败！' + res.errMsg)
        }
      }
    });
  }

})


var API_URL = "https://gentle-springs-10865.herokuapp.com/wx_users/wx_login";

function  Login(code,encryptedData,iv){
  console.log('code='+code+'&encryptedData='+encryptedData+'&iv='+iv);
 //创建一个dialog
  wx.showToast({
    title: '正在登录...',
    icon: 'loading',
    duration: 10000
  });
  //请求服务器
  wx.request({
    url: API_URL,
    data: {
      code:code,
      encryptedData:encryptedData,
      iv:iv
    },
    method: 'GET', // OPTIONS, GET, HEAD, POST, PUT, DELETE, TRACE, CONNECT
    header: {
      'content-type': 'application/json'
    }, // 设置请求的 header
    success: function (res) {
      // success
      wx.hideToast();
      console.log('服务器返回');
      wx.setStorageSync('wx_user_id', res.data.wx_user.id);

    },
    fail: function () {
      // fail
      // wx.hideToast();
    },
    complete: function () {
      // complete
    }
  })
}



//
// bindViewTap1: function() {
//   wx.navigateTo({
//     url: '../new/new'
//   })
// },

// onLoad: function () {
//   //调用登录接口
//   wx.login({
//     success: function (login) {
//       //成功，返回登录凭证js_code
//       var js_code = login.code;
//       //调用获取用户信息接口
//       wx.getUserInfo({
//         success: function (res) {
//           //获取原始数据
//           var rawData = res.rawData;
//           //获取签名
//           var signature = res.signature;
//           //调用网络请求接口，把数据发送给服务器
//           wx.request({
//             url: 'https://gentle-springs-10865.herokuapp.com',
//             data: {
//               js_code: js_code,       //js_code用户获取session_key
//               rawdata: rawData,      //原始数据
//               signature: signature,  //签名
//             },
//             method: 'GET', //用Get的请求方式
//             header: {
//               'content-type': 'application/json'
//             },
//             success: function (data) {
//               //成功，返回signature，signature2数据
//               console.log(data);
//             }
//           })
//         }
//       })
//     }
//   });
// }
