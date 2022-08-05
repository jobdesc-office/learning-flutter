class ReportModel {
  List<Activities>? activities;
  List<Employees>? employees;

  ReportModel({this.activities, this.employees});

  ReportModel.fromJson(Map<String, dynamic> json) {
    if (json['activities'] != null) {
      activities = <Activities>[];
      json['activities'].forEach((v) {
        activities!.add(new Activities.fromJson(v));
      });
    }
    if (json['employees'] != null) {
      employees = <Employees>[];
      json['employees'].forEach((v) {
        employees!.add(new Employees.fromJson(v));
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
  int? dayacttypeid;
  String? dayacttypevalue;
  String? dayactdate;
  String? dayactdesc;
  String? dayactloc;
  double? dayactlatitude;
  double? dayactlongitude;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  int? userdtid;
  int? userid;
  int? userdttypeid;
  int? userdtbpid;
  int? userdtbranchnm;
  int? userdtreferalcode;
  int? userdtrelationid;
  String? username;
  String? userpassword;
  String? userfullname;
  String? useremail;
  String? userphone;
  int? userdeviceid;
  int? userfcmtoken;
  int? usersocketid;
  Dayactcat? dayactcat;
  Dayactcat? dayacttype;
  Dayactpics? dayactpics;

  Activities(
      {this.dayactid,
      this.dayactcatid,
      this.dayacttypeid,
      this.dayacttypevalue,
      this.dayactdate,
      this.dayactdesc,
      this.dayactloc,
      this.dayactlatitude,
      this.dayactlongitude,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.userdtid,
      this.userid,
      this.userdttypeid,
      this.userdtbpid,
      this.userdtbranchnm,
      this.userdtreferalcode,
      this.userdtrelationid,
      this.username,
      this.userpassword,
      this.userfullname,
      this.useremail,
      this.userphone,
      this.userdeviceid,
      this.userfcmtoken,
      this.usersocketid,
      this.dayactcat,
      this.dayacttype,
      this.dayactpics});

  Activities.fromJson(Map<String, dynamic> json) {
    dayactid = json['dayactid'];
    dayactcatid = json['dayactcatid'];
    dayacttypeid = json['dayacttypeid'];
    dayacttypevalue = json['dayacttypevalue'];
    dayactdate = json['dayactdate'];
    dayactdesc = json['dayactdesc'];
    dayactloc = json['dayactloc'];
    dayactlatitude = json['dayactlatitude'];
    dayactlongitude = json['dayactlongitude'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    userdtid = json['userdtid'];
    userid = json['userid'];
    userdttypeid = json['userdttypeid'];
    userdtbpid = json['userdtbpid'];
    userdtbranchnm = json['userdtbranchnm'];
    userdtreferalcode = json['userdtreferalcode'];
    userdtrelationid = json['userdtrelationid'];
    username = json['username'];
    userpassword = json['userpassword'];
    userfullname = json['userfullname'];
    useremail = json['useremail'];
    userphone = json['userphone'];
    userdeviceid = json['userdeviceid'];
    userfcmtoken = json['userfcmtoken'];
    usersocketid = json['usersocketid'];
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
    data['dayacttypeid'] = this.dayacttypeid;
    data['dayacttypevalue'] = this.dayacttypevalue;
    data['dayactdate'] = this.dayactdate;
    data['dayactdesc'] = this.dayactdesc;
    data['dayactloc'] = this.dayactloc;
    data['dayactlatitude'] = this.dayactlatitude;
    data['dayactlongitude'] = this.dayactlongitude;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    data['userdtid'] = this.userdtid;
    data['userid'] = this.userid;
    data['userdttypeid'] = this.userdttypeid;
    data['userdtbpid'] = this.userdtbpid;
    data['userdtbranchnm'] = this.userdtbranchnm;
    data['userdtreferalcode'] = this.userdtreferalcode;
    data['userdtrelationid'] = this.userdtrelationid;
    data['username'] = this.username;
    data['userpassword'] = this.userpassword;
    data['userfullname'] = this.userfullname;
    data['useremail'] = this.useremail;
    data['userphone'] = this.userphone;
    data['userdeviceid'] = this.userdeviceid;
    data['userfcmtoken'] = this.userfcmtoken;
    data['usersocketid'] = this.usersocketid;
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

class Employees {
  int? userid;
  String? userfullname;

  Employees({this.userid, this.userfullname});

  Employees.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    userfullname = json['userfullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['userfullname'] = this.userfullname;
    return data;
  }
}
