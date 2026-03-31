# 云建管 Flutter 项目黄金原则

## 1. 黄金原则概述

本文档定义了云建管 Flutter 项目的黄金原则，这些原则是代码库的核心价值观和指导方针，用于确保代码质量、可维护性和一致性。黄金原则是智能体开发的重要参考，也是代码审查的重要依据。

## 2. 核心黄金原则

### 2.1 代码可读性

**原则**: 代码应该清晰、易读，便于智能体理解和维护。

**具体要求**:
- 使用有意义的变量名和函数名
- 保持代码简洁，避免过度复杂的逻辑
- 使用适当的注释，解释复杂的逻辑和决策
- 遵循一致的代码风格和命名规范

**理由**:
- 提高代码的可维护性
- 减少错误和缺陷
- 便于智能体理解和生成代码
- 提高团队协作效率

### 2.2 模块化

**原则**: 代码应该模块化，便于智能体维护和测试。

**具体要求**:
- 将功能划分为独立的模块，每个模块负责特定的功能
- 模块之间的依赖关系应该清晰，避免循环依赖
- 模块内部应该采用分层设计，保持代码结构清晰
- 提取通用功能到共享模块，避免代码重复

**理由**:
- 提高代码的可维护性和可测试性
- 便于智能体理解和生成代码
- 提高代码的可重用性
- 便于团队协作和并行开发

### 2.3 测试覆盖率

**原则**: 关键功能的测试覆盖率应该达到 80% 以上。

**具体要求**:
- 对关键功能进行单元测试
- 对主要业务流程进行集成测试
- 对 UI 组件进行 Widget 测试
- 分析测试覆盖率，补充缺失的测试用例

**理由**:
- 提高代码的可靠性和质量
- 减少错误和缺陷
- 便于智能体验证代码的正确性
- 提高代码的可维护性

### 2.4 性能优化

**原则**: 应用应该性能良好，响应迅速。

**具体要求**:
- 避免不必要的重建和重绘
- 使用适当的状态管理策略
- 优化网络请求和数据处理
- 确保应用在不同设备上的性能一致

**理由**:
- 提高用户体验
- 减少资源消耗
- 便于智能体生成高效的代码
- 确保应用在各种环境下的可用性

### 2.5 安全性

**原则**: 应用应该安全，保护用户数据。

**具体要求**:
- 避免明文存储敏感信息
- 使用安全的网络请求和数据传输
- 实现适当的权限控制
- 定期进行安全审查和测试

**理由**:
- 保护用户数据和隐私
- 避免安全漏洞和攻击
- 提高应用的可信度
- 符合相关法规和标准

### 2.6 可访问性

**原则**: 应用应该对所有用户可访问，包括有视觉、听觉或运动障碍的用户。

**具体要求**:
- 使用语义标签，提高屏幕阅读器的可读性
- 支持键盘导航，方便无鼠标用户使用
- 确保文本和背景的颜色对比度符合标准
- 支持字体大小调整，适应不同用户的需求

**理由**:
- 提高应用的可用性和包容性
- 符合相关法规和标准
- 扩大应用的用户群体
- 提高应用的社会价值

### 2.7 可扩展性

**原则**: 应用应该具有良好的可扩展性，能够适应未来的需求变化。

**具体要求**:
- 使用模块化设计，便于添加新功能
- 避免硬编码依赖，使用依赖注入
- 设计清晰的接口，便于扩展和替换组件
- 考虑未来的需求变化，设计灵活的架构

**理由**:
- 提高应用的生命周期
- 减少未来的开发成本
- 便于智能体理解和扩展代码
- 适应业务需求的变化

### 2.8 一致性

**原则**: 代码应该保持一致的风格和模式，便于智能体理解和生成。

**具体要求**:
- 遵循一致的代码风格和命名规范
- 使用一致的设计模式和架构
- 保持文档和代码的一致性
- 确保测试和实现的一致性

**理由**:
- 提高代码的可维护性
- 减少错误和缺陷
- 便于智能体理解和生成代码
- 提高团队协作效率

## 3. 黄金原则的编码

### 3.1 代码风格检查

