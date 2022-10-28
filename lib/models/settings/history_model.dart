class HistoryModel {
  int? historyid;
  int? historytbhistoryid;
  int? historyrefid;
  String? historyremark;
  String? historyoldvalue;
  String? historynewvalue;
  int? historybpid;
  String? historysource;
  int? createdby;
  String? createddate;
  bool? isactive;
  Historytbhistory? historytbhistory;
  Historyuser? historyuser;

  HistoryModel(
      {this.historyid,
      this.historytbhistoryid,
      this.historyrefid,
      this.historyremark,
      this.historyoldvalue,
      this.historynewvalue,
      this.historybpid,
      this.historysource,
      this.createdby,
      this.createddate,
      this.isactive,
      this.historytbhistory,
      this.historyuser});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    historyid = json['historyid'];
    historytbhistoryid = json['historytbhistoryid'];
    historyrefid = json['historyrefid'];
    historyremark = json['historyremark'];
    historyoldvalue = json['historyoldvalue'];
    historynewvalue = json['historynewvalue'];
    historybpid = json['historybpid'];
    historysource = json['historysource'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    isactive = json['isactive'];
    historytbhistory = json['historytbhistory'] != null
        ? new Historytbhistory.fromJson(json['historytbhistory'])
        : null;
    historyuser = json['historyuser'] != null
        ? new Historyuser.fromJson(json['historyuser'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['historyid'] = this.historyid;
    data['historytbhistoryid'] = this.historytbhistoryid;
    data['historyrefid'] = this.historyrefid;
    data['historyremark'] = this.historyremark;
    data['historyoldvalue'] = this.historyoldvalue;
    data['historynewvalue'] = this.historynewvalue;
    data['historybpid'] = this.historybpid;
    data['historysource'] = this.historysource;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['isactive'] = this.isactive;
    if (this.historytbhistory != null) {
      data['historytbhistory'] = this.historytbhistory!.toJson();
    }
    if (this.historyuser != null) {
      data['historyuser'] = this.historyuser!.toJson();
    }
    return data;
  }
}

class Historytbhistory {
  int? tbhistoryid;
  String? tbhistorytbname;
  String? tbhistorytbfield;
  String? tbhistoryasfield;
  String? tbhistorycallfunc;
  String? tbhistoryremarkformat;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  Historytbhistory(
      {this.tbhistoryid,
      this.tbhistorytbname,
      this.tbhistorytbfield,
      this.tbhistoryasfield,
      this.tbhistorycallfunc,
      this.tbhistoryremarkformat,
      this.createdby,
      this.createddate,
      this.updatedby,
      this.updateddate,
      this.isactive});

  Historytbhistory.fromJson(Map<String, dynamic> json) {
    tbhistoryid = json['tbhistoryid'];
    tbhistorytbname = json['tbhistorytbname'];
    tbhistorytbfield = json['tbhistorytbfield'];
    tbhistoryasfield = json['tbhistoryasfield'];
    tbhistorycallfunc = json['tbhistorycallfunc'];
    tbhistoryremarkformat = json['tbhistoryremarkformat'];
    createdby = json['createdby'];
    createddate = json['createddate'];
    updatedby = json['updatedby'];
    updateddate = json['updateddate'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tbhistoryid'] = this.tbhistoryid;
    data['tbhistorytbname'] = this.tbhistorytbname;
    data['tbhistorytbfield'] = this.tbhistorytbfield;
    data['tbhistoryasfield'] = this.tbhistoryasfield;
    data['tbhistorycallfunc'] = this.tbhistorycallfunc;
    data['tbhistoryremarkformat'] = this.tbhistoryremarkformat;
    data['createdby'] = this.createdby;
    data['createddate'] = this.createddate;
    data['updatedby'] = this.updatedby;
    data['updateddate'] = this.updateddate;
    data['isactive'] = this.isactive;
    return data;
  }
}

class Historyuser {
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

  Historyuser(
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

  Historyuser.fromJson(Map<String, dynamic> json) {
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
