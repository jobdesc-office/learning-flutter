part of '../../prospect_detail.dart';

class _TabNote extends StatelessWidget {
  const _TabNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _navigation = Get.find<NavigationPresenter>();
    final presenter = Get.find<ProspectPresenter>();
    final GlobalKey<FormState> formState = GlobalKey<FormState>();
    TextEditingController inputNotesPopup = TextEditingController();
    ZefyrController inputDescription =
        ZefyrController(NotusDocument.fromJson(jsonDecode(source.desc.value)));
    if (source.desc.value != '') source.isdesc.value = true;
    return Column(
      mainAxisAlignment: source.desc.value != ''
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(5),
          child: Column(
            children: [
              if (source.desc.value != '')
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
                )
              else
                Container(
                  margin: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text('Notes is Empty'),
                            BsButton(
                                size: BsButtonSize.btnIconMd,
                                prefixIcon: Icons.edit,
                                onPressed: () => source.isdesc.value = true)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              if (source.isdesc.value)
                Obx(() => Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 20),
                    child: Form(
                      key: formState,
                      child: BsRow(
                        children: [
                          BsCol(
                              child: FormGroup(
                                  label: Obx(() => Text('Notes',
                                      style: TextStyle(
                                          color: _navigation.darkTheme.value
                                              ? Colors.white
                                              : Colors.black))),
                                  child: ZefyrEditorComponent(
                                    controller: inputDescription,
                                    // validators: [
                                    //   Validators.editorRequired('Description'),
                                    // ],
                                  ))),
                          BsCol(
                              margin: EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ThemeButtonSave(onPressed: () async {
                                    if (formState.currentState!.validate()) {
                                      SessionModel session =
                                          await SessionManager.current();
                                      presenter.changeNote(
                                          context,
                                          {
                                            'prospectdescription': jsonEncode(
                                                inputDescription.document),
                                            'createdby': session.userid,
                                            'updatedby': session.userid
                                          },
                                          source.prospectid.value);
                                      source.desc.value = inputNotesPopup.text;
                                    }
                                  })
                                ],
                              )),
                        ],
                      ),
                    )))
            ],
          ),
        )
      ],
    );
  }
}
