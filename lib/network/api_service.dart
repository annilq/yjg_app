import 'dart:io';
import 'package:flutter_app/network/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  final NetworkUtil _networkUtil = NetworkUtil();

  ApiService._internal();

  // 登录
  Future<Map<String, dynamic>> login(String accountName, String userName, String password) async {
    int currentInterval = DateTime.now().millisecondsSinceEpoch;
    String sha1Pass = _networkUtil.generateSHA1('$currentInterval$password');

    Map<String, dynamic> parameters = {
      'accountname': accountName,
      'username': userName,
      'password': sha1Pass,
      'timestamp': currentInterval,
    };

    var response = await _networkUtil.post('login', parameters);
    return response.data;
  }

  // 获取用户令牌
  Future<Map<String, dynamic>> getUserToken(String accountName, String userName, String password) async {
    int currentInterval = DateTime.now().millisecondsSinceEpoch;
    String md5Pass = _generateMD5(password);

    Map<String, dynamic> parameters = {
      'tenantName': accountName,
      'loginName': userName,
      'from': 'app',
      'password': md5Pass,
      'timestamp': currentInterval,
      'POSTMETHOD': 'JSON',
    };

    var response = await _networkUtil.post('http://uc.jianguanoa.com/login', parameters);
    return response.data;
  }

  // 获取用户信息
  Future<Map<String, dynamic>> getUserInfo(String token, String loginName) async {
    Map<String, dynamic> parameters = {
      'token': token,
      'loginName': loginName,
    };

    var response = await _networkUtil.post('new-login', parameters);
    return response.data;
  }

  // 发送验证码
  Future<Map<String, dynamic>> sendCode(Map<String, dynamic> params) async {
    var response = await _networkUtil.post('http://uc.jianguanoa.com/api/passwdRest/sendSms', params);
    return response.data;
  }

  // 重置密码
  Future<Map<String, dynamic>> resetPassword(Map<String, dynamic> params) async {
    var response = await _networkUtil.post('http://uc.jianguanoa.com/api/passwdRest/submit', params);
    return response.data;
  }

  // 更新密码
  Future<Map<String, dynamic>> updatePassword(Map<String, dynamic> params) async {
    var response = await _networkUtil.post('http://uc.jianguanoa.com/user/changePasswd', params);
    return response.data;
  }

  // 获取主菜单
  Future<Map<String, dynamic>> getMainMenus() async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkUtil.post('main/menus', authInfo);
    return response.data;
  }

  // 获取主菜单版本
  Future<String> getMainMenusVersion() async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkUtil.post('main/menus/version', authInfo);
    return response.data;
  }

  // 清理主菜单
  Future<String> cleanMainMenus() async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkUtil.post('clean', authInfo);
    return response.data;
  }

  // 获取工作流程
  Future<Map<String, dynamic>> getMainWorkflows() async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkUtil.post('main/workflows', authInfo);
    return response.data;
  }

  // 获取工作流程版本
  Future<String> getMainWorkflowsVersion() async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkUtil.post('main/workflows/version', authInfo);
    return response.data;
  }

  // 获取数据列表配置
  Future<Map<String, dynamic>> getMainDataListConfig() async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkUtil.post('main/datalistconfig', authInfo);
    return response.data;
  }

  // 获取数据列表配置版本
  Future<String> getMainDataListConfigVersion() async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkUtil.post('main/datalistconfig/version', authInfo);
    return response.data;
  }

  // 获取数据
  Future<List<dynamic>> getData(String url) async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkUtil.post(url, authInfo);
    return response.data;
  }

  // 获取提醒
  Future<Map<String, dynamic>> getMainReminds() async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkUtil.post('main/reminds', authInfo);
    return {'remindModels': response.data};
  }

  // 获取待办事项数量
  Future<int> getWorkflowBacklogCount() async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkUtil.post('workflow/backlog/count', authInfo);
    return response.data;
  }

  // 获取文档列表
  Future<Map<String, dynamic>> getMainDocs() async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkUtil.post('main/docs', authInfo);
    return response.data;
  }

  // 获取常用联系人
  Future<Map<String, dynamic>> getAddressBookFrequent() async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkUtil.post('address-book/frequent', authInfo);
    return response.data;
  }

  // 获取完整通讯录
  Future<Map<String, dynamic>> getAddressBookFull() async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkUtil.post('address-book/full', authInfo);
    return {'deptModels': response.data};
  }

  // 获取联系人详情
  Future<Map<String, dynamic>> getAddressBookUserDetail(String userId) async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkUtil.post('address-book/get/$userId', authInfo);
    return response.data;
  }

  // 设置联系人常用状态
  Future<bool> setAddressBookContactFrequent(String userId, bool frequent) async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    String url = frequent ? 'address-book/set-to-frequent/on' : 'address-book/set-to-frequent/off';
    authInfo['userId'] = userId;

    await _networkUtil.post(url, authInfo);
    return true;
  }

  // 获取通知列表
  Future<Map<String, dynamic>> getNotificationList(int status, String? keyword, int page, int rows) async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    if (keyword != null) {
      authInfo['keyWord'] = keyword;
    }
    authInfo['page'] = page;
    authInfo['rows'] = rows;

    var response = await _networkUtil.post('notification/list/$status', authInfo);
    return response.data;
  }

  // 标记通知已读
  Future<bool> setNotificationRead(String notificationId) async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    await _networkUtil.post('notification/read/$notificationId', authInfo);
    return true;
  }

  // 标记所有通知已读
  Future<bool> setNotificationAllRead() async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    await _networkUtil.post('notification/read-all', authInfo);
    return true;
  }

  // 获取未读通知数量
  Future<int> getNotificationUnReadCount() async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkUtil.post('notification/get-unread-count', authInfo);
    return response.data;
  }

  // 获取待办事项列表
  Future<Map<String, dynamic>> getBacklogList(int status, String? keyword, int page, int rows) async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    int statusValue = status == 0 ? 1 : 2;
    if (keyword != null) {
      authInfo['keyWord'] = keyword;
    }
    authInfo['page'] = page;
    authInfo['rows'] = rows;

    var response = await _networkUtil.post('workflow/backlog/list/$statusValue', authInfo);
    return response.data;
  }

  // 获取相关事项列表
  Future<Map<String, dynamic>> getRelatedToMeList(int status, String? keyword, int page, int rows) async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    if (keyword != null) {
      authInfo['keyWord'] = keyword;
    }
    authInfo['page'] = page;
    authInfo['rows'] = rows;

    var response = await _networkUtil.post('workflow/relatedtome/list/$status', authInfo);
    return response.data;
  }

  // 获取数据列表
  Future<Map<String, dynamic>> getDataList(String dataId, Map<String, dynamic>? filterDict, int page, int rows, int reminderIndex) async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    authInfo['page'] = page;
    authInfo['rows'] = rows;
    if (filterDict != null) {
      authInfo.addAll(filterDict);
    }
    if (reminderIndex >= 0) {
      authInfo['reminderIndex'] = reminderIndex;
    }

    var response = await _networkUtil.post('datalist/$dataId', authInfo);
    return response.data;
  }

  // 设置推送 ID
  Future<bool> setRegistrationId(String registrationId) async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    authInfo['registrationId'] = registrationId;
    authInfo['clientType'] = 2;

    await _networkUtil.post('public/set-registrationId', authInfo);
    return true;
  }

  // 获取推送状态
  Future<bool> getPushStatus() async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    authInfo['clientType'] = 2;

    var response = await _networkUtil.post('public/get-push-status', authInfo);
    return response.data == 'opend';
  }

  // 切换推送状态
  Future<bool> togglePushStatus(String registrationId) async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    authInfo['registrationId'] = registrationId;
    authInfo['clientType'] = 2;

    await _networkUtil.post('public/toggle-push-status', authInfo);
    return true;
  }

  // 上传图片
  Future<String> uploadImage(File image) async {
    return await _networkUtil.uploadImage(image, 'public/upload-img');
  }

  // 上传临时图片
  Future<String> uploadTempImage(File image) async {
    return await _networkUtil.uploadImage(image, 'public/upload-temp-img');
  }

  // 上传头像
  Future<String> uploadAvatar(File image) async {
    return await _networkUtil.uploadImage(image, 'public/upload-avatar');
  }

  // 获取剩余天数
  Future<int> getLeftDays() async {
    Map<String, dynamic>? authInfo = await _networkUtil.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkUtil.post('public/get-left-days', authInfo);
    return response.data;
  }

  // 生成 MD5
  String _generateMD5(String input) {
    // 简化实现，实际项目中应使用 crypto 库
    return input;
  }
}
