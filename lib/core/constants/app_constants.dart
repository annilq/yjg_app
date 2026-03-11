class AppConstants {
  static const String API_BASE_URL = 'http://api.jianguanoa.com/1.0/';
  static const String UC_BASE_URL = 'http://uc.jianguanoa.com/';
  static const String APP_NAME = '云建管';
  static const int CONNECT_TIMEOUT = 10;
  static const int RECEIVE_TIMEOUT = 10;
  static const List<Map<String, dynamic>> MODULE_MAP = [
    {
      "Other": {"intro": "投标、业绩、证件", "className": "icon_grgl"},
    },
    {
      "Project": {"intro": "投标、业绩、证件", "className": "icon_jy"},
    },
    {
      "Project_BidApply": {
        "className": "icon-a-6-toubiaoshenqingdan",
        "viewValue": "投标申请单",
      },
    },
    {
      "Project_CustomerStore": {
        "className": "icon-a-11-kehuku",
        "viewValue": "客户库",
      },
    },
    {
      "Project_IntroductionLetter": {
        "className": "icon-a-8-jieshaoxin",
        "viewValue": "介绍信",
      },
    },
    {
      "Chief_PerformanceApply": {
        "className": "icon-a-34-huanyeji",
        "viewValue": "借业绩",
      },
    },
    {
      "Chief_PerformanceReturn": {
        "className": "icon-a-34-huanyeji",
        "viewValue": "还业绩",
      },
    },
    {
      "Chief_Performance": {
        "className": "icon-a-33-yejiku",
        "viewValue": "业绩库",
      },
    },
    {
      "Chief_CertificateApplyNew": {
        "className": "icon-a-30-jiezhengjian",
        "viewValue": "借证件",
      },
    },
    {
      "Chief_CertificateReturn": {
        "className": "icon-a-29-huanzhengjian",
        "viewValue": "还证件",
      },
    },
    {
      "Finance": {"intro": "付款、收款、借款、报销等各种财务", "className": "icon_cw"},
    },
    {
      "Finance_PaymentInvoice": {
        "className": "icon-a-54-chengbenfapiao",
        "viewValue": "成本发票",
      },
    },
    {
      "Xm_InputInvoice": {"className": "icon-a-53-gongchengfapiao"},
    },
    {
      "Xm_OutputInvoice": {"className": "icon-a-53-gongchengfapiao"},
    },
    {
      "Finance_BorrowMoney": {
        "className": "icon-a-59-jiekuandan",
        "viewValue": "借款单",
      },
    },
    {
      "Finance_PayMoney": {
        "className": "icon-a-58-fukuandan",
        "viewValue": "付款单",
      },
    },
    {
      "Finance_OpenAccount": {
        "className": "icon-a-57-yinhangkaihu",
        "viewValue": "银行开户",
      },
    },
    {
      "Finance_TaxRecord": {
        "className": "icon-a-100-wanshuipingzheng",
        "viewValue": "完税凭证",
      },
    },
    {
      "Finance_BankGuarantee": {
        "className": "icon-a-56-yinhangbaohan",
        "viewValue": "银行保函",
      },
    },
    {
      "Chief_CertificateCost": {
        "className": "icon-a-52-zhengjianfeiyong",
        "viewValue": "证件费用",
      },
    },
    {
      "Finance_Reimbursement": {
        "className": "icon-a-63-baoxiaodan",
        "viewValue": "报销单",
      },
    },
    {
      "Finance_ProjectMoney": {
        "className": "icon-a-55-gongchengkuan",
        "viewValue": "工程款",
      },
    },
    {
      "Finance_DepositApplySingle": {
        "className": "icon-a-50-toubiaobaozhengjin",
        "viewValue": "保证金",
      },
    },
    {
      "Finance_PerformanceBond": {
        "className": "icon-a-51-lvyuejinbaozhengjin",
        "viewValue": "履约保证金",
      },
    },
    {
      "Finance_OtherMoney": {
        "className": "icon-a-60-shoukuan",
        "viewValue": "收款",
      },
    },
    {
      "Finance_BcompanyCost": {
        "className": "icon-a-102-fengongsishoukuan",
        "viewValue": "分公司收款",
      },
    },
    {
      "Finance_TaxReceiptRegister": {
        "className": "icon-a-53-gongchengfapiao",
        "viewValue": "工程税票",
      },
    },
    {
      "Finance_AddedValueTax": {
        "className": "icon-a-103-zengzhishuifapiao",
        "viewValue": "增值税发票",
      },
    },
    {
      "Finance_TaxDeduction": {
        "className": "icon-a-82-jinxiangfapiao",
        "viewValue": "增值税抵扣",
      },
    },
    {
      "Project_BidNotice": {
        "className": "icon-a-7-toubiaogongshilan",
        "viewValue": "投标公示栏",
      },
    },
    {
      "Finance_SendDepositApply": {
        "className": "icon-a-104-huibaozhengjin",
        "viewValue": "汇保证金",
      },
    },
    {
      "Finance_BackDepositApply": {
        "className": "icon-a-105-tuibaozhengjin",
        "viewValue": "退保证金",
      },
    },
    {
      "Project_BidChargeSingle": {
        "className": "icon-a-106-toubiaofeishoukuan",
        "viewValue": "投标费收款",
      },
    },
    {
      "Finance_ManagermentCharge": {
        "className": "icon-a-107-guanlifeishoukuan",
        "viewValue": "管理费收款",
      },
    },
    {
      "Finance_OutRun": {
        "className": "icon-a-62-waijingzheng",
        "viewValue": "外经证",
      },
    },
    {
      "Personnel": {"intro": "出差、请假、加班、调休等人事申请", "className": "icon_rs"},
    },
    {
      "Personnel_TravelApply": {
        "className": "icon-a-13-chuchatiao",
        "viewValue": "出差条",
      },
    },
    {
      "Personnel_BdApply": {
        "className": "icon-a-14-budengtiao",
        "viewValue": "补登条",
      },
    },
    {
      "Personnel_Leave": {
        "className": "icon-a-12-qingjiatiao",
        "viewValue": "请假条",
      },
    },
    {
      "Personnel_SalaryApply": {
        "className": "icon-a-17-gongzitiao",
        "viewValue": "工资条",
      },
    },
    {
      "Personnel_PayrollApply": {
        "className": "icon-a-18-gongzibiao",
        "viewValue": "工资表",
      },
    },
    {
      "Project_CommisionApply": {
        "className": "icon-a-6-tichengshenqing",
        "viewValue": "提成申请",
      },
    },
    {
      "Personnel_OvertimeApply": {
        "className": "icon-a-15-jiabantiao",
        "viewValue": "加班条",
      },
    },
    {
      "Personnel_DaysoffApply": {
        "className": "icon-a-16-tiaoxiutiao",
        "viewValue": "补休条",
      },
    },
    {
      "Personnel_CaseRegister": {
        "className": "icon-a-49-anjiandengji",
        "viewValue": "案件登记",
      },
    },
    {
      "Personnel_UseCar": {
        "className": "icon-a-48-yongcheshenqing",
        "viewValue": "用车申请",
      },
    },
    {
      "Project_AttendanceApply": {
        "className": "icon-a-9-chuchangshenqing",
        "viewValue": "出场申请",
      },
    },
    {
      "Personnel_GoOut": {
        "className": "icon-a-19-waichubanshi",
        "viewValue": "外出办事",
      },
    },
    {
      "Personnel_Archives": {"className": "icon-a-99-renshidangan"},
    },
    {
      "Chief": {"intro": "通知发文、办消证件、印章相关", "className": "icon_xz"},
    },
    {
      "Chief_Certificate": {
        "className": "icon-a-27-zhengjianku",
        "viewValue": "证件库",
      },
    },
    {
      "Chief_BorrowMaterial": {"className": "icon-a-47-jiewuzi"},
    },
    {
      "Chief_BuyMaterial": {"className": "icon-a-34-caigouwuzi"},
    },
    {
      "Chief_ReturnMaterial": {"className": "icon-a-46-huanwuzi"},
    },
    {
      "Chief_StockMaterial": {"className": "icon-a-37-wuziruku"},
    },
    {
      "Chief_CommonStore": {"className": "icon-a-36-wuziku"},
    },
    {
      "Chief_SealStore": {
        "className": "icon-a-38-yinzhangku",
        "viewValue": "印章库",
      },
    },
    {
      "Project_WinBid": {
        "className": "icon-a-10-zhongbiaogongshilan",
        "viewValue": "中标公示栏",
      },
    },
    {
      "Other_Placard": {
        "className": "icon-a-44-gonggaolan",
        "viewValue": "公告栏",
      },
    },
    {
      "Chief_CertificateDeal": {
        "className": "icon-a-28-banzhengjian",
        "viewValue": "办证件",
      },
    },
    {
      "Chief_ReturnSeal": {
        "className": "icon-a-42-huanyinzhang",
        "viewValue": "还印章",
      },
    },
    {
      "Chief_BorrowSeal": {
        "className": "icon-a-43-jieyinzhang",
        "viewValue": "借印章",
      },
    },
    {
      "Chief_CarveSeal": {
        "className": "icon-a-39-keyinzhang",
        "viewValue": "刻印章",
      },
    },
    {
      "Chief_PublicDoc": {
        "className": "icon-a-45-tongzhifawen",
        "viewValue": "通知发文",
      },
    },
    {
      "Chief_DestorySeal": {
        "className": "icon-a-40-yinzhangzhuxiao",
        "viewValue": "印章注销",
      },
    },
    {
      "Chief_CertificateTransfer": {
        "className": "icon-a-32-zhengjianzhuanchuzhuxiao",
        "viewValue": "证件转出注销",
      },
    },
    {
      "Chief_UseSeal": {
        "className": "icon-a-41-yongyinshenqing",
        "viewValue": "用印登记",
      },
    },
    {
      "Chief_CertificateShift": {
        "className": "icon-a-31-zhengjiantiaopei",
        "viewValue": "证件调配",
      },
    },
    {
      "Contract": {"intro": "工程、证件、分公司合同", "className": "icon_ht"},
    },
    {
      "Contract_GodownEntry": {
        "className": "icon-a-26-rukudan",
        "viewValue": "入库单",
      },
    },
    {
      "Contract_CommonContract": {
        "className": "icon-a-22-tongyonghetong",
        "viewValue": "通用合同",
      },
    },
    {
      "Project_ContractApplySingle": {
        "className": "icon-a-21-gongchenghetong",
        "viewValue": "工程合同",
      },
    },
    {
      "Chief_AgreementApply": {
        "className": "icon-a-23-zhengjianhetong",
        "viewValue": "证件合同",
      },
    },
    {
      "Contract_BcompanyContract": {
        "className": "icon-a-24-fengongsihetong",
        "viewValue": "分公司合同",
      },
    },
    {
      "Xm_ContractPurchase": {"className": "icon-a-22-tongyonghetong"},
    },
    {
      "Xm_ContractRent": {"className": "icon-a-22-tongyonghetong"},
    },
    {
      "Xm_ContractSubpackage": {"className": "icon-a-22-tongyonghetong"},
    },
    {
      "Xm_ContractOther": {"className": "icon-a-22-tongyonghetong"},
    },
    {
      "Other_CaduitObject": {
        "className": "icon-a-1-zidingyiliucheng",
        "viewValue": "自定义流程",
      },
    },
    {
      "Xm_ProjectStore": {"className": "icon-a-64-xiangmuxinxi"},
    },
    {
      "Xm_ProjectGathering": {"className": "icon-a-68-xiangmushoukuan"},
    },
    {
      "Xm_ProjectRefund": {"className": "icon-a-71-xiangmutuikuan"},
    },
    {
      "Xm_ProjectPayment": {"className": "icon-a-69-xiangmufukuan"},
    },
    {
      "Xm_ProjectCost": {"className": "icon-a-70-xiangmukoukuan"},
    },
    {
      "Xm_ProjectRepay": {"className": "icon-a-74-xiangmuqingzhang"},
    },
    {
      "Xm_ProjectTransfer": {"className": "icon-a-75-xiangmuyuetiaobo"},
    },
    {
      "Xm_SupplierStore": {"className": "icon-a-87-gongyingshang"},
    },
    {
      "Xm_TaxesPayment": {"className": "icon-a-83-jiaoshuijilu"},
    },
    {
      "Xm_SupplementContract": {"className": "icon-a-77-buchonghetong"},
    },
    {
      "Xm_ProjectBorrowing": {"className": "icon-a-72-xiangmujiekuan"},
    },
    {
      "Xm_ProjectReimburse": {"className": "icon-a-73-xiangmubaoxiao"},
    },
    {
      "Xm_ProjectSettlement": {"className": "icon-a-65-xiangmujiesuan"},
    },
    {
      "Xm_ProjectDeposit": {"className": "icon-a-66-baozhengjin"},
    },
    {
      "Xm_CreditRefund": {"className": "icon-a-84-dishuituishui"},
    },
    {
      "Xm_MigrantWages": {"className": "icon-a-84-dishuituishui"},
    },
    {
      "Material_MaterialWarehouse": {"className": "icon-a-90-cailiaocangku"},
    },
    {
      "Material_MaterialPurchase": {"className": "icon-a-34-caigouwuzi"},
    },
    {
      "Material_MaterialEntering": {"className": "icon-a-92-cailiaoruku"},
    },
    {
      "Material_MaterialPicking": {"className": "icon-a-94-cailiaochuku"},
    },
    {
      "Material_MaterialReturn": {"className": "icon-a-95-cailiaotuiku"},
    },
    {
      "Material_MaterialCheck": {"className": "icon-a-96-cailiaopandian"},
    },
    {
      "Material_MaterialAccount": {"className": "icon-a-97-cailiaoduizhang"},
    },
    {
      "Material_MaterialOrder": {"className": "icon-a-93-cailiaodingdan"},
    },
    {
      "Material_MaterialAllocate": {"className": "icon-a-98-cailiaotiaobo"},
    },
  ];
}
