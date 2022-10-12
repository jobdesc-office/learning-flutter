class AttendanceModel {
  int? attid;
  int? attbpid;
  int? attuserid;
  String? attdate;
  String? attclockin;
  String? attclockout;
  double? attlatin;
  double? attlongin;
  String? attaddressin;
  double? attlatout;
  double? attlongout;
  String? attaddressout;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Attuser? attuser;
  Attbp? attbp;

  AttendanceModel(
      {this.attid,
      this.attbpid,
      this.attuserid,
      this.attdate,
      this.attclockin,
      this.attclockout,
      this.attlatin,
      this.attlongin,
      this.attaddressin,
      this.attlatout,
      this.attlongout,
      this.attaddressout,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.attuser,
      this.attbp});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    attid = json['attid'];
    attbpid = json['attbpid'];
    attuserid = json['attuserid'];
    attdate = json['attdate'];
    attclockin = json['attclockin'];
    attclockout = json['attclockout'];
    attlatin = json['attlatin'];
    attlongin = json['attlongin'];
    attaddressin = json['attaddressin'];
    attlatout = json['attlatout'];
    attlongout = json['attlongout'];
    attaddressout = json['attaddressout'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    attuser =
        json['attuser'] != null ? new Attuser.fromJson(json['attuser']) : null;
    attbp = json['attbp'] != null ? new Attbp.fromJson(json['attbp']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attid'] = this.attid;
    data['attbpid'] = this.attbpid;
    data['attuserid'] = this.attuserid;
    data['attdate'] = this.attdate;
    data['attclockin'] = this.attclockin;
    data['attclockout'] = this.attclockout;
    data['attlatin'] = this.attlatin;
    data['attlongin'] = this.attlongin;
    data['attaddressin'] = this.attaddressin;
    data['attlatout'] = this.attlatout;
    data['attlongout'] = this.attlongout;
    data['attaddressout'] = this.attaddressout;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.attuser != null) {
      data['attuser'] = this.attuser!.toJson();
    }
    if (this.attbp != null) {
      data['attbp'] = this.attbp!.toJson();
    }
    return data;
  }
}

class Attuser {
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

  Attuser(
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

  Attuser.fromJson(Map<String, dynamic> json) {
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

class Attbp {
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

  Attbp(
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

  Attbp.fromJson(Map<String, dynamic> json) {
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
