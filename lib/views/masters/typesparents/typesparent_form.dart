import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/masters/type_model.dart';
import '../../../presenters/masters/typeparent_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '../../../widgets/form_group.dart';
import '_form_source.dart';
import '_text.dart';

// ignore: must_be_immutable
class TypeParentFormView extends StatelessWidget implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final TypeParentPresenter presenter = Get.find<TypeParentPresenter>();
  final source = TypeParentSource().obs;
  final Function(Map<String, dynamic> body) onSave;
  final _navigation = Get.find<NavigationPresenter>();

  var isEdit = false.obs;

  late TypeParentForm tpForm;

  TypeParentFormView({required this.onSave}) {
    presenter.typeParentFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: TypeParentsText.title + ' Form',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Type'),
          BreadcrumbWidget('Type Parent', back: true),
          BreadcrumbWidget('Type Parent Form', active: true),
        ],
        activeRoutes: [
          RouteList.masterTypeParent.index,
          RouteList.masterTypeParent.index
        ],
        child: Obx(() {
          tpForm = TypeParentForm(source.value);
          return BsRow(
            children: [
              BsCol(
                sizes: ColScreen(
                  sm: Col.col_6,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _navigation.darkTheme.value
                        ? ColorPallates.elseDarkColor
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: formState,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        tpForm.inputCode(),
                        tpForm.inputName(),
                        tpForm.inputSeq(),
                        tpForm.inputDesc(),
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ThemeButtonSave(
                                disabled: presenter.isProcessing.value,
                                processing: presenter.isProcessing.value,
                                margin: EdgeInsets.only(right: 5),
                                onPressed: () => onClickSaveModal(context),
                              ),
                              ThemeButtonCancel(
                                disabled: presenter.isProcessing.value,
                                margin: EdgeInsets.only(right: 5),
                                onPressed: () => onClickCancelModal(context),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if (isEdit.value)
                BsCol(
                  margin: EdgeInsets.only(left: 5),
                  sizes: ColScreen(lg: Col.col_6),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _navigation.darkTheme.value
                          ? ColorPallates.elseDarkColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: BsRow(
                      children: [
                        BsCol(
                          child: BsRow(
                            children: [
                              BsCol(
                                child: FormGroup(
                                    label: Text('Created By',
                                        style: TextStyle(
                                            color: _navigation.darkTheme.value
                                                ? Colors.white
                                                : Colors.black)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(source.value.createdby.value),
                                        Divider()
                                      ],
                                    )),
                              ),
                              BsCol(
                                margin: EdgeInsets.only(top: 10),
                                child: FormGroup(
                                    label: Text('Created At',
                                        style: TextStyle(
                                            color: _navigation.darkTheme.value
                                                ? Colors.white
                                                : Colors.black)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(source.value.createddate.value),
                                        Divider()
                                      ],
                                    )),
                              ),
                              BsCol(
                                margin: EdgeInsets.only(top: 10),
                                child: FormGroup(
                                    label: Text('Last Updated By',
                                        style: TextStyle(
                                            color: _navigation.darkTheme.value
                                                ? Colors.white
                                                : Colors.black)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(source.value.updatedby.value),
                                        Divider()
                                      ],
                                    )),
                              ),
                              BsCol(
                                margin: EdgeInsets.only(top: 10),
                                child: FormGroup(
                                    label: Text('Last Updated At',
                                        style: TextStyle(
                                            color: _navigation.darkTheme.value
                                                ? Colors.white
                                                : Colors.black)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(source.value.updateddate.value),
                                        Divider()
                                      ],
                                    )),
                              ),
                              BsCol(
                                margin: EdgeInsets.only(top: 10),
                                child: FormGroup(
                                    label: Text('Activation',
                                        style: TextStyle(
                                            color: _navigation.darkTheme.value
                                                ? Colors.white
                                                : Colors.black)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (source.value.isactive.value)
                                          InkWell(
                                            child: Icon(
                                              Icons.toggle_on,
                                              size: 35,
                                              color: _navigation.darkTheme.value
                                                  ? ColorPallates.onDarkMode
                                                  : ColorPallates.onLightMode,
                                            ),
                                            onTap: () =>
                                                source.value.isactive.toggle(),
                                          )
                                        else
                                          InkWell(
                                            child: Icon(
                                              Icons.toggle_off,
                                              size: 35,
                                              color: _navigation.darkTheme.value
                                                  ? ColorPallates.offDarkMode
                                                  : ColorPallates.offLightMode,
                                            ),
                                            onTap: () =>
                                                source.value.isactive.toggle(),
                                          ),
                                        Divider()
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ],
          );
        }),
      ),
    );
  }

  void onClickSaveModal(BuildContext context) async {
    presenter.setProcessing(true);
    if (formState.currentState!.validate())
      onSave(await source.toJson());
    else
      presenter.setProcessing(false);
  }

  void onClickCancelModal(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);
    isEdit.value = true;

    source.update((val) {
      TypeModel menu = TypeModel.fromJson(response.body);
      source.value.inputName.text = menu.typename ?? '';
      source.value.inputCode.text = menu.typecd ?? '';
      source.value.inputSeq.text = menu.typeseq.toString();
      source.value.inputDesc.text = menu.typedesc ?? '';

      source.value.createdby.value = menu.typecreatedby?.userfullname ?? '';
      source.value.createddate.value = menu.createddate ?? '';
      source.value.updatedby.value = menu.typeupdatedby?.userfullname ?? '';
      source.value.updateddate.value = menu.updateddate ?? '';
      source.value.isactive.value = menu.isactive ?? true;
    });
  }
}
