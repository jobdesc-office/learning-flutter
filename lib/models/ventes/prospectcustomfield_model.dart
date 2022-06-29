class ProspectCustomFieldModel {
  int? prospectcfid;
  int? prospectid;
  int? prospectcustfid;
  String? prospectcfvalue;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Customfield? customfield;
  Prospect? prospect;

  ProspectCustomFieldModel(
      {this.prospectcfid,
      this.prospectid,
      this.prospectcustfid,
      this.prospectcfvalue,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.customfield,
      this.prospect});

  ProspectCustomFieldModel.fromJson(Map<String, dynamic> json) {
    prospectcfid = json['prospectcfid'];
    prospectid = json['prospectid'];
    prospectcustfid = json['prospectcustfid'];
    prospectcfvalue = json['prospectcfvalue'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    customfield = json['customfield'] != null
        ? new Customfield.fromJson(json['customfield'])
        : null;
    prospect = json['prospect'] != null
        ? new Prospect.fromJson(json['prospect'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prospectcfid'] = this.prospectcfid;
    data['prospectid'] = this.prospectid;
    data['prospectcustfid'] = this.prospectcustfid;
    data['prospectcfvalue'] = this.prospectcfvalue;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.customfield != null) {
      data['customfield'] = this.customfield!.toJson();
    }
    if (this.prospect != null) {
      data['prospect'] = this.prospect!.toJson();
    }
    return data;
  }
}

class Customfield {
  int? custfid;
  int? custfbpid;
  String? custfname;
  int? custftypeid;
  bool? isvisiblesidebar;
  bool? onlyinnewprospect;
  int? lastprospectid;
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
      this.isvisiblesidebar,
      this.onlyinnewprospect,
      this.lastprospectid,
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
    isvisiblesidebar = json['isvisiblesidebar'];
    onlyinnewprospect = json['onlyinnewprospect'];
    lastprospectid = json['lastprospectid'];
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
    data['isvisiblesidebar'] = this.isvisiblesidebar;
    data['onlyinnewprospect'] = this.onlyinnewprospect;
    data['lastprospectid'] = this.lastprospectid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}

class Prospect {
  int? prospectid;
  String? prospectname;
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
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Prospect(
      {this.prospectid,
      this.prospectname,
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
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Prospect.fromJson(Map<String, dynamic> json) {
    prospectid = json['prospectid'];
    prospectname = json['prospectname'];
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
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
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
    return data;
  }
}
