import 'package:bs_flutter_responsive/bs_flutter_responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScheduleView extends GetView {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: BsRow(
        children: [
          BsCol(
            margin: EdgeInsets.all(10),
            sizes: ColScreen(sm: Col.col_12),
            child: Text(
              'Your Schedules',
              style: TextStyle(fontSize: 22),
            ),
          ),
          BsCol(
            sizes: ColScreen(sm: Col.col_12),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey.shade300)),
              child: Container(
                margin: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.pink.shade200,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey.shade300)),
                      child: Container(
                          margin: EdgeInsets.all(10),
                          child: BsRow(
                            children: [
                              BsCol(
                                sizes: ColScreen(sm: Col.col_10),
                                child: Text('Bakar Ayam'),
                              ),
                              BsCol(
                                sizes: ColScreen(sm: Col.col_2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('15 May 2022'),
                                    Text('10:00:00')
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey.shade300)),
                      child: Container(
                          margin: EdgeInsets.all(10),
                          child: BsRow(
                            children: [
                              BsCol(
                                sizes: ColScreen(sm: Col.col_10),
                                child: Text('Bakar Baso'),
                              ),
                              BsCol(
                                sizes: ColScreen(sm: Col.col_2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('15 May 2022'),
                                    Text('10:00:00')
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Colors.indigo.shade200,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey.shade300)),
                      child: Container(
                          margin: EdgeInsets.all(10),
                          child: BsRow(
                            children: [
                              BsCol(
                                sizes: ColScreen(sm: Col.col_10),
                                child: Text('Bakar Berhala'),
                              ),
                              BsCol(
                                sizes: ColScreen(sm: Col.col_2),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('15 May 2022'),
                                    Text('10:00:00')
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
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
