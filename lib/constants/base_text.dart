class BaseText {
  static String buttonSave = 'Save';
  static String buttonCancel = 'Cancel';
  static String buttonCreate = 'Create';
  static String buttonFilter = 'Filter';
  static String buttonLost = 'Mark as Lost';

  static String defaultLabelName = 'Name';

  static String processing = 'Processing ...';

  static String yesConfirm = 'Yes';
  static String noConfirm = 'No';

  static String active = 'Active';
  static String nonactive = 'Non Active';

  static String editDelete = 'Long Press to Edit or Delete';

  static String hintText({String? field}) {
    return 'Type $field here...';
  }

  static String hiintSelect({String? field}) {
    return 'Choose $field here...';
  }

  static String confirmTitle = 'Confirmation';

  static String detailHintDatatable({String? field}) {
    return 'Detail of $field';
  }

  static String editHintDatatable({String? field}) {
    return 'Edit $field';
  }

  static String deleteHintDatatable({String? field}) {
    return 'Delete $field';
  }

  static String deleteConfirmDatatable({String? field}) {
    return 'Are you sure you want to delete $field ?';
  }
}
