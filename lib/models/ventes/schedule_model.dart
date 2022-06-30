import 'package:flutter/material.dart';

class ScheduleModel {
  int? scheid;
  String? schenm;
  String? schestartdate;
  String? scheenddate;
  String? schestarttime;
  String? scheendtime;
  int? schetypeid;
  String? scheactdate;
  int? schetowardid;
  int? schebpid;
  int? schereftypeid;
  int? scherefid;
  bool? scheallday;
  String? scheloc;
  bool? scheprivate;
  bool? scheonline;
  String? schetz;
  int? scheremind;
  String? schedesc;
  String? scheonlink;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Schetype? schetype;
  List<Scheguest>? scheguest;
  Schebp? schebp;
  Schetoward? schetoward;
  Color? bg;

  ScheduleModel(
      {this.scheid,
      this.schenm,
      this.schestartdate,
      this.scheenddate,
      this.schestarttime,
      this.scheendtime,
      this.schetypeid,
      this.scheactdate,
      this.schetowardid,
      this.schebpid,
      this.schereftypeid,
      this.scherefid,
      this.scheallday,
      this.scheloc,
      this.scheprivate,
      this.scheonline,
      this.schetz,
      this.scheremind,
      this.schedesc,
      this.scheonlink,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.schetype,
      this.scheguest,
      this.schebp,
      this.schetoward,
      this.bg});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    scheid = json['scheid'];
    schenm = json['schenm'];
    schestartdate = json['schestartdate'];
    scheenddate = json['scheenddate'];
    schestarttime = json['schestarttime'];
    scheendtime = json['scheendtime'];
    schetypeid = json['schetypeid'];
    scheactdate = json['scheactdate'];
    schetowardid = json['schetowardid'];
    schebpid = json['schebpid'];
    schereftypeid = json['schereftypeid'];
    scherefid = json['scherefid'];
    scheallday = json['scheallday'];
    scheloc = json['scheloc'];
    scheprivate = json['scheprivate'];
    scheonline = json['scheonline'];
    schetz = json['schetz'];
    scheremind = json['scheremind'];
    schedesc = json['schedesc'];
    scheonlink = json['scheonlink'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    schetype = json['schetype'] != null
        ? new Schetype.fromJson(json['schetype'])
        : null;
    if (json['scheguest'] != null) {
      scheguest = <Scheguest>[];
      json['scheguest'].forEach((v) {
        scheguest!.add(new Scheguest.fromJson(v));
      });
    }
    schebp =
        json['schebp'] != null ? new Schebp.fromJson(json['schebp']) : null;
    schetoward = json['schetoward'] != null
        ? new Schetoward.fromJson(json['schetoward'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheid'] = this.scheid;
    data['schenm'] = this.schenm;
    data['schestartdate'] = this.schestartdate;
    data['scheenddate'] = this.scheenddate;
    data['schestarttime'] = this.schestarttime;
    data['scheendtime'] = this.scheendtime;
    data['schetypeid'] = this.schetypeid;
    data['scheactdate'] = this.scheactdate;
    data['schetowardid'] = this.schetowardid;
    data['schebpid'] = this.schebpid;
    data['schereftypeid'] = this.schereftypeid;
    data['scherefid'] = this.scherefid;
    data['scheallday'] = this.scheallday;
    data['scheloc'] = this.scheloc;
    data['scheprivate'] = this.scheprivate;
    data['scheonline'] = this.scheonline;
    data['schetz'] = this.schetz;
    data['scheremind'] = this.scheremind;
    data['schedesc'] = this.schedesc;
    data['scheonlink'] = this.scheonlink;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.schetype != null) {
      data['schetype'] = this.schetype!.toJson();
    }
    if (this.scheguest != null) {
      data['scheguest'] = this.scheguest!.map((v) => v.toJson()).toList();
    }
    if (this.schebp != null) {
      data['schebp'] = this.schebp!.toJson();
    }
    if (this.schetoward != null) {
      data['schetoward'] = this.schetoward!.toJson();
    }
    return data;
  }
}

class Schetype {
  int? typeid;
  String? typename;

  Schetype({this.typeid, this.typename});

  Schetype.fromJson(Map<String, dynamic> json) {
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

class Scheguest {
  int? scheguestid;
  int? scheid;
  int? scheuserid;
  int? schebpid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  String? schepermisid;
  Scheuser? scheuser;
  Schebp? schebp;

  Scheguest(
      {this.scheguestid,
      this.scheid,
      this.scheuserid,
      this.schebpid,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.schepermisid,
      this.scheuser,
      this.schebp});

  Scheguest.fromJson(Map<String, dynamic> json) {
    scheguestid = json['scheguestid'];
    scheid = json['scheid'];
    scheuserid = json['scheuserid'];
    schebpid = json['schebpid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    schepermisid = json['schepermisid'];
    scheuser = json['scheuser'] != null
        ? new Scheuser.fromJson(json['scheuser'])
        : null;
    schebp =
        json['schebp'] != null ? new Schebp.fromJson(json['schebp']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheguestid'] = this.scheguestid;
    data['scheid'] = this.scheid;
    data['scheuserid'] = this.scheuserid;
    data['schebpid'] = this.schebpid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    data['schepermisid'] = this.schepermisid;
    if (this.scheuser != null) {
      data['scheuser'] = this.scheuser!.toJson();
    }
    if (this.schebp != null) {
      data['schebp'] = this.schebp!.toJson();
    }
    return data;
  }
}

class Scheuser {
  int? userid;
  String? username;
  String? userpassword;
  String? userfullname;
  String? useremail;
  String? userphone;
  String? userdeviceid;
  String? userfcmtoken;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Scheuser(
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

  Scheuser.fromJson(Map<String, dynamic> json) {
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

class Schebp {
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

  Schebp(
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

  Schebp.fromJson(Map<String, dynamic> json) {
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

class Schebpartner {
  int? bpid;
  String? bpname;

  Schebpartner({this.bpid, this.bpname});

  Schebpartner.fromJson(Map<String, dynamic> json) {
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

class Schetoward {
  int? userid;
  String? userfullname;

  Schetoward({this.userid, this.userfullname});

  Schetoward.fromJson(Map<String, dynamic> json) {
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
