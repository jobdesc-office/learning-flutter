import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileProfileView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: BsRow(
        children: [
          BsCol(
            sizes: ColScreen(sm: Col.col_3),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.shade300)),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/photos/novan.jpg'),
                      radius: 100,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Text(
                            'Novan Andre Andriansyah Putra',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text('a.k.a', style: TextStyle(fontSize: 14)),
                          Text(
                            'Novan',
                            style: TextStyle(fontSize: 21),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          BsCol(
            margin: EdgeInsets.only(left: 10),
            sizes: ColScreen(sm: Col.col_9),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.shade300)),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: BsRow(
                        children: [
                          BsCol(
                            sizes: ColScreen(sm: Col.col_2),
                            child: Column(
                              children: [
                                Row(
                                  children: [Text('data')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text('data')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text('data')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text('data')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text('data')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text('data')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text('data')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text('data')],
                                ),
                              ],
                            ),
                          ),
                          BsCol(
                            sizes: ColScreen(sm: Col.col_1),
                            child: Column(
                              children: [
                                Row(
                                  children: [Text(':')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text(':')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text(':')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text(':')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text(':')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text(':')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text(':')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text(':')],
                                )
                              ],
                            ),
                          ),
                          BsCol(
                            sizes: ColScreen(sm: Col.col_9),
                            child: Column(
                              children: [
                                Row(
                                  children: [Text('data')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text('data')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text('data')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text('data')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text('data')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text('data')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text('data')],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [Text('data')],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
