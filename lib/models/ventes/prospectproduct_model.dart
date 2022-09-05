class ProspectProductModel {
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
  Prospectproductcreatedby? prospectproductcreatedby;
  Prospectproductcreatedby? prospectproductupdatedby;
  Prosproductproduct? prosproductproduct;
  Prosproductprospect? prosproductprospect;
  Prosproducttaxtype? prosproducttaxtype;

  ProspectProductModel(
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
      this.prospectproductcreatedby,
      this.prospectproductupdatedby,
      this.prosproductproduct,
      this.prosproductprospect,
      this.prosproducttaxtype});

  ProspectProductModel.fromJson(Map<String, dynamic> json) {
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
    prospectproductcreatedby = json['prospectproductcreatedby'] != null
        ? new Prospectproductcreatedby.fromJson(
            json['prospectproductcreatedby'])
        : null;
    prospectproductupdatedby = json['prospectproductupdatedby'] != null
        ? new Prospectproductcreatedby.fromJson(
            json['prospectproductupdatedby'])
        : null;
    prosproductproduct = json['prosproductproduct'] != null
        ? new Prosproductproduct.fromJson(json['prosproductproduct'])
        : null;
    prosproductprospect = json['prosproductprospect'] != null
        ? new Prosproductprospect.fromJson(json['prosproductprospect'])
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
    if (this.prospectproductcreatedby != null) {
      data['prospectproductcreatedby'] =
          this.prospectproductcreatedby!.toJson();
    }
    if (this.prospectproductupdatedby != null) {
      data['prospectproductupdatedby'] =
          this.prospectproductupdatedby!.toJson();
    }
    if (this.prosproductproduct != null) {
      data['prosproductproduct'] = this.prosproductproduct!.toJson();
    }
    if (this.prosproductprospect != null) {
      data['prosproductprospect'] = this.prosproductprospect!.toJson();
    }
    if (this.prosproducttaxtype != null) {
      data['prosproducttaxtype'] = this.prosproducttaxtype!.toJson();
    }
    return data;
  }
}

class Prospectproductcreatedby {
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

  Prospectproductcreatedby(
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

  Prospectproductcreatedby.fromJson(Map<String, dynamic> json) {
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

class Prosproductprospect {
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

  Prosproductprospect(
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

  Prosproductprospect.fromJson(Map<String, dynamic> json) {
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

class Prosproducttaxtype {
  int? typeid;
  String? typename;

  Prosproducttaxtype({this.typeid, this.typename});

  Prosproducttaxtype.fromJson(Map<String, dynamic> json) {
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
