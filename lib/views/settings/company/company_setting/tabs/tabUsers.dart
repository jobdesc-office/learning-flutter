part of '../company.dart';

class _TabUsers extends StatelessWidget
    implements IndexViewContract, UserResetContract, EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final presenter = Get.find<UserPresenter>();
  final datatable = UserDataTableSource();
  final source = UserSource().obs;

  late UserForm userForm;

  var isEdit = false.obs;
  var isForm = false.obs;

  _TabUsers() {
    presenter.userViewContract = this;
    presenter.usersFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          child: Column(
            children: [
              if (isForm.value)
                Obx(() {
                  userForm = UserForm(source.value);
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
                                userForm.inputFullName(),
                                userForm.inputPassword(),
                                userForm.inputConfirmPassword(),
                                userForm.inputEmail(),
                                userForm.inputPhone(),
                                Row(
                                  children: [
                                    ButtonRoleUser(
                                      onPressed: onClickAddRole,
                                      disabled:
                                          source.value.selectsRole.length > 260
                                              ? true
                                              : false,
                                    )
                                  ],
                                ),
                                userForm.formDetail(
                                    onRemoveItem: onClickRemoveRoleItem),
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
                                          if (isEdit.value) {
                                            presenter.update(
                                                context,
                                                await source.value.toJson(),
                                                source.value.id.value);
                                          } else {
                                            presenter.save(context,
                                                await source.value.toJson());
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
                  ThemeButtonCreate(
                    prefix: 'User',
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

  void onClickAddRole() {
    source.update((val) {
      source.value.selectsRole.add(BsSelectBoxController());
      source.value.selectsBp.add(BsSelectBoxController());
    });
  }

  void onClickRemoveRoleItem(int index) {
    source.update((val) {
      source.value.selectsRole.removeAt(index);
      source.value.selectsBp.removeAt(index);
    });
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
    print(response);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener =
        (userid) => presenter.details(context, userid);
    datatable.onEditListener = (userid) => presenter.edits(context, userid);
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
      UserModel menu = UserModel.fromJson(response.body);
      source.value.id.value = menu.userid!;
      source.value.inputName.text = menu.username!;
      // source.value.inputPassword.text = menu.userpassword;
      // source.value.inputConfirmPassword.text = menu.userpassword;

      source.value.inputFullName.text = menu.userfullname!;
      source.value.inputEmail.text = menu.useremail!;
      source.value.inputPhone.text = menu.userphone!;
      for (var item in menu.userdetails!) {
        source.value.selectsRole.add(BsSelectBoxController(selected: [
          BsSelectBoxOption(
              value: item.usertype!.typeid,
              text: Text(item.usertype!.typename!))
        ]));
        source.value.selectsBp.add(BsSelectBoxController(selected: [
          BsSelectBoxOption(
              value: item.businesspartner!.bpid,
              text: Text(item.businesspartner!.bpname!))
        ]));

        source.value.createdby.value = menu.usercreatedby?.userfullname ?? '';
        source.value.createddate.value = menu.createddate ?? '';
        source.value.updatedby.value = menu.userupdatedby?.userfullname ?? '';
        source.value.updateddate.value = menu.updateddate ?? '';
        source.value.isactive.value = menu.isactive ?? true;
      }
    });
  }
}
