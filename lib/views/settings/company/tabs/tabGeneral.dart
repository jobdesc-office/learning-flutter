part of '../company.dart';

class _TabGeneral extends StatelessWidget {
  const _TabGeneral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController inputName = TextEditingController();
    TextEditingController inputDomain = TextEditingController();
    return BsRow(
      margin: EdgeInsets.all(20),
      children: [
        BsCol(
          child: BsRow(
            children: [
              BsCol(
                sizes: ColScreen(sm: Col.col_4),
                child: Text('Company Name'),
              ),
              BsCol(
                sizes: ColScreen(sm: Col.col_7),
                child: CustomInput(controller: inputName),
              ),
            ],
          ),
        ),
        BsCol(
          child: BsRow(
            margin: EdgeInsets.only(top: 20),
            children: [
              BsCol(
                sizes: ColScreen(sm: Col.col_4),
                child: Text('Company Domain'),
              ),
              BsCol(
                sizes: ColScreen(sm: Col.col_7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInput(controller: inputDomain),
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      child: Text(
                        'The Company Domain name is Used for the Smart BCC Address and Your Account\'s Address on the Web App',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                    ThemeButtonSave(
                      margin: EdgeInsets.only(top: 20),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              BsCol(
                margin: EdgeInsets.only(top: 10),
                sizes: ColScreen(sm: Col.col_1),
                child: BsButton(
                  onPressed: () {},
                  prefixIcon: Icons.edit,
                  size: BsButtonSize.btnIconSm,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
