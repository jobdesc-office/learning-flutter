part of '../datafield.dart';

class _TabProduct extends StatelessWidget {
  const _TabProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: CustomDatabales(
        source: datatable,
        columns: datatable.columns,
        searchable: false,
      ),
    );
  }
}
