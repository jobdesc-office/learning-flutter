part of '../company.dart';

// ignore: must_be_immutable
class _TabUsers extends StatelessWidget implements IndexViewContract, UserResetContract, EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final presenter = Get.find<UserPresenter>();
  final datatable = UserDataTableSource();
  final src = UserSource().obs;

  late UserForm userForm;

  _TabUsers() {
    presenter.userViewContract = this;
    presenter.usersFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView(
          child: Column(
            children: [
              if (source.value.isformactcat.value)
                Obx(() {
                  userForm = UserForm(src.value);
                  return BsRow(
                    children: [
                      BsCol(
                        sizes: ColScreen(
                          sm: Col.col_6,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: _navigation.darkTheme.value ? ColorPallates.elseDarkColor : Colors.white,
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
                                userForm.selectRole(),
                                userForm.selectAccess(),
                                userForm.selectSecurityGroup(),
                                Obx(
                                  () => Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ThemeButtonSave(
                                        disabled: presenter.isProcessing.value,
                                        processing: presenter.isProcessing.value,
                                        margin: EdgeInsets.only(right: 5),
                                        onPressed: () async {
                                          if (formState.currentState!.validate()) {
                                            if (source.value.isupdate.value) {
                                              presenter.update(context, await src.value.toJson(), src.value.id.value);
                                            } else {
                                              presenter.save(context, await src.value.toJson());
                                            }
                                          }
                                        },
                                      ),
                                      ThemeButtonCancel(
                                        disabled: presenter.isProcessing.value,
                                        margin: EdgeInsets.only(right: 5),
                                        onPressed: () {
                                          if (source.value.isupdate.value) {
                                            source.value.isupdate.value = false;
                                            source.value.isformactcat.toggle();
                                            src.value.reset();
                                          } else {
                                            source.value.isformactcat.toggle();
                                            src.value.reset();
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
                      if (source.value.isupdate.value)
                        BsCol(
                          margin: EdgeInsets.only(left: 5),
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
                                  child: BsRow(
                                    children: [
                                      BsCol(
                                        child: FormGroupEdit(
                                            label: Text('Created By', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [Text(src.value.createdby.value), Divider()],
                                            )),
                                      ),
                                      BsCol(
                                        margin: EdgeInsets.only(top: 10),
                                        child: FormGroupEdit(
                                            label: Text('Created At', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [Text(src.value.createddate.value), Divider()],
                                            )),
                                      ),
                                      BsCol(
                                        margin: EdgeInsets.only(top: 10),
                                        child: FormGroupEdit(
                                            label: Text('Last Updated By', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [Text(src.value.updatedby.value), Divider()],
                                            )),
                                      ),
                                      BsCol(
                                        margin: EdgeInsets.only(top: 10),
                                        child: FormGroupEdit(
                                            label: Text('Last Updated At', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [Text(src.value.updateddate.value), Divider()],
                                            )),
                                      ),
                                      BsCol(
                                        margin: EdgeInsets.only(top: 10),
                                        child: FormGroupEdit(
                                            label: Text('Is Active', style: TextStyle(color: _navigation.darkTheme.value ? Colors.white : Colors.black)),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                if (src.value.isactive.value)
                                                  InkWell(
                                                    child: Icon(
                                                      Icons.toggle_on,
                                                      size: 35,
                                                      color: _navigation.darkTheme.value ? ColorPallates.onDarkMode : ColorPallates.onLightMode,
                                                    ),
                                                    onTap: () => src.value.isactive.toggle(),
                                                  )
                                                else
                                                  InkWell(
                                                    child: Icon(
                                                      Icons.toggle_off,
                                                      size: 35,
                                                      color: _navigation.darkTheme.value ? ColorPallates.offDarkMode : ColorPallates.offLightMode,
                                                    ),
                                                    onTap: () => src.value.isactive.toggle(),
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
                      prefix: 'User',
                      onPressed: () {
                        if (source.value.isupdate.value) {
                          source.value.isupdate.value = false;
                          source.value.isformactcat.toggle();
                        } else {
                          source.value.isformactcat.toggle();
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
    src.update((val) {
      src.value.selectsRole.add(BsSelectBoxController());
      src.value.selectsBp.add(BsSelectBoxController());
    });
  }

  void onClickRemoveRoleItem(int index) {
    src.update((val) {
      src.value.selectsRole.removeAt(index);
      src.value.selectsBp.removeAt(index);
    });
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    source.value.isformactcat.value = false;
    source.value.isupdate.value = false;
    Snackbar().createSuccess(context!);
    src.value.reset();
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    source.value.isformactcat.value = false;
    source.value.isupdate.value = false;
    Snackbar().deleteSuccess(context!);
    src.value.reset();
    Navigator.pop(context);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    source.value.isformactcat.value = false;
    source.value.isupdate.value = false;
    Snackbar().editSuccess(context!);
    src.value.reset();
  }

  @override
  void onErrorRequest(Response response) {
    presenter.setProcessing(false);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener = (userid) => presenter.details(context, userid);
    datatable.onEditListener = (userid) => presenter.edits(context, userid);
    datatable.onDeleteListener = (userid, name) => presenter.delete(context, userid, name);
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
    src.value.reset();
    source.value.isformactcat.value = true;
    source.value.isupdate.value = true;

    src.update((val) {
      UserModel menu = UserModel.fromJson(response.body);
      src.value.id.value = menu.userid!;
      src.value.inputName.text = menu.username!;
      // src.value.inputPassword.text = menu.userpassword;
      // src.value.inputConfirmPassword.text = menu.userpassword;

      src.value.inputFullName.text = menu.userfullname!;
      src.value.inputEmail.text = menu.useremail!;
      src.value.inputPhone.text = menu.userphone!;
      src.value.selectAccess.setSelected(BsSelectBoxOption(value: menu.appaccess!.typeid!, text: Text(menu.appaccess!.typename!)));
      for (var item in menu.userdetails!) {
        src.value.selectRole.setSelected(BsSelectBoxOption(value: item.usertype!.typeid, text: Text(item.usertype!.typename!)));
        src.value.selectsRole.add(BsSelectBoxController(selected: [BsSelectBoxOption(value: item.usertype!.typeid, text: Text(item.usertype!.typename!))]));
        src.value.selectsBp.add(BsSelectBoxController(selected: [BsSelectBoxOption(value: item.businesspartner!.bpid, text: Text(item.businesspartner!.bpname!))]));

        src.value.createdby.value = menu.usercreatedby?.userfullname ?? '';
        src.value.createddate.value = menu.createddate ?? '';
        src.value.updatedby.value = menu.userupdatedby?.userfullname ?? '';
        src.value.updateddate.value = menu.updateddate ?? '';
        src.value.isactive.value = menu.isactive ?? true;
      }
    });
  }
}
