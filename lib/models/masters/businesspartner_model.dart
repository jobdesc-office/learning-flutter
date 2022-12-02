import 'package:boilerplate/models/masters/type_model.dart';

class BusinessPartnerModel {
  int? bpid;
  String? bpname;
  int? bptypeid;
  String? bppicname;
  String? bpemail;
  String? bpphone;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? bpdayactanytime;
  bool? bpprosactanytime;
  bool? isactive;
  TypeModel? bptype;
  Bpcreatedby? bpcreatedby;
  Bpcreatedby? bpupdatedby;

  BusinessPartnerModel(
      {this.bpid,
      this.bpname,
      this.bptypeid,
      this.bppicname,
      this.bpemail,
      this.bpphone,
      this.createdby,
      this.createddate,
      this.bpdayactanytime,
      this.bpprosactanytime,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.bptype,
      this.bpcreatedby,
      this.bpupdatedby});

  BusinessPartnerModel.fromJson(Map<String, dynamic> json) {
    bpid = json['bpid'];
    bpname = json['bpname'];
    bptypeid = json['bptypeid'];
    bppicname = json['bppicname'];
    bpemail = json['bpemail'];
    bpphone = json['bpphone'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    bpdayactanytime = json['bpdayactanytime'];
    bpprosactanytime = json['bpprosactanytime'];
    bptype = json['bptype'] != null ? new TypeModel.fromJson(json['bptype']) : null;
    bpcreatedby = json['bpcreatedby'] != null ? new Bpcreatedby.fromJson(json['bpcreatedby']) : null;
    bpupdatedby = json['bpupdatedby'] != null ? new Bpcreatedby.fromJson(json['bpupdatedby']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bpid'] = this.bpid;
    data['bpname'] = this.bpname;
    data['bptypeid'] = this.bptypeid;
    data['bppicname'] = this.bppicname;
    data['bpemail'] = this.bpemail;
    data['bpphone'] = this.bpphone;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    data['bpprosactanytime'] = this.bpprosactanytime;
    data['bpdayactanytime'] = this.bpdayactanytime;
    if (this.bptype != null) {
      data['bptype'] = this.bptype!.toJson();
    }
    if (this.bpcreatedby != null) {
      data['bpcreatedby'] = this.bpcreatedby!.toJson();
    }
    if (this.bpupdatedby != null) {
      data['bpupdatedby'] = this.bpupdatedby!.toJson();
    }
    return data;
  }
}

class Bptype {
  int? typeid;
  String? typename;

  Bptype({this.typeid, this.typename});

  Bptype.fromJson(Map<String, dynamic> json) {
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

class Bpcreatedby {
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

  Bpcreatedby(
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

  Bpcreatedby.fromJson(Map<String, dynamic> json) {
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
