part of '../../prospect_detail.dart';

class _TabActivity extends StatelessWidget {
  const _TabActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    var permis = authPresenter.rolepermis.value;
    final source = Get.put(ProspectDetailsSource());
    final detailPresenter = Get.find<ProspectActivityPresenter>();
    return Obx(() => Column(
          mainAxisAlignment: source.detailData.isNotEmpty
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            if (source.detailData.isNotEmpty)
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Activities :',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    if (source.status.value !=
                                            ProspectText.closedWon &&
                                        source.status.value !=
                                            ProspectText.closedLost &&
                                        source.status.value !=
                                            ProspectText.forceClosed)
                                      if (permis
                                          .where((element) =>
                                              element.menunm == 'Ventes Datas')
                                          .first
                                          .children!
                                          .where((element) =>
                                              element.menunm == 'Prospect')
                                          .first
                                          .features!
                                          .where((element) =>
                                              element.featslug == 'create')
                                          .first
                                          .permissions!
                                          .hasaccess!)
                                        BsButton(
                                            style: BsButtonStyle.success,
                                            onPressed: () =>
                                                detailPresenter.add(context,
                                                    source.prospectid.value),
                                            label: Text('Add Activity')),
                                  ],
                                ),
                              )),
                          Obx(() => Column(
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: source.detailData
                                    .map((element) => Tooltip(
                                          message: source.status.value !=
                                                      ProspectText.closedWon &&
                                                  source.status.value !=
                                                      ProspectText.closedLost &&
                                                  source.status.value !=
                                                      ProspectText.forceClosed
                                              ? BaseText.editDelete
                                              : '',
                                          child: InkWell(
                                            onLongPress: () {
                                              if (source.status.value !=
                                                      ProspectText.closedWon &&
                                                  source.status.value !=
                                                      ProspectText.closedLost &&
                                                  source.status.value !=
                                                      ProspectText.forceClosed)
                                                Get.defaultDialog(
                                                    middleText: '',
                                                    title: 'Setting',
                                                    actions: [
                                                      if (permis
                                                          .where((element) =>
                                                              element.menunm ==
                                                              'Ventes Datas')
                                                          .first
                                                          .children!
                                                          .where((element) =>
                                                              element.menunm ==
                                                              'Prospect')
                                                          .first
                                                          .features!
                                                          .where((element) =>
                                                              element
                                                                  .featslug ==
                                                              'update')
                                                          .first
                                                          .permissions!
                                                          .hasaccess!)
                                                        ButtonEditDatatables(
                                                            onPressed: () {
                                                          source.doubleback
                                                              .value = true;
                                                          detailPresenter.edit(
                                                              context,
                                                              element.dayactid!,
                                                              source.prospectid
                                                                  .value);
                                                        }),
                                                      if (permis
                                                          .where((element) =>
                                                              element.menunm ==
                                                              'Ventes Datas')
                                                          .first
                                                          .children!
                                                          .where((element) =>
                                                              element.menunm ==
                                                              'Prospect')
                                                          .first
                                                          .features!
                                                          .where((element) =>
                                                              element
                                                                  .featslug ==
                                                              'delete')
                                                          .first
                                                          .permissions!
                                                          .hasaccess!)
                                                        ButtonDeleteDatatables(
                                                            onPressed: () {
                                                          detailPresenter.delete(
                                                              context,
                                                              element.dayactid!,
                                                              '${element.dayactcat!.sbttypename} at ${element.dayactdate}');
                                                        }),
                                                    ]);
                                            },
                                            onTap: () {
                                              detailPresenter.detail(
                                                  context, element.dayactid!);
                                            },
                                            child: BsRow(
                                              children: [
                                                BsCol(
                                                    sizes: ColScreen(
                                                        sm: Col.col_1),
                                                    child: Column(
                                                      children: [
                                                        OutlinedDotIndicator(),
                                                        SizedBox(
                                                          height: 70.0,
                                                          child:
                                                              SolidLineConnector(),
                                                        )
                                                      ],
                                                    )),
                                                BsCol(
                                                    alignment: Alignment.center,
                                                    sizes: ColScreen(
                                                        sm: Col.col_3),
                                                    child: Text(
                                                        element.dayactdate ??
                                                            '')),
                                                BsCol(
                                                    sizes: ColScreen(
                                                        sm: Col.col_8),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                element.dayactcat
                                                                        ?.sbttypename ??
                                                                    '',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                            Text(
                                                              'Created at : ${element.createddate ?? ''}',
                                                              style: TextStyle(
                                                                  fontSize: 12),
                                                            )
                                                          ],
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(element
                                                                  .dayactloclabel ??
                                                              ''),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5,
                                                                  bottom: 10),
                                                          child: Text(
                                                            element.dayactdesc ??
                                                                '',
                                                            style: TextStyle(
                                                                fontSize: 12),
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
              )
            else
              Obx(() => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('There\'s no Activity'),
                      if (source.status.value != ProspectText.closedWon &&
                          source.status.value != ProspectText.closedLost &&
                          source.status.value != ProspectText.forceClosed)
                        if (permis
                            .where(
                                (element) => element.menunm == 'Ventes Datas')
                            .first
                            .children!
                            .where((element) => element.menunm == 'Prospect')
                            .first
                            .features!
                            .where((element) => element.featslug == 'create')
                            .first
                            .permissions!
                            .hasaccess!)
                          BsButton(
                              margin: EdgeInsets.only(top: 5),
                              style: BsButtonStyle.success,
                              onPressed: () => detailPresenter.add(
                                  context, source.prospectid.value),
                              label: Text('Add Activity')),
                    ],
                  ))
          ],
        ));
  }
}
