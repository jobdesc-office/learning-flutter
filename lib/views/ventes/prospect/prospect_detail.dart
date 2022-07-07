import 'dart:html';

import 'package:boilerplate/models/ventes/customfield_model.dart';
import 'package:boilerplate/views/skins/template.dart';
import 'package:boilerplate/views/ventes/prospect/prospectdetail_component/title_section.dart';
import 'package:boilerplate/widgets/button/button_edit_datatable.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';

import '../../../constants/base_text.dart';
import '../../../contracts/base/details_view_contract.dart';
import '../../../contracts/base/index_view_contract.dart';
import '../../../contracts/ventes/customfield_contract.dart';
import '../../../contracts/ventes/prospectcustomfield_contract.dart';
import '../../../models/masters/type_model.dart';
import '../../../models/ventes/prospect_model.dart';
import '../../../models/ventes/prospectactivity_model.dart';
import '../../../models/ventes/prospectcustomfield_model.dart';
import '../../../presenters/auth_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/ventes/customfield_presenter.dart';
import '../../../presenters/ventes/prospect_presenter.dart';
import '../../../presenters/ventes/prospectassign_presenter.dart';
import '../../../presenters/ventes/prospectactivity_presenter.dart';
import '../../../presenters/ventes/prospectcustomfield_presenter.dart';
import '../../../presenters/ventes/prospectproduct_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/button_controller.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/button_info_assign.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';
import '../../../widgets/confirm_dialog.dart';
import '../../../widgets/map/_map_source.dart';
import '../../../widgets/snackbar.dart';
import '_detail_source.dart';
import 'prospectdetail_component/_stagePipeline.dart';
import 'customfield/_form_source.dart';
import 'prospectcustomfield/_form_source.dart';
import 'prospectdetail_component/activity_section.dart';
import 'prospectdetail_component/customfield_section.dart';
import 'prospectdetail_component/organization_section.dart';

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
        IndexViewContract,
        ProspectCustomFieldContract,
        CustomFieldContract {
  late TabController _tabController;
  // late TabController _tabControllerTimeline;
  final detailPresenter = Get.find<ProspectActivityPresenter>();
  final assignPresenter = Get.find<ProspectAssignPresenter>();
  final productPresenter = Get.find<ProspectProductPresenter>();
  final customFieldPresenter = Get.find<CustomFieldPresenter>();
  final prospectCustomFieldPresenter = Get.find<ProspectCustomFieldPresenter>();
  final presenter = Get.find<ProspectPresenter>();
  final source = Get.put(prospectDetailsSource());
  final controller = Get.put(ButtonController());
  final map = Get.put(mapSource());
  final cfForm = ProspectCustomFieldSource().obs;
  final cfieldForm = CustomFieldSource().obs;
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final GlobalKey<FormState> formStateCF = GlobalKey<FormState>();

  late ProspectCustomFieldForm prospectCustomFieldForm;
  late CustomFieldForm customFieldForm;

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
    customFieldPresenter.setCustomFieldContract = this;
    customFieldPresenter.CustomFieldViewContract = this;
    prospectCustomFieldPresenter.prospectViewContract = this;
    prospectCustomFieldPresenter.setcustomFieldContract = this;

    customFieldPresenter.allBp(context);
  }

  final _navigation = Get.find<NavigationPresenter>();
  final _auth = Get.put(AuthPresenter());

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
                prospectDetailTitleSection(context),
                BsCol(
                  margin: EdgeInsets.fromLTRB(0, 0, 5, 5),
                  sizes: ColScreen(sm: Col.col_4),
                  child: BsRow(
                    children: [
                      prospectDetailCustomFieldSection(context),
                      prospectDetailOrganizationSection(context),
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
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        margin: EdgeInsets.only(
                                                            top: 15,
                                                            bottom: 10),
                                                        child: Text(
                                                          'This Prospect is Assigned to : ',
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                      BsButton(
                                                        style: BsButtonStyle
                                                            .success,
                                                        onPressed: () {
                                                          assignPresenter.add(
                                                              context,
                                                              source.prospectid
                                                                  .value);
                                                        },
                                                        prefixIcon:
                                                            Icons.assignment,
                                                        label: Text(
                                                            'Add Assignation'),
                                                      ),
                                                    ],
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
                                                                              .prospectassignss
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
                                                                              .prospectassignss
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
                                                                              .prospectassignss
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
                                                    'This Prospect is not Assigned'),
                                                BsButton(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  style: BsButtonStyle.success,
                                                  onPressed: () {
                                                    assignPresenter.add(
                                                        context,
                                                        source
                                                            .prospectid.value);
                                                  },
                                                  prefixIcon: Icons.assignment,
                                                  label:
                                                      Text('Add Assignation'),
                                                ),
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
                                                                            .prospectreportss
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
                                                                            .prospectreportss
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
                                                                            .prospectreportss
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
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        margin: EdgeInsets.only(
                                                            top: 15,
                                                            bottom: 10),
                                                        child: Text(
                                                          'Prospect Product : ',
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                      BsButton(
                                                        style: BsButtonStyle
                                                            .success,
                                                        onPressed: () {
                                                          productPresenter.add(
                                                              context,
                                                              source.prospectid
                                                                  .value);
                                                        },
                                                        prefixIcon:
                                                            Icons.shopping_bag,
                                                        label:
                                                            Text('Add Product'),
                                                      )
                                                    ],
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
                                                    'This Prospect Don\'t Have Product'),
                                                BsButton(
                                                  style: BsButtonStyle.success,
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  onPressed: () {
                                                    productPresenter.add(
                                                        context,
                                                        source
                                                            .prospectid.value);
                                                  },
                                                  prefixIcon:
                                                      Icons.shopping_bag,
                                                  label: Text('Add Product'),
                                                )
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
                              prospectDetailActivitySection(context),
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
  void dispose() {
    super.dispose();
    source.report.value = [];
    source.assign.value = [];

    source.isAdd.value = false;
    source.isAddCF.value = false;
  }

  @override
  void onSuccessFetchData(Response response) {
    List products = [];
    List assign = [];
    List report = [];
    List<ProspectCustomFieldModel> customField = [];
    ProspectModel dt = ProspectModel.fromJson(response.body);
    source.prospectid.value = dt.prospectid!;
    source.prospectbpid.value = dt.prospectbp!.bpid!;
    _auth.bpActiveId.value = dt.prospectbp!.bpid!;
    source.status.value = dt.prospectstatus!.typename!;
    customFieldPresenter.allBp(context);

    detailPresenter.details(context, {'id': dt.prospectid.toString()});

    source.prospectname.value = dt.prospectname ?? '';
    source.prospectvalue.value = dt.prospectvalue ?? '0.0';
    source.userfullname.value = dt.prospectownerusers!.userfullname ?? '';
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
    } else {
      source.assign.value = [];
      source.report.value = [];
    }
    if (dt.prospectproduct != null) {
      dt.prospectproduct?.forEach((element) {
        products.add(element);
      });
      source.product.value = products;
    }
    if (dt.prospectcustomfield != null) {
      dt.prospectcustomfield?.forEach((element) {
        customField.add(element);
      });
      source.customField.value = customField;
    }
    presenter.setProcessing(false);
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
    prospectCustomFieldPresenter.setProcessing(false);
    customFieldPresenter.setProcessing(false);
    detailPresenter.setProcessing(false);
    assignPresenter.setProcessing(false);
    Navigator.pop(context!);
    presenter.details(context, source.prospectid.value);
    Snackbar().createSuccess();
    detailPresenter
        .details(context, {'id': source.prospectid.value.toString()});
    customFieldPresenter.allBp(context);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    map.reset();
    prospectCustomFieldPresenter.setProcessing(false);
    detailPresenter.setProcessing(false);
    assignPresenter.setProcessing(false);
    Navigator.pop(context!);
    Navigator.pop(context);
    presenter.details(context, source.prospectid.value);
    Snackbar().deleteSuccess();
    detailPresenter
        .details(context, {'id': source.prospectid.value.toString()});
    customFieldPresenter.allBp(context);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    map.reset();
    presenter.details(context!, source.prospectid.value);
    Snackbar().editSuccess();
    detailPresenter
        .details(context, {'id': source.prospectid.value.toString()});
    customFieldPresenter.allBp(context);
    prospectCustomFieldPresenter.setProcessing(false);
    detailPresenter.setProcessing(false);
    assignPresenter.setProcessing(false);
    if (context != null) Navigator.pop(context);
    Navigator.pop(context);
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

  @override
  void onFetchCustomFieldErrorRequest(Response response) {}

  @override
  void onFetchCustomFieldSuccess(BuildContext context, Response response) {
    prospectCustomFieldPresenter.setProcessing(false);
    Navigator.pop(context);
    source.isAdd.value = true;
    ProspectCustomFieldModel prospect =
        ProspectCustomFieldModel.fromJson(response.body);
    cfForm.value.format.value = prospect.customfield!.custftype!.typename!;
    cfForm.value.inputValue.text = prospect.prospectcfvalue!;
    cfForm.value.selectCustomfield.setSelected(BsSelectBoxOption(
        value: prospect.prospectcustfid,
        text: Text(prospect.customfield!.custfname!)));
    source.isUpdate.value = true;
  }

  @override
  void onErrorCustomFieldRequest(Response response) {}

  @override
  void onLoadCustomFieldSuccess(BuildContext context, Response response) {
    List<CustomFieldModel> cf = [];
    for (var item in response.body) {
      var test = CustomFieldModel.fromJson(item);
      cf.add(test);
    }
    for (var item in source.customField) {
      cf.removeWhere((element) => element.custfid == item.prospectcustfid);
    }
    cf.removeWhere((element) =>
        element.onlyinnewprospect == true &&
        element.lastprospectid! > source.prospectid.value);
    cf.removeWhere((element) => element.isvisiblesidebar == false);
    source.rawcustomField.value = cf;
  }
}
