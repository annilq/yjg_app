# 工作流模块 (workflow)

## 模块功能

工作流模块负责工作流程的管理，包括流程列表、流程设置等功能。

## 目录结构

```
workflow/
├── service/        # 数据服务
│   └── workflow_service.dart     # 工作流服务
├── models/          # 实体
│   └── workflow_model.dart     # 工作流模型
├── presentation/    # 表示层
│   ├── screens/     # 页面
│   │   ├── workflow_list_screen.dart      # 工作流列表页面
│   │   └── workflow_setting_screen.dart   # 工作流设置页面
│   └── widgets/     # 组件
└── providers/       # 状态管理
    ├── workflow_list_provider.dart    # 工作流列表状态管理
    └── workflow_providers.dart        # 工作流状态管理
```

## 依赖关系

- **核心模块**: 依赖 core 模块中的常量、主题、工具类和错误处理
- **共享模块**: 依赖 shared 模块中的通用组件和服务
- **认证模块**: 依赖 auth 模块中的认证状态

## 使用方法

### 工作流列表

1. 用户通过底部导航栏或侧边栏进入工作流模块
2. 工作流列表页面展示用户的工作流程
3. 用户可以点击工作流程查看详细信息
4. 用户可以启动或暂停工作流程

### 工作流设置

1. 用户在工作流模块中进入设置页面
2. 工作流设置页面展示工作流程的配置选项
3. 用户可以修改工作流程的配置
4. 用户可以保存配置更改

## 主要服务

### WorkflowService

负责工作流相关的服务，包括获取工作流列表、启动/暂停工作流程、修改工作流配置等功能。

## 状态管理

使用 Riverpod 进行状态管理，主要包括：

- `workflowListProvider`: 管理工作流列表状态
- `workflowProvider`: 管理工作流状态

## 注意事项

- 工作流模块需要及时更新工作流程状态，确保用户能够看到最新的工作流程信息
- 实现适当的错误处理和加载状态
- 考虑添加工作流程执行日志，便于用户查看工作流程的执行情况
