import 'package:flutter/material.dart';

import '../../../widgets/breadcrumb.dart';
import '../../skins/tempalte.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Profile',
        breadcrumbs: [
          BreadcrumbWidget('Profile', active: true),
        ],
        child: Container(
          child: Text('Profile'),
        ),
      ),
    );
  }
}
