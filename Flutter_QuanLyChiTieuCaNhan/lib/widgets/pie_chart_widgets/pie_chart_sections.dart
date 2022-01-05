import 'package:daily_spending/constants/convert.dart';
import 'package:daily_spending/models/pie_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

List<PieChartSectionData> getSections(
        int touchedIndex, List<PieData> pieData , double screenWidth) =>
    pieData
        .asMap()
        .map<int, PieChartSectionData>((index, data) {
          final isTouched = index == touchedIndex;
          final double fontSize = isTouched ? 25 : 16;
          final double radius = isTouched ? screenWidth*0.35 : screenWidth*0.30;
          final String title = isTouched? '${data.name}  \n ' +  Themdaucham(data.price) +" VNĐ" :'${data.percent} %';
          final int Colo = isTouched ? 0xff0a0000 : 0xffffffff;
          final value = PieChartSectionData(
            color: data.color,
            value: data.percent,
            title: title,
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Color(Colo),
            ),
          );

          return MapEntry(index, value);
        })
        .values
        .toList();
