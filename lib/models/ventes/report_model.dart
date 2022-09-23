class ReportModel {
  List<Activities>? activities;
  List<Dayactuser>? employees;

  ReportModel({this.activities, this.employees});

  ReportModel.fromJson(Map<String, dynamic> json) {
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(new Activities.fromJson(v));
      });
    }
    if (json['employees'] != null) {
      employees = <Dayactuser>[];
      json['employees'].forEach((v) {
        employees!.add(new Dayactuser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.activities != null) {
      data['activities'] = this.activities!.map((v) => v.toJson()).toList();
    }
    if (this.employees != null) {
      data['employees'] = this.employees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Activities {
  int? dayactid;
  int? dayactcatid;
  int? dayactcustid;
  String? dayactdate;
  String? dayactdesc;
  String? dayactloclabel;
  String? dayactloc;
  double? dayactlatitude;
  double? dayactlongitude;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Dayactuser? dayactuser;
  Dayactuser? dayactupdatedby;
  Dayactcust? dayactcust;
  Dayactcat? dayactcat;
  List<Activitycustomfield>? activitycustomfield;
  List<Dayactpics>? dayactpics;

  Activities(
      {this.dayactid,
      this.dayactcatid,
      this.dayactcustid,
      this.dayactdate,
      this.dayactdesc,
      this.dayactloclabel,
      this.dayactloc,
      this.dayactlatitude,
      this.dayactlongitude,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.dayactuser,
      this.dayactupdatedby,
      this.dayactcust,
      this.dayactcat,
      this.activitycustomfield,
      this.dayactpics});

  Activities.fromJson(Map<String, dynamic> json) {
    dayactid = json['dayactid'];
    dayactcatid = json['dayactcatid'];
    dayactcustid = json['dayactcustid'];
    dayactdate = json['dayactdate'];
    dayactdesc = json['dayactdesc'];
    dayactloclabel = json['dayactloclabel'];
    dayactloc = json['dayactloc'];
    dayactlatitude = json['dayactlatitude'];
    dayactlongitude = json['dayactlongitude'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    dayactuser = json['dayactuser'] != null
        ? new Dayactuser.fromJson(json['dayactuser'])
        : null;
    dayactupdatedby = json['dayactupdatedby'] != null
        ? new Dayactuser.fromJson(json['dayactupdatedby'])
        : null;
    dayactcust = json['dayactcust'] != null
        ? new Dayactcust.fromJson(json['dayactcust'])
        : null;
    dayactcat = json['dayactcat'] != null
        ? new Dayactcat.fromJson(json['dayactcat'])
        : null;
    if (json['activitycustomfield'] != null) {
      activitycustomfield = <Activitycustomfield>[];
      json['activitycustomfield'].forEach((v) {
        activitycustomfield!.add(new Activitycustomfield.fromJson(v));
      });
    }
    if (json['dayactpics'] != null) {
      dayactpics = <Dayactpics>[];
      json['dayactpics'].forEach((v) {
        dayactpics!.add(new Dayactpics.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dayactid'] = this.dayactid;
    data['dayactcatid'] = this.dayactcatid;
    data['dayactcustid'] = this.dayactcustid;
    data['dayactdate'] = this.dayactdate;
    data['dayactdesc'] = this.dayactdesc;
    data['dayactloclabel'] = this.dayactloclabel;
    data['dayactloc'] = this.dayactloc;
    data['dayactlatitude'] = this.dayactlatitude;
    data['dayactlongitude'] = this.dayactlongitude;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.dayactuser != null) {
      data['dayactuser'] = this.dayactuser!.toJson();
    }
    if (this.dayactupdatedby != null) {
      data['dayactupdatedby'] = this.dayactupdatedby!.toJson();
    }
    if (this.dayactcust != null) {
      data['dayactcust'] = this.dayactcust!.toJson();
    }
    if (this.dayactcat != null) {
      data['dayactcat'] = this.dayactcat!.toJson();
    }
    if (this.activitycustomfield != null) {
      data['activitycustomfield'] =
          this.activitycustomfield!.map((v) => v.toJson()).toList();
    }
    if (this.dayactpics != null) {
      data['dayactpics'] = this.dayactpics!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dayactuser {
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

  Dayactuser(
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

  Dayactuser.fromJson(Map<String, dynamic> json) {
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

class Dayactcust {
  int? sbcid;
  int? sbcbpid;
  int? sbccstmid;
  int? sbccstmstatusid;
  String? sbccstmname;
  String? sbccstmphone;
  String? sbccstmaddress;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Dayactcust(
      {this.sbcid,
      this.sbcbpid,
      this.sbccstmid,
      this.sbccstmstatusid,
      this.sbccstmname,
      this.sbccstmphone,
      this.sbccstmaddress,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Dayactcust.fromJson(Map<String, dynamic> json) {
    sbcid = json['sbcid'];
    sbcbpid = json['sbcbpid'];
    sbccstmid = json['sbccstmid'];
    sbccstmstatusid = json['sbccstmstatusid'];
    sbccstmname = json['sbccstmname'];
    sbccstmphone = json['sbccstmphone'];
    sbccstmaddress = json['sbccstmaddress'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
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
    return data;
  }
}

class Dayactcat {
  int? sbtid;
  String? sbttypename;

  Dayactcat({this.sbtid, this.sbttypename});

  Dayactcat.fromJson(Map<String, dynamic> json) {
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

class Activitycustomfield {
  int? activitycfid;
  int? activityid;
  int? activitycustfid;
  String? activitycfvalue;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Customfield? customfield;

  Activitycustomfield(
      {this.activitycfid,
      this.activityid,
      this.activitycustfid,
      this.activitycfvalue,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.customfield});

  Activitycustomfield.fromJson(Map<String, dynamic> json) {
    activitycfid = json['activitycfid'];
    activityid = json['activityid'];
    activitycustfid = json['activitycustfid'];
    activitycfvalue = json['activitycfvalue'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    customfield = json['customfield'] != null
        ? new Customfield.fromJson(json['customfield'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activitycfid'] = this.activitycfid;
    data['activityid'] = this.activityid;
    data['activitycustfid'] = this.activitycustfid;
    data['activitycfvalue'] = this.activitycfvalue;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.customfield != null) {
      data['customfield'] = this.customfield!.toJson();
    }
    return data;
  }
}

class Customfield {
  int? custfid;
  int? custfbpid;
  String? custfname;
  int? custftypeid;
  int? custfreftypeid;
  bool? alldata;
  bool? onlythisdata;
  bool? thisdataid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Customfield(
      {this.custfid,
      this.custfbpid,
      this.custfname,
      this.custftypeid,
      this.custfreftypeid,
      this.alldata,
      this.onlythisdata,
      this.thisdataid,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Customfield.fromJson(Map<String, dynamic> json) {
    custfid = json['custfid'];
    custfbpid = json['custfbpid'];
    custfname = json['custfname'];
    custftypeid = json['custftypeid'];
    custfreftypeid = json['custfreftypeid'];
    alldata = json['alldata'];
    onlythisdata = json['onlythisdata'];
    thisdataid = json['thisdataid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custfid'] = this.custfid;
    data['custfbpid'] = this.custfbpid;
    data['custfname'] = this.custfname;
    data['custftypeid'] = this.custftypeid;
    data['custfreftypeid'] = this.custfreftypeid;
    data['alldata'] = this.alldata;
    data['onlythisdata'] = this.onlythisdata;
    data['thisdataid'] = this.thisdataid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}

class Dayactpics {
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

  Dayactpics(
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

  Dayactpics.fromJson(Map<String, dynamic> json) {
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
