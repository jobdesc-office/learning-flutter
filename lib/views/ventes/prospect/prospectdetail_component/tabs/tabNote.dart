part of '../../prospect_detail.dart';

class _TabNote extends StatelessWidget {
  const _TabNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Get.find<ProspectPresenter>();
    final GlobalKey<FormState> formState = GlobalKey<FormState>();
    ZefyrController inputDescription;
    if (source.desc.value == '')
      inputDescription = ZefyrController(NotusDocument());
    else
      inputDescription = ZefyrController(
          NotusDocument.fromJson(jsonDecode(source.desc.value)));
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            'Notes :',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 20),
                  child: Form(
                    key: formState,
                    child: BsRow(
                      children: [
                        BsCol(
                            child: FormGroup(
                                // label: Obx(() => Text('Notes',
                                //     style: TextStyle(
                                //         color: _navigation.darkTheme.value
                                //             ? Colors.white
                                //             : Colors.black))),
                                child: ZefyrEditorComponent(
                          readonly:
                              source.status.value != ProspectText.closedWon &&
                                      source.status.value !=
                                          ProspectText.closedLost &&
                                      source.status.value !=
                                          ProspectText.forceClosed
                                  ? false
                                  : true,
                          controller: inputDescription,
                          // validators: [
                          //   Validators.editorRequired('Description'),
                          // ],
                        ))),
                        if (source.status.value != ProspectText.closedWon &&
                            source.status.value != ProspectText.closedLost &&
                            source.status.value != ProspectText.forceClosed)
                          BsCol(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Obx(() =>
                                      ThemeButtonSave(onPressed: () async {
                                        if (formState.currentState!
                                            .validate()) {
                                          SessionModel session =
                                              await SessionManager.current();
                                          presenter.changeNote(
                                              context,
                                              {
                                                'prospectdescription':
                                                    jsonEncode(inputDescription
                                                        .document),
                                                'createdby': session.userid,
                                                'updatedby': session.userid
                                              },
                                              source.prospectid.value);
                                          source.desc.value = jsonEncode(
                                              inputDescription.document);
                                        }
                                      }))
                                ],
                              )),
                      ],
                    ),
                  ))
            ],
          ),
        )
      ],
    );
  }
}
