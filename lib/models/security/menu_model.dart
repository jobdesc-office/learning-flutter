import 'package:Ventes/models/masters/type_model.dart';

import '../../helpers/function.dart';

class MenuModel {
  int menuid;
  int masterid;
  int menutypeid;
  String menunm;
  String icon;
  String route;
  String color;
  int seq;

  Map<String, dynamic>? _parent;
  Map<String, dynamic>? _menutype;

  MenuModel({
    this.menuid = 0,
    this.masterid = 0,
    this.menutypeid = 0,
    this.menunm = '',
    this.icon = '',
    this.route = '',
    this.color = '',
    this.seq = 0,
    Map<String, dynamic>? parent,
    Map<String, dynamic>? menutype,
  }) : _menutype = menutype;

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      menuid: parseInt(json['menuid']),
      masterid: parseInt(json['masterid']),
      menutypeid: parseInt(json['menutypeid']),
      menunm: parseString(json['menunm']),
      icon: parseString(json['menuicon']),
      route: parseString(json['menuroute']),
      color: parseString(json['menucolor']),
      seq: parseInt(json['menuseq']),
      parent: json['parent'],
      menutype: json['menutype'],
    );
  }

  MenuModel get parent {
    if (_parent == null) return MenuModel();

    return MenuModel.fromJson(_parent!);
  }

  TypeModel get menutype {
    if (_menutype == null) return TypeModel();

    return TypeModel.fromJson(_menutype!);
  }
}
