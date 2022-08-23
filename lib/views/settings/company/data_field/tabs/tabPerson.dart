part of '../datafield.dart';

class _TabPerson extends StatelessWidget {
  const _TabPerson({Key? key}) : super(key: key);

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
