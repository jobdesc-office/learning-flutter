part of 'home.dart';

class _filter extends StatelessWidget {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController inputYear = TextEditingController();
  BsSelectBoxController selectMonth = BsSelectBoxController(options: [
    BsSelectBoxOption(value: 1, text: Text('January')),
    BsSelectBoxOption(value: 2, text: Text('February')),
    BsSelectBoxOption(value: 3, text: Text('March')),
    BsSelectBoxOption(value: 4, text: Text('April')),
    BsSelectBoxOption(value: 5, text: Text('May')),
    BsSelectBoxOption(value: 6, text: Text('June')),
    BsSelectBoxOption(value: 7, text: Text('July')),
    BsSelectBoxOption(value: 8, text: Text('August')),
    BsSelectBoxOption(value: 9, text: Text('September')),
    BsSelectBoxOption(value: 10, text: Text('October')),
    BsSelectBoxOption(value: 11, text: Text('November')),
    BsSelectBoxOption(value: 12, text: Text('December')),
  ]);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.sm,
          child: BsModalContent(children: [
            BsModalContainer(
              title: Text('Filter'),
              closeButton: true,
            ),
            BsModalContainer(
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormGroup(
                      child: CustomInputNumber(
                        controller: inputYear,
                        hintText: 'Year',
                      ),
                    ),
                    FormGroup(
                      child: Container(
                          margin: EdgeInsets.only(top: 5),
                          child: CustomSelectBox(
                            hintText: BaseText.hiintSelect(field: 'Month'),
                            controller: selectMonth,
                          )),
                    ),
                  ],
                );
              }),
            ),
            BsModalContainer(
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ThemeButtonSearch(
                      margin: EdgeInsets.only(right: 5),
                      onPressed: () => onClickSaveModal(context),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  void onClickSaveModal(BuildContext context) {
    Navigator.pop(context);
    presenter.byCust(params: {
      'prospectyy': inputYear.text,
      'prospectmm': selectMonth.getSelectedAsString()
    });
  }
}
