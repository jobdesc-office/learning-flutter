import '../masters/type_model.dart';

class ProspectModel {
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
  Prospectowneruser? prospectowneruser;
  List<Prospectassigns>? prospectassigns;
  List<Prospectproduct>? prospectproduct;
  TypeModel? prospectstage;
  Prospectstage? prospectstatus;
  Prospectreference? prospectreference;
  Prospectbp? prospectbp;
  Prospectcusts? prospectcusts;

  ProspectModel(
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
      this.isactive,
      this.prospectowneruser,
      this.prospectassigns,
      this.prospectproduct,
      this.prospectstage,
      this.prospectstatus,
      this.prospectreference,
      this.prospectbp,
      this.prospectcusts});

  ProspectModel.fromJson(Map<String, dynamic> json) {
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
    prospectowneruser = json['prospectowneruser'] != null
        ? new Prospectowneruser.fromJson(json['prospectowneruser'])
        : null;
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
    prospectstatus = json['prospectstatus'] != null
        ? new Prospectstage.fromJson(json['prospectstatus'])
        : null;
    prospectreference = json['prospectreference'] != null
        ? new Prospectreference.fromJson(json['prospectreference'])
        : null;
    prospectbp = json['prospectbp'] != null
        ? new Prospectbp.fromJson(json['prospectbp'])
        : null;
    prospectcusts = json['prospectcusts'] != null
        ? new Prospectcusts.fromJson(json['prospectcusts'])
        : null;
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
    if (this.prospectowneruser != null) {
      data['prospectowneruser'] = this.prospectowneruser!.toJson();
    }
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
    if (this.prospectstatus != null) {
      data['prospectstatus'] = this.prospectstatus!.toJson();
    }
    if (this.prospectreference != null) {
      data['prospectreference'] = this.prospectreference!.toJson();
    }
    if (this.prospectbp != null) {
      data['prospectbp'] = this.prospectbp!.toJson();
    }
    if (this.prospectcusts != null) {
      data['prospectcusts'] = this.prospectcusts!.toJson();
    }
    return data;
  }
}

class Prospectowneruser {
  int? userdtid;
  int? userid;
  int? userdttypeid;
  int? userdtbpid;
  int? userdtbranchnm;
  int? userdtreferalcode;
  int? userdtrelationid;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;
  User? user;

  Prospectowneruser(
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
      this.isactive,
      this.user});

  Prospectowneruser.fromJson(Map<String, dynamic> json) {
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
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? userid;
  String? username;
  String? userpassword;
  String? userfullname;
  String? useremail;
  String? userphone;
  int? userdeviceid;
  int? userfcmtoken;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  User(
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

  User.fromJson(Map<String, dynamic> json) {
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
  Prospectowneruser? prospectassign;
  Prospectowneruser? prospectreport;

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
      this.prospectassign,
      this.prospectreport});

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
    prospectassign = json['prospectassign'] != null
        ? new Prospectowneruser.fromJson(json['prospectassign'])
        : null;
    prospectreport = json['prospectreport'] != null
        ? new Prospectowneruser.fromJson(json['prospectreport'])
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
    if (this.prospectassign != null) {
      data['prospectassign'] = this.prospectassign!.toJson();
    }
    if (this.prospectreport != null) {
      data['prospectreport'] = this.prospectreport!.toJson();
    }
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

  Prospectstage({this.typeid, this.typename});

  Prospectstage.fromJson(Map<String, dynamic> json) {
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

class Prospectreference {
  int? prospectid;
  String? prospectname;
  String? prospectstartdate;
  String? prospectenddate;
  int? prospectvalue;
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
  Prospectcusts? prospectcusts;

  Prospectreference(
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
      this.isactive,
      this.prospectcusts});

  Prospectreference.fromJson(Map<String, dynamic> json) {
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
    prospectcusts = json['prospectcusts'] != null
        ? new Prospectcusts.fromJson(json['prospectcusts'])
        : null;
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
    if (this.prospectcusts != null) {
      data['prospectcusts'] = this.prospectcusts!.toJson();
    }
    return data;
  }
}

class Prospectcusts {
  int? sbcid;
  int? sbcbpid;
  int? sbccstmid;
  int? sbccstmstatusid;
  String? sbccstmname;
  String? sbccstmphone;
  String? sbccstmaddress;
  String? sbccstmpic;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Prospectcusts(
      {this.sbcid,
      this.sbcbpid,
      this.sbccstmid,
      this.sbccstmstatusid,
      this.sbccstmname,
      this.sbccstmphone,
      this.sbccstmaddress,
      this.sbccstmpic,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Prospectcusts.fromJson(Map<String, dynamic> json) {
    sbcid = json['sbcid'];
    sbcbpid = json['sbcbpid'];
    sbccstmid = json['sbccstmid'];
    sbccstmstatusid = json['sbccstmstatusid'];
    sbccstmname = json['sbccstmname'];
    sbccstmphone = json['sbccstmphone'];
    sbccstmaddress = json['sbccstmaddress'];
    sbccstmpic = json['sbccstmpic'];
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
    data['sbccstmpic'] = this.sbccstmpic;
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
  int? referalcode;
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
