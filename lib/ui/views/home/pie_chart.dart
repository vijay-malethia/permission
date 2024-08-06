import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '/ui/common/index.dart';

class PieChartPage extends StatelessWidget {
  const PieChartPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  sections: _generateSections(),
                  borderData: FlBorderData(show: false)))),
          // const Spacer(),
          const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NameWidget(name: 'Suyama', color: piChartYellow),
                NameWidget(name: 'Manoj Kumar', color: piChartPurple),
                NameWidget(name: 'Seshadri', color: piChartOrange),
                NameWidget(name: 'Abhishek', color: piChartBlue),
                NameWidget(name: 'Nirmal Raj', color: piChartRed)
              ])
        ],
      ),
    );
  }

  List<PieChartSectionData> _generateSections() {
    return [
      PieChartSectionData(
          color: piChartPurple,
          value: 5,
          radius: 75,
          title: '5',
          titlePositionPercentageOffset: 0.6,
          titleStyle: AppTextStyle().buttonTextStyle(FontColor().white)),
      PieChartSectionData(
          color: piChartDarkRed, title: '', value: 1, radius: 70),
      PieChartSectionData(
          color: piChartLightOrange,
          value: 15,
          radius: 70,
          title: '15',
          titlePositionPercentageOffset: 0.6,
          titleStyle: AppTextStyle().buttonTextStyle(FontColor().white)),
      PieChartSectionData(
          color: piChartBlueGrey, title: '', value: 1, radius: 65),
      PieChartSectionData(
          color: piChartBlue,
          value: 35,
          radius: 65,
          title: '35',
          titleStyle: AppTextStyle().buttonTextStyle(FontColor().white)),
      PieChartSectionData(
          color: piChartDarkRed, title: '', value: 1, radius: 60),
      PieChartSectionData(
          color: piChartLightRed,
          value: 15,
          radius: 60,
          title: '15',
          titlePositionPercentageOffset: 0.6,
          titleStyle: AppTextStyle().buttonTextStyle(FontColor().white)),
      PieChartSectionData(
        color: piChartYellow,
        value: 20,
        radius: 80,
        title: '30',
        titleStyle: AppTextStyle().buttonTextStyle(FontColor().white),
      ),
      PieChartSectionData(
          color: piChartDarkPurple, title: '', value: 1, radius: 75),
    ];
  }
}

class NameWidget extends StatelessWidget {
  final String name;
  final Color? color;
  const NameWidget({
    required this.name,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 5),
      child: Row(
        children: [
          Container(
            height: 10,
            width: 15,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(2)),
          ),
          horizontalSpaceTiny,
          Text(
            name,
            style: AppTextStyle().mediumSmallText(textColor: FontColor().black),
          ),
        ],
      ),
    );
  }
}

class LeadBackSide extends StatelessWidget {
  const LeadBackSide({
    super.key,
    required this.leadItem,
  });

  final List<LeadGridItem> leadItem;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: GridView.builder(
          padding: const EdgeInsets.all(5),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 45,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 5),
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: leadItem[index].bgColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Text("${leadItem[index].leadName}",
                          style: AppTextStyle().textButtonTextStyle(
                              textColor: FontColor().black)),
                      Text('${leadItem[index].leadCount}',
                          style: AppTextStyle().sixteenPixel(
                            textColor: leadItem[index].fgColor,
                          ))
                    ])));
          },
        ));
  }
}

class LeadGridItem {
  late Color? bgColor;
  late Color? fgColor;
  late String? leadName;
  late String? leadCount;
  LeadGridItem({this.bgColor, this.fgColor, this.leadName, this.leadCount});
}

// class PieSegment {
//   final Color color;
//   final double radius;
//   final double angle;

//   PieSegment({required this.color, required this.radius, required this.angle});
// }

// class PieChartPainter extends CustomPainter {
//   final List<PieSegment> segments;

//   PieChartPainter(this.segments);

//   @override
//   void paint(Canvas canvas, Size size) {
//     double totalAngle = 0;

//     for (var segment in segments) {
//       final paint = Paint()..color = segment.color;
//       final rect = Rect.fromCircle(
//         center: Offset(size.width / 2, size.height / 2),
//         radius: segment.radius,
//       );

//       canvas.drawArc(
//         rect,
//         totalAngle,
//         segment.angle,
//         true,
//         paint,
//       );

//       totalAngle += segment.angle;
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
