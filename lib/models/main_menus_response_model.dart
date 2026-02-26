class MainMenusResponseModel {
  List<MenuModel>? menuModels;

  MainMenusResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['menuModels'] != null) {
      menuModels = [];
      json['menuModels'].forEach((v) {
        menuModels!.add(MenuModel.fromJson(v));
      });
    }
  }
}

class MenuModel {
  String? menuId;
  String? menuName;
  String? menuIcon;
  String? menuUrl;
  List<MenuModel>? subMenus;

  MenuModel.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'];
    menuName = json['menuName'];
    menuIcon = json['menuIcon'];
    menuUrl = json['menuUrl'];
    if (json['subMenus'] != null) {
      subMenus = [];
      json['subMenus'].forEach((v) {
        subMenus!.add(MenuModel.fromJson(v));
      });
    }
  }
}
