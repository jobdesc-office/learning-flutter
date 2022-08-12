import 'dart:typed_data';

import 'package:boilerplate/models/ventes/customfield_model.dart';
import 'package:boilerplate/views/skins/template.dart';
import 'package:boilerplate/views/ventes/prospect/prospectdetail_component/title_section.dart';
import 'package:boilerplate/widgets/button/button_edit_datatable.dart';
import 'package:boilerplate/widgets/datatables/custom_datatable.dart';
import 'package:bs_flutter_buttons/bs_flutter_buttons.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/base_text.dart';
import '../../../contracts/base/details_view_contract.dart';
import '../../../contracts/base/index_view_contract.dart';
import '../../../contracts/ventes/customfield_contract.dart';
import '../../../contracts/ventes/prospectcustomfield_contract.dart';
import '../../../models/masters/type_model.dart';
import '../../../models/ventes/prospect_model.dart';
import '../../../models/ventes/prospectactivity_model.dart';
import '../../../models/ventes/prospectcustomfield_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/settings/customfield_presenter.dart';
import '../../../presenters/ventes/prospect_presenter.dart';
import '../../../presenters/ventes/prospectassign_presenter.dart';
import '../../../presenters/ventes/prospectactivity_presenter.dart';
import '../../../presenters/ventes/prospectcontact_presenter.dart';
import '../../../presenters/ventes/prospectcustomfield_presenter.dart';
import '../../../presenters/ventes/prospectfile_presenter.dart';
import '../../../presenters/ventes/prospectproduct_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/button_controller.dart';
import '../../../widgets/button/button_delete_datatable.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';
import '../../../widgets/map/_map_source.dart';
import '../../../widgets/snackbar.dart';
import '_detail_source.dart';
import 'prospectcontact/_datatable_source.dart';
import 'prospectdetail_component/_stagePipeline.dart';
import 'customfield/_form_source.dart';
import 'prospectcustomfield/_form_source.dart';
import 'prospectdetail_component/activity_section.dart';
import 'prospectfiles/image_picture.dart';

part 'prospectdetail_component/customizefield_section.dart';

