part of '../../prospect_detail.dart';

class _TabAssign extends StatelessWidget {
  const _TabAssign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    source.report.value = '';
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
                if (source.status.value != ProspectText.closedWon &&
                    source.status.value != ProspectText.closedLost &&
                    source.status.value != ProspectText.forceClosed)
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
            Column(
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
                            Text(element.prospectreportss?.userfullname ?? ''),
                            Card(
                              color: Colors.green,
                              margin: EdgeInsets.only(left: 20),
                              child: Text('Report to'),
                            )
                          ],
                        ),
                        children: source.assign
                            .where((p0) =>
                                p0.prospectreportto == element.prospectreportto)
                            .toList()
                            .map((e) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        e.prospectassignss?.userfullname ?? ''),
                                    Card(
                                      color: Colors.green,
                                      margin: EdgeInsets.only(left: 20),
                                      child: Text('Assign to'),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Tooltip(
                                          message: BaseText.detailHintDatatable(
                                              field:
                                                  'Assignment for ${e.prospectassignss?.userfullname}'),
                                          child: InkWell(
                                              onTap: () =>
                                                  assignPresenter.detail(
                                                      context,
                                                      e.prospectassignid!),
                                              child:
                                                  Icon(Icons.remove_red_eye)),
                                        ),
                                        if (source.status.value !=
                                                ProspectText.closedWon &&
                                            source.status.value !=
                                                ProspectText.closedLost &&
                                            source.status.value !=
                                                ProspectText.forceClosed)
                                          Tooltip(
                                            message: BaseText.editHintDatatable(
                                                field:
                                                    'Assignment for ${e.prospectassignss?.userfullname}'),
                                            child: InkWell(
                                                onTap: () =>
                                                    assignPresenter.edit(
                                                        context,
                                                        e.prospectassignid!,
                                                        source
                                                            .prospectid.value),
                                                child: Icon(Icons.edit)),
                                          ),
                                        if (source.status.value !=
                                                ProspectText.closedWon &&
                                            source.status.value !=
                                                ProspectText.closedLost &&
                                            source.status.value !=
                                                ProspectText.forceClosed)
                                          Tooltip(
                                            message: BaseText.deleteHintDatatable(
                                                field:
                                                    'Assignment for ${e.prospectassignss?.userfullname}'),
                                            child: InkWell(
                                                onTap: () => assignPresenter.delete(
                                                    context,
                                                    e.prospectassignid!,
                                                    'Assignment for ${e.prospectassignss?.userfullname}'),
                                                child: Icon(Icons.delete)),
                                          )
                                      ],
                                    )
                                  ],
                                ))
                            .toList()),
                  );
                }
              }).toList(),
            )
          ],
        ),
      );
    else
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('This Prospect is not Assigned'),
          if (source.status.value != ProspectText.closedWon &&
              source.status.value != ProspectText.closedLost &&
              source.status.value != ProspectText.forceClosed)
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
