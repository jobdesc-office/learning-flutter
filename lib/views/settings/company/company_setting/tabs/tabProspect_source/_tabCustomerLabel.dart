part of '../../company.dart';

class _TabProspectCustomerLabel extends StatelessWidget
    implements IndexViewContract, EditViewContract {
  final BuildContext context;
  final presenter = Get.find<StBpTypeProspectCustomerLabelPresenter>();

  _TabProspectCustomerLabel(this.context) {
    presenter.datatables(context);

    presenter.stBpTypeProspectCustomerLabelViewContract = this;
    presenter.stBpTypeProspectCustomerLabelFetchDataContract = this;
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
                    _sources.prospectCustomerLabeltypeid.value,
                    _sources.prospectCustomerLabeltype.value,
                    'Customer Label',
                    color: true,
                    textcolor: true),
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
                    prefix: 'Customer Label',
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
              if (_sources.stbpprospectcustomerlabel.isNotEmpty)
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: _sources.stbpprospectcustomerlabel.map((e) {
                      Map<String, dynamic> colors = {};
                      if (e.sbtremark != null)
                        colors = jsonDecode(e.sbtremark ?? '');
                      int index = _sources.stbpprospectcustomerlabel.indexOf(e);
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
                                e.sbttypename ?? '',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          BsCol(
                              sizes: ColScreen(sm: Col.col_1),
                              child: Text(
                                  e.sbtseq != null ? e.sbtseq.toString() : '')),
                          if (colors.isNotEmpty)
                            BsCol(
                                sizes: ColScreen(sm: Col.col_1),
                                child: InkWell(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (context) => _ShowColor(
                                            color: Color(
                                              parseInt(colors['color']),
                                            ),
                                            textcolor: Color(
                                              parseInt(colors['textcolor']),
                                            ),
                                            text: e.sbttypename!,
                                          )),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color(parseInt(colors['color'])),
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: EdgeInsets.all(2),
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Text('${e.sbttypename}',
                                          style: TextStyle(
                                              color: Color(parseInt(
                                                  colors['textcolor'])))),
                                    ),
                                  ),
                                ))
                          else
                            BsCol(
                                sizes: ColScreen(sm: Col.col_1),
                                child: InkWell(
                                  onTap: () => showDialog(
                                      context: context,
                                      builder: (context) => _ShowColor(
                                            color: Colors.transparent,
                                            textcolor: Colors.black,
                                            text: e.sbttypename!,
                                          )),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: EdgeInsets.all(2),
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: Text('${e.sbttypename}',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                )),
                          BsCol(
                              alignment: Alignment.center,
                              sizes: ColScreen(sm: Col.col_2),
                              child: Text(e.sbtname ?? '')),
                          BsCol(
                            sizes: ColScreen(sm: Col.col_4),
                            child: BsRow(
                              children: [
                                BsCol(
                                  alignment: Alignment.center,
                                  sizes: ColScreen(sm: Col.col_1),
                                ),
                                if (permis
                                    .where((element) =>
                                        element.menunm == 'Settings')
                                    .first
                                    .children!
                                    .where((element) =>
                                        element.menunm == 'Company Setting')
                                    .first
                                    .features!
                                    .where((element) =>
                                        element.featslug == 'update')
                                    .first
                                    .permissions!
                                    .hasaccess!)
                                  BsCol(
                                    alignment: Alignment.center,
                                    sizes: ColScreen(sm: Col.col_3),
                                    child: InkWell(
                                      onTap: () =>
                                          presenter.edit(context, e.sbtid!),
                                      child: Text('Edit'),
                                    ),
                                  ),
                                if (permis
                                    .where((element) =>
                                        element.menunm == 'Settings')
                                    .first
                                    .children!
                                    .where((element) =>
                                        element.menunm == 'Company Setting')
                                    .first
                                    .features!
                                    .where((element) =>
                                        element.featslug == 'update')
                                    .first
                                    .permissions!
                                    .hasaccess!)
                                  BsCol(
                                      alignment: Alignment.center,
                                      sizes: ColScreen(sm: Col.col_1),
                                      child: Text('|')),
                                if (permis
                                    .where((element) =>
                                        element.menunm == 'Settings')
                                    .first
                                    .children!
                                    .where((element) =>
                                        element.menunm == 'Company Setting')
                                    .first
                                    .features!
                                    .where((element) =>
                                        element.featslug == 'update')
                                    .first
                                    .permissions!
                                    .hasaccess!)
                                  BsCol(
                                    alignment: Alignment.center,
                                    sizes: ColScreen(sm: Col.col_3),
                                    child: InkWell(
                                      onTap: () => presenter.changeStatus(
                                          context, e.sbtid!, e.isactive!),
                                      child: e.isactive!
                                          ? Text('Active',
                                              style: TextStyle(
                                                  color: Colors.green))
                                          : Text(
                                              'Not Active',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                    ),
                                  ),
                                if (permis
                                    .where((element) =>
                                        element.menunm == 'Settings')
                                    .first
                                    .children!
                                    .where((element) =>
                                        element.menunm == 'Company Setting')
                                    .first
                                    .features!
                                    .where((element) =>
                                        element.featslug == 'delete')
                                    .first
                                    .permissions!
                                    .hasaccess!)
                                  BsCol(
                                      alignment: Alignment.center,
                                      sizes: ColScreen(sm: Col.col_1),
                                      child: Text('|')),
                                if (permis
                                    .where((element) =>
                                        element.menunm == 'Settings')
                                    .first
                                    .children!
                                    .where((element) =>
                                        element.menunm == 'Company Setting')
                                    .first
                                    .features!
                                    .where((element) =>
                                        element.featslug == 'delete')
                                    .first
                                    .permissions!
                                    .hasaccess!)
                                  BsCol(
                                    alignment: Alignment.center,
                                    sizes: ColScreen(sm: Col.col_3),
                                    child: InkWell(
                                      onTap: () => presenter.delete(context,
                                          e.sbtid!, e.sbttypename ?? ''),
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
                _DefautlNoTypes('Customer Label'),
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
    Snackbar().createSuccess(context);
  }

  @override
  void onDeleteSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    presenter.datatables(context!);
    Navigator.pop(context);
    Snackbar().deleteSuccess(context);
  }

  @override
  void onEditSuccess(Response response, {BuildContext? context}) {
    presenter.setProcessing(false);
    presenter.datatables(context!);
    source.value.reset();
    source.value.isformactcat.value = false;
    source.value.isupdate.value = false;
    Snackbar().editSuccess(context);
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

    _sources.stbpprospectcustomerlabel.value = stbpraw;
  }

  @override
  void onSuccessFetchData(Response response) {
    source.update((val) {
      source.value.isupdate.value = true;
      source.value.isformactcat.value = true;
      StbptypeModel val = StbptypeModel.fromJson(response.body);
      source.value.id.value = val.sbtid ?? 0;
      source.value.inputName.text = val.sbttypename ?? '';

      if (val.sbtseq != null) {
        source.value.seq.value = true;
        source.value.inputSeq.text =
            val.sbtseq != null ? val.sbtseq.toString() : '';
      }

      if (val.sbtremark != null) {
        Map<String, dynamic> colors = {};
        colors = jsonDecode(val.sbtremark ?? '');
        source.value.pickerColor.value = Color(parseInt(colors['color']));
        source.value.pickerTextColor.value =
            Color(parseInt(colors['textcolor']));
      }
      source.value.createdby.value = val.stbptypecreatedby?.userfullname ?? '';
      source.value.createddate.value = val.createddate ?? '';
      source.value.updatedby.value = val.stbptypeupdatedby?.userfullname ?? '';
      source.value.updateddate.value = val.updateddate ?? '';
      source.value.isactive.value = val.isactive ?? false;
    });
  }
}
