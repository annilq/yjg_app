import 'dart:io';
import 'package:flutter_app/core/utils/encryption_util.dart';
import 'package:flutter_app/shared/services/network_service.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  final NetworkService _networkService = NetworkService();

  ApiService._internal();

  Future<Map<String, dynamic>> login(
    String accountName,
    String userName,
    String password,
  ) async {
    int currentInterval = DateTime.now().millisecondsSinceEpoch;
    String sha1Pass = EncryptionUtil.generateSHA1('$currentInterval$password');

    Map<String, dynamic> parameters = {
      'accountname': accountName,
      'username': userName,
      'password': sha1Pass,
      'timestamp': currentInterval,
    };

    var response = await _networkService.post('login', parameters);
    return response.data;
  }

  Future<Map<String, dynamic>> getUserToken(
    String accountName,
    String userName,
    String password,
  ) async {
    int currentInterval = DateTime.now().millisecondsSinceEpoch;
    String md5Pass = EncryptionUtil.generateMD5(password);

    Map<String, dynamic> parameters = {
      'tenantName': accountName,
      'loginName': userName,
      'from': 'app',
      'password': md5Pass,
      'timestamp': currentInterval,
      'POSTMETHOD': 'JSON',
    };

    var response = await _networkService.post(
      'http://uc.jianguanoa.com/login',
      parameters,
    );
    var userDataResponse = await getUserInfo(response.data['token'], userName);
    return userDataResponse;
  }

  Future<Map<String, dynamic>> getUserInfo(
    String token,
    String loginName,
  ) async {
    Map<String, dynamic> parameters = {'token': token, 'loginName': loginName};

    var response = await _networkService.post('new-login', parameters);
    return response.data;
  }

  Future<Map<String, dynamic>> sendCode(Map<String, dynamic> params) async {
    var response = await _networkService.post(
      'http://uc.jianguanoa.com/api/passwdRest/sendSms',
      params,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> resetPassword(
    Map<String, dynamic> params,
  ) async {
    var response = await _networkService.post(
      'http://uc.jianguanoa.com/api/passwdRest/submit',
      params,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> updatePassword(
    Map<String, dynamic> params,
  ) async {
    var response = await _networkService.post(
      'http://uc.jianguanoa.com/user/changePasswd',
      params,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getMainMenus() async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkService.post('main/menus', authInfo);
    return response.data;
  }

  Future<String> getMainMenusVersion() async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkService.post('main/menus/version', authInfo);
    return response.data;
  }

  Future<String> cleanMainMenus() async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkService.post('clean', authInfo);
    return response.data;
  }

  Future<Map<String, dynamic>> getMainWorkflows() async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkService.post('main/workflows', authInfo);
    return response.data;
  }

  Future<String> getMainWorkflowsVersion() async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkService.post('main/workflows/version', authInfo);
    return response.data;
  }

  Future<Map<String, dynamic>> getMainDataListConfig() async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkService.post('main/datalistconfig', authInfo);
    return response.data;
  }

  Future<String> getMainDataListConfigVersion() async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkService.post(
      'main/datalistconfig/version',
      authInfo,
    );
    return response.data;
  }

  Future<List<dynamic>> getData(String url) async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkService.post(url, authInfo);
    return response.data;
  }

  Future<Map<String, dynamic>> getMainReminds() async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkService.post('main/reminds', authInfo);
    return {'remindModels': response.data};
  }

  Future<int> getWorkflowBacklogCount() async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkService.post('workflow/backlog/count', authInfo);
    return response.data;
  }

  Future<Map<String, dynamic>> getMainDocs() async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkService.post('main/docs', authInfo);
    return response.data;
  }

  Future<Map<String, dynamic>> getAddressBookFrequent() async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkService.post('address-book/frequent', authInfo);
    return response.data;
  }

  Future<Map<String, dynamic>> getAddressBookFull() async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkService.post('address-book/full', authInfo);
    return {'deptModels': response.data};
  }

  Future<Map<String, dynamic>> getAddressBookUserDetail(String userId) async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkService.post(
      'address-book/get/$userId',
      authInfo,
    );
    return response.data;
  }

  Future<bool> setAddressBookContactFrequent(
    String userId,
    bool frequent,
  ) async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    String url = frequent
        ? 'address-book/set-to-frequent/on'
        : 'address-book/set-to-frequent/off';
    authInfo['userId'] = userId;

    await _networkService.post(url, authInfo);
    return true;
  }

  Future<Map<String, dynamic>> getNotificationList(
    int status,
    String? keyword,
    int page,
    int rows,
  ) async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    if (keyword != null) {
      authInfo['keyWord'] = keyword;
    }
    authInfo['page'] = page;
    authInfo['rows'] = rows;

    var response = await _networkService.post(
      'notification/list/$status',
      authInfo,
    );
    return response.data;
  }

  Future<bool> setNotificationRead(String notificationId) async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    await _networkService.post('notification/read/$notificationId', authInfo);
    return true;
  }

  Future<bool> setNotificationAllRead() async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    await _networkService.post('notification/read-all', authInfo);
    return true;
  }

  Future<int> getNotificationUnReadCount() async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkService.post(
      'notification/get-unread-count',
      authInfo,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getBacklogList(
    int status,
    String? keyword,
    int page,
    int rows,
  ) async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    int statusValue = status == 0 ? 1 : 2;
    if (keyword != null) {
      authInfo['keyWord'] = keyword;
    }
    authInfo['page'] = page;
    authInfo['rows'] = rows;

    var response = await _networkService.post(
      'workflow/backlog/list/$statusValue',
      authInfo,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getRelatedToMeList(
    int status,
    String? keyword,
    int page,
    int rows,
  ) async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    if (keyword != null) {
      authInfo['keyWord'] = keyword;
    }
    authInfo['page'] = page;
    authInfo['rows'] = rows;

    var response = await _networkService.post(
      'workflow/relatedtome/list/$status',
      authInfo,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getDataList(
    String dataId,
    Map<String, dynamic>? filterDict,
    int page,
    int rows,
    int reminderIndex,
  ) async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
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

    var response = await _networkService.post('datalist/$dataId', authInfo);
    return response.data;
  }

  Future<bool> setRegistrationId(String registrationId) async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    authInfo['registrationId'] = registrationId;
    authInfo['clientType'] = 2;

    await _networkService.post('public/set-registrationId', authInfo);
    return true;
  }

  Future<bool> getPushStatus() async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    authInfo['clientType'] = 2;

    var response = await _networkService.post('public/get-push-status', authInfo);
    return response.data == 'opend';
  }

  Future<bool> togglePushStatus(String registrationId) async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    authInfo['registrationId'] = registrationId;
    authInfo['clientType'] = 2;

    await _networkService.post('public/toggle-push-status', authInfo);
    return true;
  }

  Future<String> uploadImage(File image) async {
    return await _networkService.uploadImage(image, 'public/upload-img');
  }

  Future<String> uploadTempImage(File image) async {
    return await _networkService.uploadImage(image, 'public/upload-temp-img');
  }

  Future<String> uploadAvatar(File image) async {
    return await _networkService.uploadImage(image, 'public/upload-avatar');
  }

  Future<int> getLeftDays() async {
    Map<String, dynamic>? authInfo = await _networkService.getAuthenticationInfo();
    if (authInfo == null) {
      throw Exception('未登录');
    }

    var response = await _networkService.post('public/get-left-days', authInfo);
    return response.data;
  }
}
