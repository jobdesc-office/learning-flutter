class StbptypeModel {
  int? sbtid;
  int? sbtbpid;
  String? sbtname;
  int? sbtseq;
  int? sbttypemasterid;
  String? sbttypename;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Stbptypecreatedby? stbptypecreatedby;
  Stbptypecreatedby? stbptypeupdatedby;
  Stbptypetype? stbptypetype;
  Stbptypebp? stbptypebp;

  StbptypeModel(
      {this.sbtid,
      this.sbtbpid,
      this.sbtname,
      this.sbtseq,
      this.sbttypemasterid,
      this.sbttypename,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.stbptypecreatedby,
      this.stbptypeupdatedby,
      this.stbptypetype,
      this.stbptypebp});

  StbptypeModel.fromJson(Map<String, dynamic> json) {
    sbtid = json['sbtid'];
    sbtbpid = json['sbtbpid'];
    sbtname = json['sbtname'];
    sbtseq = json['sbtseq'];
    sbttypemasterid = json['sbttypemasterid'];
    sbttypename = json['sbttypename'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    stbptypecreatedby = json['stbptypecreatedby'] != null
        ? new Stbptypecreatedby.fromJson(json['stbptypecreatedby'])
        : null;
    stbptypeupdatedby = json['stbptypeupdatedby'] != null
        ? new Stbptypecreatedby.fromJson(json['stbptypeupdatedby'])
        : null;
    stbptypetype = json['stbptypetype'] != null
        ? new Stbptypetype.fromJson(json['stbptypetype'])
        : null;
    stbptypebp = json['stbptypebp'] != null
        ? new Stbptypebp.fromJson(json['stbptypebp'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sbtid'] = this.sbtid;
    data['sbtbpid'] = this.sbtbpid;
    data['sbtname'] = this.sbtname;
    data['sbtseq'] = this.sbtseq;
    data['sbttypemasterid'] = this.sbttypemasterid;
    data['sbttypename'] = this.sbttypename;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.stbptypecreatedby != null) {
      data['stbptypecreatedby'] = this.stbptypecreatedby!.toJson();
    }
    if (this.stbptypeupdatedby != null) {
      data['stbptypeupdatedby'] = this.stbptypeupdatedby!.toJson();
    }
    if (this.stbptypetype != null) {
      data['stbptypetype'] = this.stbptypetype!.toJson();
    }
    if (this.stbptypebp != null) {
      data['stbptypebp'] = this.stbptypebp!.toJson();
    }
    return data;
  }
}

class Stbptypecreatedby {
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

  Stbptypecreatedby(
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

  Stbptypecreatedby.fromJson(Map<String, dynamic> json) {
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

class Stbptypetype {
  int? typeid;
  String? typename;

  Stbptypetype({this.typeid, this.typename});

  Stbptypetype.fromJson(Map<String, dynamic> json) {
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

class Stbptypebp {
  int? bpid;
  String? bpname;

  Stbptypebp({this.bpid, this.bpname});

  Stbptypebp.fromJson(Map<String, dynamic> json) {
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
