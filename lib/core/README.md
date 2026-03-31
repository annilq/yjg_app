# 核心模块 (core)

## 模块功能

核心模块包含应用的基础功能，如常量定义、主题配置、工具类和错误处理。这些功能被其他模块共享使用。

## 目录结构

```
core/
├── constants/  # 常量定义
│   ├── app_constants.dart  # 应用常量
│   └── app_images.dart     # 应用图片
├── theme/      # 主题配置
│   ├── tokens/  # 主题令牌
│   │   ├── app_colors.dart      # 应用颜色
│   │   ├── app_radius.dart      # 应用圆角
│   │   ├── app_shadows.dart     # 应用阴影
│   │   ├── app_spacing.dart     # 应用间距
│   │   ├── app_typography.dart  # 应用 typography
│   │   └── tokens.dart          # 令牌汇总
│   └── app_theme.dart  # 应用主题
├── utils/      # 工具类
│   ├── encryption_util.dart  # 加密工具
│   └── util.dart             # 通用工具
└── errors/     # 错误处理
    ├── error_handler.dart  # 错误处理器
    ├── exceptions.dart     # 异常定义
    └── failures.dart       # 失败定义
```

## 依赖关系

- **核心模块**不依赖其他模块，是应用的基础模块

## 使用方法

### 常量使用

```dart
import 'package:flutter_app/core/constants/app_constants.dart';

// 使用应用常量
var apiUrl = AppConstants.apiUrl;
```

### 主题使用

```dart
import 'package:flutter_app/core/theme/app_theme.dart';

// 使用应用主题
MaterialApp(
  theme: AppTheme.light,
  darkTheme: AppTheme.dark,
);
```

### 工具类使用

```dart
import 'package:flutter_app/core/utils/util.dart';

// 使用通用工具
var formattedDate = Util.formatDate(DateTime.now());
```

### 错误处理

```dart
import 'package:flutter_app/core/errors/error_handler.dart';

// 使用错误处理器
try {
  // 可能抛出异常的代码
} catch (e) {
  ErrorHandler.handleError(e);
}
```

## 注意事项

- 核心模块是应用的基础模块，其他模块都依赖于它
- 确保核心模块的代码质量和稳定性
- 避免在核心模块中引入不必要的依赖
- 保持核心模块的功能简洁明了
