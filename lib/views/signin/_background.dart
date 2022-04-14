import 'package:Ventes/styles/color_palattes.dart';
import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackgroundAuth extends GetView {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: BsRow(
        margin: EdgeInsets.only(top: 15, bottom: 20),
        children: [
          BsCol(
            margin: EdgeInsets.only(bottom: 20),
            sizes: ColScreen(lg: Col.col_2),
            child:
                Image.asset('assets/images/logo.png', width: 125, height: 64.5),
          ),
          BsCol(
            sizes: ColScreen(lg: Col.col_4),
          ),
          BsCol(
            margin: EdgeInsets.only(bottom: 20),
            sizes: ColScreen(lg: Col.col_6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('data',
                    style: TextStyle(fontSize: 24, color: ColorPallates.dark)),
                Text('data',
                    style: TextStyle(fontSize: 24, color: ColorPallates.dark)),
                Text('data',
                    style: TextStyle(fontSize: 24, color: ColorPallates.dark)),
                Text('data',
                    style: TextStyle(fontSize: 24, color: ColorPallates.dark))
              ],
            ),
          ),
          BsCol(
            sizes: ColScreen(lg: Col.col_4),
          ),
          BsCol(
            sizes: ColScreen(lg: Col.col_2),
          ),
          BsCol(
            alignment: Alignment.centerLeft,
            sizes: ColScreen(lg: Col.col_5),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Image.asset('assets/images/bg_auth.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
