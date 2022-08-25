part of '../../prospect_detail.dart';

class _TabActivity extends StatelessWidget {
  const _TabActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final source = Get.put(ProspectDetailsSource());
    final detailPresenter = Get.find<ProspectActivityPresenter>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Activities :',
                        style: TextStyle(fontSize: 18),
                      ),
                      BsButton(
                          style: BsButtonStyle.success,
                          onPressed: () => detailPresenter.add(
                              context, source.prospectid.value),
                          label: Text('Add Activity')),
                    ],
                  ),
                ),
                Obx(() => Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: source.detailData
                          .map((element) => Tooltip(
                                message: BaseText.editDelete,
                                child: InkWell(
                                  onLongPress: () {
                                    Get.defaultDialog(
                                        middleText: '',
                                        title: 'Setting',
                                        actions: [
                                          ButtonEditDatatables(onPressed: () {
                                            detailPresenter.edit(
                                                context,
                                                element.prospectactivityid!,
                                                source.prospectid.value);
                                          }),
                                          ButtonDeleteDatatables(onPressed: () {
                                            detailPresenter.delete(
                                                context,
                                                element.prospectactivityid!,
                                                '${element.prospectactivitytype!.typename} at ${element.prospectactivitydate}');
                                          }),
                                        ]);
                                  },
                                  onTap: () {
                                    detailPresenter.detail(
                                        context, element.prospectactivityid!);
                                  },
                                  child: BsRow(
                                    children: [
                                      BsCol(
                                          sizes: ColScreen(sm: Col.col_1),
                                          child: Column(
                                            children: [
                                              OutlinedDotIndicator(),
                                              SizedBox(
                                                height: 45.0,
                                                child: SolidLineConnector(),
                                              )
                                            ],
                                          )),
                                      BsCol(
                                          alignment: Alignment.center,
                                          sizes: ColScreen(sm: Col.col_3),
                                          child: Text(
                                              element.prospectactivitydate ??
                                                  '')),
                                      BsCol(
                                          sizes: ColScreen(sm: Col.col_8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                element.prospectactivitycat
                                                        ?.typename ??
                                                    '',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(element
                                                        .prospectactivitytype
                                                        ?.typename ??
                                                    ''),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                  element.prospectactivitydesc ??
                                                      '',
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
