import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/details_view_contract.dart';
import '../../../models/ventes/customfield_model.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../presenters/settings/customfield_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/form_group.dart';
import '../../skins/template.dart';
import '../company/company_setting/tabs/tabCustomizeField_source/customfield_presenter.dart';
import '_details_source.dart';
import '_text.dart';

final _navigation = Get.find<NavigationPresenter>();

class CustomFieldDetails extends GetView implements DetailViewContract {
  final CustomFieldPresenter presenter = Get.find<CustomFieldPresenter>();
  final CustomFieldsPresenter presenters = Get.find<CustomFieldsPresenter>();
  final CustomFieldDetailsSource controller = Get.put(CustomFieldDetailsSource());

  final String data;

  CustomFieldDetails(this.data) {
    Get.delete<CustomFieldDetailsSource>();
    presenter.customFieldDataDetailsContract = this;
    presenters.customFieldDataDetailsContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: CustomFieldText.title + ' Details',
        breadcrumbs: [
          BreadcrumbWidget('Settings'),
          BreadcrumbWidget('Custom Fields', active: true),
          BreadcrumbWidget('Custom Field Details', active: true),
        ],
        activeRoutes: [RouteList.settings.index, RouteList.settingsCustomField.index],
        back: true,
        child: Obx(() => BsRow(
              children: [
                BsCol(
                    sizes: ColScreen(lg: Col.col_6),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: _navigation.darkTheme.value ? ColorPallates.elseDarkColor : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: BsRow(
                        children: [
                          BsCol(
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Name', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [Text(controller.name.value), Divider()],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Type', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [Text(controller.type.value), Divider()],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Business Partner', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [Text(controller.bp.value), Divider()],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 10),
                              sizes: ColScreen(lg: Col.col_12),
                              child: FormGroup(
                                  label: Text('Security Group', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [Text(controller.bp.value), Divider()],
                                  ))),
                          if (controller.newprospect.value)
                            BsCol(
                                margin: EdgeInsets.only(top: 10),
                                sizes: ColScreen(lg: Col.col_12),
                                child: FormGroup(
                                    label: Text('Available at All $data', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [Text(controller.newprospect.value ? 'Yes' : 'No'), Divider()],
                                    ))),
                          if (controller.isvisible.value)
                            BsCol(
                                margin: EdgeInsets.only(top: 10),
                                sizes: ColScreen(lg: Col.col_12),
                                child: FormGroup(
                                    label: Text('Available at', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [Text('${controller.ref.value}'), Divider()],
                                    ))),
                          if (controller.isselectbox.value)
                            BsCol(
                                margin: EdgeInsets.only(top: 10),
                                sizes: ColScreen(lg: Col.col_12),
                                child: FormGroup(
                                    label: Text('Option', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: controller.selectbox
                                          .map((element) => Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [Text(element.optvalue ?? ''), Divider()],
                                              ))
                                          .toList(),
                                    ))),
                        ],
                      ),
                    )),
                BsCol(
                    margin: EdgeInsets.only(left: 10),
                    sizes: ColScreen(lg: Col.col_6),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: _navigation.darkTheme.value ? ColorPallates.elseDarkColor : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: BsRow(
                        children: [
                          BsCol(
                            child: FormGroup(
                                label: Text('Created By', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text(controller.createdby.value), Divider()],
                                )),
                          ),
                          BsCol(
                            margin: EdgeInsets.only(top: 10),
                            child: FormGroup(
                                label: Text('Created At', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text(controller.createddate.value), Divider()],
                                )),
                          ),
                          BsCol(
                            margin: EdgeInsets.only(top: 10),
                            child: FormGroup(
                                label: Text('Last Updated By', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text(controller.updatedby.value), Divider()],
                                )),
                          ),
                          BsCol(
                            margin: EdgeInsets.only(top: 10),
                            child: FormGroup(
                                label: Text('Last Updated At', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [Text(controller.updateddate.value), Divider()],
                                )),
                          ),
                          BsCol(
                            margin: EdgeInsets.only(top: 10),
                            child: FormGroup(
                                label: Text('Is Active', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (controller.isactive.value)
                                      Card(
                                        color: Colors.green,
                                        child: Text('Active', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                      )
                                    else
                                      Card(
                                        color: Colors.red,
                                        child: Text('Not Active', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                      ),
                                    Divider()
                                  ],
                                )),
                          ),
                        ],
                      ),
                    )),
              ],
            )),
      ),
    );
  }

  @override
  void onSuccessFetchData(Response response) {
    CustomFieldModel dt = CustomFieldModel.fromJson(response.body);
    controller.name.value = dt.custfname ?? '-';
    controller.type.value = dt.custftype!.typename ?? '-';
    controller.bp.value = dt.businesspartner!.bpname ?? '-';
    controller.group.value = dt.securitygroup?.sgname ?? "-";
    controller.isvisible.value = dt.onlythisdata!;
    controller.newprospect.value = dt.alldata!;

    if (dt.selectoption != []) {
      controller.isselectbox.value = true;
      controller.selectbox.value = dt.selectoption!;
    }

    if (dt.custfreftype?.typename == 'Prospect')
      controller.ref.value = '${dt.refprospect?.prospectname ?? '-'} || ${dt.refprospect?.prospectcust?.sbccstmname ?? '-'}';
    else
      controller.ref.value = '${dt.refactivity?.dayactloclabel ?? '-'} || ${dt.refactivity?.dayactdate ?? '-'}';

    controller.createdby.value = dt.custfcreatedby?.userfullname ?? '-';
    controller.createddate.value = dt.createddate ?? '';
    controller.updatedby.value = dt.custfupdatedby?.userfullname ?? '-';
    controller.updateddate.value = dt.updateddate ?? '';
    controller.isactive.value = dt.isactive!;
    presenter.setProcessing(false);
    presenters.setProcessing(false);
  }
}
