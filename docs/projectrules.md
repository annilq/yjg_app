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
│   │   ├── data/       # 数据层
│   │   │   ├── repositories/  # 数据仓库
│   │   │   └── datasources/   # 数据源
│   │   ├── domain/     # 领域层
│   │   │   ├── entities/      # 实体
│   │   │   └── usecases/      # 用例
│   │   ├── presentation/ # 表示层
│   │   │   ├── screens/       # 页面
│   │   │   └── widgets/       # 组件
│   │   └── providers/   # 状态管理
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

## 2. 代码规范

### 2.1 命名约定

#### 2.1.1 文件命名
- 使用小写字母和下划线组合，如 `login_screen.dart`
- 页面文件以 `_screen.dart` 结尾（在 features 模块中）
- 组件文件以 `_widget.dart` 结尾（在 features 模块中）
- 组件文件以 `_component.dart` 结尾（在 shared 目录中）
- 模型文件以 `_model.dart` 结尾（在 shared 目录中）
- 实体文件以 `_entity.dart` 结尾（在 domain 层中）
- 用例文件以 `_usecase.dart` 结尾（在 domain 层中）
- 仓库文件以 `_repository.dart` 结尾（在 data 层中）
- 数据源文件以 `_datasource.dart` 结尾（在 data 层中）
- 服务文件以 `_service.dart` 结尾
- Provider 文件以 `_provider.dart` 结尾

#### 2.1.2 类命名
- 使用大驼峰命名法，如 `LoginScreen`
- 页面类以 `Screen` 结尾（在 features 模块中）
- 组件类以 `Widget` 结尾（在 features 模块中）
- 组件类以 `Component` 结尾（在 shared 目录中）
- 模型类以 `Model` 结尾（在 shared 目录中）
- 实体类以 `Entity` 结尾（在 domain 层中）
- 用例类以 `Usecase` 结尾（在 domain 层中）
- 仓库类以 `Repository` 结尾（在 data 层中）
- 数据源类以 `Datasource` 结尾（在 data 层中）
- 服务类以 `Service` 结尾
- Provider 类以 `Provider` 结尾

#### 2.1.3 变量命名
- 使用小驼峰命名法，如 `userName`
- 私有变量以 `_` 开头，如 `_currentIndex`
- 常量使用全大写，如 `API_BASE_URL`
- 枚举使用大驼峰命名法，如 `AuthStatus`
- 扩展函数使用小驼峰命名法，如 `StringExtension`

### 2.2 代码风格

- 使用 2 个空格进行缩进
- 每行代码长度不超过 80 个字符
- 方法和方法之间空一行
- 类和类之间空两行
- 导入包按以下顺序排列：
  1. Flutter 核心包
  2. 第三方包
  3. 本地包

### 2.3 代码优化

- **使用 const 构造函数**：尽可能使用 const 构造函数创建不变的组件，减少重建
- **避免在 build 方法中创建对象**：将不变的对象移到 build 方法外
- **使用正确的 key**：为列表项和需要唯一标识的组件提供适当的 key
- **使用 Consumer/ConsumerWidget**：对于使用 Riverpod 的状态管理，使用 Consumer 或 ConsumerWidget 而不是 StatefulWidget
- **避免直接修改状态**：始终创建状态的新实例，而不是直接修改现有状态
- **使用 compute 函数**：对于 heavy computation，使用 compute 函数避免阻塞 UI 线程

### 2.4 注释规范

- 类和方法需要添加文档注释
- 复杂逻辑需要添加行内注释
- 注释使用中文

## 3. 开发流程

### 3.1 分支管理

- `main`: 主分支，用于发布版本
- `develop`: 开发分支，用于集成新功能
- `feature/xxx`: 功能分支，用于开发新功能
- `bugfix/xxx`: 修复分支，用于修复 bug

### 3.2 代码提交

- 提交信息使用中文
- 提交信息格式：`[功能/修复] 具体描述`
- 每次提交只包含一个功能或一个 bug 修复

### 3.3 代码审查

