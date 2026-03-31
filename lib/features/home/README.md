# 主页模块 (home)

## 模块功能

主页模块负责应用的主页展示，包括公告轮播、常用应用、待办事项等功能。

## 目录结构

```
home/
├── service/        # 数据服务
│   └── home_service.dart     # 主页服务
├── models/          # 实体
│   └── remind_model.dart     # 提醒模型
├── presentation/    # 表示层
│   ├── screens/     # 页面
│   │   ├── home_screen.dart      # 主页
│   │   └── main_screen.dart      # 主屏幕
│   └── widgets/     # 组件
│       ├── announcement_carousel_component.dart  # 公告轮播组件
│       ├── backlog_menu_component.dart           # 待办菜单组件
│       ├── common_apps_component.dart            # 常用应用组件
│       ├── copyright_component.dart              # 版权组件
│       └── fixed_apps_component.dart             # 固定应用组件
└── providers/       # 状态管理
    └── home_providers.dart    # 主页状态管理
```

## 依赖关系

- **核心模块**: 依赖 core 模块中的常量、主题、工具类和错误处理
- **共享模块**: 依赖 shared 模块中的通用组件和服务
- **认证模块**: 依赖 auth 模块中的认证状态

## 使用方法

### 主页展示

1. 用户登录后进入主页
2. 主页展示公告轮播、常用应用、待办事项等内容
3. 用户可以点击常用应用进入相应功能
4. 用户可以点击待办事项查看详细信息

### 主屏幕

1. 主屏幕包含底部导航栏和侧边栏
2. 用户可以通过底部导航栏切换不同功能模块
3. 用户可以通过侧边栏访问设置、关于等功能

## 主要服务

### HomeService

负责主页相关的服务，包括获取公告、常用应用、待办事项等功能。

## 状态管理

使用 Riverpod 进行状态管理，主要包括：

- `homeProvider`: 管理主页状态
- `remindProvider`: 管理提醒状态

## 注意事项

- 主页模块是用户进入应用后看到的第一个模块，需要确保界面美观、响应迅速
- 主页内容需要根据用户权限和角色动态调整
- 实现适当的错误处理和加载状态
