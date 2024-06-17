import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

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
      getTooltipColor: (BarChartGroupData group) => Colors.blueGrey,
                
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
                  reservedSize: 16 * heightFactor,
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
                    return Text(
                      text,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 8 * widthFactor,
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
                    color: HexColor("#5E72D5"),
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
                    color: HexColor("#AEB8EB"),
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
                    color:  HexColor("#D7DBF4"),
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
                    color: HexColor("#8795E0"),
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

// // // Example color constants (replace these with your actual colors from constants.dart)
// const tintcolor1 = Colors.red;
// const tintcolor2 = Colors.green;
// const tintcolor3 = Colors.blue;
// const tintcolor4 = Colors.orange;
