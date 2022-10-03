import 'dart:math';

import 'package:boilerplate/helpers/function.dart';
import 'package:boilerplate/styles/color_palattes.dart';
import 'package:boilerplate/widgets/button/button_X_datatable.dart';
import 'package:boilerplate/widgets/input/custom_input_number.dart';
import 'package:boilerplate/widgets/selectbox/custom_selectbox.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_modal/bs_flutter_modal.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/base_text.dart';
import '../../../contracts/default/home_view_contract.dart';
import '../../../models/default/dspbycust_model.dart';
import '../../../models/default/dspbycustlabel_model.dart';
import '../../../models/default/dspbystage_model.dart';
import '../../../models/default/dspbystatus_model.dart';
import '../../../models/default/home_model.dart';
import '../../../presenters/default/home_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/ventes/schedule_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_search.dart';
import '../../../widgets/form_group.dart';
import '../../skins/template.dart';
import '_source.dart';
import 'chart/_bycustlabel_chart.dart';
import 'chart/_bystage_chart.dart';
import 'chart/_byvalue_chart.dart';
import 'chart/_leads_users_chart.dart';

part '_filter.dart';
part 'home_component/_total_part.dart';
part 'home_component/_chart_stage.dart';
part 'home_component/_top10_part.dart';
part 'home_component/_chart_custlabel.dart';
part 'home_component/_chart_value.dart';

part 'details/_custdetails.dart';
part 'details/_statusdetails.dart';
part 'details/_stagedetails.dart';
part 'details/_custlabeldetails.dart';

final presenter = Get.find<HomePresenter>();
final _navigation = Get.find<NavigationPresenter>();

final source = Get.put(HomeSource());
final currencyFormatter = NumberFormat('#,##0.00', 'ID');
int indexColor = 0;
String newvalue = '';
String oldvalue = '';

