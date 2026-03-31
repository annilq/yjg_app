# 共享模块 (shared)

## 模块功能

共享模块包含多个功能模块共用的资源，如通用组件、通用服务和通用模型。

## 目录结构

```
shared/
├── widgets/    # 通用组件
│   ├── iconfont/  # 图标字体
│   │   ├── iconfont_constants.dart  # 图标字体常量
│   │   ├── iconfont_widget.dart     # 图标字体组件
│   │   └── index.dart                # 图标字体索引
│   ├── app_bar_component.dart        # 应用栏组件
│   ├── app_search_delegate.dart      # 应用搜索代理
│   ├── business_card.dart            # 业务卡片组件
│   ├── business_icon_component.dart  # 业务图标组件
│   ├── button_component.dart         # 按钮组件
│   ├── card_item_component.dart      # 卡片项组件
│   ├── empty_card.dart               # 空卡片组件
│   ├── error_component.dart          # 错误组件
│   ├── index.dart                    # 组件索引
│   ├── loading_component.dart        # 加载组件
│   ├── main_drawer.dart              # 主抽屉组件
│   ├── paginated_list_screen.dart    # 分页列表页面
│   ├── snackbar_helper.dart          #  Snackbar 辅助类
│   ├── tab_component.dart            # 标签组件
│   ├── text_button_component.dart    # 文本按钮组件
│   └── text_form_field_component.dart # 文本输入框组件
├── services/   # 通用服务
│   ├── api_service.dart            # API 服务
│   ├── js_interface_service.dart   # JS 接口服务
│   └── network_service.dart        # 网络服务
└── models/     # 通用模型
    └── login_response_model.dart   # 登录响应模型
```

## 依赖关系

- **核心模块**: 依赖 core 模块中的常量、主题、工具类和错误处理

## 使用方法

### 通用组件使用

```dart
import 'package:flutter_app/shared/widgets/button_component.dart';

// 使用按钮组件
ButtonComponent(
  onPressed: () {
    // 按钮点击事件
  },
  text: '点击按钮',
);
```

### 通用服务使用

```dart
import 'package:flutter_app/shared/services/api_service.dart';

// 使用 API 服务
var response = await ApiService.get('/api/users');
```

### 通用模型使用

```dart
import 'package:flutter_app/shared/models/login_response_model.dart';

// 使用登录响应模型
LoginResponseModel loginResponse = LoginResponseModel.fromJson(json);
```

## 注意事项

- 共享模块包含多个功能模块共用的资源，需要确保其通用性和稳定性
- 避免在共享模块中引入特定功能模块的依赖
- 保持共享模块的功能简洁明了，只包含真正通用的资源
