part of '../../prospect_detail.dart';

class _TabCompetitor extends StatefulWidget {
  const _TabCompetitor({Key? key}) : super(key: key);

  @override
  State<_TabCompetitor> createState() => _TabCompetitorState();
}

class _TabCompetitorState extends State<_TabCompetitor>
    with TickerProviderStateMixin {
  // late TabController _tabController;

  @override
  void initState() {
    // _tabController = TabController(length: 1, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: invalid_use_of_protected_member
    var permis = authPresenter.rolepermis.value;
    final competitorPresenter = Get.find<CompetitorPresenter>();
    final prospectcomptPresenter = Get.find<ProspectCompetitorPresenter>();
    final presenter = Get.find<ProspectDetailPresenter>();
    final competitorsource = CompetitorSource().obs;
    final competitorForm = CompetitorForm(competitorsource.value);

    if (source.competitors.length != 0)
      return Column(
        children: [
          BsRow(
            children: [
              // BsCol(
              //   sizes: ColScreen(sm: Col.col_4),
              //   child: TabBar(
              //       controller: _tabController,
              //       labelColor: Colors.black,
              //       tabs: [
              //         Tab(
              //           text: 'Documents',
              //         ),
              //         // Tab(
              //         //   text: 'Templates',
              //         // )
              //       ]),
              // ),
              BsCol(
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.8,
                  child:
                      // TabBarView(
                      //   controller: _tabController,
                      //   children: [
                      Obx(() => SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(top: 15, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Competitors : ',
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
                                                element.menunm ==
                                                'Ventes Datas')
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
                                          Row(children: [
                                            Column(
                                              children: [
                                                BsButton(
                                                  style: BsButtonStyle.success,
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  onPressed: () async {
                                                    prospectcomptPresenter.add(
                                                        context,
                                                        prospectid: source
                                                            .prospectid.value);
                                                  },
                                                  prefixIcon: Icons.person,
                                                  label: Text('Add Competitor'),
                                                ),
                                              ],
                                            ),
                                            if (source.pickedFile.isNotEmpty)
                                              ThemeButtonSave(
                                                disabled: prospectcomptPresenter
                                                    .isProcessing.value,
                                                processing:
                                                    prospectcomptPresenter
                                                        .isProcessing.value,
                                                margin:
                                                    EdgeInsets.only(right: 5),
                                                onPressed: () async {
                                                  presenter
                                                      .choosedPopup(context);
                                                },
                                              )
                                          ])
                                    ],
                                  ),
                                ),
                                Obx(() => BsRow(
                                      children:
                                          source.competitors.map((competitors) {
                                        return BsCol(
                                          sizes: ColScreen(sm: Col.col_12),
                                          margin: EdgeInsets.all(
                                            5,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 100,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all(
                                                      color: Color.fromARGB(
                                                          255, 207, 202, 202),
                                                    )),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      child: competitors
                                                              .comptpics!
                                                              .isNotEmpty
                                                          ? Image.network(
                                                              competitors
                                                                  .comptpics!
                                                                  .last['url']
                                                                  .toString(),
                                                              width: 100)
                                                          : Image.network(
                                                              "http://10.21.1.27/learning-api/public/storage/images/default_image.jpeg",
                                                              width: 100),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width -
                                                              825,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    competitors
                                                                        .comptname!,
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            25),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      "Product: "),
                                                                  Text(competitors
                                                                      .comptproductname!)
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              competitors
                                                                      .description ??
                                                                  '',
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              softWrap: false,
                                                              maxLines: 3,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                            children: [
                                                              if (source.status.value != ProspectText.closedWon &&
                                                                  source.status
                                                                          .value !=
                                                                      ProspectText
                                                                          .closedLost &&
                                                                  source.status
                                                                          .value !=
                                                                      ProspectText
                                                                          .forceClosed)
                                                                if (permis
                                                                    .where((element) =>
                                                                        element
                                                                            .menunm ==
                                                                        'Ventes Datas')
                                                                    .first
                                                                    .children!
                                                                    .where((element) =>
                                                                        element
                                                                            .menunm ==
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
                                                                  InkWell(
                                                                      onTap: () =>
                                                                          prospectcomptPresenter
                                                                              .edit(
                                                                            context,
                                                                            competitors.comptid!,
                                                                          ),
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                5),
                                                                        child: Icon(
                                                                            Icons.edit),
                                                                      )),
                                                              if (source.status.value != ProspectText.closedWon &&
                                                                  source.status
                                                                          .value !=
                                                                      ProspectText
                                                                          .closedLost &&
                                                                  source.status
                                                                          .value !=
                                                                      ProspectText
                                                                          .forceClosed)
                                                                if (permis
                                                                    .where((element) =>
                                                                        element
                                                                            .menunm ==
                                                                        'Ventes Datas')
                                                                    .first
                                                                    .children!
                                                                    .where((element) =>
                                                                        element
                                                                            .menunm ==
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
                                                                  InkWell(
                                                                      onTap:
                                                                          () {
                                                                        // print(competitors
                                                                        //     .comptid);
                                                                        prospectcomptPresenter.delete(
                                                                            context,
                                                                            competitors.comptid!,
                                                                            competitors.comptname!);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                5),
                                                                        child: Icon(
                                                                            Icons.delete),
                                                                      )),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          // child: Column(
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.start,
                                          //   children: [
                                          //     Container(
                                          //       width: MediaQuery.of(context)
                                          //           .size
                                          //           .width,
                                          //       padding: EdgeInsets.all(10),
                                          //       decoration: BoxDecoration(
                                          //           borderRadius:
                                          //               BorderRadius.circular(
                                          //                   15),
                                          //           border: Border.all(
                                          //             color: Color.fromARGB(
                                          //                 255, 207, 202, 202),
                                          //           )),
                                          //       child: Column(
                                          //         crossAxisAlignment:
                                          //             CrossAxisAlignment.end,
                                          //         children: [
                                          //           Row(
                                          //             mainAxisAlignment:
                                          //                 MainAxisAlignment.end,
                                          //             children: [
                                          //               if (source.status.value != ProspectText.closedWon &&
                                          //                   source.status
                                          //                           .value !=
                                          //                       ProspectText
                                          //                           .closedLost &&
                                          //                   source.status
                                          //                           .value !=
                                          //                       ProspectText
                                          //                           .forceClosed)
                                          //                 if (permis
                                          //                     .where((element) =>
                                          //                         element
                                          //                             .menunm ==
                                          //                         'Ventes Datas')
                                          //                     .first
                                          //                     .children!
                                          //                     .where((element) =>
                                          //                         element
                                          //                             .menunm ==
                                          //                         'Prospect')
                                          //                     .first
                                          //                     .features!
                                          //                     .where((element) =>
                                          //                         element
                                          //                             .featslug ==
                                          //                         'update')
                                          //                     .first
                                          //                     .permissions!
                                          //                     .hasaccess!)
                                          //                   InkWell(
                                          //                       onTap: () =>
                                          //                           prospectcomptPresenter
                                          //                               .edit(
                                          //                             context,
                                          //                             competitors
                                          //                                 .comptid!,
                                          //                           ),
                                          //                       child:
                                          //                           Container(
                                          //                         margin: EdgeInsets
                                          //                             .only(
                                          //                                 left:
                                          //                                     5),
                                          //                         child: Icon(
                                          //                             Icons
                                          //                                 .edit),
                                          //                       )),
                                          //               if (source.status.value != ProspectText.closedWon &&
                                          //                   source.status
                                          //                           .value !=
                                          //                       ProspectText
                                          //                           .closedLost &&
                                          //                   source.status
                                          //                           .value !=
                                          //                       ProspectText
                                          //                           .forceClosed)
                                          //                 if (permis
                                          //                     .where((element) =>
                                          //                         element
                                          //                             .menunm ==
                                          //                         'Ventes Datas')
                                          //                     .first
                                          //                     .children!
                                          //                     .where((element) =>
                                          //                         element
                                          //                             .menunm ==
                                          //                         'Prospect')
                                          //                     .first
                                          //                     .features!
                                          //                     .where((element) =>
                                          //                         element
                                          //                             .featslug ==
                                          //                         'delete')
                                          //                     .first
                                          //                     .permissions!
                                          //                     .hasaccess!)
                                          //                   InkWell(
                                          //                       onTap: () {
                                          //                         // print(competitors
                                          //                         //     .comptid);
                                          //                         prospectcomptPresenter.delete(
                                          //                             context,
                                          //                             competitors
                                          //                                 .comptid!,
                                          //                             competitors
                                          //                                 .comptname!);
                                          //                       },
                                          //                       child:
                                          //                           Container(
                                          //                         margin: EdgeInsets
                                          //                             .only(
                                          //                                 left:
                                          //                                     5),
                                          //                         child: Icon(Icons
                                          //                             .delete),
                                          //                       )),
                                          //             ],
                                          //           ),
                                          //           Row(
                                          //             children: [
                                          //               Column(
                                          //                 children: [
                                          //                   Text(competitors
                                          //                       .comptname!),
                                          //                   Text(competitors
                                          //                       .comptproductname!)
                                          //                 ],
                                          //               )
                                          //             ],
                                          //           )
                                          //           // Competitor card
                                          //           // Container(
                                          //           //   height: 250,
                                          //           //   decoration: BoxDecoration(
                                          //           //       color: Colors.white,
                                          //           //       borderRadius:
                                          //           //           BorderRadius
                                          //           //               .circular(15),
                                          //           //       boxShadow: [
                                          //           //         BoxShadow(
                                          //           //             color: Colors
                                          //           //                 .grey
                                          //           //                 .withOpacity(
                                          //           //                     0.5),
                                          //           //             spreadRadius: 3,
                                          //           //             blurRadius: 10,
                                          //           //             offset: Offset(
                                          //           //                 0, 3))
                                          //           //       ]),
                                          //           // )

                                          //           // === Files ===

                                          //           // ExpansionTile(
                                          //           //   expandedAlignment:
                                          //           //       Alignment
                                          //           //           .bottomCenter,
                                          //           //   title: Text(competitors
                                          //           //           .comptname ??
                                          //           //       ''),
                                          //           //   subtitle: Row(
                                          //           //     mainAxisAlignment:
                                          //           //         MainAxisAlignment
                                          //           //             .spaceBetween,
                                          //           //     children: [
                                          //           //       Text(competitors
                                          //           //               .comptname ??
                                          //           //           ''),
                                          //           //       Text(competitors
                                          //           //               .createddate ??
                                          //           //           ''),
                                          //           //     ],
                                          //           //   ),
                                          //           // children: [
                                          //           //   competitors.comptpics!
                                          //           //           .isNotEmpty
                                          //           //       ? Image.network(
                                          //           //           competitors
                                          //           //               .comptpics!
                                          //           //               .last['url']
                                          //           //               .toString(),
                                          //           //           width: 250)
                                          //           //       : Image.network(
                                          //           //           "http://10.21.1.27/learning-api/public/storage/images/default_image.jpeg",
                                          //           //           width: 250)
                                          //           // ],
                                          //           // ),
                                          //         ],
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                        );
                                      }).toList(),
                                    ))
                              ],
                            ),
                          )),
                  // Container()
                  //   ],
                  // ),
                ),
              )
            ],
          ),
        ],
      );
    else
      return Obx(() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No Competitor Added'),
              if (source.status.value != ProspectText.closedWon &&
                  source.status.value != ProspectText.closedLost &&
                  source.status.value != ProspectText.forceClosed)
                if (permis
                    .where((element) => element.menunm == 'Ventes Datas')
                    .first
                    .children!
                    .where((element) => element.menunm == 'Prospect')
                    .first
                    .features!
                    .where((element) => element.featslug == 'create')
                    .first
                    .permissions!
                    .hasaccess!)
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Column(
                      children: [
                        BsButton(
                          style: BsButtonStyle.success,
                          margin: EdgeInsets.only(top: 10),
                          onPressed: () async {
                            prospectcomptPresenter.add(context,
                                prospectid: source.prospectid.value);
                          },
                          prefixIcon: Icons.person,
                          label: Text('Add Competitor'),
                        ),
                      ],
                    ),
                  ])
            ],
          ));
  }
}
