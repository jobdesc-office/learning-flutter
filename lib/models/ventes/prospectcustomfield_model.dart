class ProspectCustomFieldModel {
  int? prospectcfid;
  int? prospectid;
  int? prospectcustfid;
  String? prospectcfvalue;
  int? optchoosed;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Customfield? customfield;
  Prospect? prospect;
  Selectedoption? selectedoption;

  ProspectCustomFieldModel(
      {this.prospectcfid,
      this.prospectid,
      this.prospectcustfid,
      this.prospectcfvalue,
      this.optchoosed,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.customfield,
      this.prospect,
      this.selectedoption});

  ProspectCustomFieldModel.fromJson(Map<String, dynamic> json) {
    prospectcfid = json['prospectcfid'];
    prospectid = json['prospectid'];
    prospectcustfid = json['prospectcustfid'];
    prospectcfvalue = json['prospectcfvalue'];
    optchoosed = json['optchoosed'];
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
    selectedoption = json['selectedoption'] != null
        ? new Selectedoption.fromJson(json['selectedoption'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prospectcfid'] = this.prospectcfid;
    data['prospectid'] = this.prospectid;
    data['prospectcustfid'] = this.prospectcustfid;
    data['prospectcfvalue'] = this.prospectcfvalue;
    data['optchoosed'] = this.optchoosed;
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
    if (this.selectedoption != null) {
      data['selectedoption'] = this.selectedoption!.toJson();
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
  int? thisdataid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Custftype? custftype;

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
      this.isactive,
      this.custftype});

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
    custftype = json['custftype'] != null
        ? new Custftype.fromJson(json['custftype'])
        : null;
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
    if (this.custftype != null) {
      data['custftype'] = this.custftype!.toJson();
    }
    return data;
  }
}

class Custftype {
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

  Custftype(
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

  Custftype.fromJson(Map<String, dynamic> json) {
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

class Prospect {
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

  Prospect(
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
      this.isactive});

  Prospect.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Selectedoption {
  int? optid;
  int? custfid;
  String? optvalue;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Selectedoption(
      {this.optid,
      this.custfid,
      this.optvalue,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Selectedoption.fromJson(Map<String, dynamic> json) {
    optid = json['optid'];
    custfid = json['custfid'];
    optvalue = json['optvalue'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['optid'] = this.optid;
    data['custfid'] = this.custfid;
    data['optvalue'] = this.optvalue;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}
