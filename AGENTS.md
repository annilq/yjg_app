# 云建管 Flutter 项目 - 智能体导航地图

## 项目概览

云建管 Flutter 项目采用 Feature-First 架构，旨在提供高效、可靠的建筑管理系统。本文件是智能体的导航地图，提供项目的基本信息和指向详细文档的链接。

## 核心架构

### 目录结构

```
lib/
├── main.dart       # 应用入口
├── app.dart        # 应用配置
├── core/           # 核心功能
├── features/       # 功能模块
├── shared/         # 共享资源
└── routes/         # 路由配置
```

### 技术栈

- Flutter SDK: ^3.8.1
- 网络请求: dio ^5.5.0
- 存储: shared_preferences, hive_flutter
- 状态管理: flutter_riverpod (推荐) 或 bloc
- 导航: go_router
- 代码生成: freezed, json_serializable

## 智能体工作流程

### 基本流程

1. **任务理解**: 智能体应首先理解任务需求，确定需要修改的文件和模块。

2. **上下文收集**: 智能体应收集相关的代码和文档，了解当前的实现和约束。

3. **方案设计**: 智能体应设计实现方案，确保符合项目的架构和规范。

4. **代码生成**: 智能体应生成高质量的代码，包括功能实现、测试和文档。

5. **自我审查**: 智能体应审查自己的代码，识别和修复问题。

6. **测试验证**: 智能体应运行测试，确保代码的正确性和质量。

7. **提交请求**: 智能体应创建 Pull Request，等待审查和合并。

### 深度优先工作方式

- **模块化构建**: 将更大的目标拆解为更小的构建模块（设计、代码、评审、测试等）
- **渐进式实现**: 提示智能体去构建这些模块，并使用它们去解锁更复杂的任务
- **能力扩展**: 当智能体遇到困难时，人类工程师应介入并追问："究竟还需要什么样的能力，我们又该如何让这个能力对智能体来说既清晰可读又可强制执行？"

### 智能体审查机制

- **自我审查**: 智能体应在本地审核其自身的更改
- **多智能体审查**: 智能体可以请求额外的特定智能体审查
- **反馈循环**: 智能体应响应任何人工或智能体给出的反馈，并循环往复，直到所有智能体审核人员都满意为止
- **工具集成**: 智能体应直接使用标准开发工具（如 git 命令、本地脚本和嵌入代码仓库的技能）来收集情境

## Git 提交规范

| 类型       | 用途               |
| ---------- | ------------------ |
| `feat`     | 新功能             |
| `fix`      | 修复 Bug           |
| `refactor` | 重构（无功能变更） |
| `perf`     | 性能优化           |
| `test`     | 测试相关           |
| `docs`     | 文档更新           |
| `chore`    | 依赖/配置更新      |
| `ci`       | CI/CD 相关         |

## 常用命令

```bash
# 安装依赖
flutter pub get

# 运行
flutter run

# 代码生成
flutter pub run build_runner build

# 代码检查
flutter analyze

# 运行测试
flutter test
```

## 关键约束（不可违背）

RULES:

1. You MUST generate a plan.md BEFORE writing any code.
2. You MUST NOT execute or generate code until user explicitly approves the plan.
3. The plan MUST follow the provided structure.
4. After generating plan, STOP and wait for user confirmation.

Workflow:

- Step 1: Understand task
- Step 2: Generate plan.md
- Step 3: Ask for confirmation
- Step 4: Only after approval → execute
- Step 5: run `flutter analyze` when task finished

If user says:

- "OK" / "同意" / "执行" → proceed
- Otherwise → revise plan

## 关键文档

- **架构文档**: `docs/architecture.md` - 详细的项目架构说明
- **设计文档**: `docs/design.md` - 项目设计原则和规范
- **开发指南**: `docs/development_guide.md` - 详细的开发指南和最佳实践
- **决策日志**: `docs/decision_log.md` - 项目决策记录
- **技能文档**: `.agents/skills/` - 项目相关技能指南

## 重要规则

1. **智能体优先**: 所有代码和工具都应由智能体生成和维护。

2. **环境设计**: 创建清晰、结构化的环境，使智能体能够有效工作。

3. **明确意图**: 通过清晰的提示和文档传达开发目标。

4. **反馈回路**: 建立自动化的测试、验证和审查机制。

5. **渐进式披露**: 从简单的切入点开始，逐步提供更多上下文。

## 工具和技能

- **代码生成**: 使用 `build_runner` 执行代码生成
- **测试**: 使用 `flutter_test` 进行单元测试和 Widget 测试
- **代码质量**: 使用 `flutter_lints` 进行代码检查
- **性能分析**: 使用 `flutter devtools` 进行性能分析

## 联系和支持

如有问题或需要帮助，请参考详细文档或联系项目团队。
