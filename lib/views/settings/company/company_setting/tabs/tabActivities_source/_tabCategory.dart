part of '../../company.dart';

class _TabActivityCategory extends StatelessWidget
    implements IndexViewContract, EditViewContract {
  final presenter = Get.find<StBpTypeActivityCategoryPresenter>();
  final datatable = ActivityCatDataTableSource();
  final _sources = Get.find<CompanySources>();

  var id = 0.obs;

  var isupdate = false.obs;

  var isformactcat = false.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = true.obs;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputTypeName = TextEditingController();
  TextEditingController inputSeq = TextEditingController();

  reset() {
    inputName.text = '';
    inputTypeName.text = '';
    inputSeq.text = '';
  }

  _TabActivityCategory() {
    presenter.StBpTypeActivityCategoryViewContract = this;
    presenter.StBpTypeActivityCategoryFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() =>
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (isformactcat.value)
              BsRow(
                children: [
                  BsCol(
                    sizes: ColScreen(sm: Col.col_6),
                    child: AnimatedContainer(
                      duration: Duration(seconds: 3),
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.all(3),
                      child: Column(
                        children: [
                          FormGroup(
                            label: Obx(() => Text('Category Name',
                                style: TextStyle(
                                    color: _navigation.darkTheme.value
                                        ? Colors.white
                                        : Colors.black))),
                            child: CustomInput(
                              disabled: presenter.isProcessing.value,
                              controller: inputName,
                              hintText:
                                  BaseText.hintText(field: 'Category Name'),
                              validators: [
                                Validators.inputRequired('Category Name'),
                              ],
                            ),
                          ),
                          FormGroup(
                            label: Obx(() => Text('Category Type Name',
                                style: TextStyle(
                                    color: _navigation.darkTheme.value
                                        ? Colors.white
                                        : Colors.black))),
                            child: CustomInput(
                              disabled: presenter.isProcessing.value,
                              controller: inputTypeName,
                              hintText: BaseText.hintText(
                                  field: 'Category Type Name'),
                            ),
                          ),
                          FormGroup(
                            label: Obx(() => Text('Category Sequence',
                                style: TextStyle(
                                    color: _navigation.darkTheme.value
                                        ? Colors.white
                                        : Colors.black))),
                            child: CustomInputNumber(
                              disabled: presenter.isProcessing.value,
                              controller: inputSeq,
                              hintText:
                                  BaseText.hintText(field: 'Category Sequel'),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ThemeButtonSave(onPressed: () async {
                                SessionModel session =
                                    await SessionManager.current();
                                Map<String, dynamic> body = {
                                  'sbtbpid': box.read('mybpid'),
                                  'sbtname': inputName.text,
                                  'sbtseq': inputSeq.text,
                                  'sbttypemasterid': _sources.typeid.value,
                                  'sbttypename': inputTypeName.text,
                                  'createdby': session.userid,
                                  'updatedby': session.userid,
                                  'isactive': isactive.value,
                                };
                                if (isupdate.value) {
                                  presenter.update(context, body, id.value);
                                } else {
                                  presenter.save(context, body);
                                }
                              }),
                              ThemeButtonCancel(
                                margin: EdgeInsets.only(left: 5),
                                onPressed: () {
                                  isformactcat.value = false;
                                  isupdate.value = false;
                                  reset();
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  if (isupdate.value)
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
                                                color:
                                                    _navigation.darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(createdby.value),
                                            Divider()
                                          ],
                                        )),
                                  ),
                                  BsCol(
                                    margin: EdgeInsets.only(top: 10),
                                    child: FormGroup(
                                        label: Text('Created At',
                                            style: TextStyle(
                                                color:
                                                    _navigation.darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(createddate.value),
                                            Divider()
                                          ],
                                        )),
                                  ),
                                  BsCol(
                                    margin: EdgeInsets.only(top: 10),
                                    child: FormGroup(
                                        label: Text('Last Updated By',
                                            style: TextStyle(
                                                color:
                                                    _navigation.darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(updatedby.value),
                                            Divider()
                                          ],
                                        )),
                                  ),
                                  BsCol(
                                    margin: EdgeInsets.only(top: 10),
                                    child: FormGroup(
                                        label: Text('Last Updated At',
                                            style: TextStyle(
                                                color:
                                                    _navigation.darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(updateddate.value),
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
              ),
            CustomDatabales(
                source: datatable,
                columns: datatable.columns,
                headerActions: [
                  ThemeButtonCreate(
                      prefix: 'Category',
                      onPressed: () {
                        if (isupdate.value) {
                          isupdate.value = false;
                          reset();
                        } else {
                          isformactcat.toggle();
                          isupdate.value = false;
                          reset();
                        }
                      })
                ],
                serverSide: (params) => presenter.datatables(context, params)),
          ])),
    );
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    reset();
    isformactcat.value = false;
    isupdate.value = false;
    Snackbar().createSuccess();
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    Navigator.pop(context!);
    Snackbar().deleteSuccess();
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    datatable.controller.reload();
    reset();
    isformactcat.value = false;
    isupdate.value = false;
    Snackbar().editSuccess();
  }

  @override
  void onErrorRequest(Response response) {}

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    presenter.setProcessing(false);
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener = (typeid, bool status) =>
        presenter.changeStatus(context, typeid, status);
    datatable.onEditListener = (typeid) => presenter.edit(context, typeid);
    datatable.onDeleteListener =
        (typeid, name) => presenter.delete(context, typeid, name);
    // else
    //   datatable.onDeleteListener =
    //       (typeid, name) => Snackbar().regionDeletePermission();
  }

  @override
  void onSuccessFetchData(Response response) {
    isupdate.value = true;
    isformactcat.value = true;
    StbptypeModel val = StbptypeModel.fromJson(response.body);
    id.value = val.sbtid ?? 0;
    inputName.text = val.sbtname ?? '';
    inputTypeName.text = val.sbttypename ?? '';
    inputSeq.text = parseString(val.sbtseq ?? 0);
    createdby.value = val.stbptypecreatedby?.userfullname ?? '';
    createddate.value = val.createddate ?? '';
    updatedby.value = val.stbptypeupdatedby?.userfullname ?? '';
    updateddate.value = val.updateddate ?? '';
    isactive.value = val.isactive ?? false;
  }
}
