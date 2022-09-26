part of '../home.dart';

BsCol stageChart(context) {
  return BsCol(
    margin: EdgeInsets.all(3),
    sizes: ColScreen(sm: Col.col_4),
    child: Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Obx(() => Column(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade300,
                  padding: EdgeInsets.fromLTRB(5, 20, 20, 20),
                  child: Text(
                    'Number of Open Opportunities and Average Days in Each Stage',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              if (source.stagename.isNotEmpty)
                ChartByStage(stage: source.stagename.value)
            ],
          )),
    ),
  );
}
