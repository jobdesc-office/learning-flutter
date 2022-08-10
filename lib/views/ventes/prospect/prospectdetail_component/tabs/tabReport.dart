part of '../../prospect_detail.dart';

class _tabReport extends StatelessWidget {
  const _tabReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (source.assign.length != 0)
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 15, bottom: 10),
              child: Text(
                'This Prospect is Reported to : ',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Obx(() => Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: source.report.length,
                    itemBuilder: (context, index) {
                      var reports = source.report[index];
                      return BsRow(
                        margin: source.report[index] == 0
                            ? EdgeInsets.zero
                            : EdgeInsets.only(top: 20),
                        children: [
                          BsCol(
                            sizes: ColScreen(sm: Col.col_1),
                            child: Text('${index + 1} )'),
                          ),
                          BsCol(
                            sizes: ColScreen(sm: Col.col_11),
                            child: BsRow(
                              children: [
                                BsCol(
                                  sizes: ColScreen(sm: Col.col_2),
                                  child: Text("Name"),
                                ),
                                BsCol(
                                  sizes: ColScreen(sm: Col.col_1),
                                  child: Text(':'),
                                ),
                                BsCol(
                                  sizes: ColScreen(sm: Col.col_9),
                                  child: Text(
                                      reports.prospectreportss.userfullname),
                                ),
                                BsCol(
                                  margin: EdgeInsets.only(top: 5),
                                  sizes: ColScreen(sm: Col.col_2),
                                  child: Text("Email"),
                                ),
                                BsCol(
                                  margin: EdgeInsets.only(top: 5),
                                  sizes: ColScreen(sm: Col.col_1),
                                  child: Text(':'),
                                ),
                                BsCol(
                                  margin: EdgeInsets.only(top: 5),
                                  sizes: ColScreen(sm: Col.col_9),
                                  child:
                                      Text(reports.prospectreportss.useremail),
                                ),
                                BsCol(
                                  margin: EdgeInsets.only(top: 5),
                                  sizes: ColScreen(sm: Col.col_2),
                                  child: Text("Phone"),
                                ),
                                BsCol(
                                  margin: EdgeInsets.only(top: 5),
                                  sizes: ColScreen(sm: Col.col_1),
                                  child: Text(':'),
                                ),
                                BsCol(
                                  margin: EdgeInsets.only(top: 5),
                                  sizes: ColScreen(sm: Col.col_9),
                                  child:
                                      Text(reports.prospectreportss.userphone),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ))
          ],
        ),
      );
    else
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('This Reported Prospect Has Not Been Defined')],
      );
  }
}
