part of '../../company.dart';

class _TabProspectLostReason extends StatelessWidget
    implements IndexViewContract, EditViewContract {
  final BuildContext context;
  final presenter = Get.find<StBpTypeProspectLostReasonPresenter>();

  _TabProspectLostReason(this.context) {
    presenter.datatables(context);

    presenter.stBpTypeProspectLostReasonViewContract = this;
    presenter.stBpTypeProspectLostReasonFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() => Container(
            padding: EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              if (source.value.isformactcat.value)
                source.value.form(context, presenter,
                    _sources.prospectLostReasontypeid.value),
              ThemeButtonCreate(
                  prefix: 'Lost Reason',
                  onPressed: () {
                    if (source.value.isupdate.value) {
                      source.value.isupdate.value = false;
                      source.value.reset();
                    } else {
                      source.value.isformactcat.toggle();
                      source.value.isupdate.value = false;
                      source.value.reset();
                    }
                  }),
              if (_sources.stbpprospectlostreason.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: _sources.stbpprospectlostreason.map((e) {
                      int index = _sources.stbpprospectlostreason.indexOf(e);
                      return BsRow(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: _navigation.darkTheme.value
                              ? index % 2 == 0
                                  ? ColorPallates.datatableDarkEvenRowColor
                                  : ColorPallates.datatableDarkOddRowColor
                              : index % 2 == 0
                                  ? ColorPallates.datatableLightEvenRowColor
                                  : ColorPallates.datatableLightOddRowColor,
                        ),
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(top: 5),
                        children: [
                          BsCol(
                              sizes: ColScreen(sm: Col.col_4),
                              child: Text(
                                e.sbtname ?? '',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                          BsCol(
                              sizes: ColScreen(sm: Col.col_4),
                              child: Text(e.sbttypename ?? '',
                                  style: TextStyle(fontSize: 18))),
                          BsCol(
                            sizes: ColScreen(sm: Col.col_3),
                            child: BsRow(
                              children: [
                                BsCol(
                                  sizes: ColScreen(sm: Col.col_2),
                                  child: InkWell(
                                    onTap: () =>
                                        presenter.edit(context, e.sbtid!),
                                    child: Text('Edit',
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                ),
                                BsCol(
                                    sizes: ColScreen(sm: Col.col_1),
                                    child: Text('|',
                                        style: TextStyle(fontSize: 18))),
                                if (e.isactive!)
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_5),
                                    child: InkWell(
                                      onTap: () => presenter.changeStatus(
                                          context, e.sbtid!, e.isactive!),
                                      child: Text('Active',
                                          style: TextStyle(fontSize: 18)),
                                    ),
                                  )
                                else
                                  BsCol(
                                    sizes: ColScreen(sm: Col.col_5),
                                    child: InkWell(
                                      onTap: () => presenter.changeStatus(
                                          context, e.sbtid!, e.isactive!),
                                      child: Text('Not Active',
                                          style: TextStyle(fontSize: 18)),
                                    ),
                                  ),
                                BsCol(
                                    sizes: ColScreen(sm: Col.col_1),
                                    child: Text('|',
                                        style: TextStyle(fontSize: 18))),
                                BsCol(
                                  sizes: ColScreen(sm: Col.col_3),
                                  child: InkWell(
                                    onTap: () => presenter.delete(
                                        context, e.sbtid!, e.sbtname ?? ''),
                                    child: Text('Delete',
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    }).toList(),
                  ),
                )
              else
                _DefautlNoTypes(),
            ]),
          )),
    );
  }

  @override
  void onCreateSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    presenter.datatables(context!);
    source.value.reset();
    source.value.isformactcat.value = false;
    source.value.isupdate.value = false;
    Snackbar().createSuccess();
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    presenter.datatables(context!);
    Navigator.pop(context);
    Snackbar().deleteSuccess();
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    presenter.datatables(context!);
    source.value.reset();
    source.value.isformactcat.value = false;
    source.value.isupdate.value = false;
    Snackbar().editSuccess();
  }

  @override
  void onErrorRequest(Response response) {}

  @override
  void onLoadDatatables(BuildContext context, Response response) {
    presenter.setProcessing(false);

    List<StbptypeModel> stbpraw = [];

    for (var element in response.body) {
      stbpraw.add(StbptypeModel.fromJson(element));
    }

    _sources.stbpprospectlostreason.value = stbpraw;
  }

  @override
  void onSuccessFetchData(Response response) {
    source.update((val) {
      source.value.isupdate.value = true;
      source.value.isformactcat.value = true;
      StbptypeModel val = StbptypeModel.fromJson(response.body);
      source.value.id.value = val.sbtid ?? 0;
      source.value.inputName.text = val.sbtname ?? '';
      source.value.inputTypeName.text = val.sbttypename ?? '';
      source.value.inputSeq.text = parseString(val.sbtseq ?? 0);
      source.value.createdby.value = val.stbptypecreatedby?.userfullname ?? '';
      source.value.createddate.value = val.createddate ?? '';
      source.value.updatedby.value = val.stbptypeupdatedby?.userfullname ?? '';
      source.value.updateddate.value = val.updateddate ?? '';
      source.value.isactive.value = val.isactive ?? false;
    });
  }
}
