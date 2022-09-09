part of '../../company.dart';

class _CompanyTabFormSource extends GetxController {
  _CompanyTabFormSource();

  var seq = false.obs;

  var withcolor = false.obs;

  var id = 0.obs;

  var isupdate = false.obs;

  var isformactcat = false.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = true.obs;

  var pickerColor = ColorPallates.primary.obs;
  var pickedColor = '0xFF6D9773'.obs;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputSeq = TextEditingController();

  reset() {
    source.value.seq.value = false;
    inputName.text = '';
    inputSeq.text = '';
    withcolor.value = false;
  }

  Widget form(BuildContext context, presenter, int typeid, String typename,
      String tabname,
      {bool color = false}) {
    if (color) withcolor.value = color;
    return BsRow(
      children: [
        BsCol(
          sizes: ColScreen(sm: Col.col_6),
          child: AnimatedContainer(
            duration: Duration(seconds: 3),
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.all(3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormGroup(
                  label: Obx(() => Text('$tabname Name',
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black))),
                  child: CustomInput(
                    disabled: presenter.isProcessing.value,
                    controller: inputName,
                    hintText: BaseText.hintText(field: '$tabname Name'),
                  ),
                ),
                Row(
                  children: [
                    Text('Set Custom Sequence'),
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Obx(() => Checkbox(
                          value: seq.value,
                          onChanged: (value) => seq.toggle())),
                    ),
                  ],
                ),
                if (seq.value)
                  FormGroup(
                    label: Obx(() => Text('$tabname Sequence',
                        style: TextStyle(
                            color: _navigation.darkTheme.value
                                ? Colors.white
                                : Colors.black))),
                    child: CustomInputNumber(
                      disabled: presenter.isProcessing.value,
                      controller: inputSeq,
                      hintText: BaseText.hintText(field: '$tabname Sequel'),
                    ),
                  ),
                if (color)
                  FormGroup(
                      child: Row(
                    children: [
                      BsButton(
                          style: BsButtonStyle.success,
                          label: Text('Pick Color'),
                          onPressed: () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Pick a color !'),
                                    content: SingleChildScrollView(
                                      child: Obx(() => ColorPicker(
                                          pickerColor: pickerColor.value,
                                          onColorChanged: ((value) {
                                            pickerColor.value = value;
                                            pickedColor.value = pickerColor
                                                .value
                                                .toString()
                                                .replaceAll('Color(', '')
                                                .replaceAll(')', '');
                                          }))),
                                    ),
                                  ))),
                      Obx(() => BsButton(
                            margin: EdgeInsets.only(left: 20),
                            onPressed: () => showDialog(
                                context: context,
                                builder: (context) => _ShowColor(
                                      color: pickerColor.value,
                                    )),
                            style: BsButtonStyle(
                                borderColor: Colors.black,
                                color: Colors.black,
                                backgroundColor: pickerColor.value),
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
                        'sbtremark': withcolor.value ? pickedColor.value : null,
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
