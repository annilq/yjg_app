# 云建管 Flutter 项目开发指南

## 1. 开发指南概述

本开发指南提供了云建管 Flutter 项目的开发最佳实践和指导，包括项目结构、编码规范、测试策略和部署流程等。本指南旨在帮助智能体和开发人员了解项目的开发流程和规范，确保代码质量和开发效率。

## 2. 快速导航

### 2.1 新增功能/模块

```
1. 查阅 ARCHITECTURE.md → 确定功能归属的域和层
2. 查阅 docs/DESIGN.md → 了解设计原则和约束
3. 查阅 docs/PLANS.md → 生成功能开发计划文档
4. 开发 → 遵循依赖方向（见 ARCHITECTURE.md）
5. 提交 → 遵循 Git 提交规范（见 AGENTS.md）
```

### 2.2 修复 Bug

```
1. 定位问题所在的包/模块
2. 查阅 docs/RELIABILITY.md → 了解可靠性要求
3. 修复 → 确保不破坏架构约束
4. 添加测试 → 防止回归
```

### 2.3 重构/优化

```
1. 查阅 ARCHITECTURE.md → 理解当前架构边界
2. 查阅 docs/QUALITY_SCORE.md → 识别质量 gap
3. 制定计划 → 更新 docs/PLANS.md
4. 执行 → 保持依赖方向不变
```

## 3. 常用命令

```bash
# 安装依赖
flutter pub get

# 运行
flutter run

# 代码生成
flutter pub run build_runner build

# 代码生成（watch 模式）
flutter pub run build_runner watch

# 代码检查
flutter analyze

# 运行测试
flutter test

# 运行测试（带覆盖率）
flutter test --coverage

# 构建（Android）
flutter build apk

# 构建（iOS）
flutter build ios

# 构建（Web）
flutter build web

# 启动 DevTools
flutter pub global run devtools

# 格式化代码
flutter format .
```

## 4. 项目结构

### 4.1 目录结构

项目采用 Feature-First 架构，目录结构如下：

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

### 4.2 模块划分

