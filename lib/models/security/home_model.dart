import '../../helpers/function.dart';

class HomeModel {
  int users;
  int schedules;
  int prospects;
  int partners;

  HomeModel({
    this.users = 0,
    this.schedules = 0,
    this.prospects = 0,
    this.partners = 0,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      users: parseInt(json['users']),
      schedules: parseInt(json['schedules']),
      prospects: parseInt(json['prospects']),
      partners: parseInt(json['businesspartner']),
    );
  }
}
