// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../routes/route_list.dart';
// import '../../../widgets/breadcrumb.dart';
// import '../../../widgets/datatables/custom_datatable.dart';
// import '../../skins/template.dart';

// class CustomerView extends GetView{
//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       body: TemplateView(
//         title: 'Menus',
//         breadcrumbs: [
//           BreadcrumbWidget('Dashboard', route: RouteList.home.index),
//           BreadcrumbWidget('Masters'),
//           BreadcrumbWidget('Customers', active: true),
//         ],
//         activeRoutes: [RouteList.master.index, RouteList.masterCustomer.index],
//         child: Container(
//           child: Column(
//             children: [
//               CustomDatabales(
//                 source: datatable,
//                 columns: datatable.columns,
//                 headerActions: [
//                   ThemeButtonCreate(
//                     prefix: MenuText.title,
//                     onPressed: () => presenter.add(context),
//                   )
//                 ],
//                 serverSide: (params) => presenter.datatables(context, params),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

// }