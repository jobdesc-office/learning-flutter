class ContactModel {
  int? contactpersonid;
  int? contactcustomerid;
  int? contacttypeid;
  String? contactvalueid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Contactcustomer? contactcustomer;
  Contacttype? contacttype;

  ContactModel(
      {this.contactpersonid,
      this.contactcustomerid,
      this.contacttypeid,
      this.contactvalueid,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.contactcustomer,
      this.contacttype});

  ContactModel.fromJson(Map<String, dynamic> json) {
    contactpersonid = json['contactpersonid'];
    contactcustomerid = json['contactcustomerid'];
    contacttypeid = json['contacttypeid'];
    contactvalueid = json['contactvalueid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
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
    data['contactcustomerid'] = this.contactcustomerid;
    data['contacttypeid'] = this.contacttypeid;
    data['contactvalueid'] = this.contactvalueid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.contactcustomer != null) {
      data['contactcustomer'] = this.contactcustomer!.toJson();
    }
    if (this.contacttype != null) {
      data['contacttype'] = this.contacttype!.toJson();
    }
    return data;
  }
}

class Contactcustomer {
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
  Null? referalcode;
  Null? createdby;
  String? createddate;
  Null? updatedby;
  String? updateddate;
  bool? isactive;

  Contactcustomer(
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

  Contactcustomer.fromJson(Map<String, dynamic> json) {
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

class Contacttype {
  int? typeid;
  String? typename;

  Contacttype({this.typeid, this.typename});

  Contacttype.fromJson(Map<String, dynamic> json) {
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
