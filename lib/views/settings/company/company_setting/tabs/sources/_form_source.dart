part of '../../company.dart';

class _CompanyTabFormSource extends GetxController {
  _CompanyTabFormSource();

  var seq = false.obs;

  var id = 0.obs;

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  var isupdate = false.obs;

  var isformactcat = false.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = true.obs;

  var pickerColor = Color.fromARGB(0, 255, 255, 255).obs;
  var pickedColor = '0xFF0000ffff'.obs;

  var pickerTextColor = Color.fromARGB(255, 0, 0, 0).obs;
  var pickedTextColor = '0xFF000000'.obs;

  TextEditingController inputName = TextEditingController();
  TextEditingController inputSeq = TextEditingController();

  reset() {
    seq.value = false;
    id.value = 0;
    isupdate.value = false;

    // pickerColor.value = Color.fromARGB(0, 255, 255, 255);
    // pickedColor.value = '0xFF0000ffff';
    // pickerTextColor.value = Color.fromARGB(255, 0, 0, 0);
    // pickedTextColor.value = '0xFF000000';

    createdby.value = '';
    createddate.value = '';
    updatedby.value = '';
    updateddate.value = '';
    isactive.value = false;

    // pickerColor.value = Color.fromARGB(0, 255, 255, 255);
    // pickedColor.value = '0xFF0000ffff';

    // pickerTextColor.value = Color.fromARGB(255, 0, 0, 0);
    // pickedTextColor.value = '0xFF000000';

    inputName.text = '';
    inputSeq.text = '';
  }

  Widget form(BuildContext context, presenter, int typeid, String typename,
      String tabname,
      {bool color = false, bool textcolor = false}) {
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
                Form(
                  key: formState,
                  child: FormGroup(
                    label: Obx(() => Text('$tabname Name',
                        style: TextStyle(
                            color: _navigation.darkTheme.value
                                ? Colors.white
                                : Colors.black))),
                    child: CustomInput(
                        disabled: presenter.isProcessing.value,
                        controller: inputName,
                        hintText: BaseText.hintText(field: '$tabname Name'),
                        validators: [
                          Validators.inputRequired('$tabname Name')
                        ]),
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
                  BsRow(
                    children: [
                      BsCol(
                        sizes: ColScreen(sm: Col.col_6),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BsButton(
                                    style: BsButtonStyle.success,
                                    label: Text('Pick Color'),
                                    onPressed: () => showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              backgroundColor:
                                                  Color(0xfff1f1f1),
                                              title:
                                                  const Text('Pick a color !'),
                                              content: SingleChildScrollView(
                                                child: Obx(() => ColorPicker(
                                                    pickerColor:
                                                        pickerColor.value,
                                                    onColorChanged: ((value) {
                                                      pickerColor.value = value;
                                                      pickedColor.value =
                                                          pickerColor.value
                                                              .toString()
                                                              .replaceAll(
                                                                  'Color(', '')
                                                              .replaceAll(
                                                                  ')', '');
                                                    }))),
                                              ),
                                            ))),
                                Obx(() => BsButton(
                                      margin: EdgeInsets.only(left: 20),
                                      onPressed: () {},
                                      style: BsButtonStyle(
                                          borderColor: Colors.black,
                                          color: Colors.black,
                                          backgroundColor: pickerColor.value),
                                    ))
                              ],
                            ),
                            if (textcolor)
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BsButton(
                                        style: BsButtonStyle.success,
                                        label: Text('Pick Text Color'),
                                        onPressed: () => showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  backgroundColor:
                                                      Color(0xfff1f1f1),
                                                  title: const Text(
                                                      'Pick a color !'),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Obx(() =>
                                                        ColorPicker(
                                                            pickerColor:
                                                                pickerTextColor
                                                                    .value,
                                                            onColorChanged:
                                                                ((value) {
                                                              pickerTextColor
                                                                      .value =
                                                                  value;
                                                              pickedTextColor
                                                                      .value =
                                                                  pickerTextColor
                                                                      .value
                                                                      .toString()
                                                                      .replaceAll(
                                                                          'Color(',
                                                                          '')
                                                                      .replaceAll(
                                                                          ')',
                                                                          '');
                                                            }))),
                                                  ),
                                                ))),
                                    Obx(() => BsButton(
                                          margin: EdgeInsets.only(left: 20),
                                          onPressed: () {},
                                          style: BsButtonStyle(
                                              borderColor: Colors.black,
                                              color: Colors.black,
                                              backgroundColor:
                                                  pickerTextColor.value),
                                        ))
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      BsCol(
                        alignment: Alignment.centerRight,
                        sizes: ColScreen(sm: Col.col_6),
                        child: Obx(() => InkWell(
                              onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => _ShowColor(
                                        color: pickerColor.value,
                                        textcolor: pickerTextColor.value,
                                        text: tabname,
                                      )),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: pickerColor.value,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  '$tabname',
                                  style: TextStyle(
                                      color: textcolor
                                          ? pickerTextColor.value
                                          : Colors.black,
                                      fontSize: 28),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ThemeButtonSave(onPressed: () async {
                      if (formState.currentState!.validate()) {
                        SessionModel session = await SessionManager.current();
                        late Map<String, dynamic> colors;
                        if (color)
                          colors = {
                            'color': pickedColor.value,
                          };
                        if (color && textcolor)
                          colors = {
                            'color': pickedColor.value,
                            'textcolor': pickedTextColor.value,
                          };
                        Map<String, dynamic> body = {
                          'sbtbpid': box.read('mybpid'),
                          'sbtname': typename,
                          'sbtseq': inputSeq.text == '' ? null : inputSeq.text,
                          'sbttypemasterid': typeid,
                          'sbttypename': inputName.text,
                          'sbtremark': color ? jsonEncode(colors) : null,
                          'createdby': session.userid,
                          'updatedby': session.userid,
                          'isactive': isactive.value,
                        };
                        if (isupdate.value) {
                          presenter.update(context, body, id.value);
                        } else {
                          presenter.save(context, body);
                        }
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
                          child: FormGroupEdit(
                              label: Text('Created By',
                                  style: TextStyle(
                                      color: _navigation.darkTheme.value
                                          ? Colors.white
                                          : Colors.black)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [Text(createdby.value), Divider()],
                              )),
                        ),
                        BsCol(
                          margin: EdgeInsets.only(top: 10),
                          child: FormGroupEdit(
                              label: Text('Created At',
                                  style: TextStyle(
                                      color: _navigation.darkTheme.value
                                          ? Colors.white
                                          : Colors.black)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [Text(createddate.value), Divider()],
                              )),
                        ),
                        BsCol(
                          margin: EdgeInsets.only(top: 10),
                          child: FormGroupEdit(
                              label: Text('Last Updated By',
                                  style: TextStyle(
                                      color: _navigation.darkTheme.value
                                          ? Colors.white
                                          : Colors.black)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [Text(updatedby.value), Divider()],
                              )),
                        ),
                        BsCol(
                          margin: EdgeInsets.only(top: 10),
                          child: FormGroupEdit(
                              label: Text('Last Updated At',
                                  style: TextStyle(
                                      color: _navigation.darkTheme.value
                                          ? Colors.white
                                          : Colors.black)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
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
