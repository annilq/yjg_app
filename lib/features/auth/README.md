# 认证模块 (auth)

## 模块功能

认证模块负责用户登录、注册、密码管理等认证相关功能。

## 目录结构

```
auth/
├── service/        # 数据服务
│   ├── account_service.dart  # 账户服务
│   └── auth_service.dart     # 认证服务
├── models/          # 实体
│   ├── account_model.dart     # 账户模型
│   └── auth_model.dart        # 认证模型
├── presentation/    # 表示层
│   ├── screens/     # 页面
│   │   ├── accounts_screen.dart       # 账户列表页面
│   │   ├── add_account_screen.dart    # 添加账户页面
│   │   ├── login_screen.dart          # 登录页面
│   │   ├── reset_password_screen.dart # 重置密码页面
│   │   └── update_password_screen.dart # 更新密码页面
│   └── widgets/     # 组件
└── providers/       # 状态管理
    └── auth_providers.dart    # 认证状态管理
```

## 依赖关系

- **核心模块**: 依赖 core 模块中的常量、主题、工具类和错误处理
- **共享模块**: 依赖 shared 模块中的通用组件和服务

## 使用方法

### 登录流程

1. 用户打开登录页面
2. 输入用户名和密码
3. 点击登录按钮
4. 系统验证用户凭据
5. 登录成功后跳转到主页

### 账户管理

1. 用户打开账户列表页面
2. 可以查看已添加的账户
3. 可以添加新账户
4. 可以更新账户密码
5. 可以重置账户密码

## 主要服务

### AuthService

负责用户认证相关的服务，包括登录、注册、密码重置等功能。

### AccountService

负责账户管理相关的服务，包括获取账户列表、添加账户、更新账户等功能。

## 状态管理

使用 Riverpod 进行状态管理，主要包括：

- `authProvider`: 管理认证状态
- `accountProvider`: 管理账户列表状态

## 注意事项

- 认证模块是应用的核心模块，其他模块可能依赖于认证状态
- 确保认证信息的安全性，避免明文存储密码
- 实现适当的错误处理和用户反馈
