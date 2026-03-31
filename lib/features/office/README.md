# 办公模块 (office)

## 模块功能

办公模块负责办公相关功能，包括待办事项、相关任务等功能。

## 目录结构

```
office/
├── service/        # 数据服务
│   └── office_service.dart     # 办公服务
├── models/          # 实体
│   └── backlog_model.dart     # 待办事项模型
├── presentation/    # 表示层
│   ├── screens/     # 页面
│   │   ├── backlog_list_screen.dart      # 待办事项列表页面
│   │   └── relatedtome_list_screen.dart  # 相关任务列表页面
│   └── widgets/     # 组件
│       ├── backlog_tab_widget.dart           # 待办事项标签组件
│       └── relatedtome_tab_widget.dart       # 相关任务标签组件
└── providers/       # 状态管理
    ├── backlog_provider.dart    # 待办事项状态管理
    └── relatedtome_provider.dart  # 相关任务状态管理
```

## 依赖关系

- **核心模块**: 依赖 core 模块中的常量、主题、工具类和错误处理
- **共享模块**: 依赖 shared 模块中的通用组件和服务
- **认证模块**: 依赖 auth 模块中的认证状态

## 使用方法

### 待办事项

1. 用户通过底部导航栏或侧边栏进入办公模块
2. 待办事项列表页面展示用户的待办事项
3. 用户可以点击待办事项查看详细信息
4. 用户可以标记待办事项为已完成

### 相关任务

1. 用户在办公模块中切换到相关任务标签
2. 相关任务列表页面展示与用户相关的任务
3. 用户可以点击任务查看详细信息
4. 用户可以更新任务状态

## 主要服务

### OfficeService

负责办公相关的服务，包括获取待办事项、相关任务等功能。

## 状态管理

使用 Riverpod 进行状态管理，主要包括：

- `backlogProvider`: 管理待办事项状态
- `relatedtomeProvider`: 管理相关任务状态

## 注意事项

- 办公模块需要及时更新任务状态，确保用户能够看到最新的任务信息
- 实现适当的错误处理和加载状态
- 考虑添加任务提醒功能，及时提醒用户有即将到期的任务
