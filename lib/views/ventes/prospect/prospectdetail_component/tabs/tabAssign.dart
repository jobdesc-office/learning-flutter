part of '../../prospect_detail.dart';

class _tabAssign extends StatelessWidget {
  const _tabAssign({Key? key}) : super(key: key);

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
                  child: Text(
                    'This Prospect is Assigned to : ',
                    style: TextStyle(fontSize: 18),
                  ),
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
            Obx(() => Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: source.assign.length,
                    itemBuilder: (context, index) {
                      var assigns = source.assign[index];
                      return Tooltip(
                        message: BaseText.editDelete,
                        child: InkWell(
                          onLongPress: (() {
                            Get.defaultDialog(
                                middleText: '',
                                title: 'Setting',
                                actions: [
                                  ButtonEditDatatables(onPressed: () {
                                    assignPresenter.edit(
                                        context,
                                        assigns.prospectassignid,
                                        source.prospectid.value);
                                  }),
                                  ButtonDeleteDatatables(onPressed: () {
                                    assignPresenter.delete(
                                        context,
                                        assigns.prospectassignid,
                                        'Assignment for ${assigns.prospectassignss.userfullname}');
                                  }),
                                ]);
                          }),
                          onTap: () {
                            assignPresenter.detail(
                                context, assigns.prospectassignid);
                          },
                          child: BsRow(
                            margin: source.assign[index] == 0
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
                                      child: Text(assigns
                                          .prospectassignss.userfullname),
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
                                      child: Text(
                                          assigns.prospectassignss.useremail),
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
                                      child: Text(
                                          assigns.prospectassignss.userphone),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
