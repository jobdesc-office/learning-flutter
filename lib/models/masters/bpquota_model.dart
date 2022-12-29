class BpQuotaModel {
  int? sbqid;
  int? sbqbpid;
  int? sbqwebuserquota;
  int? sbqmobuserquota;
  int? sbqcstmquota;
  int? sbqcntcquota;
  int? sbqprodquota;
  int? sbqprosquota;
  int? sbqdayactquota;
  int? sbqprosactquota;
  int? sbqwebuserquotaused;
  int? sbqmobuserquotaused;
  int? sbqcstmquotaused;
  int? sbqcntcquotaused;
  int? sbqprodquotaused;
  int? sbqprosquotaused;
  int? sbqdayactquotaused;
  int? sbqprosactquotaused;
  int? createdby;
  String? createddate;
  int? updatedby;
  String? updateddate;
  bool? isactive;

  BpQuotaModel({
    this.sbqbpid,
    this.createdby,
    this.createddate,
    this.isactive,
    this.sbqcntcquota,
    this.sbqcstmquota,
    this.sbqdayactquota,
    this.sbqid,
    this.sbqmobuserquota,
    this.sbqprodquota,
    this.sbqprosactquota,
    this.sbqprosquota,
    this.sbqwebuserquota,
    this.sbqcntcquotaused,
    this.sbqcstmquotaused,
    this.sbqdayactquotaused,
    this.sbqmobuserquotaused,
    this.sbqprodquotaused,
    this.sbqprosactquotaused,
    this.sbqprosquotaused,
    this.sbqwebuserquotaused,
    this.updatedby,
    this.updateddate,
  });

  BpQuotaModel.fromJson(Map<String, dynamic> json) {
    sbqbpid = json["sbqbpid"];
    createdby = json["createdby"];
    createddate = json["createddate"];
    isactive = json["isactive"];
    sbqid = json["sbqid"];
    sbqcntcquota = json["sbqcntcquota"];
    sbqcstmquota = json["sbqcstmquota"];
    sbqdayactquota = json["sbqdayactquota"];
    sbqmobuserquota = json["sbqmobuserquota"];
    sbqprodquota = json["sbqprodquota"];
    sbqprosactquota = json["sbqprosactquota"];
    sbqprosquota = json["sbqprosquota"];
    sbqwebuserquota = json["sbqwebuserquota"];
    sbqcntcquotaused = json["sbqcntcquotaused"];
    sbqcstmquotaused = json["sbqcstmquotaused"];
    sbqdayactquotaused = json["sbqdayactquotaused"];
    sbqmobuserquotaused = json["sbqmobuserquotaused"];
    sbqprodquotaused = json["sbqprodquotaused"];
    sbqprosactquotaused = json["sbqprosactquotaused"];
    sbqprosquotaused = json["sbqprosquotaused"];
    sbqwebuserquotaused = json["sbqwebuserquotaused"];
    updatedby = json["updatedby"];
    updateddate = json["updateddate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sbqbpid'] = sbqbpid;
    data['createdby'] = createdby;
    data['createddate'] = createddate;
    data['isactive'] = isactive;
    data['sbqid'] = sbqid;
    data['sbqcntcquota'] = sbqcntcquota;
    data['sbqcstmquota'] = sbqcstmquota;
    data['sbqdayactquota'] = sbqdayactquota;
    data['sbqmobuserquota'] = sbqmobuserquota;
    data['sbqprodquota'] = sbqprodquota;
    data['sbqprosactquota'] = sbqprosactquota;
    data['sbqprosquota'] = sbqprosquota;
    data['sbqwebuserquota'] = sbqwebuserquota;
    data['sbqcntcquotaused'] = sbqcntcquotaused;
    data['sbqcstmquotaused'] = sbqcstmquotaused;
    data['sbqdayactquotaused'] = sbqdayactquotaused;
    data['sbqmobuserquotaused'] = sbqmobuserquotaused;
    data['sbqprodquotaused'] = sbqprodquotaused;
    data['sbqprosactquotaused'] = sbqprosactquotaused;
    data['sbqprosquotaused'] = sbqprosquotaused;
    data['sbqwebuserquotaused'] = sbqwebuserquotaused;
    data['updatedby'] = updatedby;
    data['updateddate'] = updateddate;
    return data;
  }
}
