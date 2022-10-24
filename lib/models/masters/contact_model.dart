class ContactModel {
  int? contactpersonid;
  int? contactbpcustomerid;
  int? contacttypeid;
  String? contactname;
  String? contactvalueid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Contactcreatedby? contactcreatedby;
  Contactcreatedby? contactupdatedby;
  Contactcustomer? contactcustomer;
  Contacttype? contacttype;

  ContactModel(
      {this.contactpersonid,
      this.contactbpcustomerid,
      this.contacttypeid,
      this.contactname,
      this.contactvalueid,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.contactcreatedby,
      this.contactupdatedby,
      this.contactcustomer,
      this.contacttype});

  ContactModel.fromJson(Map<String, dynamic> json) {
    contactpersonid = json['contactpersonid'];
    contactbpcustomerid = json['contactbpcustomerid'];
    contacttypeid = json['contacttypeid'];
    contactname = json['contactname'];
    contactvalueid = json['contactvalueid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    contactcreatedby = json['contactcreatedby'] != null
        ? new Contactcreatedby.fromJson(json['contactcreatedby'])
        : null;
    contactupdatedby = json['contactupdatedby'] != null
        ? new Contactcreatedby.fromJson(json['contactupdatedby'])
        : null;
    contactcustomer = json['contactcustomer'] != null
        ? new Contactcustomer.fromJson(json['contactcustomer'])
        : null;
    contacttype = json['contacttype'] != null
        ? new Contacttype.fromJson(json['contacttype'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contactpersonid'] = this.contactpersonid;
    data['contactbpcustomerid'] = this.contactbpcustomerid;
    data['contacttypeid'] = this.contacttypeid;
    data['contactname'] = this.contactname;
    data['contactvalueid'] = this.contactvalueid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.contactcreatedby != null) {
      data['contactcreatedby'] = this.contactcreatedby!.toJson();
    }
    if (this.contactupdatedby != null) {
      data['contactupdatedby'] = this.contactupdatedby!.toJson();
    }
    if (this.contactcustomer != null) {
      data['contactcustomer'] = this.contactcustomer!.toJson();
    }
    if (this.contacttype != null) {
      data['contacttype'] = this.contacttype!.toJson();
    }
    return data;
  }
}

class Contactcreatedby {
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

  Contactcreatedby(
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

  Contactcreatedby.fromJson(Map<String, dynamic> json) {
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

class Contactcustomer {
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

  Contactcustomer(
      {this.sbcid,
      this.sbcbpid,
      this.sbccstmid,
      this.sbccstmstatusid,
      this.sbcactivitytypeid,
      this.sbccstmname,
      this.sbccstmphone,
      this.sbccstmaddress,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Contactcustomer.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sbcid'] = this.sbcid;
    data['sbcbpid'] = this.sbcbpid;
    data['sbccstmid'] = this.sbccstmid;
    data['sbccstmstatusid'] = this.sbccstmstatusid;
    data['sbcactivitytypeid'] = this.sbcactivitytypeid;
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

class Contacttype {
  int? sbtid;
  String? sbttypename;

  Contacttype({this.sbtid, this.sbttypename});

  Contacttype.fromJson(Map<String, dynamic> json) {
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
