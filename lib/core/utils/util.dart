import 'package:flutter_app/core/constants/app_constants.dart';
import 'dart:ui';

class Util {
  static const String _themeColor = '#4678fb';

  static String formatTime(dynamic date, [String format = 'yyyy-MM-dd']) {
    if (date == null) return '';
    
    DateTime dateTime;
    if (date is DateTime) {
      dateTime = date;
    } else if (date is String) {
      dateTime = DateTime.parse(date.replaceAll('-', '/'));
    } else {
      return '';
    }

    String year = dateTime.year.toString();
    String month = _padZero(dateTime.month);
    String day = _padZero(dateTime.day);
    String hours = _padZero(dateTime.hour);
    String minutes = _padZero(dateTime.minute);
    String seconds = _padZero(dateTime.second);

    return format
        .replaceAll('yyyy', year)
        .replaceAll('MM', month)
        .replaceAll('dd', day)
        .replaceAll('HH', hours)
        .replaceAll('mm', minutes)
        .replaceAll('ss', seconds);
  }

  static String getDayInweek(dynamic input) {
    if (input == null) return '';
    
    DateTime date;
    if (input is DateTime) {
      date = input;
    } else if (input is String) {
      date = DateTime.parse(input.replaceAll('-', '/'));
    } else {
      return '';
    }

    String weekday;
    switch (date.weekday) {
      case 1:
        weekday = "一";
        break;
      case 2:
        weekday = "二";
        break;
      case 3:
        weekday = "三";
        break;
      case 4:
        weekday = "四";
        break;
      case 5:
        weekday = "五";
        break;
      case 6:
        weekday = "六";
        break;
      case 7:
        weekday = "天";
        break;
      default:
        weekday = "";
    }
    return "星期$weekday";
  }

  static String _padZero(int value) {
    String str = value.toString();
    return str.length >= 2 ? str : '0$str';
  }

  static String formatName(String? str) {
    if (str == null || str.isEmpty) return '';
    return str.substring(str.length - 2);
  }

  static String? toFixed(num? value, [int number = 2]) {
    if (value == null) return null;
    return value.toStringAsFixed(number);
  }

  static String? toStringValue(dynamic value) {
    if (value == null) return null;
    return value.toString();
  }

  static String themeColor() {
    return _themeColor;
  }

  static String? lisText(List<dynamic>? data, String name) {
    if (data == null || data.isEmpty) return null;
    String value = '';
    for (var item in data) {
      if (item is Map && item[name] != null) {
        value = '$value${item[name]}、';
      }
    }
    return value.isNotEmpty ? value.substring(0, value.length - 1) : null;
  }

  static String? pickerShowKey(List<dynamic>? data, dynamic value) {
    if (value == null && value != 0) return null;
    if (data == null) return null;
    
    for (var item in data) {
      if (item is! Map) continue;
      
      if (value is Map) {
        if (item['value'] is Map) {
          if (item['value'].toString() == value.toString()) {
            return item['label']?.toString();
          }
        }
      } else {
        if (item['value'] == value) {
          return item['label']?.toString();
        }
      }
    }
    return null;
  }

  static String? approveStatus(int? value) {
    if (value == null) return null;
    switch (value) {
      case -1:
        return '待审批';
      case 0:
        return '未初始化';
      case 1:
        return '草稿';
      case 2:
        return '处理中';
      case 3:
        return '审批驳回';
      case 4:
        return '已退回';
      case 5:
        return '撤回';
      case 8:
        return '已通过';
      default:
        return null;
    }
  }

