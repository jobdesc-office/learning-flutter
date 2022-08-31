part of '../company.dart';

class _TabCurrencies extends StatelessWidget {
  const _TabCurrencies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final datatable = CompanyCurrencyDataTableSource();
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Here You Add Custom Currency to Your Company. Custom Currency Will Get Excluded from Currency-Converted totals.'),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.toggle_off),
                  Row(
                    children: [
                      BsButton(
                        size: BsButtonSize.btnSm,
                        onPressed: () {},
                        style: BsButtonStyle.success,
                        label: Text('Add Custom Currency'),
                      ),
                      BsButton(
                        margin: EdgeInsets.only(left: 5),
                        size: BsButtonSize.btnSm,
                        onPressed: () {},
                        style: BsButtonStyle.secondary,
                        label: Text('Deactive All Unused Currency'),
                      )
                    ],
                  ),
                ],
              )),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: CustomDatabales(
              source: datatable,
              columns: datatable.columns,
              searchable: false,
            ),
          )
        ],
      ),
    );
  }
}
