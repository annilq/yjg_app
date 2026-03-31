# WebView 模块 (webview)

## 模块功能

WebView 模块负责加载和显示网页内容，包括内嵌网页、外部链接等功能。

## 目录结构

```
webview/
├── service/        # 数据服务
│   └── webview_service.dart     # WebView 服务
├── models/          # 实体
│   └── webview_model.dart     # WebView 模型
├── presentation/    # 表示层
│   ├── screens/     # 页面
│   │   └── webview_screen.dart      # WebView 页面
│   └── widgets/     # 组件
│       └── js_interface_bridge.dart  # JS 接口桥接组件
└── providers/       # 状态管理
    └── webview_providers.dart    # WebView 状态管理
```

## 依赖关系

- **核心模块**: 依赖 core 模块中的常量、主题、工具类和错误处理
- **共享模块**: 依赖 shared 模块中的通用组件和服务
- **认证模块**: 依赖 auth 模块中的认证状态

## 使用方法

### WebView 页面

1. 用户通过其他模块的链接或按钮进入 WebView 模块
2. WebView 页面加载指定的网页内容
3. 用户可以在 WebView 中浏览网页、点击链接等
4. 用户可以通过返回按钮退出 WebView 页面

### JS 接口桥接

1. WebView 模块提供 JS 接口桥接功能，允许网页与 Flutter 应用进行交互
2. 网页可以通过 JS 调用 Flutter 方法
3. Flutter 应用可以通过桥接向网页发送消息

## 主要服务

### WebViewService

负责 WebView 相关的服务，包括加载网页、处理 JS 交互等功能。

## 状态管理

使用 Riverpod 进行状态管理，主要包括：

- `webviewProvider`: 管理 WebView 状态

## 注意事项

- WebView 模块需要处理网页加载失败、超时等异常情况
- 实现适当的错误处理和加载状态
- 考虑添加网页缓存功能，提高加载速度
- 确保 WebView 中的内容安全，避免恶意网页攻击
