import 'dart:html';

import 'package:boilerplate/views/skins/template.dart';
import 'package:boilerplate/widgets/button/button_edit_datatable.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../contracts/base/index_view_contract.dart';
import '../../../models/masters/type_model.dart';
import '../../../models/ventes/prospect_model.dart';
import '../../../models/ventes/prospectactivity_model.dart';
import '../../../presenters/auth_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/ventes/customfield_presenter.dart';
import '../../../presenters/ventes/prospect_presenter.dart';
import '../../../presenters/ventes/prospectassign_presenter.dart';
import '../../../presenters/ventes/prospectactivity_presenter.dart';
import '../../../presenters/ventes/prospectproduct_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/button_controller.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_info_assign.dart';
import '../../../widgets/map/_map_source.dart';
import '../../../widgets/snackbar.dart';
import '_detail_source.dart';
import '_stagePipeline.dart';

class ProspectDetails extends StatefulWidget {
  const ProspectDetails({Key? key}) : super(key: key);

  @override
  State<ProspectDetails> createState() => _ProspectDetailsState();
}

class _ProspectDetailsState extends State<ProspectDetails>
    with TickerProviderStateMixin
    implements
        DetailViewContract,
        MenuTypeViewDetailContract,
        IndexViewContract {
  late TabController _tabController;
  // late TabController _tabControllerTimeline;
  final detailPresenter = Get.find<ProspectActivityPresenter>();
  final assignPresenter = Get.find<ProspectAssignPresenter>();
  final productPresenter = Get.find<ProspectProductPresenter>();
  final customFieldPresenter = Get.find<CustomFieldPresenter>();
  final presenter = Get.find<ProspectPresenter>();
  final source = Get.put(prospectDetailsSource());
  final controller = Get.put(ButtonController());
  final map = Get.put(mapSource());

  final currencyFormatter = NumberFormat('#,##0.00', 'ID');

  @override
  void initState() {
    super.initState();
    presenter.prospectViewContract = this;
    _tabController = TabController(length: 6, vsync: this);
    // _tabControllerTimeline = TabController(length: 8, vsync: this);
    presenter.prospectTypeViewDetailContract = this;
    detailPresenter.prospectViewContract = this;
    assignPresenter.prospectViewContract = this;
    productPresenter.prospectViewContract = this;
  }

  final _navigation = Get.find<NavigationPresenter>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Prospect Details',
        breadcrumbs: [
          BreadcrumbWidget('Dashboard', route: RouteList.home.index),
          BreadcrumbWidget('Venteses'),
          BreadcrumbWidget('Prospect', back: true),
          BreadcrumbWidget('Prospect Details', active: true),
        ],
        activeRoutes: [RouteList.ventes.index, RouteList.ventesProspect.index],
        child: Column(
          children: [
            BsRow(
              children: [
                BsCol(
                  margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
                  sizes: ColScreen(sm: Col.col_12),
                  child: Obx(() => Container(
                        decoration: BoxDecoration(
                          color: _navigation.darkTheme.value
                              ? ColorPallates.elseDarkColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(source.prospectname.value),
                                    Icon(Icons.label)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    BsButton(
                                      style: BsButtonStyle.success,
                                      onPressed: () {
                                        Get.snackbar('Biasa aja', '');
                                      },
                                      // prefixIcon: Icons.settings,
                                      label: Text('Won'),
                                    ),
                                    BsButton(
                                      margin: EdgeInsets.only(left: 10),
                                      style: BsButtonStyle.danger,
                                      onPressed: () {
                                        Get.snackbar('Awokawokawok', 'Kalah');
                                      },
                                      // prefixIcon: Icons.settings,
                                      label: Text('Lost'),
                                    ),
                                    BsButton(
                                      margin: EdgeInsets.only(left: 10),
                                      style: BsButtonStyle.success,
                                      onPressed: () {
                                        assignPresenter.add(
                                            context, source.prospectid.value);
                                      },
                                      prefixIcon: Icons.settings,
                                      label: Text('Add Assignation'),
                                    ),
                                    BsButton(
                                      style: BsButtonStyle.success,
                                      margin: EdgeInsets.only(left: 10),
                                      onPressed: () {
                                        productPresenter.add(
                                            context, source.prospectid.value);
                                      },
                                      prefixIcon: Icons.settings,
                                      label: Text('Add Product'),
                                    )
                                    // Container(
                                    //   margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    //   child: ElevatedButton(
                                    //       onPressed: () {},
                                    //       child: Text('data')),
                                    // ),
                                    // Container(
                                    //   margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    //   child: ElevatedButton(
                                    //       onPressed: () {},
                                    //       child: Text('data')),
                                    // ),
                                    // Container(
                                    //   margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    //   child: ElevatedButton(
                                    //       onPressed: () {},
                                    //       child: Text('data')),
                                    // ),
                                    // Container(
                                    //   margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                    //   child: ElevatedButton(
                                    //       onPressed: () {},
                                    //       child: Text('data')),
                                    // )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            BsRow(
                              children: [
                                BsCol(
                                    sizes: ColScreen(sm: Col.col_2),
                                    child: Text('Rp. ' +
                                        currencyFormatter.format(double.parse(
                                            source.prospectvalue.value)))),
                                BsCol(
                                  sizes: ColScreen(sm: Col.col_10),
                                  child: Container(
                                    child: BsRow(
                                      children: [
                                        // BsCol(
                                        //     sizes: ColScreen(sm: Col.col_3),
                                        //     child: Text('Add Product')),
                                        BsCol(
                                          sizes: ColScreen(sm: Col.col_4),
                                          child: Row(
                                            children: [
                                              Icon(Icons.person),
                                              Text(source.userfullname.value)
                                            ],
                                          ),
                                        ),
                                        BsCol(
                                          sizes: ColScreen(sm: Col.col_5),
                                          child: Row(
                                            children: [
                                              Icon(Icons.domain),
                                              Text(source.bpname.value)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: BsRow(
                                children: [
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_12),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: MenuTypeOptions(
                                        controller:
                                            source.prospectStageController,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Prospect Start'),
                                Text(source.prospectstartdate.value),
                              ],
                            )
                          ]),
                        ),
                      )),
                ),
                BsCol(
                  margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
                  sizes: ColScreen(sm: Col.col_4),
                  child: BsRow(
                    children: [
                      BsCol(
                        child: Obx(() => Container(
                              decoration: BoxDecoration(
                                color: _navigation.darkTheme.value
                                    ? ColorPallates.elseDarkColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Detail'),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            BsButton(
                                                size: BsButtonSize.btnSm,
                                                onPressed: () {},
                                                label: Icon(
                                                  Icons.edit,
                                                  size: 13,
                                                )),
                                            BsButton(
                                                margin:
                                                    EdgeInsets.only(left: 5),
                                                size: BsButtonSize.btnSm,
                                                onPressed: () =>
                                                    customFieldPresenter.popup(
                                                      context,
                                                    ),
                                                label: Text('Customize Fields'))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ),
                      BsCol(
                        margin: EdgeInsets.only(top: 10),
                        child: Obx(() => Container(
                              decoration: BoxDecoration(
                                color: _navigation.darkTheme.value
                                    ? ColorPallates.elseDarkColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Organization'),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            BsButton(
                                                onPressed: () {},
                                                label: Icon(
                                                  Icons.edit,
                                                  size: 13,
                                                )),
                                            // BsButton(
                                            //     onPressed: () {},
                                            //     label: Icon(
                                            //       Icons.edit,
                                            //       size: 13,
                                            //     )),
                                            // BsButton(
                                            //     onPressed: () {},
                                            //     label: Icon(
                                            //       Icons.edit,
                                            //       size: 13,
                                            //     )),
                                            // BsButton(
                                            //     onPressed: () {},
                                            //     label: Icon(
                                            //       Icons.edit,
                                            //       size: 13,
                                            //     )),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                CircleAvatar(
                                                  child: Icon(Icons.domain),
                                                ),
                                                Text('Address')
                                              ],
                                            ),
                                            Text(source.bpname.value)
                                          ],
                                        ),
                                        ExpansionTile(
                                          title: Text(
                                            "Title",
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          children: <Widget>[
                                            ListTile(
                                              subtitle: Text(
                                                  'data data data data data data data data'),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                BsCol(
                  margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
                  sizes: ColScreen(sm: Col.col_8),
                  child: BsRow(
                    children: [
                      BsCol(
                        child: Obx(() => Container(
                              decoration: BoxDecoration(
                                color: _navigation.darkTheme.value
                                    ? ColorPallates.elseDarkColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Container(
                                      child: TabBar(
                                        controller: _tabController,
                                        labelColor: Colors.green,
                                        unselectedLabelColor: Colors.black,
                                        tabs: [
                                          Tab(
                                              text: 'Notes',
                                              icon: Icon(Icons.note)),
                                          Tab(
                                              text: 'Assign',
                                              icon: Icon(Icons.group)),
                                          Tab(
                                              text: 'Report',
                                              icon: Icon(
                                                  Icons.description_outlined)),
                                          Tab(
                                              text: 'Product',
                                              icon: Icon(Icons.sell)),
                                          Tab(
                                              text: 'Call',
                                              icon: Icon(Icons.phone)),
                                          Tab(
                                              text: 'Files',
                                              icon: Icon(Icons.file_copy)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 200,
                                      child: TabBarView(
                                        controller: _tabController,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [Text('Notes')],
                                          ),
                                          if (source.assign.length != 0)
                                            SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    margin: EdgeInsets.only(
                                                        top: 15, bottom: 10),
                                                    child: Text(
                                                      'This Prospect is Assigned to : ',
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  Obx(() => Container(
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: source
                                                              .assign.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            var assigns = source
                                                                .assign[index];
                                                            return BsRow(
                                                              margin: source.assign[
                                                                          index] ==
                                                                      0
                                                                  ? EdgeInsets
                                                                      .zero
                                                                  : EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              20),
                                                              children: [
                                                                BsCol(
                                                                  sizes: ColScreen(
                                                                      sm: Col
                                                                          .col_1),
                                                                  child: Text(
                                                                      '${index + 1} )'),
                                                                ),
                                                                BsCol(
                                                                  sizes: ColScreen(
                                                                      sm: Col
                                                                          .col_11),
                                                                  child:
                                                                      InkWell(
                                                                    onLongPress:
                                                                        (() {
                                                                      Get.defaultDialog(
                                                                          middleText:
                                                                              '',
                                                                          title:
                                                                              'Setting',
                                                                          actions: [
                                                                            ButtonEditDatatables(onPressed:
                                                                                () {
                                                                              assignPresenter.edit(context, assigns.prospectassignid, source.prospectid.value);
                                                                            }),
                                                                            ButtonDeleteDatatables(onPressed:
                                                                                () {
                                                                              assignPresenter.delete(context, assigns.prospectassignid, 'Assignment for ${assigns.prospectassign.userfullname}');
                                                                            }),
                                                                          ]);
                                                                    }),
                                                                    onTap: () {
                                                                      assignPresenter.detail(
                                                                          context,
                                                                          assigns
                                                                              .prospectassignid);
                                                                    },
                                                                    child:
                                                                        BsRow(
                                                                      children: [
                                                                        BsCol(
                                                                          sizes:
                                                                              ColScreen(sm: Col.col_2),
                                                                          child:
                                                                              Text("Name"),
                                                                        ),
                                                                        BsCol(
                                                                          sizes:
                                                                              ColScreen(sm: Col.col_1),
                                                                          child:
                                                                              Text(':'),
                                                                        ),
                                                                        BsCol(
                                                                          sizes:
                                                                              ColScreen(sm: Col.col_9),
                                                                          child: Text(assigns
                                                                              .prospectassign
                                                                              .user
                                                                              .userfullname),
                                                                        ),
                                                                        BsCol(
                                                                          margin:
                                                                              EdgeInsets.only(top: 5),
                                                                          sizes:
                                                                              ColScreen(sm: Col.col_2),
                                                                          child:
                                                                              Text("Email"),
                                                                        ),
                                                                        BsCol(
                                                                          margin:
                                                                              EdgeInsets.only(top: 5),
                                                                          sizes:
                                                                              ColScreen(sm: Col.col_1),
                                                                          child:
                                                                              Text(':'),
                                                                        ),
                                                                        BsCol(
                                                                          margin:
                                                                              EdgeInsets.only(top: 5),
                                                                          sizes:
                                                                              ColScreen(sm: Col.col_9),
                                                                          child: Text(assigns
                                                                              .prospectassign
                                                                              .user
                                                                              .useremail),
                                                                        ),
                                                                        BsCol(
                                                                          margin:
                                                                              EdgeInsets.only(top: 5),
                                                                          sizes:
                                                                              ColScreen(sm: Col.col_2),
                                                                          child:
                                                                              Text("Phone"),
                                                                        ),
                                                                        BsCol(
                                                                          margin:
                                                                              EdgeInsets.only(top: 5),
                                                                          sizes:
                                                                              ColScreen(sm: Col.col_1),
                                                                          child:
                                                                              Text(':'),
                                                                        ),
                                                                        BsCol(
                                                                          margin:
                                                                              EdgeInsets.only(top: 5),
                                                                          sizes:
                                                                              ColScreen(sm: Col.col_9),
                                                                          child: Text(assigns
                                                                              .prospectassign
                                                                              .user
                                                                              .userphone),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            )
                                          else
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    'This Prospect is not Assigned')
                                              ],
                                            ),
                                          if (source.assign.length != 0)
                                            SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    margin: EdgeInsets.only(
                                                        top: 15, bottom: 10),
                                                    child: Text(
                                                      'This Prospect is Reported to : ',
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  Obx(() => Container(
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: source
                                                              .report.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            var reports = source
                                                                .report[index];
                                                            return BsRow(
                                                              margin: source.report[
                                                                          index] ==
                                                                      0
                                                                  ? EdgeInsets
                                                                      .zero
                                                                  : EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              20),
                                                              children: [
                                                                BsCol(
                                                                  sizes: ColScreen(
                                                                      sm: Col
                                                                          .col_1),
                                                                  child: Text(
                                                                      '${index + 1} )'),
                                                                ),
                                                                BsCol(
                                                                  sizes: ColScreen(
                                                                      sm: Col
                                                                          .col_11),
                                                                  child: BsRow(
                                                                    children: [
                                                                      BsCol(
                                                                        sizes: ColScreen(
                                                                            sm: Col.col_2),
                                                                        child: Text(
                                                                            "Name"),
                                                                      ),
                                                                      BsCol(
                                                                        sizes: ColScreen(
                                                                            sm: Col.col_1),
                                                                        child: Text(
                                                                            ':'),
                                                                      ),
                                                                      BsCol(
                                                                        sizes: ColScreen(
                                                                            sm: Col.col_9),
                                                                        child: Text(reports
                                                                            .prospectreport
                                                                            .user
                                                                            .userfullname),
                                                                      ),
                                                                      BsCol(
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                5),
                                                                        sizes: ColScreen(
                                                                            sm: Col.col_2),
                                                                        child: Text(
                                                                            "Email"),
                                                                      ),
                                                                      BsCol(
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                5),
                                                                        sizes: ColScreen(
                                                                            sm: Col.col_1),
                                                                        child: Text(
                                                                            ':'),
                                                                      ),
                                                                      BsCol(
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                5),
                                                                        sizes: ColScreen(
                                                                            sm: Col.col_9),
                                                                        child: Text(reports
                                                                            .prospectreport
                                                                            .user
                                                                            .useremail),
                                                                      ),
                                                                      BsCol(
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                5),
                                                                        sizes: ColScreen(
                                                                            sm: Col.col_2),
                                                                        child: Text(
                                                                            "Phone"),
                                                                      ),
                                                                      BsCol(
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                5),
                                                                        sizes: ColScreen(
                                                                            sm: Col.col_1),
                                                                        child: Text(
                                                                            ':'),
                                                                      ),
                                                                      BsCol(
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                5),
                                                                        sizes: ColScreen(
                                                                            sm: Col.col_9),
                                                                        child: Text(reports
                                                                            .prospectreport
                                                                            .user
                                                                            .userphone),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            )
                                          else
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    'This Reported Prospect Has Not Been Defined')
                                              ],
                                            ),
                                          if (source.product.length != 0)
                                            SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    margin: EdgeInsets.only(
                                                        top: 15, bottom: 10),
                                                    child: Text(
                                                      'Prospect Product : ',
                                                      style: TextStyle(
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                  Obx(() => Container(
                                                        child: ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: source
                                                              .product.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            var products =
                                                                source.product[
                                                                    index];
                                                            return BsRow(
                                                              margin: source.product[
                                                                          index] ==
                                                                      0
                                                                  ? EdgeInsets
                                                                      .zero
                                                                  : EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              20),
                                                              children: [
                                                                BsCol(
                                                                  sizes: ColScreen(
                                                                      sm: Col
                                                                          .col_1),
                                                                  child: Text(
                                                                      '${index + 1} )'),
                                                                ),
                                                                BsCol(
                                                                  sizes: ColScreen(
                                                                      sm: Col
                                                                          .col_11),
                                                                  child:
                                                                      InkWell(
                                                                    onTap: () {
                                                                      productPresenter.detail(
                                                                          context,
                                                                          products
                                                                              .prosproductid);
                                                                    },
                                                                    onLongPress:
                                                                        () {
                                                                      Get.defaultDialog(
                                                                          middleText:
                                                                              '',
                                                                          title:
                                                                              'Setting',
                                                                          actions: [
                                                                            ButtonEditDatatables(onPressed:
                                                                                () {
                                                                              productPresenter.edit(context, products.prosproductid, source.prospectid.value);
                                                                            }),
                                                                            ButtonDeleteDatatables(onPressed:
                                                                                () {
                                                                              productPresenter.delete(context, products.prosproductid, '${products.prosproductproduct?.productname}');
                                                                            }),
                                                                          ]);
                                                                    },
                                                                    child:
                                                                        BsRow(
                                                                      children: [
                                                                        BsCol(
                                                                          sizes:
                                                                              ColScreen(sm: Col.col_2),
                                                                          child:
                                                                              Text("Name"),
                                                                        ),
                                                                        BsCol(
                                                                          sizes:
                                                                              ColScreen(sm: Col.col_1),
                                                                          child:
                                                                              Text(':'),
                                                                        ),
                                                                        BsCol(
                                                                          sizes:
                                                                              ColScreen(sm: Col.col_9),
                                                                          child: Text(products
                                                                              .prosproductproduct
                                                                              ?.productname),
                                                                        ),
                                                                        BsCol(
                                                                          margin:
                                                                              EdgeInsets.only(top: 5),
                                                                          sizes:
                                                                              ColScreen(sm: Col.col_2),
                                                                          child:
                                                                              Text("Amount"),
                                                                        ),
                                                                        BsCol(
                                                                          margin:
                                                                              EdgeInsets.only(top: 5),
                                                                          sizes:
                                                                              ColScreen(sm: Col.col_1),
                                                                          child:
                                                                              Text(':'),
                                                                        ),
                                                                        BsCol(
                                                                          margin:
                                                                              EdgeInsets.only(top: 5),
                                                                          sizes:
                                                                              ColScreen(sm: Col.col_9),
                                                                          child:
                                                                              Text('Rp. ' + currencyFormatter.format(double.parse(products.prosproductamount))),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            )
                                          else
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    'This Prospect Don\'t Have Product')
                                              ],
                                            ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [Text('Call')],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [Text('Files')],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )),
                      ),
                      BsCol(
                        margin: EdgeInsets.only(top: 10),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  BsBadge(
                                    child: Text('PLANNED'),
                                  ),
                                  if (source.detailData.length == 0)
                                    Column(
                                      children: [
                                        Text(
                                            'You have no upcoming activities.'),
                                        SizedBox(height: 10),
                                        InkWell(
                                          child: Text('+ Schedule an activity'),
                                          onTap: () => detailPresenter.add(
                                              context, source.prospectid.value),
                                        ),
                                      ],
                                    )
                                  else
                                    Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.topRight,
                                          child: BsButton(
                                              style: BsButtonStyle.success,
                                              onPressed: () =>
                                                  detailPresenter.add(context,
                                                      source.prospectid.value),
                                              label: Text('Add Activity')),
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: source.detailData.length,
                                            itemBuilder: (context, index) {
                                              var schedule =
                                                  source.detailData[index];

                                              return InkWell(
                                                onLongPress: () {
                                                  Get.defaultDialog(
                                                      middleText: '',
                                                      title: 'Setting',
                                                      actions: [
                                                        ButtonEditDatatables(
                                                            onPressed: () {
                                                          detailPresenter.edit(
                                                              context,
                                                              schedule
                                                                  .prospectactivityid,
                                                              source.prospectid
                                                                  .value);
                                                        }),
                                                        ButtonDeleteDatatables(
                                                            onPressed: () {
                                                          detailPresenter.delete(
                                                              context,
                                                              schedule
                                                                  .prospectactivityid,
                                                              '${schedule.prospectactivitytype!.typename} at ${schedule.prospectactivitydate}');
                                                        }),
                                                      ]);
                                                },
                                                onTap: () {
                                                  detailPresenter.detail(
                                                      context,
                                                      schedule
                                                          .prospectactivityid);
                                                },
                                                child: BsRow(
                                                  children: [
                                                    BsCol(
                                                        sizes: ColScreen(
                                                            sm: Col.col_1),
                                                        child: Column(
                                                          children: [
                                                            OutlinedDotIndicator(),
                                                            SizedBox(
                                                              height: 50.0,
                                                              child:
                                                                  SolidLineConnector(),
                                                            )
                                                          ],
                                                        )),
                                                    BsCol(
                                                        alignment:
                                                            Alignment.center,
                                                        sizes: ColScreen(
                                                            sm: Col.col_3),
                                                        child: Text(schedule
                                                            .prospectactivitydate)),
                                                    BsCol(
                                                        sizes: ColScreen(
                                                            sm: Col.col_8),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              schedule
                                                                  .prospectactivitycat
                                                                  .typename,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(top: 5),
                                                              child: Text(schedule
                                                                  .prospectactivitytype
                                                                  .typename),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ],
                                    )
                                ],
                              ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Column(
                              //   children: [
                              //     BsBadge(
                              //       child: Text('DONE'),
                              //     ),
                              //     Column(
                              //       children: [
                              //         Text(
                              //             'You don\'t have complete activities.'),
                              //       ],
                              //     ),
                              //   ],
                              // ),

                              // SizedBox(
                              //   height: 30,
                              // ),
                              // Container(
                              //   child: TabBar(
                              //     controller: _tabControllerTimeline,
                              //     labelColor: Colors.green,
                              //     unselectedLabelColor: Colors.black,
                              //     tabs: [
                              //       Tab(text: 'All'),
                              //       Tab(text: 'Activity'),
                              //       Tab(text: 'Notes'),
                              //       Tab(text: 'Email'),
                              //       Tab(text: 'Invoices'),
                              //       Tab(text: 'Documents'),
                              //       Tab(text: 'Files'),
                              //       Tab(text: 'Changelog'),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   width: double.infinity,
                              //   height: 200,
                              //   child: TabBarView(
                              //     controller: _tabControllerTimeline,
                              //     children: [
                              //       Container(
                              //         margin: EdgeInsets.only(top: 20),
                              //         child: Column(
                              //           mainAxisAlignment:
                              //               MainAxisAlignment.center,
                              //           children: [
                              //             BsRow(
                              //               children: [
                              //                 BsCol(
                              //                     sizes:
                              //                         ColScreen(sm: Col.col_1),
                              //                     child: Column(
                              //                       children: [
                              //                         OutlinedDotIndicator(),
                              //                         SizedBox(
                              //                           height: 50.0,
                              //                           child:
                              //                               SolidLineConnector(),
                              //                         )
                              //                       ],
                              //                     )),
                              //                 BsCol(
                              //                     sizes:
                              //                         ColScreen(sm: Col.col_2),
                              //                     child: Text('Today')),
                              //                 BsCol(
                              //                     sizes:
                              //                         ColScreen(sm: Col.col_9),
                              //                     child: Column(
                              //                       crossAxisAlignment:
                              //                           CrossAxisAlignment
                              //                               .start,
                              //                       children: [
                              //                         Text(
                              //                           'Meeting',
                              //                           style: TextStyle(
                              //                               fontWeight:
                              //                                   FontWeight
                              //                                       .bold),
                              //                         ),
                              //                         Text('at Town Hall'),
                              //                       ],
                              //                     )),
                              //                 BsCol(
                              //                     sizes:
                              //                         ColScreen(sm: Col.col_1),
                              //                     child: Column(
                              //                       children: [
                              //                         OutlinedDotIndicator()
                              //                       ],
                              //                     )),
                              //                 BsCol(
                              //                     sizes:
                              //                         ColScreen(sm: Col.col_2),
                              //                     child: Text('Yesterday')),
                              //                 BsCol(
                              //                     sizes:
                              //                         ColScreen(sm: Col.col_9),
                              //                     child: Column(
                              //                       crossAxisAlignment:
                              //                           CrossAxisAlignment
                              //                               .start,
                              //                       children: [
                              //                         Text(
                              //                           'Meeting',
                              //                           style: TextStyle(
                              //                               fontWeight:
                              //                                   FontWeight
                              //                                       .bold),
                              //                         ),
                              //                         Text('at Town Hall'),
                              //                       ],
                              //                     )),
                              //               ],
                              //             )
                              //           ],
                              //         ),
                              //       ),
                              //       Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //         children: [Text('Activity')],
                              //       ),
                              //       Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //         children: [Text('Notes')],
                              //       ),
                              //       Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //         children: [Text('Email')],
                              //       ),
                              //       Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //         children: [Text('Invoices')],
                              //       ),
                              //       Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //         children: [Text('Documents')],
                              //       ),
                              //       Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //         children: [Text('Files')],
                              //       ),
                              //       Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.center,
                              //         children: [Text('Changelog')],
                              //       ),
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void onSuccessFetchData(Response response) {
    List products = [];
    List assign = [];
    List report = [];
    ProspectModel dt = ProspectModel.fromJson(response.body);
    source.prospectid.value = dt.prospectid!;

    detailPresenter.details(context, {'id': dt.prospectid.toString()});

    source.prospectname.value = dt.prospectname ?? '';
    source.prospectvalue.value = dt.prospectvalue ?? '0.0';
    source.userfullname.value = dt.prospectowneruser!.user!.userfullname ?? '';
    source.bpname.value = dt.prospectbp!.bpname ?? '';
    source.prospectstartdate.value = dt.prospectstartdate ?? '';
    source.prospectStageController.selected = dt.prospectstage;

    if (dt.prospectassigns != null) {
      dt.prospectassigns?.forEach((element) {
        assign.add(element);
        report.add(element);
        source.assign.value = assign;
        source.report.value = assign;
      });
    }
    if (dt.prospectproduct != null) {
      dt.prospectproduct?.forEach((element) {
        products.add(element);
      });
      source.product.value = products;
      presenter.setProcessing(false);
    }
  }

  @override
  void onLoadSuccess(Response response) {
    source.prospectStageController.options = List<TypeModel>.from(
      response.body.map((data) {
        return TypeModel.fromJson(data);
      }),
    );
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    map.reset();
    detailPresenter.setProcessing(false);
    assignPresenter.setProcessing(false);
    Navigator.pop(context!);
    presenter.details(context, source.prospectid.value);
    Snackbar().createSuccess();
    detailPresenter
        .details(context, {'id': source.prospectid.value.toString()});
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    map.reset();
    detailPresenter.setProcessing(false);
    assignPresenter.setProcessing(false);
    Navigator.pop(context!);
    Navigator.pop(context);
    presenter.details(context, source.prospectid.value);
    Snackbar().deleteSuccess();
    detailPresenter
        .details(context, {'id': source.prospectid.value.toString()});
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    map.reset();
    detailPresenter.setProcessing(false);
    assignPresenter.setProcessing(false);
    if (context != null) Navigator.pop(context);
    Navigator.pop(context!);
    presenter.details(context, source.prospectid.value);
    Snackbar().editSuccess();
    detailPresenter
        .details(context, {'id': source.prospectid.value.toString()});
  }

  @override
  void onErrorRequest(Response response) {
    detailPresenter.setProcessing(false);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    List x = [];
    for (var item in response.body) {
      x.add(ProspectActivityModel.fromJson(item));
    }
    source.detailData.value = x;
  }
}
