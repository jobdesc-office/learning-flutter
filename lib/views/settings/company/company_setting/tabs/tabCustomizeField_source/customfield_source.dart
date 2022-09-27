part of '../../company.dart';

class CustomizeFieldSource extends GetxController {
  final _type = Get.put(TypeService());
  var id = 0.obs;

  var visible = false.obs;
  var newprospect = false.obs;

  var createdby = ''.obs;
  var createddate = ''.obs;
  var updatedby = ''.obs;
  var updateddate = ''.obs;
  var isactive = true.obs;

  var config = ''.obs;

  reset() {
    id.value = 0;
    visible.value = false;
    newprospect.value = false;

    createdby.value = '';
    createddate.value = '';
    updatedby.value = '';
    updateddate.value = '';
    isactive.value = false;

    selectType.clear();
    selectprospect.clear();

    inputName.text = '';

    config.value = '';
  }

  BsSelectBoxController selectType = BsSelectBoxController();
  BsSelectBoxController selectprospect = BsSelectBoxController();

  TextEditingController inputName = TextEditingController();

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
      'thisdataid': selectprospect.getSelectedAsString(),
      'createdby': session.userid,
      'updatedby': session.userid,
      'isactive': isactive.value,
    };
  }

  var isEdit = false.obs;
  var isForm = false.obs;
  final presenter = Get.find<CustomFieldPresenter>();
  final datatable = CustomFieldDataTableSource();
  final _navigation = Get.find<NavigationPresenter>();
  final source = CustomFieldSource().obs;

  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  void onClickSaveModal(BuildContext context) async {
    presenter.setProcessing(true);
    if (formState.currentState!.validate()) {
      if (isEdit.value) {
        presenter.update(context, await toJson(), id.value);
      } else {
        if (formState.currentState!.validate()) {
          presenter.save(context, await toJson());
        } else
          presenter.setProcessing(false);
      }
    } else
      presenter.setProcessing(false);
  }

  void onClickCancelModal(BuildContext context) {
    if (isEdit.value) {
      isEdit.value = false;
      isForm.toggle();
      reset();
    } else {
      isForm.toggle();
      reset();
    }
  }

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
      ),
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
}
