// import 'package:admin_portal/constants/constants.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:hexcolor/hexcolor.dart';

// class Graph extends StatelessWidget {
//   final List<String> xLabels; // List of x-axis labels
//   final List<double> yData; // List of y-axis data points

//   Graph({Key? key, required this.xLabels, required this.yData}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double widthFactor = MediaQuery.of(context).size.width / 1440;
//     double heightFactor = MediaQuery.of(context).size.height / 1024;

//     // Prepare bar groups with different colors based on yData
//     List<BarChartGroupData> barGroups = List.generate(yData.length, (index) {
//       // Generate a different color for each bar based on its yData value
//       Color barColor = _getBarColor(yData[index]);

//       return BarChartGroupData(
//         x: index,
//         barRods: [
//           BarChartRodData(
//             toY: yData[index], // Use y instead of toY for exact value
//             color: barColor,
//             width: 14 * widthFactor,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(10),
//               topRight: Radius.circular(10),
//             ),
//           ),
//         ],
//       );
//     });

//     double maxY = ((yData.reduce((curr, next) => curr > next ? curr : next) + 50) / 50).ceil() * 50;
//     double interval = 50;

//     return LayoutBuilder(
//       builder: (context, constraints) {
//           return BarChart(
//           BarChartData(
//             alignment: BarChartAlignment.spaceAround,
//               maxY: maxY, // Adjust maxY dynamically
//             barTouchData: BarTouchData(
//               touchTooltipData: BarTouchTooltipData(
//                 // tooltipBgColor: Colors.white60,
//               ),
//             ),
//             titlesData: FlTitlesData(
//               leftTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   getTitlesWidget: (double value, TitleMeta meta) {
//                     return Text(
//                       value.toString(),
//                       style: GoogleFonts.poppins(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w700,
//                         fontSize: 10 * widthFactor,
//                       ),
//                     );
//                   },
//                   reservedSize: 45 * heightFactor,
//               rightTitles: const AxisTitles(
//               ),
//               topTitles: const AxisTitles(
//                 sideTitles: SideTitles(showTitles: false),
//               ),
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   reservedSize: 40 * heightFactor,
//                   getTitlesWidget: (double value, TitleMeta meta) {
//                     if (value.toInt() >= 0 && value.toInt() < xLabels.length) {
//                       return Padding(
//                         padding: EdgeInsets.only(top: 8 * heightFactor),
//                         child: Text(
//                           xLabels[value.toInt()],
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.poppins(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 8 * widthFactor,
//                           ),
//                         ),
//                       );
//                     } else {
//                       return const SizedBox(); // Return empty SizedBox for out-of-bound indices
//                     }
//                   },
//                 ),
//               ),
//             ),
//             borderData: FlBorderData(show: false),
//             gridData: FlGridData(
//               show: true,
//               drawHorizontalLine: true,
//               drawVerticalLine: false,
//               horizontalInterval: 50,
//               getDrawingHorizontalLine: (value) {
//                 return FlLine(
//                   color: Colors.grey,
//                   strokeWidth: 0.3 * widthFactor,
//                 );
//               },
//             ),
//             barGroups: barGroups,
//           ),
//         );
//       },
//     );
//   }

//   // Function to determine bar color based on y-axis value
//   Color _getBarColor(double value) {
//     // Example logic: Assign colors based on value ranges or specific conditions
//     if (value >= 200) {
//       return tintcolor4;
//     }else if (value >= 150) {
//       return tintcolor2;
//     }else if (value >= 100) {
//       return tintcolor3;
//     } else if (value > 50) {
//       return tintcolor1;
//     } else {
//       return tintcolor5;
//     }
//   }
// }

import 'package:admin_portal/constants/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Graph extends StatefulWidget {
  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    double widthFactor = MediaQuery.of(context).size.width / 1440;
    double heightFactor = MediaQuery.of(context).size.height / 1024;

    return LayoutBuilder(
      builder: (context, constraints) {
        return BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 250,
            barTouchData: BarTouchData(
              touchTooltipData: BarTouchTooltipData(
                // tooltipBgColor: Colors.white60,
              ),
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    return Text(
                      value.toString(),
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 10 * widthFactor,
                      ),
                    );
                  },
                  reservedSize: 45 * heightFactor,
                  interval: 50,
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40 * heightFactor,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    String text;
                    switch (value.toInt()) {
                      case 0:
                        text = 'Day Scholar\nBoys';
                        break;
                      case 1:
                        text = 'Hosteller\nBoys';
                        break;
                      case 2:
                        text = 'Hosteller\nGirls';
                        break;
                      case 3:
                        text = 'Day Scholar\nGirls';
                        break;
                      default:
                        text = '';
                        break;
                    }
                    return Padding(
                      padding: EdgeInsets.only(top: 8 * heightFactor),
                      child: Text(
                        text,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 8 * widthFactor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              drawVerticalLine: false,
              horizontalInterval: 50,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.grey,
                  strokeWidth: 0.3 * widthFactor,
                );
              },
            ),
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                    toY: 200,
                    color: tintcolor4,
                    width: 14 * widthFactor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                    toY: 150,
                    color: tintcolor2,
                    width: 14 * widthFactor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ],
              ),
              BarChartGroupData(
                x: 2,
                barRods: [
                  BarChartRodData(
                    toY: 100,
                    color: tintcolor1,
                    width: 14 * widthFactor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ],
              ),
              BarChartGroupData(
                x: 3,
                barRods: [
                  BarChartRodData(
                    toY: 150,
                    color: tintcolor3,
                    width: 14 * widthFactor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}