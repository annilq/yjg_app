# 云建管 Flutter 项目架构文档

## 1. 架构概述

云建管 Flutter 项目采用 Feature-First 架构，旨在提供高效、可靠的建筑管理系统。本架构文档描述了项目的整体结构、模块划分和依赖关系，为智能体和开发人员提供清晰的架构指南。

## 2. 核心架构原则

### 2.1 Feature-First 架构

项目采用 Feature-First 架构，将功能模块化，每个功能模块包含完整的业务逻辑、数据模型、表示层和状态管理。这种架构使得代码结构清晰，易于理解和维护。

### 2.2 分层设计

每个功能模块内部采用分层设计：

- **表示层**：负责 UI 渲染和用户交互
- **状态管理层**：负责状态管理和业务逻辑
- **服务层**：负责数据获取和处理
- **模型层**：定义数据结构和实体

### 2.3 依赖注入

项目使用 Riverpod 进行依赖注入，使得模块之间的依赖关系清晰，易于测试和维护。

### 2.4 代码生成

项目使用 Freezed 和 json_serializable 进行代码生成，减少手动编写样板代码的需要，提高开发效率。

## 3. 目录结构

```
lib/
├── main.dart       # 应用入口
├── app.dart        # 应用配置
├── core/           # 核心功能
│   ├── constants/  # 常量定义
│   ├── theme/      # 主题配置
│   ├── utils/      # 工具类
│   └── errors/     # 错误处理
├── features/       # 功能模块
│   ├── auth/       # 认证模块
│   │   ├── service/        # 数据服务
│   │   ├── models/          # 实体
│   │   ├── presentation/    # 表示层
│   │   │   ├── screens/     # 页面
│   │   │   └── widgets/     # 组件
│   │   └── providers/       # 状态管理
│   ├── home/       # 主页模块
│   ├── notices/    # 通知模块
│   ├── office/     # 办公模块
│   ├── workflow/   # 工作流模块
│   └── webview/    # WebView 模块
├── shared/         # 共享资源
│   ├── widgets/    # 通用组件
│   ├── services/   # 通用服务
│   └── models/     # 通用模型
└── routes/         # 路由配置
    └── app_router.dart
```

## 4. 模块划分

### 4.1 核心模块 (core/)

核心模块包含应用的基础功能，如常量定义、主题配置、工具类和错误处理。这些功能被其他模块共享使用。

### 4.2 功能模块 (features/)

功能模块包含应用的具体业务功能，每个功能模块都是一个独立的业务领域：

- **auth**：认证模块，负责用户登录、注册和密码管理
- **home**：主页模块，负责应用的主页展示
- **notices**：通知模块，负责通知的展示和管理
- **office**：办公模块，负责办公相关功能
- **workflow**：工作流模块，负责工作流程的管理
- **webview**：WebView 模块，负责加载和显示网页内容

### 4.3 共享模块 (shared/)

共享模块包含多个功能模块共用的资源，如通用组件、通用服务和通用模型。

### 4.4 路由模块 (routes/)

路由模块负责应用的导航和路由管理，使用 GoRouter 进行路由配置。

## 5. 依赖关系

### 5.1 模块间依赖

- 功能模块依赖核心模块和共享模块
- 共享模块依赖核心模块
- 路由模块依赖功能模块和共享模块

### 5.2 依赖层次（自底向上）

```
┌─────────────────────────────────────────────────────────┐
│  routes/         路由配置（依赖 features/ 和 shared/）  │
│                  ↑ 依赖 features/ 和 shared/            │
├─────────────────────────────────────────────────────────┤
│  features/       功能模块                                │
│                  ↑ 依赖 core/ 和 shared/                │
├─────────────────────────────────────────────────────────┤
│  shared/         共享资源                                │
│                  ↑ 依赖 core/                          │
├─────────────────────────────────────────────────────────┤
│  core/           核心功能（被所有模块依赖）              │
│                  ↑ 仅依赖外部包                        │
├─────────────────────────────────────────────────────────┤
│  pub dependencies 外部依赖（Flutter SDK、第三方库）     │
└─────────────────────────────────────────────────────────┘
```

### 5.3 依赖方向规则（严格遵守）

```
Models → Services → Providers → Presentation
```

- **Models**: 数据模型层（实体、DTO、类型定义）
- **Services**: 服务层（API 调用、数据处理）
- **Providers**: 状态管理层（Riverpod 提供者）
- **Presentation**: 表示层（页面、组件）

> **禁止反向依赖**。例如：Presentation 层不能依赖 Services 层中的具体实现。

### 5.4 技术依赖

- Flutter SDK: ^3.8.1
- 网络请求: dio ^5.5.0
- 存储: shared_preferences ^2.2.3, hive_flutter ^1.1.0
- 加密: crypto ^3.0.3
- 图片选择: image_picker ^1.1.1
- 跨平台组件: flutter_platform_widgets ^10.0.0
- 本地国际化: flutter_localizations
- WebView: webview_flutter ^4.13.1
- 状态管理: flutter_riverpod ^2.5.0 (推荐) 或 bloc ^8.x
- 导航: go_router ^14.0.0
- 代码生成: freezed ^2.5.0, json_serializable ^6.8.0

## 6. 技术栈全景

| 层级       | 技术选型                   | 说明                    |
| ---------- | -------------------------- | ----------------------- |
| **框架**   | Flutter 3.8.1 + Dart       | 跨平台 UI 框架          |
| **状态**   | flutter_riverpod 2.5.0     | 声明式状态管理          |
| **导航**   | go_router 14.0.0           | 声明式路由配置          |
| **网络**   | dio 5.5.0                  | 网络请求库              |
| **存储**   | shared_preferences, hive   | 本地存储                |
| **代码生成** | freezed, json_serializable | 减少样板代码            |
| **工具**   | build_runner               | 代码生成工具            |
| **测试**   | flutter_test               | 单元测试和 Widget 测试  |
| **Lint**   | flutter_lints              | 代码质量检查            |

