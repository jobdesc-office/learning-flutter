class CustomFieldModel {
  int? custfid;
  int? custfbpid;
  String? custfname;
  int? custftypeid;
  bool? allprospect;
  bool? onlythisprospect;
  int? thisprospectid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Custfcreatedby? custfcreatedby;
  Custfcreatedby? custfupdatedby;
  Businesspartner? businesspartner;
  Custftype? custftype;

  CustomFieldModel(
      {this.custfid,
      this.custfbpid,
      this.custfname,
      this.custftypeid,
      this.allprospect,
      this.onlythisprospect,
      this.thisprospectid,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.custfcreatedby,
      this.custfupdatedby,
      this.businesspartner,
      this.custftype});

  CustomFieldModel.fromJson(Map<String, dynamic> json) {
    custfid = json['custfid'];
    custfbpid = json['custfbpid'];
    custfname = json['custfname'];
    custftypeid = json['custftypeid'];
    allprospect = json['allprospect'];
    onlythisprospect = json['onlythisprospect'];
    thisprospectid = json['thisprospectid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    custfcreatedby = json['custfcreatedby'] != null
        ? new Custfcreatedby.fromJson(json['custfcreatedby'])
        : null;
    custfupdatedby = json['custfupdatedby'];
    businesspartner = json['businesspartner'] != null
        ? new Businesspartner.fromJson(json['businesspartner'])
        : null;
    custftype = json['custftype'] != null
        ? new Custftype.fromJson(json['custftype'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custfid'] = this.custfid;
    data['custfbpid'] = this.custfbpid;
    data['custfname'] = this.custfname;
    data['custftypeid'] = this.custftypeid;
    data['allprospect'] = this.allprospect;
    data['onlythisprospect'] = this.onlythisprospect;
    data['thisprospectid'] = this.thisprospectid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.custfcreatedby != null) {
      data['custfcreatedby'] = this.custfcreatedby!.toJson();
    }
    data['custfupdatedby'] = this.custfupdatedby;
    if (this.businesspartner != null) {
      data['businesspartner'] = this.businesspartner!.toJson();
    }
    if (this.custftype != null) {
      data['custftype'] = this.custftype!.toJson();
    }
    return data;
  }
}

class Custfcreatedby {
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

  Custfcreatedby(
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

  Custfcreatedby.fromJson(Map<String, dynamic> json) {
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

class Custftype {
  int? typeid;
  String? typename;

  Custftype({this.typeid, this.typename});

  Custftype.fromJson(Map<String, dynamic> json) {
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
