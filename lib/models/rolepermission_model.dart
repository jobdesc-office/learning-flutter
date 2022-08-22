class RolePermissionModel {
  int? permisid;
  int? permismenuid;
  int? permisfeatid;
  bool? hasaccess;
  Menu? menu;
  Feature? feature;

  RolePermissionModel(
      {this.permisid,
      this.permismenuid,
      this.permisfeatid,
      this.hasaccess,
      this.menu,
      this.feature});

  RolePermissionModel.fromJson(Map<String, dynamic> json) {
    permisid = json['permisid'];
    permismenuid = json['permismenuid'];
    permisfeatid = json['permisfeatid'];
    hasaccess = json['hasaccess'];
    menu = json['menu'] != null ? new Menu.fromJson(json['menu']) : null;
    feature =
        json['feature'] != null ? new Feature.fromJson(json['feature']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['permisid'] = this.permisid;
    data['permismenuid'] = this.permismenuid;
    data['permisfeatid'] = this.permisfeatid;
    data['hasaccess'] = this.hasaccess;
    if (this.menu != null) {
      data['menu'] = this.menu!.toJson();
    }
    if (this.feature != null) {
      data['feature'] = this.feature!.toJson();
    }
    return data;
  }
}

class Menu {
  int? menuid;
  String? menunm;
  String? menuroute;

  Menu({this.menuid, this.menunm, this.menuroute});

  Menu.fromJson(Map<String, dynamic> json) {
    menuid = json['menuid'];
    menunm = json['menunm'];
    menuroute = json['menuroute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuid'] = this.menuid;
    data['menunm'] = this.menunm;
    data['menuroute'] = this.menuroute;
    return data;
  }
}

class Feature {
  int? featid;
  String? feattitle;
  String? featslug;

  Feature({this.featid, this.feattitle, this.featslug});

  Feature.fromJson(Map<String, dynamic> json) {
    featid = json['featid'];
    feattitle = json['feattitle'];
    featslug = json['featslug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['featid'] = this.featid;
    data['feattitle'] = this.feattitle;
    data['featslug'] = this.featslug;
    return data;
  }
}
