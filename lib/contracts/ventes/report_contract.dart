import '../../models/ventes/report_model.dart';

abstract class ReportContract {
  void onLoadReportSuccess(ReportModel response);
}