- 所有代码合并到 `develop` 分支前必须经过代码审查
- 代码审查重点：
  - 代码风格是否符合规范
  - 逻辑是否正确
  - 是否存在性能问题
  - 是否存在安全隐患

## 4. 功能模块开发规范

### 4.1 页面开发 (Feature-First 架构)

- 页面文件放在 `features/{feature}/presentation/screens/` 目录中
- 页面使用 `ConsumerWidget`（使用 Riverpod 时）或 `StatefulWidget`/`StatelessWidget`
- 页面布局使用 `Scaffold` 作为根组件
- 页面导航使用 `GoRouter`
- 页面参数传递使用 `GoRouter` 的参数传递机制

### 4.2 组件开发

- 通用组件放在 `shared/widgets/` 目录中
- 功能特定组件放在 `features/{feature}/presentation/widgets/` 目录中
- 组件应具有良好的可复用性
- 组件参数应使用命名参数
- 组件应提供合理的默认值
- 复杂组件应拆分为多个小组件
- 尽可能使用 `const` 构造函数

### 4.3 网络请求

- 网络服务放在 `shared/services/` 目录中
- 使用 `ApiService` 单例进行网络请求
- 网络请求方法应返回 `Future`
- 网络请求异常应进行捕获和处理
- 网络请求需要携带认证信息的，使用 `_networkUtil.getAuthenticationInfo()` 获取
- 使用 `Dio` 的拦截器处理请求和响应

### 4.4 数据模型

- 通用模型放在 `shared/models/` 目录中
- 实体放在 `features/{feature}/domain/entities/` 目录中
- 数据传输对象 (DTO) 放在 `features/{feature}/data/dtos/` 目录中
- 数据模型应与后端返回数据结构对应
- 数据模型应使用 `json_serializable` 进行序列化和反序列化
- 数据模型应包含必要的字段和方法

### 4.5 状态管理

- 功能特定的状态管理放在 `features/{feature}/providers/` 目录中
- 简单状态使用 `setState`
- 复杂状态使用 `Riverpod`（推荐）或 `Bloc`
- 全局状态使用 `Riverpod` 的 `ProviderScope`
- 避免使用 `setState` 进行应用级状态管理

### 4.6 主题配置

- 主题配置在 `core/theme/` 目录中
- 主题应包含浅色和深色模式
- 颜色、字体等应统一管理
- 使用 `ThemeMode.system` 跟随系统主题

### 4.7 路由配置

- 路由配置放在 `routes/app_router.dart` 文件中
- 使用 `GoRouter` 进行路由管理
- 路由应按功能模块组织
- 支持深度链接

### 4.8 数据层

- 数据仓库放在 `features/{feature}/data/repositories/` 目录中
- 数据源放在 `features/{feature}/data/datasources/` 目录中
- 仓库作为单一数据源 (SSOT)
- 处理缓存、错误处理和重试逻辑

### 4.9 领域层

- 用例放在 `features/{feature}/domain/usecases/` 目录中
- 处理复杂的业务逻辑
- 用例应专注于单一功能

### 4.10 核心功能

- 常量定义放在 `core/constants/` 目录中
- 工具类放在 `core/utils/` 目录中
- 错误处理放在 `core/errors/` 目录中

## 5. 性能优化

### 5.1 渲染性能

- **避免在 `build` 方法中进行耗时操作**：将计算移到 `initState` 或使用 `FutureBuilder`
- **使用 `const` 构造函数**：尽可能使用 `const` 构造函数创建不变的组件，减少重建
- **使用 `ListView.builder`**：处理长列表时使用 `ListView.builder` 进行懒加载
- **合理使用 `RepaintBoundary`**：减少不必要的重绘
- **使用 `const` 小部件**：对于静态内容，使用 `const` 关键字
- **避免嵌套过深的布局**：减少布局层级，使用 `SizedBox`、`ConstrainedBox` 等优化布局

### 5.2 网络性能