使用 `flutter_lints` 进行代码风格检查，确保代码风格一致。配置文件位于 `analysis_options.yaml`，包含以下规则：

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    - always_declare_return_types
    - always_use_package_imports
    - avoid_empty_else
    - avoid_function_literals_in_foreach_calls
    - avoid_null_checks_in_equality_operators
    - avoid_relative_lib_imports
    - avoid_redundant_argument_values
    - avoid_returning_null_for_void
    - avoid_shadowing_type_parameters
    - avoid_types_as_parameter_names
    - avoid_unused_constructor_parameters
    - avoid_void_async
    - await_only_futures
    - camel_case_extensions
    - camel_case_types
    - camel_case_variables
    - cancel_subscriptions
    - close_sinks
    - comment_references
    - constant_identifier_names
    - control_flow_in_finally
    - curly_braces_in_flow_control_structures
    - directives_ordering
    - empty_catches
    - empty_constructor_bodies
    - empty_statements
    - hash_and_equals
    - implementation_imports
    - iterable_contains_unrelated_type
    - library_names
    - library_prefixes
    - no_adjacent_strings_in_list
    - no_duplicate_case_values
    - non_constant_identifier_names
    - null_closures
    - only_throw_errors
    - overridden_fields
    - package_api_docs
    - prefer_adjacent_string_concatenation
    - prefer_asserts_in_initializer_lists
    - prefer_collection_literals
    - prefer_conditional_assignment
    - prefer_const_constructors
    - prefer_const_declarations
    - prefer_const_literals_to_create_immutables
    - prefer_contains
    - prefer_equal_for_default_values
    - prefer_final_fields
    - prefer_final_in_for_each
    - prefer_final_locals
    - prefer_for_elements_to_map_fromIterable
    - prefer_function_declarations_over_variables
    - prefer_generic_function_type_aliases
    - prefer_if_elements_to_conditional_expressions
    - prefer_if_null_operators
    - prefer_initializing_formals
    - prefer_inlined_adds
    - prefer_interpolation_to_compose_strings
    - prefer_is_empty
    - prefer_is_not_empty
    - prefer_iterable_whereType
    - prefer_mixin
    - prefer_null_aware_operators
    - prefer_single_quotes
    - prefer_spread_collections
    - prefer_typing_uninitialized_variables
    - prefer_void_to_null
    - provide_deprecation_message
    - recursive_getters
    - slash_for_doc_comments
    - sort_child_properties_last
    - sort_constructors_first
    - sort_pub_dependencies
    - sort_unnamed_constructors_first
    - test_types_in_equals
    - throw_in_finally
    - type_annotate_public_apis
    - type_init_formals
    - unawaited_futures
    - unnecessary_brace_in_string_interps
    - unnecessary_const
    - unnecessary_getters_setters
    - unnecessary_lambdas
    - unnecessary_new
    - unnecessary_null_aware_assignments
    - unnecessary_null_in_if_null_operators
    - unnecessary_overrides
    - unnecessary_parenthesis
    - unnecessary_statements
    - unnecessary_string_escapes
    - unnecessary_string_interpolations
    - unsafe_html
    - use_full_hex_values_for_flutter_colors
    - use_function_type_syntax_for_parameters
    - use_rethrow_when_possible
    - use_setters_to_change_properties
    - use_string_buffers
    - use_to_and_as_if_applicable
    - valid_regexps
    - void_checks
```

### 3.2 依赖关系检查

实现自定义的依赖关系检查工具，确保模块间的依赖关系符合规范。检查规则：

- 功能模块只能依赖核心模块和共享模块
- 共享模块只能依赖核心模块
- 核心模块不依赖其他模块
- 避免循环依赖

### 3.3 文件结构检查

实现自定义的文件结构检查工具，确保模块结构符合规范。检查规则：

- 每个功能模块应该包含 `service/`、`models/`、`presentation/` 和 `providers/` 目录
- 表示层应该包含 `screens/` 和 `widgets/` 目录
- 文件名应该符合命名规范
- 目录结构应该清晰、一致

## 4. 黄金原则的维护和更新机制

### 4.1 定期审查

- 每季度审查一次黄金原则，确保其与项目的发展和技术的变化保持一致
- 收集团队成员和智能体的反馈，持续改进黄金原则
- 确保黄金原则能够适应项目的需求变化

### 4.2 自动化检查

- 实现自动化的黄金原则检查工具，确保代码符合黄金原则
- 在 CI/CD 流程中集成黄金原则检查，确保代码质量
- 提供详细的检查报告，便于识别和修复问题

### 4.3 知识共享

- 定期组织团队培训，分享黄金原则的最佳实践
- 创建黄金原则的详细文档，便于团队成员和智能体理解
- 建立黄金原则的反馈机制，收集和处理反馈

## 5. 黄金原则的应用

### 5.1 智能体开发

- 智能体在生成代码时应该遵循黄金原则
- 智能体在审查代码时应该检查是否符合黄金原则
- 智能体在测试代码时应该验证是否符合黄金原则

### 5.2 人工审查

- 人工审查代码时应该参考黄金原则
- 人工审查应该关注黄金原则的执行情况
- 人工审查应该提供反馈，帮助智能体改进

### 5.3 持续改进

- 基于反馈持续改进黄金原则
- 基于项目的发展和技术的变化更新黄金原则
- 确保黄金原则能够适应未来的需求变化

## 6. 结论

黄金原则是云建管 Flutter 项目的核心价值观和指导方针，用于确保代码质量、可维护性和一致性。通过定义和编码黄金原则，我们可以指导智能体开发，提高代码质量，减少错误和缺陷。

随着项目的发展，我们将继续审查和更新黄金原则，确保其与项目的发展和技术的变化保持一致，为实施 Harness 架构奠定基础。
