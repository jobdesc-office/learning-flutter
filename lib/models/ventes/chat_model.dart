class ChatModel {
  int? chatid;
  int? chatbpid;
  String? chatmessage;
  int? chatreftypeid;
  int? chatrefid;
  Chatfile? chatfile;
  String? chatreadat;
  int? chatreceiverid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Chatbp? chatbp;
  Chatreceiver? chatreceiver;
  Chatreftype? chatreftype;
  Createdbyuser? createdbyuser;
  Refactivity? refactivity;
  Refprospect? refprospect;

  ChatModel(
      {this.chatid,
      this.chatbpid,
      this.chatmessage,
      this.chatreftypeid,
      this.chatrefid,
      this.chatfile,
      this.chatreadat,
      this.chatreceiverid,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.chatbp,
      this.chatreceiver,
      this.chatreftype,
      this.createdbyuser,
      this.refactivity,
      this.refprospect});

  ChatModel.fromJson(Map<String, dynamic> json) {
    chatid = json['chatid'];
    chatbpid = json['chatbpid'];
    chatmessage = json['chatmessage'];
    chatreftypeid = json['chatreftypeid'];
    chatrefid = json['chatrefid'];
    chatfile = json['chatfile'] != null
        ? new Chatfile.fromJson(json['chatfile'])
        : null;
    chatreadat = json['chatreadat'];
    chatreceiverid = json['chatreceiverid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    chatbp =
        json['chatbp'] != null ? new Chatbp.fromJson(json['chatbp']) : null;
    chatreceiver = json['chatreceiver'] != null
        ? new Chatreceiver.fromJson(json['chatreceiver'])
        : null;
    chatreftype = json['chatreftype'] != null
        ? new Chatreftype.fromJson(json['chatreftype'])
        : null;
    createdbyuser = json['createdbyuser'] != null
        ? new Createdbyuser.fromJson(json['createdbyuser'])
        : null;
    refactivity = json['refactivity'] != null
        ? new Refactivity.fromJson(json['refactivity'])
        : null;
    refprospect = json['refprospect'] != null
        ? new Refprospect.fromJson(json['refprospect'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatid'] = this.chatid;
    data['chatbpid'] = this.chatbpid;
    data['chatmessage'] = this.chatmessage;
    data['chatreftypeid'] = this.chatreftypeid;
    data['chatrefid'] = this.chatrefid;
    if (this.chatfile != null) {
      data['chatfile'] = this.chatfile!.toJson();
    }
    data['chatreadat'] = this.chatreadat;
    data['chatreceiverid'] = this.chatreceiverid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.chatbp != null) {
      data['chatbp'] = this.chatbp!.toJson();
    }
    if (this.chatreceiver != null) {
      data['chatreceiver'] = this.chatreceiver!.toJson();
    }
    if (this.chatreftype != null) {
      data['chatreftype'] = this.chatreftype!.toJson();
    }
    if (this.createdbyuser != null) {
      data['createdbyuser'] = this.createdbyuser!.toJson();
    }
    if (this.refactivity != null) {
      data['refactivity'] = this.refactivity!.toJson();
    }
    if (this.refprospect != null) {
      data['refprospect'] = this.refprospect!.toJson();
    }
    return data;
  }
}

class Chatfile {
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

  Chatfile(
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

  Chatfile.fromJson(Map<String, dynamic> json) {
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

class Chatbp {
  int? bpid;
  String? bpname;
  int? bptypeid;
  String? bppicname;
  String? bpemail;
  String? bpphone;
  bool? bpactanytime;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Chatbp(
      {this.bpid,
      this.bpname,
      this.bptypeid,
      this.bppicname,
      this.bpemail,
      this.bpphone,
      this.bpactanytime,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Chatbp.fromJson(Map<String, dynamic> json) {
    bpid = json['bpid'];
    bpname = json['bpname'];
    bptypeid = json['bptypeid'];
    bppicname = json['bppicname'];
    bpemail = json['bpemail'];
    bpphone = json['bpphone'];
    bpactanytime = json['bpactanytime'];
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
    data['bpactanytime'] = this.bpactanytime;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}

class Chatreceiver {
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

  Chatreceiver(
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

  Chatreceiver.fromJson(Map<String, dynamic> json) {
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

class Chatreftype {
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

  Chatreftype(
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
      this.isactive});

  Chatreftype.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Createdbyuser {
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

  Createdbyuser(
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

  Createdbyuser.fromJson(Map<String, dynamic> json) {
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

class Refactivity {
  int? dayactid;
  int? dayactcatid;
  int? dayactcustid;
  int? dayactrefid;
  int? dayactreftypeid;
  String? dayactdate;
  String? dayactdesc;
  String? dayactloclabel;
  String? dayactloc;
  String? dayactaddress;
  double? dayactlatitude;
  double? dayactlongitude;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Chatreceiver? dayactuser;
  Dayactreftype? dayactreftype;
  Dayactcust? dayactcust;
  Dayactcat? dayactcat;

  Refactivity(
      {this.dayactid,
      this.dayactcatid,
      this.dayactcustid,
      this.dayactrefid,
      this.dayactreftypeid,
      this.dayactdate,
      this.dayactdesc,
      this.dayactloclabel,
      this.dayactloc,
      this.dayactaddress,
      this.dayactlatitude,
      this.dayactlongitude,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.dayactuser,
      this.dayactreftype,
      this.dayactcust,
      this.dayactcat});

  Refactivity.fromJson(Map<String, dynamic> json) {
    dayactid = json['dayactid'];
    dayactcatid = json['dayactcatid'];
    dayactcustid = json['dayactcustid'];
    dayactrefid = json['dayactrefid'];
    dayactreftypeid = json['dayactreftypeid'];
    dayactdate = json['dayactdate'];
    dayactdesc = json['dayactdesc'];
    dayactloclabel = json['dayactloclabel'];
    dayactloc = json['dayactloc'];
    dayactaddress = json['dayactaddress'];
    dayactlatitude = json['dayactlatitude'];
    dayactlongitude = json['dayactlongitude'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    dayactuser = json['dayactuser'] != null
        ? new Chatreceiver.fromJson(json['dayactuser'])
        : null;
    dayactreftype = json['dayactreftype'] != null
        ? new Dayactreftype.fromJson(json['dayactreftype'])
        : null;
    dayactcust = json['dayactcust'] != null
        ? new Dayactcust.fromJson(json['dayactcust'])
        : null;
    dayactcat = json['dayactcat'] != null
        ? new Dayactcat.fromJson(json['dayactcat'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dayactid'] = this.dayactid;
    data['dayactcatid'] = this.dayactcatid;
    data['dayactcustid'] = this.dayactcustid;
    data['dayactrefid'] = this.dayactrefid;
    data['dayactreftypeid'] = this.dayactreftypeid;
    data['dayactdate'] = this.dayactdate;
    data['dayactdesc'] = this.dayactdesc;
    data['dayactloclabel'] = this.dayactloclabel;
    data['dayactloc'] = this.dayactloc;
    data['dayactaddress'] = this.dayactaddress;
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
    if (this.dayactreftype != null) {
      data['dayactreftype'] = this.dayactreftype!.toJson();
    }
    if (this.dayactcust != null) {
      data['dayactcust'] = this.dayactcust!.toJson();
    }
    if (this.dayactcat != null) {
      data['dayactcat'] = this.dayactcat!.toJson();
    }
    return data;
  }
}

class Dayactreftype {
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

  Dayactreftype(
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
      this.isactive});

  Dayactreftype.fromJson(Map<String, dynamic> json) {
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

class Refprospect {
  int? prospectid;
  String? prospectname;
  String? prospectcode;
  String? prospectstartdate;
  String? prospectenddate;
  String? prospectvalue;
  int? prospectowner;
  int? prospectstageid;
  int? prospectstatusid;
  String? prospectexpclosedate;
  int? prospectbpid;
  String? prospectdescription;
  int? prospectcustid;
  int? prospectrefid;
  int? prospectlostreasonid;
  String? prospectlostdesc;
  int? prospectcustlabel;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Prospectcust? prospectcust;

  Refprospect(
      {this.prospectid,
      this.prospectname,
      this.prospectcode,
      this.prospectstartdate,
      this.prospectenddate,
      this.prospectvalue,
      this.prospectowner,
      this.prospectstageid,
      this.prospectstatusid,
      this.prospectexpclosedate,
      this.prospectbpid,
      this.prospectdescription,
      this.prospectcustid,
      this.prospectrefid,
      this.prospectlostreasonid,
      this.prospectlostdesc,
      this.prospectcustlabel,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.prospectcust});

  Refprospect.fromJson(Map<String, dynamic> json) {
    prospectid = json['prospectid'];
    prospectname = json['prospectname'];
    prospectcode = json['prospectcode'];
    prospectstartdate = json['prospectstartdate'];
    prospectenddate = json['prospectenddate'];
    prospectvalue = json['prospectvalue'];
    prospectowner = json['prospectowner'];
    prospectstageid = json['prospectstageid'];
    prospectstatusid = json['prospectstatusid'];
    prospectexpclosedate = json['prospectexpclosedate'];
    prospectbpid = json['prospectbpid'];
    prospectdescription = json['prospectdescription'];
    prospectcustid = json['prospectcustid'];
    prospectrefid = json['prospectrefid'];
    prospectlostreasonid = json['prospectlostreasonid'];
    prospectlostdesc = json['prospectlostdesc'];
    prospectcustlabel = json['prospectcustlabel'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    prospectcust = json['prospectcust'] != null
        ? new Prospectcust.fromJson(json['prospectcust'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prospectid'] = this.prospectid;
    data['prospectname'] = this.prospectname;
    data['prospectcode'] = this.prospectcode;
    data['prospectstartdate'] = this.prospectstartdate;
    data['prospectenddate'] = this.prospectenddate;
    data['prospectvalue'] = this.prospectvalue;
    data['prospectowner'] = this.prospectowner;
    data['prospectstageid'] = this.prospectstageid;
    data['prospectstatusid'] = this.prospectstatusid;
    data['prospectexpclosedate'] = this.prospectexpclosedate;
    data['prospectbpid'] = this.prospectbpid;
    data['prospectdescription'] = this.prospectdescription;
    data['prospectcustid'] = this.prospectcustid;
    data['prospectrefid'] = this.prospectrefid;
    data['prospectlostreasonid'] = this.prospectlostreasonid;
    data['prospectlostdesc'] = this.prospectlostdesc;
    data['prospectcustlabel'] = this.prospectcustlabel;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.prospectcust != null) {
      data['prospectcust'] = this.prospectcust!.toJson();
    }
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
