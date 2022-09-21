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
import '../../../models/default/dspbystage_model.dart';
import '../../../models/default/dspbystatus_model.dart';
import '../../../models/default/home_model.dart';
import '../../../presenters/default/home_presenter.dart';
import '../../../presenters/ventes/schedule_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_search.dart';
import '../../../widgets/form_group.dart';
import '../../skins/template.dart';
import '_source.dart';
import 'chart/_bystage_chart.dart';
import 'chart/_leads_users_chart.dart';

part '_filter.dart';

final presenter = Get.find<HomePresenter>();

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

  final schedulePresenter = Get.find<SchedulePresenter>();

  final source = Get.put(HomeSource());
  final currencyFormatter = NumberFormat('#,##0.00', 'ID');
  int indexColor = 0;

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
              BsRow(children: [
                BsCol(
                    margin: EdgeInsets.all(3),
                    sizes: ColScreen(sm: Col.col_4),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: 200,
                        // child: LeadsUsersChart(),
                        child: Obx(() => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Prospect Value',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                if (source.prospecttotal.value != '')
                                  Center(
                                    child: Text(
                                        'Rp ' +
                                            currencyFormatter
                                                .format(double.parse(
                                                    source.prospecttotal.value))
                                                .replaceAll(',00', '')
                                                .replaceAll('.', ','),
                                        style: TextStyle(
                                          fontSize: 48,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                              ],
                            )),
                        color: Colors.white)),
                BsCol(
                    margin: EdgeInsets.all(3),
                    sizes: ColScreen(sm: Col.col_4),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: 200,
                        child: Obx(() => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Prospect Won',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                if (source.prospectwontotal.value != '')
                                  Center(
                                    child: Text(
                                        'Rp ' +
                                            currencyFormatter
                                                .format(double.parse(source
                                                    .prospectwontotal.value))
                                                .replaceAll(',00', '')
                                                .replaceAll('.', ','),
                                        style: TextStyle(
                                          fontSize: 48,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                              ],
                            )),
                        color: Colors.white)),
                BsCol(
                    margin: EdgeInsets.all(3),
                    sizes: ColScreen(sm: Col.col_4),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: 200,
                        child: Obx(() => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Prospect Lost',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                if (source.prospectlosttotal.value != '')
                                  Center(
                                    child: Text(
                                        'Rp ' +
                                            currencyFormatter
                                                .format(double.parse(source
                                                    .prospectlosttotal.value))
                                                .replaceAll(',00', '')
                                                .replaceAll('.', ','),
                                        style: TextStyle(
                                          fontSize: 48,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                              ],
                            )),
                        color: Colors.white)),
              ]),
              BsRow(
                margin: EdgeInsets.only(top: 5),
                children: [
                  BsCol(
                    margin: EdgeInsets.all(3),
                    sizes: ColScreen(sm: Col.col_4),
                    child: Container(
                      color: Colors.white,
                      child: LeadsUsersChart(),
                    ),
                  ),
                  BsCol(
                    margin: EdgeInsets.all(3),
                    sizes: ColScreen(sm: Col.col_8),
                    child: Obx(() => Container(
                          padding: EdgeInsets.all(10),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey.shade300,
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      source.orderasc.value
                                          ? 'Top 10 Adversity | By Expected Amount'
                                          : 'Top 10 Opportunities | By Expected Amount',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    InkWell(
                                        onTap: () {
                                          indexColor = 0;
                                          source.orderasc.toggle();
                                          presenter.byCust(
                                            params: {
                                              'prospectyy': selectYear
                                                  .getSelectedAsString(),
                                              'prospectmm': selectMonth
                                                  .getSelectedAsString()
                                            },
                                            order: source.orderasc.value
                                                ? 'asc'
                                                : 'desc',
                                          );
                                        },
                                        child: source.orderasc.value
                                            ? Column(
                                                children: [
                                                  Icon(Icons.keyboard_arrow_up),
                                                  Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Colors.grey.shade500,
                                                  )
                                                ],
                                              )
                                            : Column(
                                                children: [
                                                  Icon(Icons.keyboard_arrow_up,
                                                      color:
                                                          Colors.grey.shade500),
                                                  Icon(
                                                      Icons.keyboard_arrow_down)
                                                ],
                                              ))
                                  ],
                                ),
                              ),
                              if (source.bycust.value.isNotEmpty)
                                Column(
                                  children: source.bycust.value.map((e) {
                                    String newvalue = '';
                                    String oldvalue = '';
                                    newvalue = e.prospectvalue.toString();
                                    if (newvalue == oldvalue)
                                      indexColor = indexColor;
                                    else
                                      indexColor++;
                                    Color color = Colors.transparent;
                                    switch (indexColor) {
                                      case 0:
                                        color = ColorPallates.mobileprimary;
                                        break;
                                      case 1:
                                        color = ColorPallates.mobilesecondary;
                                        break;
                                      case 2:
                                        color = ColorPallates.green;
                                        break;
                                      case 3:
                                        color = ColorPallates.red;
                                        break;
                                      case 4:
                                        color = ColorPallates.indigo;
                                        break;
                                      case 5:
                                        color = ColorPallates.purple;
                                        break;
                                      case 6:
                                        color = ColorPallates.yellow;
                                        break;
                                      case 7:
                                        color = ColorPallates.cyan;
                                        break;
                                      case 8:
                                        color = ColorPallates.pink;
                                        break;
                                      case 9:
                                        color = ColorPallates.cancel;
                                        break;
                                      default:
                                        color = ColorPallates.mobileprimary;
                                        indexColor = 0;
                                    }
                                    oldvalue = e.prospectvalue.toString();
                                    return Column(
                                      children: [
                                        Divider(),
                                        Container(
                                          padding: EdgeInsets.all(3),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  e.prospectcust?.sbccstmname ??
                                                      ''),
                                              Container(
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(5),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15,
                                                color: color,
                                                child: Text(
                                                  'Rp ' +
                                                      currencyFormatter
                                                          .format(double.parse(
                                                              parseString(
                                                                  e.prospectvalue ??
                                                                      0)))
                                                          .replaceAll(',00', '')
                                                          .replaceAll('.', ','),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider()
                                      ],
                                    );
                                  }).toList(),
                                )
                              else
                                Container(),
                            ],
                          ),
                        )),
                  ),
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
    presenter.byStatus(params: {
      'prospectyy': selectYear.getSelectedAsString(),
      'prospectmm': selectMonth.getSelectedAsString(),
    });
  }

  initiator() {
    selectYear.setSelected(BsSelectBoxOption(
        value: '${DateTime.now().year}', text: Text('${DateTime.now().year}')));
    int month = DateTime.now().month;
    switch (month) {
      case 1:
        selectMonth
            .setSelected(BsSelectBoxOption(value: 1, text: Text('January')));
        break;
      case 2:
        selectMonth.setSelected(
          BsSelectBoxOption(value: 2, text: Text('February')),
        );
        break;
      case 3:
        selectMonth.setSelected(
          BsSelectBoxOption(value: 3, text: Text('March')),
        );
        break;
      case 4:
        selectMonth.setSelected(
          BsSelectBoxOption(value: 4, text: Text('April')),
        );
        break;
      case 5:
        selectMonth.setSelected(
          BsSelectBoxOption(value: 5, text: Text('May')),
        );
        break;
      case 6:
        selectMonth.setSelected(
          BsSelectBoxOption(value: 6, text: Text('June')),
        );
        break;
      case 7:
        selectMonth.setSelected(
          BsSelectBoxOption(value: 7, text: Text('July')),
        );
        break;
      case 8:
        selectMonth.setSelected(
          BsSelectBoxOption(value: 8, text: Text('August')),
        );
        break;
      case 9:
        selectMonth.setSelected(
          BsSelectBoxOption(value: 9, text: Text('September')),
        );
        break;
      case 10:
        selectMonth.setSelected(
          BsSelectBoxOption(value: 10, text: Text('October')),
        );
        break;
      case 11:
        selectMonth.setSelected(
          BsSelectBoxOption(value: 11, text: Text('November')),
        );
        break;
      case 12:
        selectMonth.setSelected(
          BsSelectBoxOption(value: 12, text: Text('December')),
        );
        break;
      default:
    }
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
      years.add(res.prospectyy ?? 0);
    }
    List<int> year = years.toSet().toList();
    if (bycust.length > 9) {
      bycust.removeRange(10, bycust.length);
    }
    source.prospecttotal.value = total.toString();
    source.bycust.value = bycust;
    source.years.value = year;
  }

  @override
  void onSuccessDspbycustlabel(Response response) {
    // TODO: implement onSuccessDspbycustlabel
  }

  @override
  void onSuccessDspbyowner(Response response) {
    // TODO: implement onSuccessDspbyowner
  }

  @override
  void onSuccessDspbystage(Response response) {
    List<DspbystageModel> model = [];
    for (var element in response.body) {
      model.add(DspbystageModel.fromJson(element));
    }
    source.bystage.value = model;
  }

  @override
  void onSuccessDspbystatus(Response response) {
    source.prospectlosttotal.value = '0';
    var losttotal = 0;
    for (var element in response.body) {
      DspbystatusModel res = DspbystatusModel.fromJson(element);
      if (res.prospectstatus == 'Closed Lost') {
        losttotal += parseInt(res.prospectvalue);
      }
    }
    source.prospectlosttotal.value = losttotal.toString();

    source.prospectwontotal.value = '0';
    var wontotal = 0;
    for (var element in response.body) {
      DspbystatusModel res = DspbystatusModel.fromJson(element);
      if (res.prospectstatus == 'Closed Won') {
        wontotal += parseInt(res.prospectvalue);
      }
    }
    source.prospectwontotal.value = wontotal.toString();
  }
}
