import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '/ui/common/index.dart';

class ProjectPieChartPage extends StatelessWidget {
  final List<PichartData> project;

  const ProjectPieChartPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      piChartYellow,
      piChartPurple,
      piChartOrange,
      piChartBlue,
      piChartRed
    ];

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              width: 145,
              height: 145,
              padding: const EdgeInsets.only(right: 10),
              alignment: Alignment.centerLeft,
              child: PieChart(PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 0,
                  startDegreeOffset: 25,
                  sections: _generateSections(project, colors),
                  borderData: FlBorderData(show: false)))),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < project.length; i++) ...[
                  NameWidget(
                      name: project[i].name,
                      color: colors[i],
                      leadcont: project[i].leadCount),
                ],
              ])
        ],
      ),
    );
  }

  List<PieChartSectionData> _generateSections(List<PichartData> data, colors) {
    int totalLeadCount = 0;

    for (int i = 0; i < data.length; i++) {
      totalLeadCount += int.parse(data[i].leadCount!);
    }

    List<PieChartSectionData> sections = [];
    // List<double> radius = [60, 62, 65, 67, 70];
    List<Color> shadowColor = [
      piChartBlueGrey,
      piChartDarkRed,
      piChartDarkPurple,
      piChartBlueGrey,
      piChartDarkRed,
    ];

    for (var i = 0; i < data.length; i++) {
      double leadPercentage =
          (int.parse(data[i].leadCount!) / totalLeadCount) * 100;
      sections.add(
        PieChartSectionData(
          color: colors[i],
          value: leadPercentage,
          radius: leadPercentage > 70
              ? 70
              : 50 + ((leadPercentage > 40 ? 40 : leadPercentage) * 0.5),
          title: data[i].leadCount,
          titlePositionPercentageOffset: leadPercentage < 15 ? 0.8 : 0.5,
          titleStyle: AppTextStyle().buttonTextStyle(FontColor().white,
              fontSize: leadPercentage < 15 ? 8 : 14),
        ),
      );
      sections.add(
        PieChartSectionData(
          color: shadowColor[i],
          value: 1,
          radius: leadPercentage > 70
              ? 70
              : 50 + ((leadPercentage > 40 ? 40 : leadPercentage) * 0.5),
          showTitle: false,
          titlePositionPercentageOffset: leadPercentage < 15 ? 0.8 : 0.5,
        ),
      );
    }
    return sections;
  }
}

class NameWidget extends StatelessWidget {
  final String? name;
  final String? leadcont;
  final Color? color;
  const NameWidget({
    required this.name,
    required this.color,
    super.key,
    this.leadcont,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 10,
                width: 15,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(2)),
              ),
              horizontalSpaceTiny,
              Text(
                name!,
                style: AppTextStyle()
                    .mediumSmallText(textColor: FontColor().black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PichartData {
  late String? name;
  late String? leadCount;

  PichartData({this.leadCount, this.name});
}
