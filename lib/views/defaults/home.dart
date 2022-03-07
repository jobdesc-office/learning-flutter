import 'package:boilerplate/views/skins/tempalte.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TemplateView(
        title: 'Dashboard',
        child: Container(color: Colors.black),
      ),
    );
  }
}
