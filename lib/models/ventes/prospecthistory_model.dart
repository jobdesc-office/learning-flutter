import '../settings/history_model.dart';

class ProspectHistoryModel {
  List<HistoryModel>? prospect;
  List<HistoryModel>? prospectproduct;
  List<HistoryModel>? prospectassign;
  List<HistoryModel>? prospectactivity;
  List<HistoryModel>? prospectcustomfield;
  List<HistoryModel>? prospectfile;

  ProspectHistoryModel(
      {this.prospect,
      this.prospectproduct,
      this.prospectassign,
      this.prospectactivity,
      this.prospectcustomfield,
      this.prospectfile});

  ProspectHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['prospect'] != null) {
      prospect = <HistoryModel>[];
      json['prospect'].forEach((v) {
        prospect!.add(new HistoryModel.fromJson(v));
      });
    }
    if (json['prospectproduct'] != null) {
      prospectproduct = <HistoryModel>[];
      json['prospectproduct'].forEach((v) {
        prospectproduct!.add(new HistoryModel.fromJson(v));
      });
    }
    if (json['prospectassign'] != null) {
      prospectassign = <HistoryModel>[];
      json['prospectassign'].forEach((v) {
        prospectassign!.add(new HistoryModel.fromJson(v));
      });
    }
    if (json['prospectactivity'] != null) {
      prospectactivity = <HistoryModel>[];
      json['prospectactivity'].forEach((v) {
        prospectactivity!.add(new HistoryModel.fromJson(v));
      });
    }
    if (json['prospectcustomfield'] != null) {
      prospectcustomfield = <HistoryModel>[];
      json['prospectcustomfield'].forEach((v) {
        prospectcustomfield!.add(new HistoryModel.fromJson(v));
      });
    }
    if (json['prospectfile'] != null) {
      prospectfile = <HistoryModel>[];
      json['prospectfile'].forEach((v) {
        prospectfile!.add(new HistoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.prospect != null) {
      data['prospect'] = this.prospect!.map((v) => v.toJson()).toList();
    }
    if (this.prospectproduct != null) {
      data['prospectproduct'] =
          this.prospectproduct!.map((v) => v.toJson()).toList();
    }
    if (this.prospectassign != null) {
      data['prospectassign'] =
          this.prospectassign!.map((v) => v.toJson()).toList();
    }
    if (this.prospectactivity != null) {
      data['prospectactivity'] =
          this.prospectactivity!.map((v) => v.toJson()).toList();
    }
    if (this.prospectcustomfield != null) {
      data['prospectcustomfield'] =
          this.prospectcustomfield!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
