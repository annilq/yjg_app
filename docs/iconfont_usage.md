# IconFont 使用指南

## 简介

本指南介绍如何在 Flutter 项目中使用从微信小程序迁移过来的 IconFont 图标库。

## 导入方式

### 方式一: 直接导入

```dart
import 'package:flutter_app/shared/widgets/iconfont/index.dart';
```

### 方式二: 通过共享组件导入

```dart
import 'package:flutter_app/shared/widgets/index.dart';
```

## 使用示例

### 基础使用

```dart
// 使用 IconFontWidget 组件
IconFontWidget(
  icon: IconFont.getIcon('a-huaban26'),
  size: 24,
  color: Colors.blue,
)

// 或者直接使用 Icon 组件
Icon(
  IconFont.getIcon('gengduo'),
  size: 20,
  color: Colors.red,
)
```

### 常用图标示例

```dart
// 全部图标
IconFontWidget(icon: IconFont.getIcon('a-huaban26'))

// 首页图标(实心)
IconFontWidget(icon: IconFont.getIcon('a-huaban5'))

// 首页图标(线条)
IconFontWidget(icon: IconFont.getIcon('a-huaban5fuben'))

// 通知图标
IconFontWidget(icon: IconFont.getIcon('a-huaban7'))

// 设置图标
IconFontWidget(icon: IconFont.getIcon('a-huaban6'))

// 刷新图标
IconFontWidget(icon: IconFont.getIcon('shuaxin'))

// 更多图标
IconFontWidget(icon: IconFont.getIcon('gengduo'))
```

### 图标大小和颜色

```dart
// 小图标
IconFontWidget(
  icon: IconFont.getIcon('a-huaban5'),
  size: 12,
  color: Colors.grey,
)

// 中等图标
IconFontWidget(
  icon: IconFont.getIcon('a-huaban5'),
  size: 16,
  color: Colors.black,
)

// 大图标
IconFontWidget(
  icon: IconFont.getIcon('a-huaban5'),
  size: 24,
  color: Colors.blue,
)
```

## 图标列表

### 基础图标
| 图标名称 | font_class | 描述 | Unicode |
|---------|-----------|------|--------|
| aHuaban26 | a-huaban26 | 全部 | 0xe735 |
| gengduo | gengduo | 更多 | 0xe734 |
| gengduo1 | gengduo1 | 更多 | 0xe614 |
| aHuaban8 | a-huaban8 | 画板 8 | 0xe731 |
| aHuaban7 | a-huaban7 | 通知 | 0xe732 |
| aHuaban6 | a-huaban6 | 设置 | 0xe733 |

### 导航图标
| 图标名称 | font_class | 描述 | Unicode |
|---------|-----------|------|--------|
| aHuaban5fuben | a-huaban5fuben | 首页-线条 | 0xe72d |
| aHuaban5 | a-huaban5 | 首页-实心 | 0xe72e |
| aHuaban5fuben3 | a-huaban5fuben3 | 我的-线条 | 0xe72f |
| aHuaban5fuben2 | a-huaban5fuben2 | 我的-实心 | 0xe730 |

### 功能图标
| 图标名称 | font_class | 描述 | Unicode |
|---------|-----------|------|--------|
| aHuaban2 | a-huaban2 | 画板 2 | 0xe72a |
| aHuaban3 | a-huaban3 | 切换 | 0xe72b |
| aHuaban4 | a-huaban4 | 地址；地图；位置 | 0xe72c |
| shuaxin | shuaxin | 刷新 | 0xe604 |
| qiehuan | qiehuan | 切换 | 0xe656 |

### 认证相关
| 图标名称 | font_class | 描述 | Unicode |
|---------|-----------|------|--------|
| aHuaban22 | a-huaban22 | 建筑企业信息化管理专家 | 0xe729 |
| aHuaban20 | a-huaban20 | 组织名 | 0xe721 |
| aHuaban18 | a-huaban18 | 密码 | 0xe722 |
| aHuaban17 | a-huaban17 | 删除 | 0xe723 |
| aHuaban19 | a-huaban19 | 用户名 | 0xe724 |
| aHuaban23 | a-huaban23 | 删除 | 0xe725 |
| aHuaban21 | a-huaban21 | LOGO | 0xe726 |
| aHuaban25 | a-huaban25 | 隐藏密码 | 0xe727 |
| aHuaban24 | a-huaban24 | 显示密码 | 0xe728 |

### 其他图标
| 图标名称 | font_class | 描述 | Unicode |
|---------|-----------|------|--------|
| more | more | more | 0xe720 |
| a128LOGO | a-128-LOGO | 128-LOGO | 0xe71f |