BsSelectBoxController selectYear = BsSelectBoxController();
BsSelectBoxController selectMonth = BsSelectBoxController(options: [
  BsSelectBoxOption(value: 1, text: Text('January')),
  BsSelectBoxOption(value: 2, text: Text('February')),
  BsSelectBoxOption(value: 3, text: Text('March')),
  BsSelectBoxOption(value: 4, text: Text('April')),
  BsSelectBoxOption(value: 5, text: Text('May')),
  BsSelectBoxOption(value: 6, text: Text('June')),
  BsSelectBoxOption(value: 7, text: Text('July')),
  BsSelectBoxOption(value: 8, text: Text('August')),
  BsSelectBoxOption(value: 9, text: Text('September')),
  BsSelectBoxOption(value: 10, text: Text('October')),
  BsSelectBoxOption(value: 11, text: Text('November')),
  BsSelectBoxOption(value: 12, text: Text('December')),
]);

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with TickerProviderStateMixin
    implements HomeViewContract {
  @override
  void initState() {
    super.initState();
    presenter.homeContract = this;
    initiator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
          title: 'Dashboard',
          breadcrumbs: [
            BreadcrumbWidget('Insight'),
            BreadcrumbWidget('Dashboard', active: true),
          ],
          activeRoutes: [RouteList.home.index],
          widget: Obx(() {
            if (source.years.value.isNotEmpty) {
              selectYear = BsSelectBoxController(
                  options: source.years.value
                      .map((e) =>
                          BsSelectBoxOption(value: e, text: Text(e.toString())))
                      .toList());
              if (source.year.value != '')
                selectYear.setSelected(BsSelectBoxOption(
                    value: source.year.value, text: Text(source.year.value)));
            }
            return Row(
              children: [
                Container(
                  width: 150,
                  child: CustomSelectBox(
                      controller: selectYear,
                      hintText: BaseText.hiintSelect(field: 'Year'),
                      onChange: (val) {
                        refresh();
                        indexColor = 0;
                        source.year.value = val.getValueAsString();
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  width: 170,
                  child: CustomSelectBox(
                    hintText: BaseText.hiintSelect(field: 'Month'),
                    controller: selectMonth,
                    onChange: (val) {
                      refresh();
                      indexColor = 0;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 5, right: 5),
                  child: BsButton(
                      size: BsButtonSize.btnSm,
                      style: BsButtonStyle.danger,
                      label: Icon(Icons.close_rounded),
                      onPressed: () {
                        indexColor = 0;
                        selectYear.clear();
                        selectMonth.clear();
                        source.year.value = '';
                        refresh();
                      }),
                )
              ],
            );
          }),
          child: Column(
            children: [
              TotalPart(),
              BsRow(
                margin: EdgeInsets.only(top: 5),
                children: [
                  stageChart(context),
                  top10(context),
                  chartCustLabel(),
                  chartValue()
                ],
              )
            ],
          )),
    );
  }

  refresh() {
    presenter.byCust(
      params: {
        'prospectyy': selectYear.getSelectedAsString(),
        'prospectmm': selectMonth.getSelectedAsString()
      },
      order: source.orderasc.value ? 'asc' : 'desc',
    );
    presenter.byCustLabel(params: {
      'prospectyy': selectYear.getSelectedAsString(),
      'prospectmm': selectMonth.getSelectedAsString(),
    });
    presenter.byStatus(params: {
      'prospectyy': selectYear.getSelectedAsString(),
      'prospectmm': selectMonth.getSelectedAsString(),
    });
    presenter.byStage(
      params: {
        'prospectyy': selectYear.getSelectedAsString(),
        'prospectmm': selectMonth.getSelectedAsString()
      },
      order: source.orderasc.value ? 'asc' : 'desc',
    );
  }

  initiator() {
    // selectYear.setSelected(BsSelectBoxOption(
    //     value: '${DateTime.now().year}', text: Text('${DateTime.now().year}')));
    // int month = DateTime.now().month;
    // switch (month) {
    //   case 1:
    //     selectMonth
    //         .setSelected(BsSelectBoxOption(value: 1, text: Text('January')));
    //     break;
    //   case 2:
    //     selectMonth.setSelected(
    //       BsSelectBoxOption(value: 2, text: Text('February')),
    //     );
    //     break;
    //   case 3:
    //     selectMonth.setSelected(
    //       BsSelectBoxOption(value: 3, text: Text('March')),
    //     );
    //     break;
    //   case 4:
    //     selectMonth.setSelected(
    //       BsSelectBoxOption(value: 4, text: Text('April')),
    //     );
    //     break;
    //   case 5:
    //     selectMonth.setSelected(
    //       BsSelectBoxOption(value: 5, text: Text('May')),
    //     );
    //     break;
    //   case 6:
    //     selectMonth.setSelected(
    //       BsSelectBoxOption(value: 6, text: Text('June')),
    //     );
    //     break;
    //   case 7:
    //     selectMonth.setSelected(
    //       BsSelectBoxOption(value: 7, text: Text('July')),
    //     );
    //     break;
    //   case 8:
    //     selectMonth.setSelected(
    //       BsSelectBoxOption(value: 8, text: Text('August')),
    //     );
    //     break;
    //   case 9:
    //     selectMonth.setSelected(
    //       BsSelectBoxOption(value: 9, text: Text('September')),
    //     );
    //     break;
    //   case 10:
    //     selectMonth.setSelected(
    //       BsSelectBoxOption(value: 10, text: Text('October')),
    //     );
    //     break;
    //   case 11:
    //     selectMonth.setSelected(
    //       BsSelectBoxOption(value: 11, text: Text('November')),
    //     );
    //     break;
    //   case 12:
    //     selectMonth.setSelected(
    //       BsSelectBoxOption(value: 12, text: Text('December')),
    //     );
    //     break;
    //   default:
    // }
    // source.year.value = '${DateTime.now().year}';
    refresh();
  }

  @override
  void onError(message) {
    print(message);
  }

  @override
  void onSuccessDspbybp(Response response) {
    // TODO: implement onSuccessDspbybp
  }

  @override
  void onSuccessDspbycust(Response response) {
    source.prospecttotal.value = '0';
    source.bycust.clear();
    source.years.clear();
    var total = 0;
    var bycust = <DspbycustModel>[];
    var years = <int>[];
    for (var element in response.body) {
      DspbycustModel res = DspbycustModel.fromJson(element);
      total += parseInt(res.prospectvalue);
      bycust.add(res);
      source.bycustall.add(res);
      years.add(res.prospectyy ?? 0);
    }
    List<int> year = years.toSet().toList();
    if (bycust.length > 9) {
      bycust.removeRange(10, bycust.length);
      source.bycust.value = bycust;
    }
    source.prospecttotal.value = total.toString();
    source.years.value = year;
  }

  @override
  void onSuccessDspbycustlabel(Response response) {
    List<DspbycustlabelModel> model = [];
    List<String> labelname = [];
    for (var element in response.body) {
      labelname
          .add(DspbycustlabelModel.fromJson(element).prospectcustlabel ?? '');
      model.add(DspbycustlabelModel.fromJson(element));
    }
    source.labelname.value = labelname.toSet().toList();
    source.bycustlabel.value = model;
  }

  @override
  void onSuccessDspbyowner(Response response) {
    // TODO: implement onSuccessDspbyowner
  }

  @override
  void onSuccessDspbystage(Response response) {
    List<DspbystageModel> model = [];
    List<String> stagename = [];
    for (var element in response.body) {
      model.add(DspbystageModel.fromJson(element));
      stagename.add(DspbystageModel.fromJson(element).prospectstage ?? '');
    }
    source.stagename.value = stagename.toSet().toList();
    source.bystage.value = model;
  }

  @override
  void onSuccessDspbystatus(Response response) {
    source.prospectlosttotal.value = '0';
    source.prospectwontotal.value = '0';
    var losttotal = 0;
    var wontotal = 0;
    for (var element in response.body) {
      DspbystatusModel res = DspbystatusModel.fromJson(element);
      if (res.prospectstatus == 'Closed Lost') {
        source.bystatuslost.add(res);
        losttotal += parseInt(res.prospectvalue);
      }
      if (res.prospectstatus == 'Closed Won') {
        source.bystatuswon.add(res);
        wontotal += parseInt(res.prospectvalue);
      }
    }
    source.prospectlosttotal.value = losttotal.toString();
    source.prospectwontotal.value = wontotal.toString();
  }
}
