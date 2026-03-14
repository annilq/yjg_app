# 云建管 Flutter 项目开发规则

## 1. 项目架构

### 1.1 目录结构 (Feature-First 架构)

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
│   │   ├── service/        # 数据服务（合并datasources和repositories）
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

### 1.2 技术栈

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


## 2. 开发规范
开发过程中应参考`.agents/skills/`目录下的技能指南。

- 在开发新功能前，参考相关技能指南
- 遵循技能指南中的最佳实践
- 利用技能指南中的代码模板和示例
- 定期更新技能指南，保持与 Flutter 最新版本同步

### 2.1 状态管理最佳实践

- **使用 AsyncNotifier 处理异步操作**：对于需要异步加载数据的场景，优先使用 `AsyncNotifier` 替代 `Notifier` + `Future.microtask` 的组合。
- **优势**：
  - 自动处理加载、成功、错误状态，无需手动管理 `isLoading` 和 `error` 字段
  - 代码结构更清晰，避免了状态未初始化的问题
  - 利用 Riverpod 的内置机制，简化状态管理逻辑
- **示例**：
  ```dart
  final homeScreenProvider = AsyncNotifierProvider<HomeScreenNotifier, HomeScreenData>(
    HomeScreenNotifier.new,
  );
  
  class HomeScreenNotifier extends AsyncNotifier<HomeScreenData> {
    @override
    Future<HomeScreenData> build() async {
      final homeService = ref.read(homeServiceProvider);
      
      final remindsResponse = await homeService.getMainReminds();
      final backlogCount = await homeService.getWorkflowBacklogCount();
      
      return HomeScreenData(
        reminds: remindsResponse.remindModels ?? [],
        backlogCount: backlogCount,
      );
    }
  }
  ```

## 3. 测试规范

### 3.1 单元测试

- 对关键功能进行单元测试
- 测试文件放在 `test` 目录中，按功能模块组织
- 测试文件命名为 `xxx_test.dart`
- 测试用例应覆盖正常流程和异常情况
- 使用 `flutter_test` 框架进行测试

### 3.2 集成测试

- 对主要业务流程进行集成测试
- 测试文件放在 `test/integration_test` 目录中
- 测试用例应模拟真实用户操作
- 使用 `integration_test` 包进行测试

### 3.3 Widget 测试

- 对 UI 组件进行测试
- 测试文件放在 `test/widget_test` 目录中
- 测试用例应验证组件的渲染和交互
- 使用 `flutter_test` 框架进行测试

### 3.4 测试覆盖率

- 关键功能的测试覆盖率应达到 80% 以上
- 使用 `flutter test --coverage` 生成测试覆盖率报告
- 分析测试覆盖率，补充缺失的测试用例


## 4. 其他规范

### 4.1 工具使用

- 使用 `flutter_lints` 进行代码检查
- 使用 `flutter format` 格式化代码
- 使用 `flutter analyze` 分析代码
- 使用 `flutter devtools` 进行性能分析
- 运行项目时使用 `flutter run -d macos` 命令
- 提交代码前运行 `flutter analyze` 确保没有语法问题