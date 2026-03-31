var NativeUtil = {
  _Callback: {},
  /**
   * [调用原生方法]
   * @param  {[type]}   name     [原生方法名]
   * @param  {Function} callback [成功之后的回调]
   * @param  {[type]}   param    [原生插件需要的参数]
   * @return [type]              [description]
   */
  use: function(name, callback, param) {
    var args = [].slice.call(arguments);
    console.log(args);
    if (this[name]) {
      if (args.length > 1) {
        var callbackId = this._genetateId(name);
        this._Callback[callbackId] = callback;
      }
      if (args.length > 2) {
        return this[name](callbackId, param);
      } else if (args.length == 2) {
        return this[name](callbackId);
      } else if (args.length == 1) {
        return this[name]();
      }
    }
  },
  /**
   *  生成回调id
   * @param  {[type]} name [调用的原生方法名]
   * @return [type]        [回调id]
   */
  _genetateId: function(name) {
    var callbackId;
    callbackId = name + "CB" + ("" + Date.now()).slice(-7);
    return callbackId;
  },
  /**
   * 用于原生回调的处理方法
   * @param  {[type]} callbackId [每一个回调会有自己id]
   * @param  {[type]} result     [原生返回的结果]
   * @return [type]              [description]
   */
  NativeCallback: function(callbackId, result) {
    console.log(result);
    if (this._Callback[callbackId]) {
      this._Callback[callbackId](result);
      delete this._Callback[callbackId];
    } else {
      console.info("NativeCallback can't found callbackId");
    }
  },
  /**
   * 显示隐藏loader
   * @return [type] [description]
   */
  toggleProgressDialog: function(type) {
    if (window.jsInterface) {
      try {
        window.jsInterface.toggleProgressDialog(type);
      } catch (e) {
        console.log(e);
      }
    }
  },
  /**
   * 当前链接的wifi
   */
  getConnectionInfo: function() {
    if (window.jsInterface) {
      try {
        var wifiinfo = window.jsInterface.getConnectionInfo();
      } catch (e) {
        return {};
        console.log(e);
      }
      if (wifiinfo) {
        return JSON.parse(wifiinfo);
      }
    }
  },
  /**
   * 周边wifi
   * @return [type] [description]
   */
  getScanResults: function() {
    if (window.jsInterface) {
      try {
        var wifilist = window.jsInterface.getScanResults();
      } catch (e) {
        return {};
        console.log(e);
      }
      if (wifilist) {
        return JSON.parse(wifilist);
      }
    }
  },
  /**
   * 获取设备信息
   * @return [string] [设备id]
   */
  getDeviceInfo: function() {
    if (window.jsInterface) {
      try {
        var deviceInfo = window.jsInterface.getDeviceInfo();
      } catch (e) {
        return {};
      }
      if (deviceInfo) {
        return JSON.parse(deviceInfo);
      }
    } else {
      return {
        deviceId: "868904020579706",
        model: "m2",
        system: "android"
      };
    }
  },
  /**
   * 原生插件成功之后的callback
   * @param  {[type]} callbackId [用于获取回调方法的id]
   * @param  {[type]} result     [原生方法返回值]
   * @return [type]              [description]
   */

  /**
   * 获取当前应用版本号
   * @return [type] [description]
   */
  getAppVersion: function() {
    if (window.jsInterface) {
      try {
        var appversion = window.jsInterface.getVersionName();
      } catch (e) {
        console.log(e);
        return "0.0.0";
      }
      return appversion;
    }
  },
  /**
   * 关闭webview
   * @return [type] [description]
   */
  close: function() {
    if (window.jsInterface) {
      try {
        window.jsInterface.close();
      } catch (e) {
        console.log(e);
      }
    }
  },
  /**
   * 获取经纬度
   * @return [type] [返回经纬度]
   */
  getLatLng: function(callbackId) {
    var point;
    if (window.jsInterface) {
      try {
        window.jsInterface.getLatLng(callbackId)
      } catch (e) {
        console.log(e);
      }
    }else{
       NativeUtil.NativeCallback(callbackId, JSON.stringify({
          longitude: 115.853834,
          latitude: 28.68003,
        }))
    }
  },
  getDistance: function(callbackId, param) {
    var distance = -1;
    if (window.jsInterface) {
      try {
        distance = window.jsInterface.getDistance(
          JSON.stringify(param.p1),
          JSON.stringify(param.p2)
        );
      } catch (e) {
        return distance;
        console.log(e);
      }
    }
    return distance;
  },
  // 获取用户基本信息
  getUserInfo: function(callback) {
    var userinfo;
    if (window.jsInterface) {
      try {
        userinfo = window.jsInterface.getUserInfo();
      } catch (e) {
        return {};
        console.log(e);
      }
      if (userinfo) {
        return JSON.parse(userinfo);
      }
    }
  },
  /**
   * 获取用户签名信息用于验证
   * @return [json] [用户签名信息]
   */
  getSign: function() {
    var sign;
    if (window.jsInterface) {
      try {
        sign = window.jsInterface.getSign();
      } catch (e) {
        console.log(e);
        return {};
      }
      if (sign) {
        return JSON.parse(sign);
      }
    } else {
      // window.alert("window.jsInterface接口无效")
    }
  },
  getSignStr: function () {
    var sign = NativeUtil.getSign();
    var param = function(obj) {
      var query = "", name, value, fullSubName, subName, subValue, innerObj, i;

      for (name in obj) {
        value = obj[name];
        if (value instanceof Array) {
          for (i = 0; i < value.length; ++i) {
            subValue = value[i];
            fullSubName = name + "[]";
            innerObj = {};
            innerObj[fullSubName] = subValue;
            query += param(innerObj) + "&";
          }
        } else if (value instanceof Object) {
          for (subName in value) {
            subValue = value[subName];
            fullSubName = name + "[" + subName + "]";
            innerObj = {};
            innerObj[fullSubName] = subValue;
            query += param(innerObj) + "&";
          }
        } else if (value !== undefined && value !== null)
          query += encodeURIComponent(name) +
            "=" +
            encodeURIComponent(value) +
            "&";
      }

      return query.length ? query.substr(0, query.length - 1) : query;
    };
    return param(sign);
  },
// 获取初始化页面参数
  getUrlParams: function() {
    // 先取缓存，再去原生最后取假数据
    var router = window.sessionStorage.getItem("routerconfig");
    if (router) {
      window.sessionStorage.removeItem("routerconfig");
      return JSON.parse(router);
    }
    if (window.jsInterface) {
      try {
        var router = window.jsInterface.getUrlParams();
      } catch (e) {
        console.log(e);
        return {};
      }
      if (router) {
        return JSON.parse(router);
      }
    }
    // 新增流程
    var newConfig = function() {
      var router = {
        formKey: "Personnel_BdApply",
        id: "2314",
        processType: "NEW"
      };
      return router;
    };
    // 运行中的流程
    var workConfig = function() {
      var router = {
        formKey: "Personnel_SalaryApply",
        id: "744858",
        processType: "WORK",
        operationResult: "check"
      };
      return router;
    };
    // 查询的数据
    var searchConfig = function() {
      // 投标申请单数据
      var router = {
        formKey: "Project_BidApply",
        processType: "SEARCH",
        url: "bid-apply/find-id.do",
        data: {
          id: 6578
        }
      };
      return router;
    };
    // 非流程模块
    var moduleConfig = function() {
      // 工作报告
      var router = {
        moduleType: 4,
        id: 1
      };
      return router;
    };
    // var router = newConfig();
    // var router = workConfig();
    var router = searchConfig();
    // var router = moduleConfig();
    return router;
  },
  // 设置页面初始化参数（基本不需要）
  setUrlParams: function(router) {
    window.sessionStorage.setItem("routerconfig", JSON.stringify(router));
    return router;
  },
  /**
   * 时间选择插件
   * @param  {[type]} callbackId [用于回调的id]
   * @param  {[type]} type       [选择时间类型]
   * @return [type]              [description]
   */
  Datepicker: function(callbackId, type) {
    if (window.jsInterface) {
      try {
        window.jsInterface.pickDate(callbackId, type);
      } catch (e) {
        console.log(e);
      }
    }
  },
  /**
   * 图片预览
   * @param  {[type]} urls [需要预览的图片]
   * @return [type]        [description]
   */
  photoPreview: function(callbackId, param) {
    if (window.jsInterface) {
      try {
        return window.jsInterface.photoPreview(
          param.data,
          param.index,
          param.showbtn
        );
      } catch (e) {
        console.log(e);
      }
    }
  },
  /**
   * 调用默认浏览器
   * @url  {[type]} string [打开的地址]
   * @return [type]        [description]
   */
  openUrl: function(callbackId, url) {
    if (window.jsInterface) {
      try {
        return window.jsInterface.openUrl(url);
      } catch (e) {
        console.log(e);
      }
    }
  },

  attachPreview: function(callbackId, url) {
    if (window.jsInterface) {
      try {
        return window.jsInterface.attachPreview(url);
      } catch (e) {
        console.log(e);
      }
    }
  },
  /**
   * 选择与上传图片
   * @param  {[type]} callbackId [用于回调]
   * @param  {[type]} num        [可以选几张]
   * @param  {[type]} url        [上传地址]
   * @return [type]              [description]
   */
  choosePhoto: function(callbackId, param) {
    if (window.jsInterface) {
      try {
        return window.jsInterface.choosePhoto(
          callbackId,
          param.num,
          param.type,
          JSON.stringify(param.data)
        );
      } catch (e) {
        console.log(e);
      }
    }
  },
  /**
   * 确认框
   * @param  {[type]} info       [确认信息]
   * @param  {[type]} callbackId [成功回调]
   * @param  {[type]} title      [提示头部]
   * @return [type]              [description]
   */
  confirm: function(callbackId, param) {
    if (window.jsInterface) {
      try {
        return window.jsInterface.confirm(param.title, param.info, callbackId);
      } catch (e) {
        console.log(e);
      }
    } else {
      window.confirm(info);
    }
  },
  beep: function() {
    if (window.jsInterface) {
      try {
        return window.jsInterface.playVoice();
      } catch (e) {
        console.log(e);
      }
    }
  },
  /**
   * 提示框
   * @param  {[type]} title [提示头]
   * @param  {[type]} info  [提示信息]
   * @return [type]         [description]
   */
  alert: function(callbackId, param) {
    if (window.jsInterface) {
      try {
        return window.jsInterface.alert(param.title, param.info);
      } catch (e) {
        console.log(e);
      }
    } else {
      window.alert(info);
    }
  },
  /**
   * 列表更新
   * @return [type] [description]
   */
  updateProcess: function() {
    if (window.jsInterface) {
      try {
        return window.jsInterface.updateProcess();
      } catch (e) {
        console.log(e);
      }
    }
  },
  /**
   * 调用原生登录
   * @return [type] [description]
   */
  login: function() {
    if (window.jsInterface) {
      return window.jsInterface.login();
    }
  }
};
// 复写cordova插件
navigator.notification = {
  confirm: function(info, callback, title) {
    var param = {
      info: info,
      title: title
    };
    NativeUtil.use("confirm", callback, param);
  },
  alert: function(title, info) {
    var param = {
      info: info,
      title: title
    };
    NativeUtil.use("alert", null, param);
  },
  beep: function() {
    NativeUtil.use("beep");
  }
};
