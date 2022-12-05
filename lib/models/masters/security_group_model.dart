import 'package:boilerplate/models/masters/businesspartner_model.dart';

class SecurityGroupModel {
  int? sgid;
  String? sgcode;
  String? sgname;
  int? sgmasterid;
  int? sgbpid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  UserCreatedBy? usercreatedby;
  UserCreatedBy? userupdatedby;
  BusinessPartnerModel? businesspartner;
  SecurityGroupModel? parent;

  SecurityGroupModel({
    this.sgid,
    this.sgcode,
    this.sgname,
    this.parent,
    this.sgmasterid,
    this.sgbpid,
    this.createdby,
    this.createddate,
    this.updatedby,
    this.updateddate,
    this.isactive,
    this.usercreatedby,
    this.userupdatedby,
  });

  SecurityGroupModel.fromJson(Map<String, dynamic> json) {
    sgid = json['sgid'];
    sgcode = json['sgcode'];
    sgname = json['sgname'];
    sgmasterid = json['sgmasterid'];
    sgbpid = json['sgbpid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    usercreatedby = json['usercreatedby'] != null ? new UserCreatedBy.fromJson(json['usercreatedby']) : null;
    userupdatedby = json['userupdatedby'] != null ? new UserCreatedBy.fromJson(json['userupdatedby']) : null;
    businesspartner = json['businesspartner'] != null ? new BusinessPartnerModel.fromJson(json['businesspartner']) : null;
    parent = json['parent'] != null ? new SecurityGroupModel.fromJson(json['parent']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sgid'] = this.sgid;
    data['sgcode'] = this.sgcode;
    data['sgname'] = this.sgname;
    data['sgmasterid'] = this.sgmasterid;
    data['sgbpid'] = this.sgbpid;
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
    if (this.businesspartner != null) {
      data['businesspartner'] = this.businesspartner!.toJson();
    }
    if (this.parent != null) {
      data['parent'] = this.parent!.toJson();
    }
    return data;
  }
}

class UserCreatedBy {
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

  UserCreatedBy(
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

  UserCreatedBy.fromJson(Map<String, dynamic> json) {
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
