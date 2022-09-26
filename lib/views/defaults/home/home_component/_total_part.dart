part of '../home.dart';

class TotalPart extends StatelessWidget {
  const TotalPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BsRow(children: [
      BsCol(
          margin: EdgeInsets.all(3),
          sizes: ColScreen(sm: Col.col_4),
          child: InkWell(
            onTap: () => presenter.detailcust(context),
            child: Container(
                padding: EdgeInsets.all(10),
                width: 200,
                // child: LeadsUsersChart(),
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Prospect Value',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        if (source.prospecttotal.value != '')
                          Center(
                            child: Text(
                                'Rp ' +
                                    currencyFormatter
                                        .format(double.parse(
                                            source.prospecttotal.value))
                                        .replaceAll(',00', '')
                                        .replaceAll('.', ','),
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                      ],
                    )),
                color: Colors.white),
          )),
      BsCol(
          margin: EdgeInsets.all(3),
          sizes: ColScreen(sm: Col.col_4),
          child: InkWell(
            onTap: () => presenter.detailstatus(context, 'Won'),
            child: Container(
                padding: EdgeInsets.all(10),
                width: 200,
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Prospect Won',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        if (source.prospectwontotal.value != '')
                          Center(
                            child: Text(
                                'Rp ' +
                                    currencyFormatter
                                        .format(double.parse(
                                            source.prospectwontotal.value))
                                        .replaceAll(',00', '')
                                        .replaceAll('.', ','),
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                      ],
                    )),
                color: Colors.white),
          )),
      BsCol(
          margin: EdgeInsets.all(3),
          sizes: ColScreen(sm: Col.col_4),
          child: InkWell(
            onTap: () => presenter.detailstatus(context, 'Lost'),
            child: Container(
                padding: EdgeInsets.all(10),
                width: 200,
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Prospect Lost',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        if (source.prospectlosttotal.value != '')
                          Center(
                            child: Text(
                                'Rp ' +
                                    currencyFormatter
                                        .format(double.parse(
                                            source.prospectlosttotal.value))
                                        .replaceAll(',00', '')
                                        .replaceAll('.', ','),
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                      ],
                    )),
                color: Colors.white),
          )),
    ]);
  }
}
