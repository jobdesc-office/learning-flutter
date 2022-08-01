import '../../models/ventes/schedule_model.dart';

abstract class ScheduleContract {
  void onLoadScheduleSuccess(List<ScheduleModel> response);
}