## 7. 业务模块架构标准

### 7.1 模块目录结构

```
features/<模块名>/                  # 模块根目录
├── service/                      # 服务层
│   └── <模块名>_service.dart      # API 接口封装
├── models/                       # 模型层
│   ├── <模块名>_model.dart        # 数据模型
│   ├── <模块名>_model.freezed.dart # Freezed 生成文件
│   └── <模块名>_model.g.dart      # JSON 序列化生成文件
├── presentation/                 # 表示层
│   ├── screens/                  # 页面
│   │   └── <模块名>_screen.dart   # 主页面
│   └── widgets/                  # 组件
│       └── <模块名>_widget.dart   # 通用组件
├── providers/                    # 状态管理层
│   └── <模块名>_providers.dart    # Riverpod 提供者
└── README.md                     # 模块文档
```

### 7.2 文件职责说明

| 文件 | 职责 | 说明 |
| --- | --- | --- |
| `service/<模块名>_service.dart` | 服务层 | API 接口封装、数据处理 |
| `models/<模块名>_model.dart` | 模型层 | 数据模型定义、序列化 |
| `presentation/screens/<模块名>_screen.dart` | 表示层 | 页面布局、用户交互 |
| `presentation/widgets/<模块名>_widget.dart` | 表示层 | 可复用组件 |
| `providers/<模块名>_providers.dart` | 状态管理层 | 状态管理、业务逻辑 |
| `README.md` | 文档 | 模块说明、使用指南 |

### 7.3 依赖方向

```
models/ (模型层)
    ↑
service/ (服务层)
    ↑
providers/ (状态管理层)
    ↑
presentation/ (表示层)
```

### 7.4 模块命名规范

| 类型     | 命名规则            | 示例                        |
| -------- | ------------------- | --------------------------- |
| 业务模块 | 模块名英文          | auth、home、notices         |
| 服务文件 | `模块名 + _service.dart` | auth_service.dart           |
| 模型文件 | `模块名 + _model.dart` | auth_model.dart             |
| 页面文件 | `模块名 + _screen.dart` | auth_screen.dart            |
| 组件文件 | `模块名 + _widget.dart` | auth_widget.dart            |
| 提供者文件 | `模块名 + _providers.dart` | auth_providers.dart         |

### 7.5 创建新模块 checklist

1. 在 `features/` 下创建模块目录（如 `auth/`）
2. 创建 `models/<模块名>_model.dart` - 定义数据模型
3. 创建 `service/<模块名>_service.dart` - 封装 API 方法
4. 创建 `providers/<模块名>_providers.dart` - 实现状态管理
5. 创建 `presentation/screens/<模块名>_screen.dart` - 实现页面
6. 创建 `presentation/widgets/` - 添加必要的组件
7. 创建 `README.md` - 编写模块文档
8. 在 `routes/app_router.dart` 中注册路由

## 8. 架构决策记录

### 8.1 状态管理选择

**决策**: 使用 Riverpod 作为主要状态管理方案

**理由**:
- Riverpod 是一种现代、声明式的状态管理方案
- 支持依赖注入，使得代码更易于测试和维护
- 性能优秀，适合复杂应用
- 与 Flutter 生态系统集成良好

### 8.2 导航方案选择

**决策**: 使用 GoRouter 作为导航方案

**理由**:
- GoRouter 提供了声明式的路由配置
- 支持嵌套路由和参数传递
- 与 Riverpod 集成良好
- 性能优秀，适合复杂应用

### 8.3 代码生成工具选择

**决策**: 使用 Freezed 和 json_serializable 进行代码生成

**理由**:
- 减少手动编写样板代码的需要
- 提高代码质量和一致性
- 与 Flutter 生态系统集成良好
- 支持不可变数据模型

## 9. 架构演进

### 9.1 当前架构状态

当前架构采用 Feature-First 架构，使用 Riverpod 进行状态管理，GoRouter 进行导航，Freezed 和 json_serializable 进行代码生成。

### 9.2 未来架构演进

- 增强模块化：进一步提高模块的独立性和可测试性
- 引入更多自动化测试：提高代码质量和可靠性
- 优化性能：针对大型应用场景进行性能优化
- 增强可观测性：添加更多的监控和日志记录

## 10. 架构最佳实践

### 10.1 模块设计

- 每个模块应该有清晰的职责和边界
- 模块之间的依赖关系应该明确，避免循环依赖
- 模块内部应该采用分层设计，保持代码结构清晰

### 10.2 代码组织

- 代码应该按照功能和职责进行组织
- 文件名和目录结构应该清晰明了，便于导航
- 代码风格应该一致，遵循 Flutter 官方推荐的代码风格

### 10.3 测试策略

- 对关键功能进行单元测试
- 对主要业务流程进行集成测试
- 对 UI 组件进行 Widget 测试
- 确保测试覆盖率达到 80% 以上

### 10.4 性能优化

- 避免不必要的重建和重绘
- 使用适当的状态管理策略
- 优化网络请求和数据处理
- 确保应用在不同设备上的性能一致

## 11. 结论

云建管 Flutter 项目的架构设计旨在提供一个清晰、可维护、可扩展的代码结构。通过采用 Feature-First 架构、Riverpod 状态管理、GoRouter 导航和代码生成工具，我们可以构建高质量的 Flutter 应用。

随着项目的发展，我们将继续优化架构，确保它能够满足不断变化的业务需求和技术要求。
