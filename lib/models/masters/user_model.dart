import 'package:boilerplate/models/masters/security_group_model.dart';

class UserModel {
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
  Usercreatedby? usercreatedby;
  Usercreatedby? userupdatedby;
  List<Userdetails>? userdetails;
  Usertype? appaccess;

  UserModel(
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
      this.isactive,
      this.usercreatedby,
      this.userupdatedby,
      this.userdetails});

  UserModel.fromJson(Map<String, dynamic> json) {
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
    usercreatedby = json['usercreatedby'] != null ? new Usercreatedby.fromJson(json['usercreatedby']) : null;
    userupdatedby = json['userupdatedby'] != null ? new Usercreatedby.fromJson(json['userupdatedby']) : null;
    appaccess = json['appaccess'] != null ? new Usertype.fromJson(json['appaccess']) : null;
    if (json['userdetails'] != null) {
      userdetails = <Userdetails>[];
      json['userdetails'].forEach((v) {
        userdetails!.add(new Userdetails.fromJson(v));
      });
    }
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
    if (this.usercreatedby != null) {
      data['usercreatedby'] = this.usercreatedby!.toJson();
    }
    if (this.userupdatedby != null) {
      data['userupdatedby'] = this.userupdatedby!.toJson();
    }
    if (this.userdetails != null) {
      data['userdetails'] = this.userdetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Usercreatedby {
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

  Usercreatedby(
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

  Usercreatedby.fromJson(Map<String, dynamic> json) {
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

class Userdetails {
  int? userdtid;
  int? userid;
  int? userdttypeid;
  int? userdtbpid;
  String? userdtbranchnm;
  String? userdtreferalcode;
  String? userdtrelationid;
  int? userdtsgid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Usertype? usertype;
  Businesspartner? businesspartner;
  SecurityGroupModel? securitygroup;

  Userdetails({
    this.userdtid,
    this.userid,
    this.userdttypeid,
    this.userdtbpid,
    this.userdtbranchnm,
    this.userdtreferalcode,
    this.userdtrelationid,
    this.createdby,
    this.createddate,
    this.updatedby,
    this.updateddate,
    this.isactive,
    this.usertype,
    this.businesspartner,
    this.userdtsgid,
    this.securitygroup,
  });

  Userdetails.fromJson(Map<String, dynamic> json) {
    userdtid = json['userdtid'];
    userid = json['userid'];
    userdttypeid = json['userdttypeid'];
    userdtbpid = json['userdtbpid'];
    userdtbranchnm = json['userdtbranchnm'];
    userdtreferalcode = json['userdtreferalcode'];
    userdtrelationid = json['userdtrelationid'];
    userdtsgid = json['userdtsgid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    usertype = json['usertype'] != null ? new Usertype.fromJson(json['usertype']) : null;
    businesspartner = json['businesspartner'] != null ? new Businesspartner.fromJson(json['businesspartner']) : null;
    securitygroup = json['securitygroup'] != null ? new SecurityGroupModel.fromJson(json['securitygroup']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userdtid'] = this.userdtid;
    data['userid'] = this.userid;
    data['userdttypeid'] = this.userdttypeid;
    data['userdtbpid'] = this.userdtbpid;
    data['userdtbranchnm'] = this.userdtbranchnm;
    data['userdtreferalcode'] = this.userdtreferalcode;
    data['userdtrelationid'] = this.userdtrelationid;
    data['userdtsgid'] = this.userdtsgid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.usertype != null) {
      data['usertype'] = this.usertype!.toJson();
    }
    if (this.businesspartner != null) {
      data['businesspartner'] = this.businesspartner!.toJson();
    }
    if (this.securitygroup != null) {
      data['securitygroup'] = this.securitygroup!.toJson();
    }
    return data;
  }
}

class Usertype {
  int? typeid;
  String? typename;

  Usertype({this.typeid, this.typename});

  Usertype.fromJson(Map<String, dynamic> json) {
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

class Businesspartner {
  int? bpid;
  String? bpname;

  Businesspartner({this.bpid, this.bpname});

  Businesspartner.fromJson(Map<String, dynamic> json) {
    bpid = json['bpid'];
    bpname = json['bpname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bpid'] = this.bpid;
    data['bpname'] = this.bpname;
    return data;
  }
}
