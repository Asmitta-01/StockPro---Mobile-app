import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget(
      {super.key,
      required this.barColor,
      required this.barData,
      required this.labels});

  final List<double> barData;
  final Color barColor;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: BarChart(
        BarChartData(
          barTouchData: barTouchData,
          titlesData: titlesData,
          borderData: borderData,
          barGroups: barGroups,
          gridData: const FlGridData(show: false),
          alignment: BarChartAlignment.spaceAround,
          maxY: barData.reduce((curr, next) => curr > next ? curr : next),
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (group) => Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              TextStyle(color: barColor, fontWeight: FontWeight.bold),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: barColor,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    String text = labels.elementAtOrNull(value.toInt()) ?? '';

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(show: false);

  List<BarChartGroupData> get barGroups {
    return barData
        .asMap()
        .entries
        .map((entry) => BarChartGroupData(
              x: entry.key,
              barRods: [BarChartRodData(toY: entry.value, color: barColor)],
              // showingTooltipIndicators: [0],
            ))
        .toList();
  }
}
