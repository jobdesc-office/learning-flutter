part of '../../prospect_detail.dart';

class _TabAssign extends StatelessWidget {
  const _TabAssign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assignPresenter = Get.find<ProspectAssignPresenter>();
    if (source.assign.length != 0)
      return SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 15, bottom: 10),
                  // child: Text(
                  //   'This Prospect is Assigned to : ',
                  //   style: TextStyle(fontSize: 18),
                  // ),
                ),
                BsButton(
                  style: BsButtonStyle.success,
                  onPressed: () {
                    assignPresenter.add(context, source.prospectid.value);
                  },
                  prefixIcon: Icons.assignment,
                  label: Text('Add Assignation'),
                ),
              ],
            ),
            Obx(() => Column(
                  children: source.assign.map((element) {
                    if (element.prospectreportss?.userfullname ==
                        source.report.value) {
                      return Container();
                    } else {
                      source.report.value =
                          element.prospectreportss?.userfullname ?? '';
                      return Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Color.fromARGB(255, 207, 202, 202),
                        )),
                        margin: EdgeInsets.only(top: 5),
                        child: ExpansionTile(
                            expandedAlignment: Alignment.centerLeft,
                            title: Row(
                              children: [
                                Text(element.prospectreportss?.userfullname ??
                                    ''),
                                Card(
                                  color: Colors.green,
                                  margin: EdgeInsets.only(left: 20),
                                  child: Text('Report to'),
                                )
                              ],
                            ),
                            children: source.assign
                                .where((p0) =>
                                    p0.prospectreportto ==
                                    element.prospectreportto)
                                .toList()
                                .map((e) => Row(
                                      children: [
                                        Text(e.prospectassignss?.userfullname ??
                                            ''),
                                        Card(
                                          color: Colors.green,
                                          margin: EdgeInsets.only(left: 20),
                                          child: Text('Assign to'),
                                        )
                                      ],
                                    ))
                                .toList()),
                      );
                    }
                  }).toList(),
                ))
          ],
        ),
      );
    else
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('This Prospect is not Assigned'),
          BsButton(
            margin: EdgeInsets.only(top: 10),
            style: BsButtonStyle.success,
            onPressed: () {
              assignPresenter.add(context, source.prospectid.value);
            },
            prefixIcon: Icons.assignment,
            label: Text('Add Assignation'),
          ),
        ],
      );
  }
}
