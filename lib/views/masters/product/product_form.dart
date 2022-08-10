import 'package:boilerplate/views/skins/template.dart';
import 'package:bs_flutter_selectbox/bs_flutter_selectbox.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../contracts/base/edit_view_contract.dart';
import '../../../models/masters/Product_model.dart';
import '../../../presenters/masters/product_presenter.dart';
import '../../../presenters/navigation_presenter.dart';
import '../../../routes/route_list.dart';
import '../../../styles/color_palattes.dart';
import '../../../widgets/breadcrumb.dart';
import '../../../widgets/button/theme_button_cancel.dart';
import '../../../widgets/button/theme_button_save.dart';

import '_form_source.dart';

// ignore: must_be_immutable
class ProductFormView extends StatelessWidget implements EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final ProductPresenter presenter = Get.find<ProductPresenter>();
  final source = ProductSource().obs;
  final Function(Map<String, dynamic> body) onSave;
  final _navigation = Get.find<NavigationPresenter>();

  late ProductForm productForm;

  ProductFormView({required this.onSave}) {
    presenter.productFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Product Form',
        breadcrumbs: [
          BreadcrumbWidget('Masters'),
          BreadcrumbWidget('Products', back: true),
          BreadcrumbWidget('Product Form', active: true),
        ],
        activeRoutes: [RouteList.master.index, RouteList.masterProduct.index],
        child: Obx(() {
          productForm = ProductForm(source.value);
          return Container(
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
                  productForm.inputName(),
                  productForm.selectBp(),
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
                  ),
                ],
              ),
            ),
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

    source.update((val) {
      ProductModel product = ProductModel.fromJson(response.body);
      source.value.inputName.text = product.productname;
      source.value.selectBp.setSelected(
          BsSelectBoxOption(value: product.bpid, text: Text(product.bpname)));
    });
  }
}
