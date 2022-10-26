// ignore_for_file: invalid_use_of_protected_member

part of '../../company.dart';

class CustomizeFieldSource extends GetxController {
  final _type = Get.put(TypeService());
  var id = 0.obs;

  var visible = false.obs;
  var newprospect = true.obs;
  var isselectbox = false.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = true.obs;

  var config = ''.obs;

  var optid = [].obs;
  var optname = [].obs;

  var isEdit = false.obs;
  var isForm = false.obs;
  final presenter = Get.find<CustomFieldPresenter>();
  final datatable = CustomFieldDataTableSource();
  final _navigation = Get.find<NavigationPresenter>();
  final source = CustomFieldSource().obs;

  reset() {
    id.value = 0;
    visible.value = false;
    newprospect.value = true;
    isselectbox.value = false;

    createdby.value = '';
    createddate.value = '';
    updatedby.value = '';
    updateddate.value = '';
    isactive.value = false;

    selectType.clear();
    selectprospect.clear();

    optid.clear();
    optname.clear();

    inputName.text = '';

    config.value = '';

    inputOptions.value = [TextEditingController()];

    isEdit.value = false;
  }

  BsSelectBoxController selectType = BsSelectBoxController();
  BsSelectBoxController selectprospect = BsSelectBoxController();

  TextEditingController inputName = TextEditingController();

  var inputOptions = List<TextEditingController>.filled(
          1, TextEditingController(),
          growable: true)
      .obs;

  List<Map<String, dynamic>> jsonOption() {
    return List<Map<String, dynamic>>.from(inputOptions.map((controller) {
      int index = inputOptions.indexOf(controller);
      return {'optvalue': inputOptions[index].text};
    }));
  }

  Future<Map<String, dynamic>> toJson() async {
    SessionModel session = await SessionManager.current();
    Response res = await _type.byCodeMaster(config.value);
    int id = TypeModel.fromJson(res.body.first).typeid ?? 0;
    return {
      'custfbpid': box.read('mybpid').toString(),
      'custftypeid': selectType.getSelectedAsString(),
      'custfname': inputName.text,
      'custfreftypeid': id,
      'alldata': newprospect.value,
      'onlythisdata': visible.value,
      'thisdataid': visible.value ? selectprospect.getSelectedAsString() : null,
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': isactive.value,
      'option': isselectbox.value ? jsonEncode(jsonOption()) : null
    };
  }

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  Widget selectTypes() {
    return FormGroup(
      label: Obx(() => Text(CustomFieldText.labelType,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
          searchable: false,
          controller: selectType,
          hintText: BaseText.hiintSelect(field: CustomFieldText.labelType),
          serverSide: (params) => selectApiCustomFieldTypes(params),
          validators: [
            Validators.selectRequired(CustomFieldText.labelType),
          ],
          onChange: (value) {
            if (value.getOtherValue()['typename'] == 'Selectbox')
              isselectbox.value = true;
            else
              isselectbox.value = false;
          }),
    );
  }

  Widget selectProspect() {
    return FormGroup(
      label: Obx(() => Text(CustomFieldText.labelBp,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        controller: selectprospect,
        hintText: BaseText.hiintSelect(field: CustomFieldText.labelBp),
        serverSide: (params) => selectApiProspect(params),
        validators: [
          Validators.selectRequired(CustomFieldText.labelBp),
        ],
      ),
    );
  }

  Widget selectActivity() {
    return FormGroup(
      label: Obx(() => Text('Activity',
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomSelectBox(
        controller: selectprospect,
        hintText: BaseText.hiintSelect(field: 'Activity'),
        serverSide: (params) => selectApiActivity(params),
        validators: [
          Validators.selectRequired('Activity'),
        ],
      ),
    );
  }

  Widget inputNames() {
    return FormGroup(
      label: Obx(() => Text(CustomFieldText.labelName,
          style: TextStyle(
              color:
                  _navigation.darkTheme.value ? Colors.white : Colors.black))),
      child: CustomInput(
        controller: inputName,
        hintText: BaseText.hiintSelect(field: CustomFieldText.labelName),
        validators: [
          Validators.inputRequired(CustomFieldText.labelName),
        ],
      ),
    );
  }

  Widget checkBoxForm(data) {
    return BsRow(
      children: [
        BsCol(
          margin: EdgeInsets.only(right: 10),
          sizes: ColScreen(lg: Col.col_2),
          child: FormGroup(
            label: Obx(() => Center(
                  child: Text('This $data Only',
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black)),
                )),
            child: Obx(() => Center(
                  child: Checkbox(
                    value: visible.value,
                    onChanged: (value) {
                      newprospect.value = !value!;

                      visible.value = value;
                    },
                  ),
                )),
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(right: 10),
          sizes: ColScreen(lg: Col.col_2),
          child: FormGroup(
            label: Obx(() => Center(
                  child: Text('All $data',
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black)),
                )),
            child: Obx(() => Center(
                  child: Checkbox(
                    value: newprospect.value,
                    onChanged: (value) {
                      visible.value = !value!;

                      newprospect.value = value;
                    },
                  ),
                )),
          ),
        ),
      ],
    );
  }

  Widget formDetail(context, {required Function onRemoveItem}) {
    return FormGroup(
      child: Obx(() => Column(
            children: inputOptions.value.map((controller) {
              int index = inputOptions.value.indexOf(controller);
              var inputOption = inputOptions.value[index];
              return BsRow(
                children: [
                  BsCol(
                    margin: EdgeInsets.only(right: 5),
                    sizes: ColScreen(lg: Col.col_11),
                    child: FormGroup(
                      child: CustomInput(
                        hintText:
                            BaseText.hintText(field: 'Option ${index + 1}'),
                        controller: inputOption,
                        validators: [
                          Validators.inputRequired('Option ${index + 1}')
                        ],
                      ),
                    ),
                  ),
                  BsCol(
                    sizes: ColScreen(sm: Col.col_1),
                    child: ButtonMultipleCancel(
                        disabled: inputOptions.length > 1 ? false : true,
                        margin: EdgeInsets.only(top: 10),
                        onPressed: () => onRemoveItem(context, index)),
                  )
                ],
              );
            }).toList(),
          )),
    );
  }
}
