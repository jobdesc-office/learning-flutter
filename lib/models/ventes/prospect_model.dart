import '../masters/type_model.dart';

class ProspectModel {
  int? prospectid;
  String? prospectname;
  String? prospectstartdate;
  String? prospectenddate;
  String? prospectvalue;
  int? prospectowner;
  int? prospectstageid;
  int? prospectstatusid;
  int? prospecttypeid;
  String? prospectexpclosedate;
  int? prospectbpid;
  String? prospectdescription;
  int? prospectcustid;
  int? prospectrefid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Prospectowneruser? prospectowneruser;
  TypeModel? prospectstage;
  Prospectstage? prospectstatus;
  Prospectstage? prospecttype;
  Prospectbp? prospectbp;
  Prospectcust? prospectcust;

  ProspectModel(
      {this.prospectid,
      this.prospectname,
      this.prospectstartdate,
      this.prospectenddate,
      this.prospectvalue,
      this.prospectowner,
      this.prospectstageid,
      this.prospectstatusid,
      this.prospecttypeid,
      this.prospectexpclosedate,
      this.prospectbpid,
      this.prospectdescription,
      this.prospectcustid,
      this.prospectrefid,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.prospectowneruser,
      this.prospectstage,
      this.prospectstatus,
      this.prospecttype,
      this.prospectbp,
      this.prospectcust});