- **合理使用缓存**：缓存频繁访问的数据
- **避免重复请求**：使用请求去重机制
- **使用 `Dio` 的拦截器**：处理请求和响应，统一添加认证信息
- **大文件上传使用分块上传**：避免一次性上传大文件
- **使用 `Connectivity` 插件**：检测网络状态，在无网络时使用缓存数据

### 5.3 内存管理

- **及时释放不再使用的资源**：使用 `dispose` 方法清理资源
- **避免内存泄漏**：注意闭包和回调中的引用
- **使用 `Image.memory` 时注意内存**：对于大图片，考虑使用 `CachedNetworkImage`
- **使用 `flutter devtools`**：分析内存使用情况

### 5.4 状态管理性能

- **使用 `Riverpod` 的 `family` 和 `autoDispose`**：优化 provider 的创建和销毁
- **避免不必要的状态更新**：只更新需要变化的部分
- **使用 `select` 方法**：只监听需要的状态部分

### 5.5 代码分割

- **使用 `deferred` 加载**：对于大型功能模块，使用延迟加载
- **合理组织代码**：按功能模块组织代码，减少初始包大小

## 6. 安全规范

### 6.1 数据安全

- 敏感数据应进行加密存储
- 密码等敏感信息应使用 `SHA1` 或 `MD5` 加密
- 网络请求应使用 `HTTPS`

### 6.2 代码安全

- 避免硬编码敏感信息
- 避免使用不安全的第三方库
- 定期更新依赖库

## 7. 测试规范

### 7.1 单元测试

- 对关键功能进行单元测试
- 测试文件放在 `test` 目录中，按功能模块组织
- 测试文件命名为 `xxx_test.dart`
- 测试用例应覆盖正常流程和异常情况
- 使用 `flutter_test` 框架进行测试

### 7.2 集成测试

- 对主要业务流程进行集成测试
- 测试文件放在 `test/integration_test` 目录中
- 测试用例应模拟真实用户操作
- 使用 `integration_test` 包进行测试

### 7.3 Widget 测试

- 对 UI 组件进行测试
- 测试文件放在 `test/widget_test` 目录中
- 测试用例应验证组件的渲染和交互
- 使用 `flutter_test` 框架进行测试

### 7.4 测试覆盖率

- 关键功能的测试覆盖率应达到 80% 以上
- 使用 `flutter test --coverage` 生成测试覆盖率报告
- 分析测试覆盖率，补充缺失的测试用例

## 8. 发布规范

### 8.1 版本管理

- 版本号格式：`x.y.z`
- 主版本号 `x`：重大功能变更
- 次版本号 `y`：新功能
- 补丁版本号 `z`：bug 修复

### 8.2 发布流程

1. 确保所有测试通过
2. 更新版本号
3. 生成发布包
4. 进行发布前检查
5. 发布到应用商店

## 9. 技能使用规范

### 9.1 技能参考

开发过程中应参考以下技能指南：

- **flutter-architecture**：提供架构指导和最佳实践，包括 Feature-First 项目组织和 MVVM 模式
- **flutter-expert**：提供高级 Flutter 开发技巧，包括状态管理、导航和性能优化
- **flutter-adaptive-ui**：提供自适应 UI 开发指南
- **flutter-animations**：提供动画开发指南

### 9.2 技能使用方法

- 在开发新功能前，参考相关技能指南
- 遵循技能指南中的最佳实践
- 利用技能指南中的代码模板和示例
- 定期更新技能指南，保持与 Flutter 最新版本同步

## 10. 其他规范

### 10.1 文档规范

- 项目应包含 `README.md` 文件
- 关键功能应提供详细文档
- 代码变更应更新相关文档

### 10.2 工具使用

- 使用 `flutter_lints` 进行代码检查
- 使用 `flutter format` 格式化代码
- 使用 `flutter analyze` 分析代码
- 使用 `flutter devtools` 进行性能分析

### 10.3 团队协作

- 遵守团队约定的开发流程
- 及时沟通和解决问题
- 尊重他人的代码和工作
- 定期进行代码审查

---

本开发规则适用于云建管 Flutter 项目，所有开发人员应严格遵守。