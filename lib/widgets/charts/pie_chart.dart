import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stock_pro/widgets/indicator.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({
    super.key,
    required this.labels,
    required this.colors,
    required this.values,
  }) : assert(labels.length == colors.length && colors.length == values.length,
            "Labels, values and colors should have the same length");

  final List<String> labels;
  final List<Color> colors;
  final List<double> values;

  @override
  State<StatefulWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.labels.map(
              (label) {
                var index = widget.labels.indexOf(label);
                return Indicator(
                  color: widget.colors.elementAt(index),
                  text: label,
                  isSquare: false,
                  size: touchedIndex == index ? 18 : 16,
                  textColor: touchedIndex == index
                      ? Get.theme.colorScheme.onSurface
                      : Get.theme.colorScheme.onSurface.withOpacity(.5),
                );
              },
            ).toList(),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  startDegreeOffset: 180,
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 1,
                  centerSpaceRadius: 0,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final maximum = widget.values.reduce((v, e) => max(v, e));
    return List.generate(
      widget.labels.length,
      (i) {
        final isTouched = i == touchedIndex;
        return PieChartSectionData(
          color: widget.colors[i],
          value: widget.values[i],
          showTitle: false,
          badgeWidget: isTouched
              ? Chip(
                  padding: EdgeInsets.zero,
                  label: Text(widget.values[i].toStringAsFixed(0)),
                  backgroundColor: Get.theme.colorScheme.surface,
                )
              : null,
          radius: (widget.values[i] / maximum) * 80,
          badgePositionPercentageOffset: 1,
          borderSide: isTouched
              ? BorderSide(color: Get.theme.colorScheme.surface, width: 6)
              : const BorderSide(color: Colors.transparent),
        );
      },
    );
  }
}
