// ignore_for_file: invalid_use_of_protected_member

part of '../home.dart';

BsCol top10(context) {
  return BsCol(
    margin: EdgeInsets.all(3),
    sizes: ColScreen(sm: Col.col_8),
    child: Obx(() => Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _navigation.darkTheme.value
                ? ColorPallates.elseDarkColor
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: _navigation.darkTheme.value
                      ? ColorPallates.contentDarkColor
                      : Colors.grey.shade300,
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      source.orderasc.value
                          ? 'Top 10 Adversity | By Expected Amount'
                          : 'Top 10 Opportunities | By Expected Amount',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                        onTap: () {
                          indexColor = 0;
                          source.orderasc.toggle();
                          presenter.byCust(
                            params: {
                              'prospectyy': selectYear.getSelectedAsString(),
                              'prospectmm': selectMonth.getSelectedAsString()
                            },
                            order: source.orderasc.value ? 'asc' : 'desc',
                          );
                        },
                        child: source.orderasc.value
                            ? Column(
                                children: [
                                  Icon(Icons.keyboard_arrow_up),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.grey.shade500,
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  Icon(Icons.keyboard_arrow_up,
                                      color: Colors.grey.shade500),
                                  Icon(Icons.keyboard_arrow_down)
                                ],
                              ))
                  ],
                ),
              ),
              if (source.bycust.value.isNotEmpty)
                Column(
                  children: source.bycust.value.map((e) {
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
                          padding: EdgeInsets.all(3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(e.prospectcustname ?? ''),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(5),
                                width: MediaQuery.of(context).size.width * 0.15,
                                color: color,
                                child: Text(
                                  'Rp ' +
                                      currencyFormatter
                                          .format(double.parse(parseString(
                                              e.prospectvalue ?? 0)))
                                          .replaceAll(',00', '')
                                          .replaceAll('.', ','),
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider()
                      ],
                    );
                  }).toList(),
                )
              else
                Container(),
            ],
          ),
        )),
  );
}
