part of '../company.dart';

final _navigation = Get.find<NavigationPresenter>();

class _TabGeneral extends StatelessWidget {
  final source = GeneralSource().obs;

  @override
  Widget build(BuildContext context) {
    return BsRow(
      margin: EdgeInsets.all(20),
      children: [
        BsCol(
          child: BsRow(
            children: [
              BsCol(
                sizes: ColScreen(sm: Col.col_4),
                child: Text('Name'),
              ),
              BsCol(
                sizes: ColScreen(sm: Col.col_7),
                child: CustomInput(controller: source.value.inputName),
              ),
            ],
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(top: 20),
          child: BsRow(
            children: [
              BsCol(
                sizes: ColScreen(sm: Col.col_4),
                child: Text('PIC'),
              ),
              BsCol(
                sizes: ColScreen(sm: Col.col_7),
                child: CustomInput(controller: source.value.inputPIC),
              ),
            ],
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(top: 20),
          child: BsRow(
            children: [
              BsCol(
                sizes: ColScreen(sm: Col.col_4),
                child: Text('Phone'),
              ),
              BsCol(
                sizes: ColScreen(sm: Col.col_7),
                child: CustomInput(controller: source.value.inputPhone),
              ),
            ],
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(top: 20),
          child: BsRow(
            children: [
              BsCol(
                sizes: ColScreen(sm: Col.col_4),
                child: Text('Email'),
              ),
              BsCol(
                sizes: ColScreen(sm: Col.col_7),
                child: CustomInput(controller: source.value.inputEmail),
              ),
            ],
          ),
        ),
        BsCol(
          margin: EdgeInsets.only(top: 20),
          child: BsRow(
            children: [
              BsCol(
                sizes: ColScreen(sm: Col.col_4),
                child: Text('Type'),
              ),
              BsCol(
                sizes: ColScreen(sm: Col.col_7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    selectSubdistrict(),
                    BsCol(
                      margin: EdgeInsets.only(top: 10),
                      sizes: ColScreen(sm: Col.col_1),
                      child: BsButton(
                        label: Text("Save Change"),
                        onPressed: () {},
                        prefixIcon: Icons.edit,
                        size: BsButtonSize.btnIconSm,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget selectSubdistrict() {
    return FormGroup(
      child: CustomSelectBox(
        searchable: true,
        disabled: source.value.isProcessing,
        controller: source.value.choosedSubdistrict,
        hintText: BaseText.hiintSelect(field: "Type"),
        serverSide: (params) => selectApiBpType(params),
        validators: [
          Validators.selectRequired("Type"),
        ],
      ),
    );
  }
}
