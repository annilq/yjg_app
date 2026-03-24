import 'dart:convert';

class StartService {
  Future<List<dynamic>> getCategories() async {
    try {
      // 模拟API调用，实际项目中应该替换为真实的API
      // 这里使用微信小程序中的API路径
      // 暂时直接返回模拟数据
      return getMockCategories();
    } catch (e) {
      // 生产环境应该使用日志系统
      // 暂时使用print进行调试
      print('Error fetching categories: $e');
      return [];
    }
  }
  
  // 模拟数据，用于开发测试
  List<dynamic> getMockCategories() {
    return [
      {
        'text': '档案管理',
        'children': [
          {
            'id': '1',
            'text': '工程合同',
            'img': 'Project_ContractApplySingle',
            'processConfigId': '101',
            'functionId': 'func101'
          },
          {
            'id': '2',
            'text': '证件挂靠合同',
            'img': 'Chief_AgreementApply',
            'processConfigId': '102',
            'functionId': 'func102'
          },
          {
            'id': '3',
            'text': '分公司合同',
            'img': 'Contract_BcompanyContract',
            'processConfigId': '103',
            'functionId': 'func103'
          },
        ]
      },
      {
        'text': '经营管理',
        'children': [
          {
            'id': '4',
            'text': '投标申请单',
            'img': 'Project_BidApply',
            'processConfigId': '201',
            'functionId': 'func201'
          },
          {
            'id': '5',
            'text': '提成申请',
            'img': 'Project_CommisionApply',
            'processConfigId': '202',
            'functionId': 'func202'
          },
          {
            'id': '6',
            'text': '出场申请',
            'img': 'Project_AttendanceApply',
            'processConfigId': '203',
            'functionId': 'func203'
          },
        ]
      },
      {
        'text': '财务管理',
        'children': [
          {
            'id': '7',
            'text': '投标保证金',
            'img': 'Finance_DepositApplySingle',
            'processConfigId': '301',
            'functionId': 'func301'
          },
          {
            'id': '8',
            'text': '项目款',
            'img': 'Finance_ProjectMoney',
            'processConfigId': '302',
            'functionId': 'func302'
          },
          {
            'id': '9',
            'text': '付款单',
            'img': 'Finance_PayMoney',
            'processConfigId': '303',
            'functionId': 'func303'
          },
        ]
      },
    ];
  }
}