  ProspectModel.fromJson(Map<String, dynamic> json) {
    prospectid = json['prospectid'];
    prospectname = json['prospectname'];
    prospectstartdate = json['prospectstartdate'];
    prospectenddate = json['prospectenddate'];
    prospectvalue = json['prospectvalue'];
    prospectowner = json['prospectowner'];
    prospectstageid = json['prospectstageid'];
    prospectstatusid = json['prospectstatusid'];
    prospecttypeid = json['prospecttypeid'];
    prospectexpclosedate = json['prospectexpclosedate'];
    prospectbpid = json['prospectbpid'];
    prospectdescription = json['prospectdescription'];
    prospectcustid = json['prospectcustid'];
    prospectrefid = json['prospectrefid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    prospectowneruser = json['prospectowneruser'] != null
        ? new Prospectowneruser.fromJson(json['prospectowneruser'])
        : null;
    prospectstage = json['prospectstage'] != null
        ? new TypeModel.fromJson(json['prospectstage'])
        : null;
    prospectstatus = json['prospectstatus'] != null
        ? new Prospectstage.fromJson(json['prospectstatus'])
        : null;
    prospecttype = json['prospecttype'] != null
        ? new Prospectstage.fromJson(json['prospecttype'])
        : null;
    prospectbp = json['prospectbp'] != null
        ? new Prospectbp.fromJson(json['prospectbp'])
        : null;
    prospectcust = json['prospectcust'] != null
        ? new Prospectcust.fromJson(json['prospectcust'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prospectid'] = this.prospectid;
    data['prospectname'] = this.prospectname;
    data['prospectstartdate'] = this.prospectstartdate;
    data['prospectenddate'] = this.prospectenddate;
    data['prospectvalue'] = this.prospectvalue;
    data['prospectowner'] = this.prospectowner;
    data['prospectstageid'] = this.prospectstageid;
    data['prospectstatusid'] = this.prospectstatusid;
    data['prospecttypeid'] = this.prospecttypeid;
    data['prospectexpclosedate'] = this.prospectexpclosedate;
    data['prospectbpid'] = this.prospectbpid;
    data['prospectdescription'] = this.prospectdescription;
    data['prospectcustid'] = this.prospectcustid;
    data['prospectrefid'] = this.prospectrefid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.prospectowneruser != null) {
      data['prospectowneruser'] = this.prospectowneruser!.toJson();
    }
    if (this.prospectstage != null) {
      data['prospectstage'] = this.prospectstage!.toJson();
    }
    if (this.prospectstatus != null) {
      data['prospectstatus'] = this.prospectstatus!.toJson();
    }
    if (this.prospecttype != null) {
      data['prospecttype'] = this.prospecttype!.toJson();
    }
    if (this.prospectbp != null) {
      data['prospectbp'] = this.prospectbp!.toJson();
    }
    if (this.prospectcust != null) {
      data['prospectcust'] = this.prospectcust!.toJson();
    }
    return data;
  }
}

class Prospectowneruser {
  int? userdtid;
  int? userid;
  int? userdttypeid;
  int? userdtbpid;
  Null? userdtbranchnm;
  Null? userdtreferalcode;
  Null? userdtrelationid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  User? user;

  Prospectowneruser(
      {this.userdtid,
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
      this.user});

  Prospectowneruser.fromJson(Map<String, dynamic> json) {
    userdtid = json['userdtid'];
    userid = json['userid'];
    userdttypeid = json['userdttypeid'];
    userdtbpid = json['userdtbpid'];
    userdtbranchnm = json['userdtbranchnm'];
    userdtreferalcode = json['userdtreferalcode'];
    userdtrelationid = json['userdtrelationid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? userid;
  String? username;
  String? userpassword;
  String? userfullname;
  String? useremail;
  String? userphone;
  Null? userdeviceid;
  Null? userfcmtoken;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  User(
      {this.userid,
      this.username,
      this.userpassword,
      this.userfullname,
      this.useremail,
      this.userphone,
      this.userdeviceid,
      this.userfcmtoken,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  User.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    username = json['username'];
    userpassword = json['userpassword'];
    userfullname = json['userfullname'];
    useremail = json['useremail'];
    userphone = json['userphone'];
    userdeviceid = json['userdeviceid'];
    userfcmtoken = json['userfcmtoken'];
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
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}

class Prospectstage {
  int? typeid;
  String? typename;

  Prospectstage({this.typeid, this.typename});

  Prospectstage.fromJson(Map<String, dynamic> json) {
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

class Prospectbp {
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
  bool? isactive;

  Prospectbp(
      {this.bpid,
      this.bpname,
      this.bptypeid,
      this.bppicname,
      this.bpemail,
      this.bpphone,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Prospectbp.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Prospectcust {
  int? sbcid;
  int? sbcbpid;
  int? sbccstmid;
  int? sbccstmstatusid;
  String? sbccstmname;
  String? sbccstmphone;
  String? sbccstmaddress;
  String? sbccstmpic;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Sbccstm? sbccstm;

  Prospectcust(
      {this.sbcid,
      this.sbcbpid,
      this.sbccstmid,
      this.sbccstmstatusid,
      this.sbccstmname,
      this.sbccstmphone,
      this.sbccstmaddress,
      this.sbccstmpic,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.sbccstm});

  Prospectcust.fromJson(Map<String, dynamic> json) {
    sbcid = json['sbcid'];
    sbcbpid = json['sbcbpid'];
    sbccstmid = json['sbccstmid'];
    sbccstmstatusid = json['sbccstmstatusid'];
    sbccstmname = json['sbccstmname'];
    sbccstmphone = json['sbccstmphone'];
    sbccstmaddress = json['sbccstmaddress'];
    sbccstmpic = json['sbccstmpic'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    sbccstm =
        json['sbccstm'] != null ? new Sbccstm.fromJson(json['sbccstm']) : null;
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
    data['sbccstmpic'] = this.sbccstmpic;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.sbccstm != null) {
      data['sbccstm'] = this.sbccstm!.toJson();
    }
    return data;
  }
}

class Sbccstm {
  int? cstmid;
  Null? cstmprefix;
  String? cstmname;
  String? cstmphone;
  String? cstmaddress;
  int? cstmtypeid;
  int? cstmprovinceid;
  int? cstmcityid;
  int? cstmsubdistrictid;
  Null? cstmuvid;
  String? cstmpostalcode;
  String? cstmlatitude;
  String? cstmlongitude;
  int? referalcode;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

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
      this.isactive});

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
    return data;
  }
}