- **core/**: 核心功能，如常量定义、主题配置、工具类和错误处理
- **features/**: 功能模块，如认证、主页、通知、办公、工作流和 WebView
- **shared/**: 共享资源，如通用组件、通用服务和通用模型
- **routes/**: 路由配置，使用 GoRouter 进行路由管理

## 5. 编码规范

### 5.1 Dart 代码风格

项目遵循 Dart 官方推荐的代码风格，使用 `flutter format` 命令格式化代码。主要规范包括：

- 使用 2 个空格进行缩进
- 使用驼峰命名法
- 类名使用大驼峰命名法
- 变量和函数名使用小驼峰命名法
- 常量使用全大写字母，单词之间用下划线分隔
- 每行代码长度不超过 80 个字符
- 使用空行分隔不同的逻辑块
- 为函数和类添加文档注释

### 5.2 命名规范

- **文件命名**: 使用小写字母，单词之间用下划线分隔，如 `login_screen.dart`
- **类命名**: 使用大驼峰命名法，如 `LoginScreen`
- **变量命名**: 使用小驼峰命名法，如 `userName`
- **常量命名**: 使用全大写字母，单词之间用下划线分隔，如 `MAX_RETRY_COUNT`
- **函数命名**: 使用小驼峰命名法，如 `fetchUserData`
- **枚举命名**: 使用大驼峰命名法，如 `LoginStatus`
- **私有成员**: 使用下划线前缀，如 `_privateMethod`

### 5.3 代码组织

- **模块化**: 将功能划分为独立的模块，每个模块负责特定的功能
- **分层**: 每个模块内部采用分层设计，包括表示层、状态管理层、服务层和模型层
- **代码重用**: 提取通用功能到共享模块，避免代码重复
- **依赖管理**: 使用 Riverpod 进行依赖注入，避免硬编码依赖

### 5.4 错误处理

- **异常处理**: 使用 try-catch 捕获和处理异常
- **错误类型**: 定义明确的错误类型，如 `AppException` 和 `AppFailure`
- **错误反馈**: 向用户提供清晰、具体的错误提示
- **日志记录**: 记录错误信息，便于调试和问题排查

## 6. 开发流程

### 6.1 智能体工作流程

1. **任务理解**: 智能体应首先理解任务需求，确定需要修改的文件和模块
2. **上下文收集**: 智能体应收集相关的代码和文档，了解当前的实现和约束
3. **方案设计**: 智能体应设计实现方案，确保符合项目的架构和规范
4. **代码生成**: 智能体应生成高质量的代码，包括功能实现、测试和文档
5. **自我审查**: 智能体应审查自己的代码，识别和修复问题
6. **测试验证**: 智能体应运行测试，确保代码的正确性和质量
7. **提交请求**: 智能体应创建 Pull Request，等待审查和合并

### 6.2 代码生成

项目使用 `build_runner` 执行代码生成，主要用于：

- **Freezed**: 生成不可变数据类
- **json_serializable**: 生成 JSON 序列化和反序列化代码

执行命令：

```bash
dart run build_runner build
```

开发过程中可以使用 watch 模式：

```bash
dart run build_runner watch
```

### 6.3 代码质量检查

项目使用 `flutter_lints` 进行代码检查，确保代码质量。执行命令：

```bash
flutter analyze
```

### 6.4 性能分析

项目使用 `flutter devtools` 进行性能分析，识别和解决性能问题。执行命令：

```bash
flutter pub global activate devtools
flutter run --profile
flutter pub global run devtools
```

## 7. 测试策略

### 7.1 单元测试

- **测试文件**: 放在 `test` 目录中，按功能模块组织
- **测试命名**: 测试文件命名为 `xxx_test.dart`
- **测试覆盖**: 对关键功能进行单元测试，确保测试覆盖率达到 80% 以上
- **测试框架**: 使用 `flutter_test` 框架进行测试

### 7.2 集成测试

- **测试文件**: 放在 `test/integration_test` 目录中
- **测试内容**: 对主要业务流程进行集成测试，模拟真实用户操作
- **测试框架**: 使用 `integration_test` 包进行测试

### 7.3 Widget 测试

- **测试文件**: 放在 `test/widget_test` 目录中
- **测试内容**: 对 UI 组件进行测试，验证组件的渲染和交互
- **测试框架**: 使用 `flutter_test` 框架进行测试

### 7.4 测试覆盖率

使用 `flutter test --coverage` 生成测试覆盖率报告，分析测试覆盖率，补充缺失的测试用例。

## 8. 部署流程

### 8.1 构建流程

1. **代码检查**: 运行 `flutter analyze` 确保没有语法问题
2. **代码生成**: 运行 `dart run build_runner build` 生成代码
3. **测试**: 运行 `flutter test` 确保测试通过
4. **构建**: 运行 `flutter build` 构建应用

### 8.2 发布流程

1. **版本管理**: 更新版本号和构建号
2. **构建**: 构建应用的发布版本
3. **测试**: 进行最终的测试和验证
4. **发布**: 发布应用到应用商店或企业分发平台

### 8.3 CI/CD 集成

项目使用 CI/CD 工具（如 GitHub Actions）进行自动化构建和测试，确保代码质量和构建稳定性。

## 9. 最佳实践

### 9.1 架构最佳实践

- **模块化设计**: 将功能划分为独立的模块，每个模块负责特定的功能
- **分层设计**: 每个模块内部采用分层设计，保持代码结构清晰
- **依赖注入**: 使用 Riverpod 进行依赖注入，避免硬编码依赖
- **代码生成**: 使用 Freezed 和 json_serializable 进行代码生成，减少样板代码

### 9.2 编码最佳实践

- **代码风格**: 遵循 Dart 官方推荐的代码风格，使用 `flutter format` 格式化代码
- **命名规范**: 使用一致的命名规范，提高代码的可读性
- **代码组织**: 保持代码的模块化和结构化，便于理解和维护
- **错误处理**: 实现完善的错误处理机制，提供清晰的错误提示

### 9.3 测试最佳实践

- **测试覆盖**: 确保关键功能的测试覆盖率达到 80% 以上
- **测试质量**: 编写高质量的测试用例，覆盖正常流程和异常情况
- **测试自动化**: 实现自动化测试，确保代码的正确性和质量
- **测试反馈**: 及时处理测试失败，确保代码质量

### 9.4 性能最佳实践

- **避免重建**: 使用 `const` 构造器和 `const` 变量，避免不必要的重建
- **状态管理**: 使用适当的状态管理策略，避免状态管理不当导致的性能问题
- **网络优化**: 优化网络请求，减少网络延迟和数据传输
- **资源管理**: 合理管理资源，避免内存泄漏和资源浪费

## 10. 工具和资源

### 10.1 开发工具

- **Flutter SDK**: Flutter 开发的核心工具
- **Dart SDK**: Dart 语言的开发工具
- **Android Studio/VS Code**: 集成开发环境
- **Flutter DevTools**: 性能分析和调试工具
- **SKILLS**: `.agents/skills/`

### 10.2 文档资源

- **Flutter 官方文档**: https://flutter.dev/docs
- **Dart 官方文档**: https://dart.dev/docs
- **Riverpod 文档**: https://riverpod.dev/docs
- **GoRouter 文档**: https://pub.dev/packages/go_router
- **Freezed 文档**: https://pub.dev/packages/freezed
- **json_serializable 文档**: https://pub.dev/packages/json_serializable
