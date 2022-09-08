part of '../../company.dart';

class _CompanyTabFormSource extends GetxController {
  _CompanyTabFormSource();

  var id = 0.obs;

  var isupdate = false.obs;

  var isformactcat = false.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = true.obs;

  var pickerColor = Color(0xff443a49).obs;
  var pickedColor = ''.obs;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputSeq = TextEditingController();

  reset() {
    inputName.text = '';
    inputSeq.text = '';
  }

  Widget form(BuildContext context, presenter, int typeid, String typename,
      {bool color = false}) {
    return BsRow(
      children: [
        BsCol(
          sizes: ColScreen(sm: Col.col_6),
          child: AnimatedContainer(
            duration: Duration(seconds: 3),
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.all(3),
            child: Column(
              children: [
                FormGroup(
                  label: Obx(() => Text('Category Type Name',
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black))),
                  child: CustomInput(
                    disabled: presenter.isProcessing.value,
                    controller: inputName,
                    hintText: BaseText.hintText(field: 'Category Type Name'),
                  ),
                ),
                FormGroup(
                  label: Obx(() => Text('Category Sequence',
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black))),
                  child: CustomInputNumber(
                    disabled: presenter.isProcessing.value,
                    controller: inputSeq,
                    hintText: BaseText.hintText(field: 'Category Sequel'),
                  ),
                ),
                if (color)
                  FormGroup(
                      child: Column(
                    children: [
                      BsButton(
                          onPressed: () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Pick a color!'),
                                    content: SingleChildScrollView(
                                      child: Obx(() => ColorPicker(
                                          pickerColor: pickerColor.value,
                                          onColorChanged: ((value) {
                                            pickerColor.value = value;
                                            pickedColor.value = value
                                                .toString()
                                                .replaceAll('Color(', '')
                                                .replaceAll(')', '');
                                          }))),
                                    ),
                                  ))),
                      Obx(() => Card(
                            color: pickerColor.value,
                            child: Text('Picked Color'),
                          ))
                    ],
                  )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ThemeButtonSave(onPressed: () async {
                      SessionModel session = await SessionManager.current();
                      Map<String, dynamic> body = {
                        'sbtbpid': box.read('mybpid'),
                        'sbtname': typename,
                        'sbtseq': inputSeq.text == '' ? null : inputSeq.text,
                        'sbttypemasterid': typeid,
                        'sbttypename': inputName.text,
                        'sbtremark': color ? pickedColor.value : null,
                        'createdby': session.userid,
                        'updatedby': session.userid,
                        'isactive': isactive.value,
                      };
                      if (isupdate.value) {
                        presenter.update(context, body, id.value);
                      } else {
                        presenter.save(context, body);
                      }
                    }),
                    ThemeButtonCancel(
                      margin: EdgeInsets.only(left: 5),
                      onPressed: () {
                        isformactcat.value = false;
                        isupdate.value = false;
                        reset();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        if (isupdate.value)
          BsCol(
            margin: EdgeInsets.only(left: 5),
            sizes: ColScreen(lg: Col.col_6),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _navigation.darkTheme.value
                    ? ColorPallates.elseDarkColor
                    : Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: BsRow(
                children: [
                  BsCol(
                    child: BsRow(
                      children: [
                        BsCol(
                          child: FormGroup(
                              label: Text('Created By',
                                  style: TextStyle(
                                      color: _navigation.darkTheme.value
                                          ? Colors.white
                                          : Colors.black)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text(createdby.value), Divider()],
                              )),
                        ),
                        BsCol(
                          margin: EdgeInsets.only(top: 10),
                          child: FormGroup(
                              label: Text('Created At',
                                  style: TextStyle(
                                      color: _navigation.darkTheme.value
                                          ? Colors.white
                                          : Colors.black)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text(createddate.value), Divider()],
                              )),
                        ),
                        BsCol(
                          margin: EdgeInsets.only(top: 10),
                          child: FormGroup(
                              label: Text('Last Updated By',
                                  style: TextStyle(
                                      color: _navigation.darkTheme.value
                                          ? Colors.white
                                          : Colors.black)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text(updatedby.value), Divider()],
                              )),
                        ),
                        BsCol(
                          margin: EdgeInsets.only(top: 10),
                          child: FormGroup(
                              label: Text('Last Updated At',
                                  style: TextStyle(
                                      color: _navigation.darkTheme.value
                                          ? Colors.white
                                          : Colors.black)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text(updateddate.value), Divider()],
                              )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
      ],
    );
  }
}
