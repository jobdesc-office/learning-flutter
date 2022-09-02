class TypeModel {
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
  Typecreatedby? typecreatedby;
  Typecreatedby? typeupdatedby;

  TypeModel(
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
      this.isactive,
      this.typecreatedby,
      this.typeupdatedby});

  TypeModel.fromJson(Map<String, dynamic> json) {
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
    typecreatedby = json['typecreatedby'] != null
        ? new Typecreatedby.fromJson(json['typecreatedby'])
        : null;
    typeupdatedby = json['typeupdatedby'] != null
        ? new Typecreatedby.fromJson(json['typeupdatedby'])
        : null;
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
    if (this.typecreatedby != null) {
      data['typecreatedby'] = this.typecreatedby!.toJson();
    }
    if (this.typeupdatedby != null) {
      data['typeupdatedby'] = this.typeupdatedby!.toJson();
    }
    return data;
  }
}

class Typecreatedby {
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

  Typecreatedby(
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

  Typecreatedby.fromJson(Map<String, dynamic> json) {
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