part 'prospectdetail_component/tabs/tabNote.dart';
part 'prospectdetail_component/tabs/tabAssign.dart';
part 'prospectdetail_component/tabs/tabReport.dart';
part 'prospectdetail_component/tabs/tabProduct.dart';
part 'prospectdetail_component/tabs/tabContact.dart';
part 'prospectdetail_component/tabs/tabFile.dart';

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
  final contactPresenter = Get.find<ProspectContactPresenter>();
  final filePresenter = Get.find<ProspectFilePresenter>();
  final prospectCustomFieldPresenter = Get.find<ProspectCustomFieldPresenter>();
  final presenter = Get.find<ProspectPresenter>();
  final source = Get.put(ProspectDetailsSource());
  final controller = Get.put(ButtonController());
  final map = Get.put(MapSource());
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
    _tabController = TabController(length: 7, vsync: this);
    // _tabControllerTimeline = TabController(length: 8, vsync: this);
    presenter.prospectTypeViewDetailContract = this;
    presenter.prospectDetailsViewContract = this;
    detailPresenter.prospectViewContract = this;
    assignPresenter.prospectViewContract = this;
    productPresenter.prospectViewContract = this;
    contactPresenter.prospectViewContract = this;
    filePresenter.prospectViewContract = this;
    customFieldPresenter.setCustomFieldContract = this;
    customFieldPresenter.customFieldViewContract = this;
    prospectCustomFieldPresenter.prospectViewContract = this;
    prospectCustomFieldPresenter.setcustomFieldContract = this;

    customFieldPresenter.allBp(context);
  }

  final _navigation = Get.find<NavigationPresenter>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Prospect Details',
        breadcrumbs: [
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
                                              text: 'Activities',
                                              icon: Icon(Icons.local_activity)),
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
                                              text: 'Contact',
                                              icon: Icon(Icons.phone)),
                                          Tab(
                                              text: 'Files',
                                              icon: Icon(Icons.file_copy)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 330,
                                      child: TabBarView(
                                        controller: _tabController,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.all(5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      margin: EdgeInsets.only(
                                                          top: 10, bottom: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Activities :',
                                                            style: TextStyle(
                                                                fontSize: 18),
                                                          ),
                                                          BsButton(
                                                              style:
                                                                  BsButtonStyle
                                                                      .success,
                                                              onPressed: () =>
                                                                  detailPresenter.add(
                                                                      context,
                                                                      source
                                                                          .prospectid
                                                                          .value),
                                                              label: Text(
                                                                  'Add Activity')),
                                                        ],
                                                      ),
                                                    ),
                                                    prospectDetailActivitySection(
                                                        context)
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          _tabNote(),
                                          _tabAssign(),
                                          _tabReport(),
                                          _tabProduct(),
                                          _tabContact(),
                                          _tabFile(),
                                        ],
                                      ),
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
                  sizes: ColScreen(sm: Col.col_4),
                  child: BsRow(
                    children: [
                      BsCol(
                        child: CustomfieldSection(),
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
    List<Cstmcontact> contact = [];
    List<ProspectCustomFieldModel> customField = [];
    List<Prospectfiles> files = [];
    ProspectModel dt = ProspectModel.fromJson(response.body);
    source.prospectid.value = dt.prospectid!;
    source.prospectbpid.value = dt.prospectbp!.bpid!;
    source.desc.value = dt.prospectdescription ?? '';
    source.status.value = dt.prospectstatus!.typename!;
    customFieldPresenter.allBp(context);

    detailPresenter.details(context, {'id': dt.prospectid.toString()});

    source.prospectname.value = dt.prospectname ?? '';
    source.prospectvalue.value = dt.prospectvalue ?? '0.0';
    source.userfullname.value = dt.prospectownerusers!.userfullname ?? '';
    source.bpname.value = dt.prospectbp!.bpname ?? '';
    source.prospectstartdate.value = dt.prospectstartdate ?? '';
    source.prospectStageController.selected = dt.prospectstage;
    source.custname.value = dt.prospectcust!.sbccstmname ?? '';
    source.custid.value = dt.prospectcust!.sbccstm!.cstmid ?? 0;

    if (dt.prospectlostreasonid != null) {
      source.losttype.value = dt.prospectlost!.typename!;
      source.lostdesc.value = dt.prospectlostdesc!;
    }

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
    if (dt.prospectcust!.sbccstm!.cstmcontact != null) {
      dt.prospectcust!.sbccstm!.cstmcontact?.forEach((element) {
        contact.add(element);
      });
      source.contact.value = contact;
    }
    if (dt.prospectfiles != null) {
      dt.prospectfiles?.forEach((element) {
        files.add(element);
      });
      source.files.value = files;
    }
    presenter.setProcessing(false);
  }

  @override
  void onLoadSuccess(Response response) {
    source.prospectStageController.options = List<TypeModel>.from(
      response.body.map((data) {
        return TypeModel.fromJson(data);
      }),
    ).toList();
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    map.reset();
    prospectCustomFieldPresenter.setProcessing(false);
    customFieldPresenter.setProcessing(false);
    detailPresenter.setProcessing(false);
    assignPresenter.setProcessing(false);
    filePresenter.setProcessing(false);
    productPresenter.setProcessing(false);
    source.pickedFile.clear();
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
    Get.back();
    Navigator.pop(context!);
    presenter.details(context, source.prospectid.value);
    Snackbar().deleteSuccess();
    detailPresenter
        .details(context, {'id': source.prospectid.value.toString()});
    customFieldPresenter.allBp(context);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    map.reset();
    Navigator.pop(context!);
    Navigator.pop(context);
    presenter.details(context, source.prospectid.value);
    Snackbar().editSuccess();
    detailPresenter
        .details(context, {'id': source.prospectid.value.toString()});
    customFieldPresenter.allBp(context);
    prospectCustomFieldPresenter.setProcessing(false);
    detailPresenter.setProcessing(false);
    assignPresenter.setProcessing(false);
    contactPresenter.setProcessing(false);
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
        element.onlythisprospect == true &&
        element.thisprospectid != source.prospectid.value);
    cf.removeWhere((element) =>
        element.allprospect == false && element.onlythisprospect == false);
    source.rawcustomField.value = cf;
  }
}
