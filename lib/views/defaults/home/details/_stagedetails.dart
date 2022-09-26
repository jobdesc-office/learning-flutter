part of '../home.dart';

class StageDetails extends StatelessWidget {
  String stage;
  StageDetails(this.stage);

  @override
  Widget build(BuildContext context) {
    List<DspbystageModel> list = source.bystage.value
        .where((element) => element.prospectstage == stage)
        .toList();
    return BsModal(
        context: context,
        dialog: BsModalDialog(
          size: BsModalSize.lg,
          child: BsModalContent(
              decoration: BoxDecoration(
                color: _navigation.darkTheme.value
                    ? ColorPallates.elseDarkColor
                    : Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              children: [
                BsModalContainer(
                  title: Text('Prospects $stage Details',
                      style: TextStyle(
                          color: _navigation.darkTheme.value
                              ? Colors.white
                              : Colors.black)),
                  closeButton: true,
                ),
                BsModalContainer(
                  child: Column(
                    children: list.map((e) {
                      newvalue = e.prospectvalue.toString();
                      if (newvalue == oldvalue) {
                        indexColor = indexColor;
                        oldvalue = e.prospectvalue.toString();
                      } else {
                        indexColor++;
                        oldvalue = e.prospectvalue.toString();
                      }
                      Color color = Colors.transparent;
                      switch (indexColor) {
                        case 0:
                          color = ColorPallates.mobileprimary;
                          break;
                        case 1:
                          color = ColorPallates.mobilesecondary;
                          break;
                        case 2:
                          color = ColorPallates.green;
                          break;
                        case 3:
                          color = ColorPallates.red;
                          break;
                        case 4:
                          color = ColorPallates.indigo;
                          break;
                        case 5:
                          color = ColorPallates.purple;
                          break;
                        case 6:
                          color = ColorPallates.yellow;
                          break;
                        case 7:
                          color = ColorPallates.cyan;
                          break;
                        case 8:
                          color = ColorPallates.pink;
                          break;
                        case 9:
                          color = ColorPallates.cancel;
                          break;
                        default:
                          color = ColorPallates.mobileprimary;
                          indexColor = 0;
                      }
                      return Column(
                        children: [
                          Divider(),
                          Container(
                            margin: EdgeInsets.all(3),
                            padding: EdgeInsets.all(5),
                            child: BsRow(
                              children: [
                                BsCol(
                                    sizes: ColScreen(sm: Col.col_9),
                                    child: Text(e.prospectstage ?? '')),
                                BsCol(
                                  sizes: ColScreen(sm: Col.col_3),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(3),
                                    color: color,
                                    child: Text(
                                        'Rp ' +
                                            currencyFormatter
                                                .format(double.parse(
                                                    e.prospectvalue.toString()))
                                                .replaceAll(',00', '')
                                                .replaceAll('.', ','),
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(),
                        ],
                      );
                    }).toList(),
                  ),
                )
              ]),
        ));
  }
}
