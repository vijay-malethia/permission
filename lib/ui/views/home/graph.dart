import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '/ui/common/index.dart';
import '/ui/views/home/home_viewmodel.dart';

class Graph extends StatelessWidget {
  final HomeViewModel viewModel;

  const Graph({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    var lineGraphData = dashBoardData['data']['line_graph_for_past_days_leads'];
    return Container(
        height: 190,
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(leadsTrend,
                    style: AppTextStyle()
                        .inputLabelTextStyle(fontColor: FontColor().grey)),
              ),
              const Spacer(),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(leadsStatic,
                    style: AppTextStyle().toastMessageTextStyle(
                        fontColor: FontColor().darkgrey)),
                Text('Last ${lineGraphData['past_days_for_lead_display']} Days',
                    style: AppTextStyle()
                        .textButtonTextStyle(textColor: FontColor().red))
              ])
            ]),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                height: 140,
                child: SfCartesianChart(
                    trackballBehavior: TrackballBehavior(
                        enable: true,
                        lineWidth: 2,
                        lineDashArray: const [5, 5]),
                    enableAxisAnimation: true,
                    plotAreaBorderColor: transparent,
                    margin: EdgeInsets.zero,
                    primaryYAxis: NumericAxis(
                        majorGridLines: MajorGridLines(
                            color: lightBgColor2,
                            width: screenDimension(context) * 0.001,
                            dashArray: const [3, 3]),
                        edgeLabelPlacement: EdgeLabelPlacement.hide,
                        axisLine: const AxisLine(color: transparent),
                        maximum: viewModel.maxValue <= 2
                            ? 8.0
                            : (viewModel.interval / 2) * 4.toDouble(),
                        interval: viewModel.interval <= 2
                            ? 2.0
                            : (viewModel.interval / 2).toDouble(),
                        labelStyle: AppTextStyle()
                            .smallLarge(fontColor: graphYAxisLabel),
                        majorTickLines:
                            const MajorTickLines(color: transparent),
                        minorTickLines:
                            const MinorTickLines(color: transparent)),
                    primaryXAxis: CategoryAxis(
                        interval: 1,
                        axisLine: const AxisLine(color: lightGrey2, width: 1),
                        labelsExtent: double.infinity,
                        labelStyle: AppTextStyle().textButtonTextStyle(
                            textColor: FontColor().lightGrey),
                        majorGridLines:
                            const MajorGridLines(color: transparent),
                        minorGridLines:
                            const MinorGridLines(color: transparent),
                        labelPlacement: LabelPlacement.onTicks,
                        majorTickLines:
                            const MajorTickLines(color: transparent),
                        minorTickLines: const MinorTickLines(color: transparent)),
                    annotations: <CartesianChartAnnotation>[
                      if (highestLeadPointOnYAxis > 0)
                        CartesianChartAnnotation(
                            widget: Container(
                                height: screenDimension(context) / 128,
                                width: screenDimension(context) / 128,
                                decoration: const BoxDecoration(
                                    color: darkRed, shape: BoxShape.circle)),
                            coordinateUnit: CoordinateUnit.point,
                            x: highestLeadPointOnXAxis,
                            y: viewModel.maxValue),
                      CartesianChartAnnotation(
                        widget: Container(
                          height: screenDimension(context) / 144,
                          width: screenDimension(context) / 144,
                          decoration: const BoxDecoration(
                            color: lightBgColor2,
                            shape: BoxShape.circle,
                          ),
                        ),
                        coordinateUnit: CoordinateUnit.point,
                        x: '8.86',
                        y: 6,
                      ),
                      CartesianChartAnnotation(
                        widget: Container(
                          height: screenDimension(context) / 144,
                          width: screenDimension(context) / 144,
                          decoration: const BoxDecoration(
                            color: lightBgColor2,
                            shape: BoxShape.circle,
                          ),
                        ),
                        coordinateUnit: CoordinateUnit.point,
                        x: '8.86',
                        y: 4,
                      ),
                      CartesianChartAnnotation(
                        widget: Container(
                          height: screenDimension(context) / 144,
                          width: screenDimension(context) / 144,
                          decoration: const BoxDecoration(
                            color: lightBgColor2,
                            shape: BoxShape.circle,
                          ),
                        ),
                        coordinateUnit: CoordinateUnit.point,
                        x: '8.86',
                        y: 2,
                      ),
                      CartesianChartAnnotation(
                          verticalAlignment: ChartAlignment.center,
                          widget: Container(
                              height: viewModel.maxValue <= 2
                                  ? (viewModel.maxValue * 15).toDouble()
                                  : 90 /
                                      viewModel.maxValue *
                                      viewModel.maxValue /
                                      1.6,
                              width: 1,
                              color: waveColor),
                          coordinateUnit: CoordinateUnit.point,
                          x: highestLeadPointOnXAxis,
                          y: viewModel.maxValue / 2)
                    ],
                    series: [
                      SplineSeries(
                          onPointTap: (pointInteractionDetails) {},
                          animationDuration: 4,
                          width: screenDimension(context) * 0.001,
                          color: warmTextColor4,
                          dataSource: List.generate(
                              lineGraphData['leads_count_for_past_days'].length,
                              (index) => SalesData(
                                  lineGraphData['leads_count_for_past_days']
                                          [index]['date']
                                      .toString()
                                      .split('-')
                                      .last,
                                  double.parse(
                                      '${lineGraphData['leads_count_for_past_days'][index]['leads_count']}'))),
                          xValueMapper: (SalesData sales, _) => sales.year,
                          yValueMapper: (SalesData sales, _) => sales.sales)
                    ])),
          ],
        ));
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final Widget x;
  final double y;
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
