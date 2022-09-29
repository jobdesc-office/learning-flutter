class RolePermissionModel {
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
  Menucreatedby? menucreatedby;
  Menucreatedby? menuupdatedby;
  Menutype? menutype;
  List<Features>? features;
  List<Children>? children;

  RolePermissionModel(
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
      this.isactive,
      this.menucreatedby,
      this.menuupdatedby,
      this.menutype,
      this.features,
      this.children});

  RolePermissionModel.fromJson(Map<String, dynamic> json) {
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
    menucreatedby = json['menucreatedby'] != null
        ? new Menucreatedby.fromJson(json['menucreatedby'])
        : null;
    menuupdatedby = json['menuupdatedby'];
    menutype = json['menutype'] != null
        ? new Menutype.fromJson(json['menutype'])
        : null;
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
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
    if (this.menucreatedby != null) {
      data['menucreatedby'] = this.menucreatedby!.toJson();
    }
    data['menuupdatedby'] = this.menuupdatedby;
    if (this.menutype != null) {
      data['menutype'] = this.menutype!.toJson();
    }
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menucreatedby {
  int? userid;
  String? username;
  String? userpassword;
  String? userfullname;
  String? useremail;
  String? userphone;
  String? userdeviceid;
  String? userfcmtoken;
  String? usersocketid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Menucreatedby(
      {this.userid,
      this.username,
      this.userpassword,
      this.userfullname,
      this.useremail,
      this.userphone,
      this.userdeviceid,
      this.userfcmtoken,
      this.usersocketid,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Menucreatedby.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    username = json['username'];
    userpassword = json['userpassword'];
    userfullname = json['userfullname'];
    useremail = json['useremail'];
    userphone = json['userphone'];
    userdeviceid = json['userdeviceid'];
    userfcmtoken = json['userfcmtoken'];
    usersocketid = json['usersocketid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['username'] = this.username;
    data['userpassword'] = this.userpassword;
    data['userfullname'] = this.userfullname;
    data['useremail'] = this.useremail;
    data['userphone'] = this.userphone;
    data['userdeviceid'] = this.userdeviceid;
    data['userfcmtoken'] = this.userfcmtoken;
    data['usersocketid'] = this.usersocketid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}

class Menutype {
  int? typeid;
  String? typename;

  Menutype({this.typeid, this.typename});

  Menutype.fromJson(Map<String, dynamic> json) {
    typeid = json['typeid'];
    typename = json['typename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeid'] = this.typeid;
    data['typename'] = this.typename;
    return data;
  }
}

class Features {
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
  Permissions? permissions;

  Features(
      {this.featid,
      this.featmenuid,
      this.feattitle,
      this.featslug,
      this.featuredesc,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.permissions});

  Features.fromJson(Map<String, dynamic> json) {
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
    permissions = json['permissions'] != null
        ? new Permissions.fromJson(json['permissions'])
        : null;
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
    if (this.permissions != null) {
      data['permissions'] = this.permissions!.toJson();
    }
    return data;
  }
}

class Permissions {
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

  Permissions(
      {this.permisid,
      this.roleid,
      this.permismenuid,
      this.permisfeatid,
      this.hasaccess,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Permissions.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Children {
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
  Menucreatedby? menucreatedby;
  Menucreatedby? menuupdatedby;
  Menutype? menutype;
  List<Features>? features;
  List<Children>? children;

  Children(
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
      this.isactive,
      this.menucreatedby,
      this.menuupdatedby,
      this.menutype,
      this.features,
      this.children});

  Children.fromJson(Map<String, dynamic> json) {
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
    menucreatedby = json['menucreatedby'] != null
        ? new Menucreatedby.fromJson(json['menucreatedby'])
        : null;
    menuupdatedby = json['menuupdatedby'];
    menutype = json['menutype'] != null
        ? new Menutype.fromJson(json['menutype'])
        : null;
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
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
    if (this.menucreatedby != null) {
      data['menucreatedby'] = this.menucreatedby!.toJson();
    }
    data['menuupdatedby'] = this.menuupdatedby;
    if (this.menutype != null) {
      data['menutype'] = this.menutype!.toJson();
    }
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
