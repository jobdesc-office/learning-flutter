class PermissionModel {
  int? permisid;
  int? roleid;
  int? permismenuid;
  int? permisfeatid;
  bool? hasaccess;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Role? role;
  Menu? menu;
  Feature? feature;

  PermissionModel(
      {this.permisid,
      this.roleid,
      this.permismenuid,
      this.permisfeatid,
      this.hasaccess,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.role,
      this.menu,
      this.feature});

  PermissionModel.fromJson(Map<String, dynamic> json) {
    permisid = json['permisid'];
    roleid = json['roleid'];
    permismenuid = json['permismenuid'];
    permisfeatid = json['permisfeatid'];
    hasaccess = json['hasaccess'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
    menu = json['menu'] != null ? new Menu.fromJson(json['menu']) : null;
    feature =
        json['feature'] != null ? new Feature.fromJson(json['feature']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['permisid'] = this.permisid;
    data['roleid'] = this.roleid;
    data['permismenuid'] = this.permismenuid;
    data['permisfeatid'] = this.permisfeatid;
    data['hasaccess'] = this.hasaccess;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    if (this.menu != null) {
      data['menu'] = this.menu!.toJson();
    }
    if (this.feature != null) {
      data['feature'] = this.feature!.toJson();
    }
    return data;
  }
}

class Role {
  int? typeid;
  String? typecd;
  String? typename;
  int? typeseq;
  int? typemasterid;
  String? typedesc;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Role(
      {this.typeid,
      this.typecd,
      this.typename,
      this.typeseq,
      this.typemasterid,
      this.typedesc,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Role.fromJson(Map<String, dynamic> json) {
    typeid = json['typeid'];
    typecd = json['typecd'];
    typename = json['typename'];
    typeseq = json['typeseq'];
    typemasterid = json['typemasterid'];
    typedesc = json['typedesc'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeid'] = this.typeid;
    data['typecd'] = this.typecd;
    data['typename'] = this.typename;
    data['typeseq'] = this.typeseq;
    data['typemasterid'] = this.typemasterid;
    data['typedesc'] = this.typedesc;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}

class Menu {
  int? menuid;
  int? masterid;
  int? menutypeid;
  String? menunm;
  String? menuicon;
  String? menuroute;
  String? menucolor;
  int? menuseq;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Menu(
      {this.menuid,
      this.masterid,
      this.menutypeid,
      this.menunm,
      this.menuicon,
      this.menuroute,
      this.menucolor,
      this.menuseq,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Menu.fromJson(Map<String, dynamic> json) {
    menuid = json['menuid'];
    masterid = json['masterid'];
    menutypeid = json['menutypeid'];
    menunm = json['menunm'];
    menuicon = json['menuicon'];
    menuroute = json['menuroute'];
    menucolor = json['menucolor'];
    menuseq = json['menuseq'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuid'] = this.menuid;
    data['masterid'] = this.masterid;
    data['menutypeid'] = this.menutypeid;
    data['menunm'] = this.menunm;
    data['menuicon'] = this.menuicon;
    data['menuroute'] = this.menuroute;
    data['menucolor'] = this.menucolor;
    data['menuseq'] = this.menuseq;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}

class Feature {
  int? featid;
  int? featmenuid;
  String? feattitle;
  String? featslug;
  String? featuredesc;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Feature(
      {this.featid,
      this.featmenuid,
      this.feattitle,
      this.featslug,
      this.featuredesc,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Feature.fromJson(Map<String, dynamic> json) {
    featid = json['featid'];
    featmenuid = json['featmenuid'];
    feattitle = json['feattitle'];
    featslug = json['featslug'];
    featuredesc = json['featuredesc'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['featid'] = this.featid;
    data['featmenuid'] = this.featmenuid;
    data['feattitle'] = this.feattitle;
    data['featslug'] = this.featslug;
    data['featuredesc'] = this.featuredesc;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}
