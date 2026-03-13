import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_app/shared/services/js_interface_service.dart';

class JsInterfaceBridge {
  final WebViewController controller;
  final JsInterfaceService _jsInterfaceService = JsInterfaceService();
  VoidCallback? onClose;
  void Function(List<String> urls, int index)? onPhotoPreview;
  void Function(String url)? onOpenUrl;
  void Function(String url)? onAttachPreview;
  void Function(int num, String type)? onChoosePhoto;
  void Function(String title, String info)? onConfirm;
  void Function(String title, String info)? onAlert;
  void Function()? onUpdateProcess;
  void Function()? onLogin;

  JsInterfaceBridge({
    required this.controller,
  });

  Future<void> init() async {
    await _setupJavaScriptChannels();
  }

  Future<void> injectJsInterface() async {
    await _injectNativeUtil();
  }

  Future<void> _injectNativeUtil() async {
    final nativeUtilScript = _buildNativeUtilScript();
    debugPrint('注入 JS 代码长度: ${nativeUtilScript.length}');
    await controller.runJavaScript(nativeUtilScript);
    debugPrint('JS 注入完成');
  }

  String _buildNativeUtilScript() {
    return '''
      (function() {
        console.log('开始初始化 NativeUtil');
        var channel = JsInterfaceChannel;
        console.log('Channel 对象:', channel);
        
        var NativeUtil = {
          _Callback: {},
          
          use: function(name, callback, param) {
            console.log('NativeUtil.use called:', name, 'callback:', typeof callback, 'param:', param);
            var callbackId = null;
            if (typeof callback === 'function') {
              callbackId = name + "CB" + Date.now().toString().slice(-7);
              NativeUtil._Callback[callbackId] = callback;
              console.log('注册回调:', callbackId);
            }
            
            if (channel && channel.postMessage) {
              var message = JSON.stringify({
                method: name,
                callbackId: callbackId,
                param: param
              });
              console.log('发送消息:', message);
              channel.postMessage(message);
            } else {
              console.error('Channel 不可用');
            }
          },
          
          NativeCallback: function(callbackId, result) {
            console.log('NativeCallback:', callbackId, result);
            if (NativeUtil._Callback[callbackId]) {
              try {
                var parsedResult = typeof result === 'string' ? JSON.parse(result) : result;
                NativeUtil._Callback[callbackId](parsedResult);
              } catch (e) {
                console.error('Callback parse error:', e);
                NativeUtil._Callback[callbackId](result);
              }
              delete NativeUtil._Callback[callbackId];
            } else {
              console.warn("NativeCallback can't find callbackId:", callbackId);
            }
          },
          
          close: function() {
            console.log('close called');
            if (channel && channel.postMessage) {
              channel.postMessage(JSON.stringify({method: 'close', callbackId: null, param: null}));
            }
          },
          
          getUserInfo: function() {
            console.log('getUserInfo called');
            if (channel && channel.postMessage) {
              var result = channel.invokeMethod ? channel.invokeMethod('getUserInfo', null, null) : null;
              return result ? JSON.parse(result) : {};
            }
            return {};
          },
          
          getSign: function() {
            console.log('getSign called');
            if (channel && channel.postMessage) {
              var result = channel.invokeMethod ? channel.invokeMethod('getSign', null, null) : null;
              return result ? JSON.parse(result) : {};
            }
            return {};
          },
          
          getSignStr: function() {
            var sign = this.getSign();
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
                  query += encodeURIComponent(name) + "=" + encodeURIComponent(value) + "&";
              }
              return query.length ? query.substr(0, query.length - 1) : query;
            };
            return param(sign);
          },
          
          getUrlParams: function() {
            console.log('getUrlParams called');
            if (channel && channel.postMessage) {
              var result = channel.invokeMethod ? channel.invokeMethod('getUrlParams', null, null) : null;
              return result ? JSON.parse(result) : {};
            }
            return {};
          },
          
          photoPreview: function(callbackId, param) {
            console.log('photoPreview called:', callbackId, param);
            if (channel && channel.postMessage) {
              channel.postMessage(JSON.stringify({method: 'photoPreview', callbackId: callbackId, param: param}));
            }
          },
          
          openUrl: function(callbackId, url) {
            console.log('openUrl called:', url);
            if (channel && channel.postMessage) {
              channel.postMessage(JSON.stringify({method: 'openUrl', callbackId: callbackId, param: url}));
            }
          },
          
          attachPreview: function(callbackId, url) {
            console.log('attachPreview called:', url);
            if (channel && channel.postMessage) {
              channel.postMessage(JSON.stringify({method: 'attachPreview', callbackId: callbackId, param: url}));
            }
          },
          
          choosePhoto: function(callbackId, param) {
            console.log('choosePhoto called:', callbackId, param);
            if (channel && channel.postMessage) {
              channel.postMessage(JSON.stringify({method: 'choosePhoto', callbackId: callbackId, param: param}));
            }
          },
          
          confirm: function(callbackId, param) {
            console.log('confirm called:', callbackId, param);
            if (channel && channel.postMessage) {
              channel.postMessage(JSON.stringify({method: 'confirm', callbackId: callbackId, param: param}));
            }
          },
          
          beep: function() {
            console.log('beep called');
            if (channel && channel.postMessage) {
              channel.postMessage(JSON.stringify({method: 'beep', callbackId: null, param: null}));
            }
          },
          
          alert: function(callbackId, param) {
            console.log('alert called:', callbackId, param);
            if (channel && channel.postMessage) {
              channel.postMessage(JSON.stringify({method: 'alert', callbackId: callbackId, param: param}));
            }
          },
          
          updateProcess: function() {
            console.log('updateProcess called');
            if (channel && channel.postMessage) {
              channel.postMessage(JSON.stringify({method: 'updateProcess', callbackId: null, param: null}));
            }
          },
          
          login: function() {
            console.log('login called');
            if (channel && channel.postMessage) {
              channel.postMessage(JSON.stringify({method: 'login', callbackId: null, param: null}));
            }
          }
        };
        
        window.jsInterface = NativeUtil;
        console.log('NativeUtil 初始化完成, 方法:', Object.keys(NativeUtil));
      })();
    ''';
  }

