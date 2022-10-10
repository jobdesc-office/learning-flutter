class BusinessPartnerCustomerModel {
  int? sbcid;
  int? sbcbpid;
  int? sbccstmid;
  int? sbccstmstatusid;
  int? sbcactivitytypeid;
  String? sbccstmname;
  String? sbccstmphone;
  String? sbccstmaddress;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Bpcustcreatedby? bpcustcreatedby;
  Bpcustcreatedby? bpcustupdatedby;
  Sbccstmstatus? sbccstmstatus;
  Sbcactivitytype? sbcactivitytype;
  Sbcbp? sbcbp;
  Sbccstm? sbccstm;
  List<Sbccstmpics>? sbccstmpics;

  BusinessPartnerCustomerModel(
      {this.sbcid,
      this.sbcbpid,
      this.sbccstmid,
      this.sbccstmstatusid,
      this.sbcactivitytypeid,
      this.sbcactivitytype,
      this.sbccstmname,
      this.sbccstmphone,
      this.sbccstmaddress,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.bpcustcreatedby,
      this.bpcustupdatedby,
      this.sbccstmstatus,
      this.sbcbp,
      this.sbccstm,
      this.sbccstmpics});

  BusinessPartnerCustomerModel.fromJson(Map<String, dynamic> json) {
    sbcid = json['sbcid'];
    sbcbpid = json['sbcbpid'];
    sbccstmid = json['sbccstmid'];
    sbccstmstatusid = json['sbccstmstatusid'];
    sbcactivitytypeid = json['sbcactivitytypeid'];
    sbccstmname = json['sbccstmname'];
    sbccstmphone = json['sbccstmphone'];
    sbccstmaddress = json['sbccstmaddress'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    bpcustcreatedby = json['bpcustcreatedby'] != null ? new Bpcustcreatedby.fromJson(json['bpcustcreatedby']) : null;
    bpcustupdatedby = json['bpcustupdatedby'] != null ? new Bpcustcreatedby.fromJson(json['bpcustupdatedby']) : null;
    sbccstmstatus = json['sbccstmstatus'] != null ? new Sbccstmstatus.fromJson(json['sbccstmstatus']) : null;
    sbcactivitytype = json['sbcactivitytype'] != null ? new Sbcactivitytype.fromJson(json['sbcactivitytype']) : null;
    sbcbp = json['sbcbp'] != null ? new Sbcbp.fromJson(json['sbcbp']) : null;
    sbccstm = json['sbccstm'] != null ? new Sbccstm.fromJson(json['sbccstm']) : null;
    if (json['sbccstmpics'] != null) {
      sbccstmpics = <Sbccstmpics>[];
      json['sbccstmpics'].forEach((v) {
        sbccstmpics!.add(new Sbccstmpics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sbcid'] = this.sbcid;
    data['sbcbpid'] = this.sbcbpid;
    data['sbccstmid'] = this.sbccstmid;
    data['sbccstmstatusid'] = this.sbccstmstatusid;
    data['sbccstmname'] = this.sbccstmname;
    data['sbccstmphone'] = this.sbccstmphone;
    data['sbccstmaddress'] = this.sbccstmaddress;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.bpcustcreatedby != null) {
      data['bpcustcreatedby'] = this.bpcustcreatedby!.toJson();
    }
    if (this.bpcustupdatedby != null) {
      data['bpcustupdatedby'] = this.bpcustupdatedby!.toJson();
    }
    if (this.sbccstmstatus != null) {
      data['sbccstmstatus'] = this.sbccstmstatus!.toJson();
    }
    if (this.sbcbp != null) {
      data['sbcbp'] = this.sbcbp!.toJson();
    }
    if (this.sbccstm != null) {
      data['sbccstm'] = this.sbccstm!.toJson();
    }
    if (this.sbccstmpics != null) {
      data['sbccstmpics'] = this.sbccstmpics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bpcustcreatedby {
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

  Bpcustcreatedby(
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

  Bpcustcreatedby.fromJson(Map<String, dynamic> json) {
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

class Sbccstmstatus {
  int? typeid;
  String? typename;

  Sbccstmstatus({this.typeid, this.typename});

  Sbccstmstatus.fromJson(Map<String, dynamic> json) {
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

class Sbcactivitytype {
  int? sbtid;
  String? sbttypename;

  Sbcactivitytype({this.sbtid, this.sbttypename});

  Sbcactivitytype.fromJson(Map<String, dynamic> json) {
    sbtid = json['sbtid'];
    sbttypename = json['sbttypename'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sbtid'] = this.sbtid;
    data['sbttypename'] = this.sbttypename;
    return data;
  }
}

class Sbcbp {
  int? bpid;
  String? bpname;

  Sbcbp({this.bpid, this.bpname});

  Sbcbp.fromJson(Map<String, dynamic> json) {
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

class Sbccstm {
  int? cstmid;
  String? cstmprefix;
  String? cstmname;
  String? cstmphone;
  String? cstmaddress;
  int? cstmtypeid;
  int? cstmprovinceid;
  int? cstmcityid;
  int? cstmsubdistrictid;
  int? cstmuvid;
  String? cstmpostalcode;
  String? cstmlatitude;
  String? cstmlongitude;
  String? referalcode;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Sbccstmstatus? cstmtype;

  Sbccstm(
      {this.cstmid,
      this.cstmprefix,
      this.cstmname,
      this.cstmphone,
      this.cstmaddress,
      this.cstmtypeid,
      this.cstmprovinceid,
      this.cstmcityid,
      this.cstmsubdistrictid,
      this.cstmuvid,
      this.cstmpostalcode,
      this.cstmlatitude,
      this.cstmlongitude,
      this.referalcode,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.cstmtype});

  Sbccstm.fromJson(Map<String, dynamic> json) {
    cstmid = json['cstmid'];
    cstmprefix = json['cstmprefix'];
    cstmname = json['cstmname'];
    cstmphone = json['cstmphone'];
    cstmaddress = json['cstmaddress'];
    cstmtypeid = json['cstmtypeid'];
    cstmprovinceid = json['cstmprovinceid'];
    cstmcityid = json['cstmcityid'];
    cstmsubdistrictid = json['cstmsubdistrictid'];
    cstmuvid = json['cstmuvid'];
    cstmpostalcode = json['cstmpostalcode'];
    cstmlatitude = json['cstmlatitude'];
    cstmlongitude = json['cstmlongitude'];
    referalcode = json['referalcode'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    cstmtype = json['cstmtype'] != null ? new Sbccstmstatus.fromJson(json['cstmtype']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cstmid'] = this.cstmid;
    data['cstmprefix'] = this.cstmprefix;
    data['cstmname'] = this.cstmname;
    data['cstmphone'] = this.cstmphone;
    data['cstmaddress'] = this.cstmaddress;
    data['cstmtypeid'] = this.cstmtypeid;
    data['cstmprovinceid'] = this.cstmprovinceid;
    data['cstmcityid'] = this.cstmcityid;
    data['cstmsubdistrictid'] = this.cstmsubdistrictid;
    data['cstmuvid'] = this.cstmuvid;
    data['cstmpostalcode'] = this.cstmpostalcode;
    data['cstmlatitude'] = this.cstmlatitude;
    data['cstmlongitude'] = this.cstmlongitude;
    data['referalcode'] = this.referalcode;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.cstmtype != null) {
      data['cstmtype'] = this.cstmtype!.toJson();
    }
    return data;
  }
}

class Sbccstmpics {
  int? fileid;
  int? transtypeid;
  int? refid;
  String? directories;
  String? filename;
  String? mimetype;
  String? filesize;
  String? remark;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  String? url;

  Sbccstmpics(
      {this.fileid,
      this.transtypeid,
      this.refid,
      this.directories,
      this.filename,
      this.mimetype,
      this.filesize,
      this.remark,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.url});

  Sbccstmpics.fromJson(Map<String, dynamic> json) {
    fileid = json['fileid'];
    transtypeid = json['transtypeid'];
    refid = json['refid'];
    directories = json['directories'];
    filename = json['filename'];
    mimetype = json['mimetype'];
    filesize = json['filesize'];
    remark = json['remark'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileid'] = this.fileid;
    data['transtypeid'] = this.transtypeid;
    data['refid'] = this.refid;
    data['directories'] = this.directories;
    data['filename'] = this.filename;
    data['mimetype'] = this.mimetype;
    data['filesize'] = this.filesize;
    data['remark'] = this.remark;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    data['url'] = this.url;
    return data;
  }
}