  static Map<String, String>? approvalTypeItem(Map<String, dynamic>? item) {
    if (item == null) return null;
    
    int? value;
    if (item['persons'] != null && item['persons'] is List && (item['persons'] as List).isNotEmpty) {
      var firstPerson = item['persons'][0];
      if (firstPerson is Map) {
        value = firstPerson['approvalType'];
      }
    }
    
    bool isStart = item['isStart'] == true;
    
    if (!isStart) {
      return {'name': '未开始', 'theme': 'default'};
    } else if (value == -2) {
      return {'name': '草稿', 'theme': 'default'};
    } else if (value == -1) {
      return {'name': '未处理', 'theme': 'default'};
    } else if (value == 0) {
      return {'name': '提交审批', 'theme': 'primary'};
    } else if (value == 1) {
      return {'name': '同意', 'theme': 'success'};
    } else if (value == 2) {
      return {'name': '退回至${item['backNodeTitle'] ?? ''}', 'theme': 'danger'};
    } else if (value == 3) {
      return {'name': '撤回', 'theme': 'danger'};
    } else if (value == 4) {
      return {'name': '转交', 'theme': 'warning'};
    } else if (value == 5) {
      return {'name': '驳回', 'theme': 'danger'};
    } else {
      return {'name': '处理中', 'theme': 'primary'};
    }
  }

  static bool contain(List<dynamic> arr, dynamic key) {
    return arr.contains(key);
  }

  static bool valueType(dynamic value, String type) {
    if (value == null) return false;
    switch (type) {
      case 'string':
        return value is String;
      case 'number':
        return value is num;
      case 'boolean':
        return value is bool;
      case 'object':
        return value is Map || value is List;
      case 'array':
        return value is List;
      default:
        return false;
    }
  }

  static dynamic columnsFormat(dynamic value, dynamic dataIndex) {
    if (value == null || dataIndex == null) return null;
    
    if (value is! Map) return null;
    
    if (dataIndex is List) {
      for (var item in dataIndex) {
        if (value[item] != null) {
          return value[item];
        }
      }
    } else {
      return value[dataIndex];
    }
    return null;
  }

  static String? pickerText(dynamic value, List<dynamic>? list) {
    if (value == null) return null;
    if (list == null) return null;
    
    for (var item in list) {
      if (item is Map && item['value'] == value) {
        return item['label']?.toString();
      }
    }
    return null;
  }

  static String getFlowIcon(String? name) {
   
    if (name == null) return "icon-a-108-tongyongtubiao";

    for (var item in AppConstants.MODULE_MAP) {
      if (item.containsKey(name)) {
        var obj = item[name];
        if (obj is Map && obj['className'] != null) {
          return obj['className'];
        }
      }
    }
    return "icon-a-108-tongyongtubiao";
  }

  static String getModuleClass(String? formKey) {
    if (formKey == null || formKey.isEmpty) return "bg-contract";
    
    List<String> parts = formKey.split("_");
    String moduleName = parts.isNotEmpty ? parts[0] : "contract";
    moduleName = moduleName.toLowerCase();
    
    return "bg-$moduleName";
  }

  
  static bool checkInLocal(dynamic flowId, List<dynamic>? flowList) {
    if (flowList == null) return false;
    
    for (var item in flowList) {
      if (item is Map && item['id'] == flowId) {
        return true;
      }
    }
    return false;
  }

  static List<String> getFlowStatus(int? status) {
    switch (status) {
      case 1:
        return ["已通过", "text-green"];
      case 2:
        return ["待审批", "text-blue"];
      case 3:
        return ["已拒绝", "text-red"];
      default:
        return ["", ""];
    }
  }

  static bool isCurDate(dynamic time) {
    if (time == null) return false;
    
    DateTime now = DateTime.now();
    String todayStr = formatTime(now);
    String timeStr = formatTime(time);
    
    return todayStr == timeStr;
  }

  static Color getModuleColor(String? formKey) {
    String moduleClass = getModuleClass(formKey);
    
    switch (moduleClass) {
      case 'bg-project':
        return const Color(0xFFFF452C);
      case 'bg-contract':
        return const Color(0xFFFF9454);
      case 'bg-finance':
        return const Color(0xFFFE4F24);
      case 'bg-chief':
        return const Color(0xFF04BB69);
      case 'bg-personnel':
        return const Color(0xFFDC4BF9);
      case 'bg-xm':
        return const Color(0xFF0D54FC);
      case 'bg-other':
        return const Color(0xFF1B67FB);
      case 'bg-material':
        return const Color(0xFF7130EE);
      default:
        return const Color(0xFFFF9454);
    }
  }
}
