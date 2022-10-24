part of '../../company.dart';

// ignore: must_be_immutable
class _TabCompetitor extends GetView
    implements IndexViewContract, EditViewContract {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final presenter = Get.find<CompetitorPresenter>();
  final datatable = CompetitorDataTableSource();
  final map = Get.put(MapSource());
  late CompetitorForm competitorForm;

  var isEdit = false.obs;
  var isForm = false.obs;

  _TabCompetitor() {
    presenter.competitorViewContract = this;
    presenter.competitorsFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() => Column(
            children: [
              if (isForm.value)
                Obx(() {
                  competitorForm = CompetitorForm(sources.value);
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
                            child: BsRow(
                              children: [
                                BsCol(
                                  sizes: ColScreen(sm: Col.col_5),
                                  child: competitorForm.btnImage(),
                                ),
                                BsCol(
                                  margin: EdgeInsets.only(left: 5),
                                  sizes: ColScreen(sm: Col.col_7),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      competitorForm.inputName(),
                                      competitorForm.inputProductName(),
                                      competitorForm.selectTypes(),
                                      // competitorForm.selectRef(),
                                      competitorForm.inputDesciption(),
                                      Obx(
                                        () => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ThemeButtonSave(
                                              disabled:
                                                  presenter.isProcessing.value,
                                              processing:
                                                  presenter.isProcessing.value,
                                              margin: EdgeInsets.only(right: 5),
                                              onPressed: () async {
                                                if (formState.currentState!
                                                    .validate()) {
                                                  if (isEdit.value) {
                                                    Map<String, dynamic>
                                                        images = {
                                                      'transtypeid': sources
                                                          .value
                                                          .transtypeid
                                                          .value,
                                                      'refid': sources
                                                          .value.refid.value
                                                    };
                                                    presenter.deleteImages(
                                                        context, images);
                                                    presenter.update(
                                                        context,
                                                        FormData(await sources
                                                            .value
                                                            .toJson()),
                                                        sources.value.id.value);
                                                  } else {
                                                    presenter.save(
                                                        context,
                                                        FormData(await sources
                                                            .value
                                                            .toJson()));
                                                  }
                                                }
                                              },
                                            ),
                                            ThemeButtonCancel(
                                              disabled:
                                                  presenter.isProcessing.value,
                                              margin: EdgeInsets.only(right: 5),
                                              onPressed: () {
                                                if (isEdit.value) {
                                                  isEdit.value = false;
                                                  isForm.toggle();
                                                  sources.value.reset();
                                                } else {
                                                  isForm.toggle();
                                                  sources.value.reset();
                                                }
                                              },
                                            ),
                                          ],
                                        ),
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
                                        child: FormGroupEdit(
                                            label: Text('Created By',
                                                style: TextStyle(
                                                    color: _navigation
                                                            .darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(source
                                                    .value.createdby.value),
                                                Divider()
                                              ],
                                            )),
                                      ),
                                      BsCol(
                                        margin: EdgeInsets.only(top: 10),
                                        child: FormGroupEdit(
                                            label: Text('Created At',
                                                style: TextStyle(
                                                    color: _navigation
                                                            .darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(source
                                                    .value.createddate.value),
                                                Divider()
                                              ],
                                            )),
                                      ),
                                      BsCol(
                                        margin: EdgeInsets.only(top: 10),
                                        child: FormGroupEdit(
                                            label: Text('Last Updated By',
                                                style: TextStyle(
                                                    color: _navigation
                                                            .darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(source
                                                    .value.updatedby.value),
                                                Divider()
                                              ],
                                            )),
                                      ),
                                      BsCol(
                                        margin: EdgeInsets.only(top: 10),
                                        child: FormGroupEdit(
                                            label: Text('Last Updated At',
                                                style: TextStyle(
                                                    color: _navigation
                                                            .darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(source
                                                    .value.updateddate.value),
                                                Divider()
                                              ],
                                            )),
                                      ),
                                      BsCol(
                                        margin: EdgeInsets.only(top: 10),
                                        child: FormGroupEdit(
                                            label: Text('Is Active',
                                                style: TextStyle(
                                                    color: _navigation
                                                            .darkTheme.value
                                                        ? Colors.white
                                                        : Colors.black)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
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
                      prefix: 'Competitor',
                      onPressed: () {
                        if (isEdit.value) {
                          isEdit.value = false;
                        } else {
                          isForm.toggle();
                          source.value.isupdate.value = false;
                        }
                      },
                    )
                ],
                serverSide: (params) => presenter.datatablesbp(context, params),
                // searchHintText: 'Search by Competitor name, Competitor phone ...',
              ),
            ],
          )),
    );
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    final map = Get.find<MapSource>();
    map.reset();
    presenter.setProcessing(false);
    datatable.controller.reload();
    isForm.value = false;
    isEdit.value = false;
    Snackbar().createSuccess(context!);
    sources.value.reset();
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    final map = Get.find<MapSource>();
    map.reset();
    presenter.setProcessing(false);
    datatable.controller.reload();
    isForm.value = false;
    isEdit.value = false;
    Navigator.pop(context!);
    Snackbar().deleteSuccess(context);
    sources.value.reset();
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    final map = Get.find<MapSource>();
    map.reset();
    presenter.setProcessing(false);
    datatable.controller.reload();
    isForm.value = false;
    isEdit.value = false;
    Snackbar().editSuccess(context!);
    sources.value.reset();
  }

  @override
  void onErrorRequest(Response response) {
    presenter.setProcessing(false);
  }

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    final map = Get.find<MapSource>();
    presenter.setProcessing(false);
    map.reset();
    datatable.response = BsDatatableResponse.createFromJson(response.body);
    datatable.onDetailsListener =
        (userid) => presenter.details(context, userid);
    datatable.onEditListener =
        (countryid) => presenter.edits(context, countryid);
    datatable.onDeleteListener =
        (cstmid, cstmname) => presenter.delete(context, cstmid, cstmname);
  }

  @override
  void onSuccessFetchData(Response response) {
    presenter.setProcessing(false);
    isForm.value = true;
    isEdit.value = true;

    source.update((val) {
      CompetitorModel competitor = CompetitorModel.fromJson(response.body);

      if (competitor.comptreftypeid != null)
        sources.value.selectType.setSelected(BsSelectBoxOption(
            value: competitor.comptreftypeid,
            text: Text(competitor.comptreftype!.typename!)));

      if (competitor.comptpics != null) {
        sources.value.isUpdate.value = true;
        sources.value.isImage.value = false;
        List image = [];
        for (var item in competitor.comptpics!) {
          image.add(item.url);
        }
        sources.value.imageupdate.value = image;
      }

      sources.value.id.value = competitor.comptid!;

      sources.value.isUpdateImage.value = true;

      sources.value.inputName.text = competitor.comptname ?? '';
      sources.value.inputProductName.text = competitor.comptproductname ?? '';
      sources.value.inputDesc.text = competitor.description ?? '';

      if (competitor.comptpics != []) {
        sources.value.transtypeid.value =
            competitor.comptpics!.first.transtypeid!;
        sources.value.refid.value = competitor.comptpics!.first.refid!;
      }

      sources.value.createdby.value =
          competitor.comptcreatedby?.userfullname ?? '';
      sources.value.createddate.value = competitor.createddate ?? '';
      sources.value.updatedby.value =
          competitor.comptupdatedby?.userfullname ?? '';
      sources.value.updateddate.value = competitor.updateddate ?? '';
      sources.value.isactive.value = competitor.isactive ?? true;
    });
  }
}
