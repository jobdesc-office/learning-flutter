part of '../../prospect_detail.dart';

class _TabFile extends StatefulWidget {
  const _TabFile({Key? key}) : super(key: key);

  @override
  State<_TabFile> createState() => _TabFileState();
}

class _TabFileState extends State<_TabFile> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filePresenter = Get.find<ProspectFilePresenter>();
    final presenter = Get.find<ProspectPresenter>();
    if (source.files.length != 0)
      return Column(
        children: [
          BsRow(
            children: [
              BsCol(
                sizes: ColScreen(sm: Col.col_4),
                child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    tabs: [
                      Tab(
                        text: 'Documents',
                      ),
                      Tab(
                        text: 'Templates',
                      )
                    ]),
              ),
              BsCol(
                child: Container(
                  width: double.infinity,
                  height: 270,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
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
                                      Row(children: [
                                        Column(
                                          children: [
                                            BsButton(
                                              style: BsButtonStyle.success,
                                              margin: EdgeInsets.only(top: 10),
                                              onPressed: () async {
                                                FilePickerResult? result =
                                                    await FilePicker.platform
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
                                                  List<Uint8List> pickedFile =
                                                      [];
                                                  for (var item
                                                      in result.files) {
                                                    pickedFile.add(item.bytes!);
                                                  }
                                                  source.pickedFile.value =
                                                      pickedFile;
                                                }
                                              },
                                              prefixIcon: Icons.file_open,
                                              label: Text('Add File'),
                                            ),
                                            if (source.pickedFile.isNotEmpty)
                                              Container(
                                                  margin: EdgeInsets.all(3),
                                                  child: InkWell(
                                                      onTap: () => presenter
                                                          .choosedPopup(
                                                              context),
                                                      child: Text(
                                                          'Choosed Files : ${source.pickedFile.length}')))
                                          ],
                                        ),
                                        if (source.pickedFile.isNotEmpty)
                                          ThemeButtonSave(
                                            disabled: filePresenter
                                                .isProcessing.value,
                                            processing: filePresenter
                                                .isProcessing.value,
                                            margin: EdgeInsets.only(right: 5),
                                            onPressed: () async {
                                              filePresenter.setProcessing(true);
                                              filePresenter.save(
                                                  context,
                                                  FormData(
                                                      await source.toJson()));
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
                                          child: Tooltip(
                                            message: 'Long Press to Delete',
                                            child: InkWell(
                                              onTap: () {
                                                if (files.filename!.substring(
                                                        files.filename!.length -
                                                            4) ==
                                                    '.pdf') {
                                                  Get.snackbar('Sorry',
                                                      'PDF View Coming Soon');
                                                } else {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        ImagePictureFiles(
                                                      title: files.filename,
                                                      image: files.url,
                                                    ),
                                                  );
                                                }
                                              },
                                              onLongPress: (() =>
                                                  filePresenter.delete(
                                                      context,
                                                      files.fileid!,
                                                      files.filename!)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
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
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(files
                                                                    .filename ??
                                                                ''),
                                                            Text(files
                                                                    .createddate ??
                                                                ''),
                                                          ],
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              files.mimetype ??
                                                                  '',
                                                              style: TextStyle(
                                                                  fontSize: 13),
                                                            ),
                                                            Divider(),
                                                            Text(
                                                                files.remark ??
                                                                    '',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ))
                              ],
                            ),
                          )),
                      Container()
                    ],
                  ),
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
                          child: InkWell(
                              onTap: () => presenter.choosedPopup(context),
                              child: Text(
                                  'Choosed Files : ${source.pickedFile.length}')))
                  ],
                ),
                if (source.pickedFile.isNotEmpty)
                  ThemeButtonSave(
                    disabled: filePresenter.isProcessing.value,
                    processing: filePresenter.isProcessing.value,
                    margin: EdgeInsets.only(right: 5),
                    onPressed: () async {
                      filePresenter.setProcessing(true);
                      filePresenter.save(
                          context, FormData(await source.toJson()));
                    },
                  )
              ])
            ],
          ));
  }
}
