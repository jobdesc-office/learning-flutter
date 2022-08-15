// import 'package:bs_flutter_datatable/bs_flutter_datatable.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../constants/base_text.dart';
// import '../../../presenters/navigation_presenter.dart';
// import '../../../styles/color_palattes.dart';
// import '../../../widgets/button/button_delete_datatable.dart';
// import '../../../widgets/button/button_edit_datatable.dart';
// import '../../../widgets/datatables/custom_datatable_tablecell.dart';
// import '../../../widgets/datatables/custom_datatable_tablehead.dart';

// final _navigation = Get.find<NavigationPresenter>();

// class PermissionDataTableSource extends BsDatatableSource {
//   ValueChanged<int> onEditListener = (value) {};
//   Function onDeleteListener = (value, name) {};

//   PermissionDataTableSource({
//     List data = const [],
//   }) : super(data: data);

//   List<BsDataColumn> get columns {
//     return <BsDataColumn>[
//       CustomBsDataColumn(
//         label: Text('No'),
//         width: 100,
//         searchable: false,
//         orderable: false,
//       ),
//       CustomBsDataColumn(
//           label: Text('Permission Name'), columnName: 'Permissionname'),
//       CustomBsDataColumn(
//         label: Text('Permission Subdistrict'),
//         columnName: 'Permissionnm',
//         searchable: false,
//         orderable: false,
//       ),
//       CustomBsDataColumn(
//           label: Text('Actions'),
//           width: 100,
//           orderable: false,
//           searchable: false),
//     ];
//   }

//   List<PermissionModel> get Permissions =>
//       response.data.map((data) => PermissionModel.fromJson(data)).toList();

//   @override
//   BsDataRow getRow(int index) {
//     final row = Permissions[index];
//     int x = controller.start + index + 1;
//     return BsDataRow(
//       index: index,
//       cells: [
//         CustomBsDataCell(
//           Text('$x'),
//           color: _navigation.darkTheme.value
//               ? x % 2 == 0
//                   ? ColorPallates.datatableDarkEvenRowColor
//                   : ColorPallates.datatableDarkOddRowColor
//               : x % 2 == 0
//                   ? ColorPallates.datatableLightEvenRowColor
//                   : ColorPallates.datatableLightOddRowColor,
//         ),
//         CustomBsDataCell(
//           Text(row.Permissionname),
//           color: _navigation.darkTheme.value
//               ? x % 2 == 0
//                   ? ColorPallates.datatableDarkEvenRowColor
//                   : ColorPallates.datatableDarkOddRowColor
//               : x % 2 == 0
//                   ? ColorPallates.datatableLightEvenRowColor
//                   : ColorPallates.datatableLightOddRowColor,
//         ),
//         CustomBsDataCell(
//           Text(row.subdistrictname),
//           color: _navigation.darkTheme.value
//               ? x % 2 == 0
//                   ? ColorPallates.datatableDarkEvenRowColor
//                   : ColorPallates.datatableDarkOddRowColor
//               : x % 2 == 0
//                   ? ColorPallates.datatableLightEvenRowColor
//                   : ColorPallates.datatableLightOddRowColor,
//         ),
//         CustomBsDataCell(
//           Row(
//             children: [
//               Tooltip(
//                 message: BaseText.editHintDatatable(field: row.Permissionname),
//                 child: ButtonEditDatatables(
//                   margin: EdgeInsets.only(right: 5),
//                   onPressed: () => onEditListener(row.Permissionid),
//                 ),
//               ),
//               Tooltip(
//                 message:
//                     BaseText.deleteHintDatatable(field: row.Permissionname),
//                 child: ButtonDeleteDatatables(
//                     onPressed: () =>
//                         onDeleteListener(row.Permissionid, row.Permissionname)),
//               ),
//             ],
//           ),
//           color: _navigation.darkTheme.value
//               ? x % 2 == 0
//                   ? ColorPallates.datatableDarkEvenRowColor
//                   : ColorPallates.datatableDarkOddRowColor
//               : x % 2 == 0
//                   ? ColorPallates.datatableLightEvenRowColor
//                   : ColorPallates.datatableLightOddRowColor,
//           padding: EdgeInsets.all(9),
//         ),
//       ],
//     );
//   }
// }
