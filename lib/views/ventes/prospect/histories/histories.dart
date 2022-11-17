part of '../prospect_detail.dart';

class TabHistory extends StatelessWidget {
  const TabHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<HistoryModel> list = source.allhistories
      ..sort((HistoryModel a, HistoryModel b) =>
          parseDate(b.createddate)!.compareTo(parseDate(a.createddate)!));

    return SingleChildScrollView(
      child: Obx(() =>
          // source.prospecthistories.isNotEmpty ||
          //         source.prospectproducthistories.isNotEmpty ||
          //         source.prospectassignhistories.isNotEmpty ||
          //         source.prospectactivityhistories.isNotEmpty ||
          //         source.prospectcustomfieldhistories.isNotEmpty ||
          //         source.prospectfilehistories.isNotEmpty
          list.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: list.map((element) {
                    String info;
                    switch (element.historytbhistory?.tbhistorytbname) {
                      case 'trprospect':
                        info = 'Prospect';
                        break;
                      case 'trprospectactivity':
                        info = 'Activity';
                        break;
                      case 'trprospectproduct':
                        info = 'Product';
                        break;
                      case 'trprospectassign':
                        info = 'Assignation';
                        break;
                      case 'msfiles':
                        info = 'File';
                        break;
                      case 'trprospectcustomfield':
                        info = 'Customfield';
                        break;
                      default:
                        info = 'Prospect';
                    }
                    return Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.fromLTRB(3, 3, 3, 5),
                      child: BsRow(
                        children: [
                          BsCol(
                            child: Divider(),
                          ),
                          BsCol(
                            child: BsRow(
                              children: [
                                BsCol(
                                  sizes: ColScreen(sm: Col.col_1),
                                  child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.history,
                                        size: 48,
                                      )),
                                ),
                                BsCol(
                                  sizes: ColScreen(sm: Col.col_11),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(element.historyremark ?? ''),
                                      Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(timeago.format(parseDate(
                                                  element.createddate ??
                                                      DateTime.now())!)),
                                              Text(info)
                                            ],
                                          )),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          BsCol(
                            child: Divider(),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                )
              // Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       TabWebProspect(),
              //       TabWebProspectActivity(),
              //       TabWebProspectAssign(),
              //       TabWebProspectCustomfield(),
              //       TabWebProspectFile(),
              //       TabWebProspectProduct()
              //     ],
              //   )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Center(child: Text(BaseText.defaultNoHistory)),
                    )
                  ],
                )),
    );
  }
}