### 审核状态
| 图标名称 | font_class | 描述 | Unicode |
|---------|-----------|------|--------|
| yibohui | yibohui | 已驳回 | 0xe71a |
| shenhezhong | shenhezhong | 审核中 | 0xe71b |
| tongguo | tongguo | 通过 | 0xe71c |
| wendang | wendang | 文档 | 0xe71d |
| shenhezhong1 | shenhezhong_1 | 审核中_1 | 0xe71e |
| bohui | bohui | 驳回 | 0xe718 |
| yitongguo | yitongguo | 已通过 | 0xe719 |

### 操作图标
| 图标名称 | font_class | 描述 | Unicode |
|---------|-----------|------|--------|
| a114pingjia | a-114-pingjia | 114-评价 | 0xe711 |
| a111tixing | a-111-tixing | 111-提醒 | 0xe712 |
| a113beizhu | a-113-beizhu | 113-备注 | 0xe713 |
| a115wenjianjia | a-115-wenjianjia | 115-文件夹 | 0xe714 |
| a112faqi | a-112-faqi | 112-发起 | 0xe715 |
| a109daichuli | a-109-daichuli | 109-待处理 | 0xe716 |
| a110yifaqi | a-110-yifaqi | 110-已发起 | 0xe717 |

### LOGO 图标
| 图标名称 | font_class | 描述 | Unicode |
|---------|-----------|------|--------|
| logozi | LOGO-zi | LOGO-字 | 0xe70f |
| logoyun | LOGO-yun | LOGO-云 | 0xe710 |

### 业务图标 (43-107)

包含以下业务领域的图标:
- 投标相关: 投标公示栏、投标申请单、投标保证金等
- 人事相关: 请假条、出差条、加班条、调休条等
- 财务相关: 工资条、工资表、借款单、报销单等
- 合同相关: 工程合同、通用合同、分公司合同等
- 物资相关: 物资入库、物资库、借物资、还物资等
- 印章相关: 用印申请、借印章、还印章、刻印章等
- 证件相关: 借证件、还证件、办证件、证件库等
- 项目相关: 项目信息、项目收款、项目付款、项目结算等
- 材料相关: 材料计划、材料入库、材料出库、材料调拨等
- 发票相关: 工程发票、成本发票、进项发票、销项发票等

## 图标命名规则

### 常量命名

IconFont 类中的常量命名采用驼峰命名法,将 font_class 中的连字符和特殊字符转换为驼峰形式:

- `a-huaban26` → `aHuaban26`
- `a-128-LOGO` → `a128LOGO`
- `shenhezhong_1` → `shenhezhong1`

### 使用方法

1. **通过 font_class 获取图标**:
   ```dart
   IconFont.getIcon('a-huaban26')
   ```

2. **通过常量获取图标**:
   ```dart
   IconData(IconFont.aHuaban26.codePoint, fontFamily: IconFont.fontFamily)
   ```

## 注意事项

1. **字体文件**: 图标使用的字体文件为 `assets/fonts/iconfont.ttf`
2. **性能优化**: 使用 const 构造函数创建图标,避免不必要的重建
3. **类型安全**: 优先使用 `IconFont.getIcon()` 方法获取图标
4. **版本管理**: 如果图标库有更新,需要同步更新字体文件和常量定义
5. **图标大小**: 建议使用 12px、16px、20px、24px 等标准尺寸

## 故障排除

### 图标不显示

1. 检查字体文件是否正确复制到 `assets/fonts/iconfont.ttf`
2. 检查 pubspec.yaml 中是否正确配置了字体
3. 运行 `flutter clean` 清理缓存
4. 重新启动应用

### 图标显示异常

1. 检查 font_class 是否正确
2. 检查 Unicode 码点是否正确
3. 确保字体文件未损坏

## 示例页面

创建一个图标展示页面来测试所有图标:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_app/shared/widgets/index.dart';

class IconFontDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('IconFont 示例')),
      body: GridView.count(
        crossAxisCount: 4,
        children: [
          // 常用图标
          _buildIconItem('全部', IconFont.getIcon('a-huaban26')),
          _buildIconItem('首页', IconFont.getIcon('a-huaban5')),
          _buildIconItem('通知', IconFont.getIcon('a-huaban7')),
          _buildIconItem('设置', IconFont.getIcon('a-huaban6')),
          _buildIconItem('刷新', IconFont.getIcon('shuaxin')),
          _buildIconItem('更多', IconFont.getIcon('gengduo')),
          // 其他图标...
        ],
      ),
    );
  }

  Widget _buildIconItem(String name, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconFontWidget(icon: icon, size: 24),
        SizedBox(height: 8),
        Text(name, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
```

## 版本信息

- 图标数量: 107 个
- 字体文件: iconfont.ttf
- 字体家族: IconFont
- Unicode 范围: e604 - e735
- 迁移日期: 2026-03-10

---

本指南提供了 IconFont 图标的完整使用说明,如有疑问请参考代码实现或联系开发团队。