  Future<void> _setupJavaScriptChannels() async {
    await controller.addJavaScriptChannel(
      'JsInterfaceChannel',
      onMessageReceived: (JavaScriptMessage message) async {
        debugPrint('收到 JS 消息: ${message.message}');
        await _handleJavaScriptMessage(message.message);
      },
    );
  }

  Future<void> _handleJavaScriptMessage(String message) async {
    try {
      debugPrint('处理 JS 消息: $message');
      final data = json.decode(message) as Map<String, dynamic>;
      final method = data['method'] as String?;
      final callbackId = data['callbackId'];
      final param = data['param'];

      debugPrint('方法: $method, callbackId: $callbackId, param: $param');

      if (method == null) return;

      dynamic result;
      Map<String, dynamic>? paramMap;

      if (param != null && param is String) {
        paramMap = json.decode(param) as Map<String, dynamic>;
      } else if (param is Map) {
        paramMap = Map<String, dynamic>.from(param);
      }

      debugPrint('开始执行方法: $method');

      switch (method) {
        case 'close':
          await _jsInterfaceService.close();
          onClose?.call();
          result = null;
          debugPrint('close 执行完成');
          break;

        case 'getUserInfo':
          result = await _jsInterfaceService.getUserInfo();
          debugPrint('getUserInfo 结果: $result');
          break;

        case 'getSign':
          result = await _jsInterfaceService.getSign();
          debugPrint('getSign 结果: $result');
          break;

        case 'getUrlParams':
          result = await _jsInterfaceService.getUrlParams(paramMap);
          break;

        case 'photoPreview':
          if (paramMap != null) {
            final urls = List<String>.from(paramMap['data'] ?? []);
            final index = paramMap['index'] as int? ?? 0;
            await _jsInterfaceService.photoPreview(urls: urls, index: index);
            onPhotoPreview?.call(urls, index);
          }
          result = null;
          break;

        case 'openUrl':
          final url = param as String?;
          if (url != null) {
            await _jsInterfaceService.openUrl(url);
            onOpenUrl?.call(url);
          }
          result = null;
          break;

        case 'attachPreview':
          final url = param as String?;
          if (url != null) {
            await _jsInterfaceService.attachPreview(url);
            onAttachPreview?.call(url);
          }
          result = null;
          break;

        case 'choosePhoto':
          if (paramMap != null) {
            final num = paramMap['num'] as int? ?? 1;
            final type = paramMap['type'] as String? ?? 'album';
            result = await _jsInterfaceService.choosePhoto(num: num, type: type, data: paramMap);
            onChoosePhoto?.call(num, type);
            debugPrint('choosePhoto 结果: $result');
          }
          break;

        case 'confirm':
          if (paramMap != null) {
            final title = paramMap['title'] as String? ?? '提示';
            final info = paramMap['info'] as String? ?? '';
            final confirmed = await _jsInterfaceService.confirm(title: title, info: info);
            onConfirm?.call(title, info);
            result = confirmed;
            debugPrint('confirm 结果: $confirmed');
          }
          break;

        case 'alert':
          if (paramMap != null) {
            final title = paramMap['title'] as String? ?? '提示';
            final info = paramMap['info'] as String? ?? '';
            onAlert?.call(title, info);
            debugPrint('alert 执行完成');
          }
          result = null;
          break;

        case 'beep':
          await _jsInterfaceService.beep();
          result = null;
          debugPrint('beep 执行完成');
          break;

        case 'updateProcess':
          await _jsInterfaceService.updateProcess();
          onUpdateProcess?.call();
          result = null;
          debugPrint('updateProcess 执行完成');
          break;

        case 'login':
          await _jsInterfaceService.login();
          onLogin?.call();
          result = null;
          debugPrint('login 执行完成');
          break;

        default:
          debugPrint('未知方法: $method');
          return;
      }

      if (callbackId != null && callbackId.toString().isNotEmpty) {
        final resultStr = result != null ? json.encode(result) : 'null';
        debugPrint('发送回调: $callbackId, 结果: $resultStr');
        await controller.runJavaScript(
          'NativeUtil.NativeCallback("$callbackId", $resultStr)',
        );
      }
    } catch (e) {
      debugPrint('处理 JS 消息错误: $e');
    }
  }

  Future<void> invokeCallback(String callbackId, dynamic result) async {
    final resultStr = result != null ? json.encode(result) : 'null';
    await controller.runJavaScript(
      'NativeUtil.NativeCallback("$callbackId", $resultStr)',
    );
  }
}
