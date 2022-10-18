part of '../company.dart';

// ignore: must_be_immutable
class _TabProduct extends StatelessWidget
    implements IndexViewContract, UserResetContract, EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final presenter = Get.find<ProductPresenter>();
  final datatable = ProductDataTableSource();
  final source = ProductSource().obs;

  late ProductForm userForm;

  var isEdit = false.obs;
  var isForm = false.obs;

  _TabProduct() {
    presenter.productViewContract = this;
    presenter.productFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          child: Column(
            children: [
              if (isForm.value)
                Obx(() {
                  userForm = ProductForm(source.value);
                  return BsRow(
                    children: [
                      BsCol(
                        sizes: ColScreen(
                          sm: Col.col_6,
                        ),
                        child: Container(
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
                                userForm.inputName(),
                                Obx(
                                  () => Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ThemeButtonSave(
                                        disabled: presenter.isProcessing.value,
                                        processing:
                                            presenter.isProcessing.value,
                                        margin: EdgeInsets.only(right: 5),
                                        onPressed: () async {
                                          if (formState.currentState!
                                              .validate()) {
                                            if (isEdit.value) {
                                              presenter.update(
                                                  context,
                                                  await source.value.toJson(),
                                                  source.value.id.value);
                                            } else {
                                              presenter.save(context,
                                                  await source.value.toJson());
                                            }
                                          }
                                        },
                                      ),
                                      ThemeButtonCancel(
                                        disabled: presenter.isProcessing.value,
                                        margin: EdgeInsets.only(right: 5),
                                        onPressed: () {
                                          if (isEdit.value) {
                                            isEdit.value = false;
                                            isForm.toggle();
                                            source.value.reset();
                                          } else {
                                            isForm.toggle();
                                            source.value.reset();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
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
                                                    color: _navigation
                                                            .darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(source
                                                    .value.createdby.value),
                                                Divider()
                                              ],
                                            )),
                                      ),
                                      BsCol(
                                        margin: EdgeInsets.only(top: 10),
                                        child: FormGroup(
                                            label: Text('Created At',
                                                style: TextStyle(
                                                    color: _navigation
                                                            .darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(source
                                                    .value.createddate.value),
                                                Divider()
                                              ],
                                            )),
                                      ),
                                      BsCol(
                                        margin: EdgeInsets.only(top: 10),
                                        child: FormGroup(
                                            label: Text('Last Updated By',
                                                style: TextStyle(
                                                    color: _navigation
                                                            .darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(source
                                                    .value.updatedby.value),
                                                Divider()
                                              ],
                                            )),
                                      ),
                                      BsCol(
                                        margin: EdgeInsets.only(top: 10),
                                        child: FormGroup(
                                            label: Text('Last Updated At',
                                                style: TextStyle(
                                                    color: _navigation
                                                            .darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(source
                                                    .value.updateddate.value),
                                                Divider()
                                              ],
                                            )),
                                      ),
                                      BsCol(
                                        margin: EdgeInsets.only(top: 10),
                                        child: FormGroup(
                                            label: Text('Is Active',
                                                style: TextStyle(
                                                    color: _navigation
                                                            .darkTheme.value
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
                                                      color: _navigation
                                                              .darkTheme.value
                                                          ? ColorPallates
                                                              .onDarkMode
                                                          : ColorPallates
                                                              .onLightMode,
                                                    ),
                                                    onTap: () => source
                                                        .value.isactive
                                                        .toggle(),
                                                  )
                                                else
                                                  InkWell(
                                                    child: Icon(
                                                      Icons.toggle_off,
                                                      size: 35,
                                                      color: _navigation
                                                              .darkTheme.value
                                                          ? ColorPallates
                                                              .offDarkMode
                                                          : ColorPallates
                                                              .offLightMode,
                                                    ),
                                                    onTap: () => source
                                                        .value.isactive
                                                        .toggle(),
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
              CustomDatabales(
                source: datatable,
                columns: datatable.columns,
                headerActions: [
                  if (permis
                      .where((element) => element.menunm == 'Settings')
                      .first
                      .children!
                      .where((element) => element.menunm == 'Company Setting')
                      .first
                      .features!
                      .where((element) => element.featslug == 'create')
                      .first
                      .permissions!
                      .hasaccess!)
                    ThemeButtonCreate(
                      prefix: 'Product',
                      onPressed: () {
                        if (isEdit.value) {
                          isEdit.value = false;
                          isForm.toggle();
                        } else {
                          isForm.toggle();
                        }
                      },
                    )
                ],
                serverSide: (params) => presenter.datatablesbp(context, params),
              ),
            ],
          ),
        ));
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    isForm.value = false;
    isEdit.value = false;
    Snackbar().createSuccess(context!);
    source.value.reset();
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    isForm.value = false;
    isEdit.value = false;
    Snackbar().deleteSuccess(context!);
    source.value.reset();
    Get.back();
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    isForm.value = false;
    isEdit.value = false;
    Snackbar().editSuccess(context!);
    source.value.reset();
  }

  @override
  void onErrorRequest(Response response) {
    presenter.setProcessing(false);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onEditListener = (userid) => presenter.show(userid);
    datatable.onDeleteListener =
        (userid, name) => presenter.delete(context, userid, name);
  }

  @override
  void onResetSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    Snackbar().resetSuccess();
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);
    source.value.reset();
    isForm.value = true;
    isEdit.value = true;

    source.update((val) {
      ProductModel menu = ProductModel.fromJson(response.body);
      source.value.id.value = menu.productid!;
      source.value.inputName.text = menu.productname!;

      source.value.createdby.value = menu.productcreatedby?.userfullname ?? '';
      source.value.createddate.value = menu.createddate ?? '';
      source.value.updatedby.value = menu.productupdatedby?.userfullname ?? '';
      source.value.updateddate.value = menu.updateddate ?? '';
      source.value.isactive.value = menu.isactive ?? true;
    });
  }
}
