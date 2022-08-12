import 'package:boilerplate/models/masters/type_model.dart';

import 'prospectcustomfield_model.dart';

class ProspectModel {
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
  List<Prospectassigns>? prospectassigns;
  List<Prospectproduct>? prospectproduct;
  TypeModel? prospectstage;
  Prospectlost? prospectlost;
  Prospectlost? prospectcustlabeltype;
  Prospectownerusers? prospectownerusers;
  Prospectlost? prospectstatus;
  Prospectlost? prospectlostreason;
  Prospectreference? prospectreference;
  Prospectby? prospectby;
  Prospectbp? prospectbp;
  List<ProspectCustomFieldModel>? prospectcustomfield;
  Prospectcust? prospectcust;
  List<Prospectfiles>? prospectfiles;

  ProspectModel(
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
      this.prospectassigns,
      this.prospectproduct,
      this.prospectstage,
      this.prospectlost,
      this.prospectcustlabeltype,
      this.prospectownerusers,
      this.prospectstatus,
      this.prospectlostreason,
      this.prospectreference,
      this.prospectby,
      this.prospectbp,
      this.prospectcustomfield,
      this.prospectcust,
      this.prospectfiles});

  ProspectModel.fromJson(Map<String, dynamic> json) {
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
    if (json['prospectassigns'] != null) {
      prospectassigns = <Prospectassigns>[];
      json['prospectassigns'].forEach((v) {
        prospectassigns!.add(new Prospectassigns.fromJson(v));
      });
    }
    if (json['prospectproduct'] != null) {
      prospectproduct = <Prospectproduct>[];
      json['prospectproduct'].forEach((v) {
        prospectproduct!.add(new Prospectproduct.fromJson(v));
      });
    }
    prospectstage = json['prospectstage'] != null
        ? new TypeModel.fromJson(json['prospectstage'])
        : null;
    prospectlost = json['prospectlost'] != null
        ? new Prospectlost.fromJson(json['prospectlost'])
        : null;
    prospectcustlabeltype = json['prospectcustlabeltype'] != null
        ? new Prospectlost.fromJson(json['prospectcustlabeltype'])
        : null;
    prospectownerusers = json['prospectownerusers'] != null
        ? new Prospectownerusers.fromJson(json['prospectownerusers'])
        : null;
    prospectstatus = json['prospectstatus'] != null
        ? new Prospectlost.fromJson(json['prospectstatus'])
        : null;
    prospectlostreason = json['prospectlostreason'] != null
        ? new Prospectlost.fromJson(json['prospectlostreason'])
        : null;
    prospectreference = json['prospectreference'] != null
        ? new Prospectreference.fromJson(json['prospectreference'])
        : null;
    prospectby = json['prospectby'] != null
        ? new Prospectby.fromJson(json['prospectby'])
        : null;
    prospectbp = json['prospectbp'] != null
        ? new Prospectbp.fromJson(json['prospectbp'])
        : null;
    if (json['prospectcustomfield'] != null) {
      prospectcustomfield = <ProspectCustomFieldModel>[];
      json['prospectcustomfield'].forEach((v) {
        prospectcustomfield!.add(new ProspectCustomFieldModel.fromJson(v));
      });
    }
    prospectcust = json['prospectcust'] != null
        ? new Prospectcust.fromJson(json['prospectcust'])
        : null;
    if (json['prospectfiles'] != null) {
      prospectfiles = <Prospectfiles>[];
      json['prospectfiles'].forEach((v) {
        prospectfiles!.add(new Prospectfiles.fromJson(v));
      });
    }
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
    if (this.prospectassigns != null) {
      data['prospectassigns'] =
          this.prospectassigns!.map((v) => v.toJson()).toList();
    }
    if (this.prospectproduct != null) {
      data['prospectproduct'] =
          this.prospectproduct!.map((v) => v.toJson()).toList();
    }
    if (this.prospectstage != null) {
      data['prospectstage'] = this.prospectstage!.toJson();
    }
    if (this.prospectlost != null) {
      data['prospectlost'] = this.prospectlost!.toJson();
    }
    if (this.prospectcustlabeltype != null) {
      data['prospectcustlabeltype'] = this.prospectcustlabeltype!.toJson();
    }
    if (this.prospectownerusers != null) {
      data['prospectownerusers'] = this.prospectownerusers!.toJson();
    }
    if (this.prospectstatus != null) {
      data['prospectstatus'] = this.prospectstatus!.toJson();
    }
    if (this.prospectlostreason != null) {
      data['prospectlostreason'] = this.prospectlostreason!.toJson();
    }
    if (this.prospectreference != null) {
      data['prospectreference'] = this.prospectreference!.toJson();
    }
    if (this.prospectby != null) {
      data['prospectby'] = this.prospectby!.toJson();
    }
    if (this.prospectbp != null) {
      data['prospectbp'] = this.prospectbp!.toJson();
    }
    if (this.prospectcustomfield != null) {
      data['prospectcustomfield'] =
          this.prospectcustomfield!.map((v) => v.toJson()).toList();
    }
    if (this.prospectcust != null) {
      data['prospectcust'] = this.prospectcust!.toJson();
    }
    if (this.prospectfiles != null) {
      data['prospectfiles'] =
          this.prospectfiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Prospectassigns {
  int? prospectassignid;
  int? prospectid;
  int? prospectassignto;
  int? prospectreportto;
  String? prospectassigndesc;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Prospectassignss? prospectassignss;
  Prospectassignss? prospectreportss;

  Prospectassigns(
      {this.prospectassignid,
      this.prospectid,
      this.prospectassignto,
      this.prospectreportto,
      this.prospectassigndesc,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.prospectassignss,
      this.prospectreportss});

  Prospectassigns.fromJson(Map<String, dynamic> json) {
    prospectassignid = json['prospectassignid'];
    prospectid = json['prospectid'];
    prospectassignto = json['prospectassignto'];
    prospectreportto = json['prospectreportto'];
    prospectassigndesc = json['prospectassigndesc'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    prospectassignss = json['prospectassignss'] != null
        ? new Prospectassignss.fromJson(json['prospectassignss'])
        : null;
    prospectreportss = json['prospectreportss'] != null
        ? new Prospectassignss.fromJson(json['prospectreportss'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prospectassignid'] = this.prospectassignid;
    data['prospectid'] = this.prospectid;
    data['prospectassignto'] = this.prospectassignto;
    data['prospectreportto'] = this.prospectreportto;
    data['prospectassigndesc'] = this.prospectassigndesc;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.prospectassignss != null) {
      data['prospectassignss'] = this.prospectassignss!.toJson();
    }
    if (this.prospectreportss != null) {
      data['prospectreportss'] = this.prospectreportss!.toJson();
    }
    return data;
  }
}

class Prospectassignss {
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

  Prospectassignss(
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

  Prospectassignss.fromJson(Map<String, dynamic> json) {
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

class Prospectproduct {
  int? prosproductid;
  int? prosproductprospectid;
  int? prosproductproductid;
  String? prosproductprice;
  int? prosproductqty;
  String? prosproducttax;
  String? prosproductdiscount;
  String? prosproductamount;
  int? prosproducttaxtypeid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Prosproductproduct? prosproductproduct;
  Prosproducttaxtype? prosproducttaxtype;

  Prospectproduct(
      {this.prosproductid,
      this.prosproductprospectid,
      this.prosproductproductid,
      this.prosproductprice,
      this.prosproductqty,
      this.prosproducttax,
      this.prosproductdiscount,
      this.prosproductamount,
      this.prosproducttaxtypeid,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.prosproductproduct,
      this.prosproducttaxtype});

  Prospectproduct.fromJson(Map<String, dynamic> json) {
    prosproductid = json['prosproductid'];
    prosproductprospectid = json['prosproductprospectid'];
    prosproductproductid = json['prosproductproductid'];
    prosproductprice = json['prosproductprice'];
    prosproductqty = json['prosproductqty'];
    prosproducttax = json['prosproducttax'];
    prosproductdiscount = json['prosproductdiscount'];
    prosproductamount = json['prosproductamount'];
    prosproducttaxtypeid = json['prosproducttaxtypeid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    prosproductproduct = json['prosproductproduct'] != null
        ? new Prosproductproduct.fromJson(json['prosproductproduct'])
        : null;
    prosproducttaxtype = json['prosproducttaxtype'] != null
        ? new Prosproducttaxtype.fromJson(json['prosproducttaxtype'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prosproductid'] = this.prosproductid;
    data['prosproductprospectid'] = this.prosproductprospectid;
    data['prosproductproductid'] = this.prosproductproductid;
    data['prosproductprice'] = this.prosproductprice;
    data['prosproductqty'] = this.prosproductqty;
    data['prosproducttax'] = this.prosproducttax;
    data['prosproductdiscount'] = this.prosproductdiscount;
    data['prosproductamount'] = this.prosproductamount;
    data['prosproducttaxtypeid'] = this.prosproducttaxtypeid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.prosproductproduct != null) {
      data['prosproductproduct'] = this.prosproductproduct!.toJson();
    }
    if (this.prosproducttaxtype != null) {
      data['prosproducttaxtype'] = this.prosproducttaxtype!.toJson();
    }
    return data;
  }
}

class Prosproductproduct {
  int? productid;
  String? productname;
  int? productbpid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Prosproductproduct(
      {this.productid,
      this.productname,
      this.productbpid,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Prosproductproduct.fromJson(Map<String, dynamic> json) {
    productid = json['productid'];
    productname = json['productname'];
    productbpid = json['productbpid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productid'] = this.productid;
    data['productname'] = this.productname;
    data['productbpid'] = this.productbpid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}

class Prosproducttaxtype {
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

  Prosproducttaxtype(
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

  Prosproducttaxtype.fromJson(Map<String, dynamic> json) {
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

class Prospectstage {
  int? typeid;
  String? typename;
  int? typeseq;

  Prospectstage({this.typeid, this.typename, this.typeseq});

  Prospectstage.fromJson(Map<String, dynamic> json) {
    typeid = json['typeid'];
    typename = json['typename'];
    typeseq = json['typeseq'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeid'] = this.typeid;
    data['typename'] = this.typename;
    data['typeseq'] = this.typeseq;
    return data;
  }
}

class Prospectlost {
  int? typeid;
  String? typename;

  Prospectlost({this.typeid, this.typename});

  Prospectlost.fromJson(Map<String, dynamic> json) {
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

class Prospectownerusers {
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
  List<Userdetails>? userdetails;

  Prospectownerusers(
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
      this.isactive,
      this.userdetails});

  Prospectownerusers.fromJson(Map<String, dynamic> json) {
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
    if (json['userdetails'] != null) {
      userdetails = <Userdetails>[];
      json['userdetails'].forEach((v) {
        userdetails!.add(new Userdetails.fromJson(v));
      });
    }
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
    if (this.userdetails != null) {
      data['userdetails'] = this.userdetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Userdetails {
  int? userdtid;
  int? userid;
  int? userdttypeid;
  int? userdtbpid;
  String? userdtbranchnm;
  String? userdtreferalcode;
  int? userdtrelationid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Userdetails(
      {this.userdtid,
      this.userid,
      this.userdttypeid,
      this.userdtbpid,
      this.userdtbranchnm,
      this.userdtreferalcode,
      this.userdtrelationid,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Userdetails.fromJson(Map<String, dynamic> json) {
    userdtid = json['userdtid'];
    userid = json['userid'];
    userdttypeid = json['userdttypeid'];
    userdtbpid = json['userdtbpid'];
    userdtbranchnm = json['userdtbranchnm'];
    userdtreferalcode = json['userdtreferalcode'];
    userdtrelationid = json['userdtrelationid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userdtid'] = this.userdtid;
    data['userid'] = this.userid;
    data['userdttypeid'] = this.userdttypeid;
    data['userdtbpid'] = this.userdtbpid;
    data['userdtbranchnm'] = this.userdtbranchnm;
    data['userdtreferalcode'] = this.userdtreferalcode;
    data['userdtrelationid'] = this.userdtrelationid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}

class Prospectreference {
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

  Prospectreference(
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

  Prospectreference.fromJson(Map<String, dynamic> json) {
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

class Prospectby {
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

  Prospectby(
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

  Prospectby.fromJson(Map<String, dynamic> json) {
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

class Prospectbp {
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

  Prospectbp(
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

  Prospectbp.fromJson(Map<String, dynamic> json) {
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

class Prospectcustomfield {
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
  Prospectreference? prospect;

  Prospectcustomfield(
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

  Prospectcustomfield.fromJson(Map<String, dynamic> json) {
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
        ? new Prospectreference.fromJson(json['prospect'])
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
  bool? allprospect;
  bool? onlythisprospect;
  int? thisprospectid;
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
      this.allprospect,
      this.onlythisprospect,
      this.thisprospectid,
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
    allprospect = json['allprospect'];
    onlythisprospect = json['onlythisprospect'];
    thisprospectid = json['thisprospectid'];
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
    data['allprospect'] = this.allprospect;
    data['onlythisprospect'] = this.onlythisprospect;
    data['thisprospectid'] = this.thisprospectid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
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
  List<Cstmcontact>? cstmcontact;

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
      this.isactive,
      this.cstmcontact});

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
    if (json['cstmcontact'] != null) {
      cstmcontact = <Cstmcontact>[];
      json['cstmcontact'].forEach((v) {
        cstmcontact!.add(new Cstmcontact.fromJson(v));
      });
    }
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
    if (this.cstmcontact != null) {
      data['cstmcontact'] = this.cstmcontact!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cstmcontact {
  int? contactpersonid;
  int? contactcustomerid;
  int? contacttypeid;
  String? contactname;
  String? contactvalueid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  Prosproducttaxtype? contacttype;

  Cstmcontact(
      {this.contactpersonid,
      this.contactcustomerid,
      this.contacttypeid,
      this.contactname,
      this.contactvalueid,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive,
      this.contacttype});

  Cstmcontact.fromJson(Map<String, dynamic> json) {
    contactpersonid = json['contactpersonid'];
    contactcustomerid = json['contactcustomerid'];
    contacttypeid = json['contacttypeid'];
    contactname = json['contactname'];
    contactvalueid = json['contactvalueid'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
    contacttype = json['contacttype'] != null
        ? new Prosproducttaxtype.fromJson(json['contacttype'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['contactpersonid'] = this.contactpersonid;
    data['contactcustomerid'] = this.contactcustomerid;
    data['contacttypeid'] = this.contacttypeid;
    data['contactname'] = this.contactname;
    data['contactvalueid'] = this.contactvalueid;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    if (this.contacttype != null) {
      data['contacttype'] = this.contacttype!.toJson();
    }
    return data;
  }
}

class Prospectfiles {
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

  Prospectfiles(
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

  Prospectfiles.fromJson(Map<String, dynamic> json) {
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
