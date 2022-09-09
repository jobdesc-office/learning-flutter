part of '../../company.dart';

class _TabScheduleType extends StatelessWidget
    implements IndexViewContract, EditViewContract {
  final BuildContext context;
  final presenter = Get.find<StBpTypeScheduleTypePresenter>();
  _TabScheduleType(this.context) {
    presenter.datatables(context);
    presenter.stBpTypeScheduleTypeViewContract = this;
    presenter.stBpTypeScheduleTypeFetchDataContract = this;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() => Container(
            padding: EdgeInsets.all(10),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              if (source.value.isformactcat.value)
                source.value.form(
                    context,
                    presenter,
                    _sources.scheduletypetypeid.value,
                    _sources.scheduletypetype.value,
                    color: true),
              ThemeButtonCreate(
                  prefix: 'Type',
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
              if (_sources.stbpscheduletype.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: _sources.stbpscheduletype.map((e) {
                      int index = _sources.stbpscheduletype.indexOf(e);
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
                              sizes: ColScreen(sm: Col.col_3),
                              child: Text(
                                e.sbttypename ?? '',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          BsCol(
                              sizes: ColScreen(sm: Col.col_1),
                              child: Text(
                                  e.sbtseq != null ? e.sbtseq.toString() : '')),
                          if (e.sbtremark != null)
                            BsCol(
                                margin: EdgeInsets.fromLTRB(5, 3, 5, 0),
                                sizes: ColScreen(sm: Col.col_1),
                                child: InkWell(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (context) => _ShowColor(
                                            color: Color(parseInt(e.sbtremark)),
                                          )),
                                  child: Container(
                                    color: Color(parseInt(e.sbtremark)),
                                    child: Text(''),
                                  ),
                                )),
                          BsCol(
                              alignment: Alignment.center,
                              sizes: ColScreen(sm: Col.col_3),
                              child: Text(e.sbtname ?? '')),
                          BsCol(
                            sizes: ColScreen(sm: Col.col_4),
                            child: BsRow(
                              children: [
                                BsCol(
                                  alignment: Alignment.center,
                                  sizes: ColScreen(sm: Col.col_1),
                                ),
                                BsCol(
                                  alignment: Alignment.center,
                                  sizes: ColScreen(sm: Col.col_3),
                                  child: InkWell(
                                    onTap: () =>
                                        presenter.edit(context, e.sbtid!),
                                    child: Text('Edit'),
                                  ),
                                ),
                                BsCol(
                                    alignment: Alignment.center,
                                    sizes: ColScreen(sm: Col.col_1),
                                    child: Text('|')),
                                BsCol(
                                  alignment: Alignment.center,
                                  sizes: ColScreen(sm: Col.col_3),
                                  child: InkWell(
                                    onTap: () => presenter.changeStatus(
                                        context, e.sbtid!, e.isactive!),
                                    child: e.isactive!
                                        ? Text('Active',
                                            style:
                                                TextStyle(color: Colors.green))
                                        : Text(
                                            'Not Active',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                  ),
                                ),
                                BsCol(
                                    alignment: Alignment.center,
                                    sizes: ColScreen(sm: Col.col_1),
                                    child: Text('|')),
                                BsCol(
                                  alignment: Alignment.center,
                                  sizes: ColScreen(sm: Col.col_3),
                                  child: InkWell(
                                    onTap: () => presenter.delete(
                                        context, e.sbtid!, e.sbttypename ?? ''),
                                    child: Text('Delete'),
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

    _sources.stbpscheduletype.value = stbpraw;
  }

  @override
  void onSuccessFetchData(Response response) {
    source.update((val) {
      source.value.isupdate.value = true;
      source.value.isformactcat.value = true;
      source.value.withcolor.value = true;
      StbptypeModel val = StbptypeModel.fromJson(response.body);
      source.value.id.value = val.sbtid ?? 0;
      source.value.inputName.text = val.sbttypename ?? '';

      if (val.sbtseq != null) {
        source.value.seq.value = true;
        source.value.inputSeq.text =
            val.sbtseq != null ? val.sbtseq.toString() : '';
      }

      if (val.sbtremark != null) {
        source.value.pickerColor.value = Color(parseInt(val.sbtremark));
      }

      source.value.createdby.value = val.stbptypecreatedby?.userfullname ?? '';
      source.value.createddate.value = val.createddate ?? '';
      source.value.updatedby.value = val.stbptypeupdatedby?.userfullname ?? '';
      source.value.updateddate.value = val.updateddate ?? '';
      source.value.isactive.value = val.isactive ?? false;
    });
  }
}
