import 'package:boilerplate/helpers/function.dart';

import '../masters/type_model.dart';

class MenuModel {
  int? menuid;
  int? masterid;
  int? menutypeid;
  String? menunm;
  String? menuicon;
  String? menuroute;
  String? menucolor;
  late int menuseq;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Menucreatedby? menucreatedby;
  Menucreatedby? menuupdatedby;
  Parent? parent;
  TypeModel? menutype;

  MenuModel(
      {this.menuid,
      this.masterid,
      this.menutypeid,
      this.menunm,
      this.menuicon,
      this.menuroute,
      this.menucolor,
      required this.menuseq,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.menucreatedby,
      this.menuupdatedby,
      this.parent,
      this.menutype});

  MenuModel.fromJson(Map<String, dynamic> json) {
    menuid = json['menuid'];
    masterid = json['masterid'];
    menutypeid = json['menutypeid'];
    menunm = json['menunm'];
    menuicon = json['menuicon'];
    menuroute = json['menuroute'];
    menucolor = json['menucolor'];
    menuseq = parseInt(json['menuseq']);
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    menucreatedby = json['menucreatedby'] != null
        ? new Menucreatedby.fromJson(json['menucreatedby'])
        : null;
    menuupdatedby = json['menuupdatedby'] != null
        ? new Menucreatedby.fromJson(json['menuupdatedby'])
        : null;
    parent =
        json['parent'] != null ? new Parent.fromJson(json['parent']) : null;
    menutype = json['menutype'] != null
        ? new TypeModel.fromJson(json['menutype'])
        : null;
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
    if (this.menuupdatedby != null) {
      data['menuupdatedby'] = this.menuupdatedby!.toJson();
    }
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    if (this.menutype != null) {
      data['menutype'] = this.menutype!.toJson();
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

class Parent {
  int? menuid;
  String? menunm;

  Parent({this.menuid, this.menunm});

  Parent.fromJson(Map<String, dynamic> json) {
    menuid = json['menuid'];
    menunm = json['menunm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuid'] = this.menuid;
    data['menunm'] = this.menunm;
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
