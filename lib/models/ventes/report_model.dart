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
  int? dayacttypeid;
  String? dayacttypevalue;
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
  Dayactcat? dayacttype;
  Dayactpics? dayactpics;

  Activities(
      {this.dayactid,
      this.dayactcatid,
      this.dayactcustid,
      this.dayacttypeid,
      this.dayacttypevalue,
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
      this.dayactcust,
      this.dayactcat,
      this.dayacttype,
      this.dayactpics});

  Activities.fromJson(Map<String, dynamic> json) {
    dayactid = json['dayactid'];
    dayactcatid = json['dayactcatid'];
    dayactcustid = json['dayactcustid'];
    dayacttypeid = json['dayacttypeid'];
    dayacttypevalue = json['dayacttypevalue'];
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
    dayacttype = json['dayacttype'] != null
        ? new Dayactcat.fromJson(json['dayacttype'])
        : null;
    dayactpics = json['dayactpics'] != null
        ? new Dayactpics.fromJson(json['dayactpics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dayactid'] = this.dayactid;
    data['dayactcatid'] = this.dayactcatid;
    data['dayactcustid'] = this.dayactcustid;
    data['dayacttypeid'] = this.dayacttypeid;
    data['dayacttypevalue'] = this.dayacttypevalue;
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
    if (this.dayacttype != null) {
      data['dayacttype'] = this.dayacttype!.toJson();
    }
    if (this.dayactpics != null) {
      data['dayactpics'] = this.dayactpics!.toJson();
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
  int? referalcode;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Dayactcust(
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

  Dayactcust.fromJson(Map<String, dynamic> json) {
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

class Dayactcat {
  int? typeid;
  String? typename;

  Dayactcat({this.typeid, this.typename});

  Dayactcat.fromJson(Map<String, dynamic> json) {
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

class Dayactpics {
  int? fileid;
  int? transtypeid;
  int? refid;
  String? directories;
  String? filename;
  String? mimetype;
  String? filesize;
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
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    data['url'] = this.url;
    return data;
  }
}
