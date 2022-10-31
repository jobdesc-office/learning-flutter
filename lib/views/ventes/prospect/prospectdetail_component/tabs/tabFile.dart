part of '../../prospect_detail.dart';

class _TabFile extends StatefulWidget {
  const _TabFile({Key? key}) : super(key: key);

  @override
  State<_TabFile> createState() => _TabFileState();
}

class _TabFileState extends State<_TabFile> with TickerProviderStateMixin {
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
    final filePresenter = Get.find<ProspectFilePresenter>();
    final presenter = Get.find<ProspectDetailPresenter>();
    if (source.files.length != 0)
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
                                        'Files : ',
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
                                                    FilePickerResult? result =
                                                        await FilePicker
                                                            .platform
                                                            .pickFiles(
                                                      allowMultiple: true,
                                                      type: FileType.custom,
                                                      allowedExtensions: [
                                                        'jpeg',
                                                        'jpg',
                                                        'pdf',
                                                        'png',
                                                        'gif'
                                                      ],
                                                    );
                                                    if (result != null) {
                                                      List<Uint8List>
                                                          pickedFile = [];
                                                      for (var item
                                                          in result.files) {
                                                        pickedFile
                                                            .add(item.bytes!);
                                                      }
                                                      source.pickedFile.value =
                                                          pickedFile;
                                                    }
                                                  },
                                                  prefixIcon: Icons.file_open,
                                                  label: Text('Add File'),
                                                ),
                                                if (source
                                                    .pickedFile.isNotEmpty)
                                                  Container(
                                                      margin: EdgeInsets.all(3),
                                                      child: Text(
                                                          'Choosed Files : ${source.pickedFile.length}'))
                                              ],
                                            ),
                                            if (source.pickedFile.isNotEmpty)
                                              ThemeButtonSave(
                                                disabled: filePresenter
                                                    .isProcessing.value,
                                                processing: filePresenter
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
                                      children: source.files.map((files) {
                                        return BsCol(
                                          sizes: ColScreen(sm: Col.col_12),
                                          margin: EdgeInsets.all(
                                            5,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 207, 202, 202),
                                                )),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        InkWell(
                                                          onTap: () =>
                                                              filePresenter
                                                                  .downloadFile(
                                                                      files
                                                                          .url!),
                                                          child: Icon(
                                                              Icons.download),
                                                        ),
                                                        InkWell(
                                                            onTap: () {
                                                              if (files
                                                                      .filename!
                                                                      .substring(files
                                                                              .filename!
                                                                              .length -
                                                                          4) ==
                                                                  '.pdf') {
                                                                filePresenter
                                                                    .viewFile(files
                                                                        .url!);
                                                              } else {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          ImagePictureFiles(
                                                                    title: files
                                                                        .filename,
                                                                    image: files
                                                                        .url,
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5),
                                                              child: Icon(Icons
                                                                  .remove_red_eye),
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
                                                                  'update')
                                                              .first
                                                              .permissions!
                                                              .hasaccess!)
                                                            InkWell(
                                                                onTap: () => filePresenter.edit(
                                                                    context,
                                                                    files
                                                                        .fileid!,
                                                                    files
                                                                        .filename!,
                                                                    files
                                                                        .remark!),
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              5),
                                                                  child: Icon(
                                                                      Icons
                                                                          .edit),
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
                                                                onTap: () =>
                                                                    filePresenter.delete(
                                                                        context,
                                                                        files
                                                                            .fileid!,
                                                                        files
                                                                            .filename!),
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              5),
                                                                  child: Icon(Icons
                                                                      .delete),
                                                                )),
                                                      ],
                                                    ),
                                                    ExpansionTile(
                                                      expandedAlignment:
                                                          Alignment.centerLeft,
                                                      leading: files.mimetype!
                                                              .contains('image')
                                                          ? Icon(Icons.image)
                                                          : Icon(
                                                              FontAwesomeIcons
                                                                  .filePdf),
                                                      title: Text(
                                                          files.filename ?? ''),
                                                      subtitle: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(files.mimetype ??
                                                              ''),
                                                          Text(files
                                                                  .createddate ??
                                                              ''),
                                                        ],
                                                      ),
                                                      children: [
                                                        Text(files.remark ?? '')
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
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
              Text('There\'s no Files'),
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
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              allowMultiple: true,
                              type: FileType.custom,
                              allowedExtensions: [
                                'jpeg',
                                'jpg',
                                'pdf',
                                'png',
                                'gif'
                              ],
                            );
                            if (result != null) {
                              List<Uint8List> pickedFile = [];
                              for (var item in result.files) {
                                pickedFile.add(item.bytes!);
                              }
                              source.pickedFile.value = pickedFile;
                            }
                          },
                          prefixIcon: Icons.file_open,
                          label: Text('Add File'),
                        ),
                        if (source.pickedFile.isNotEmpty)
                          Container(
                              margin: EdgeInsets.all(3),
                              child: Text(
                                  'Choosed Files : ${source.pickedFile.length}'))
                      ],
                    ),
                    if (source.pickedFile.isNotEmpty)
                      ThemeButtonSave(
                        disabled: filePresenter.isProcessing.value,
                        processing: filePresenter.isProcessing.value,
                        margin: EdgeInsets.only(right: 5),
                        onPressed: () async {
                          presenter.choosedPopup(context);
                        },
                      )
                  ])
            ],
          ));
  }
}
