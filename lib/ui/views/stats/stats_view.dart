import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:qadha/providers/calendar_provider.dart';
import 'package:qadha/providers/remaining_prayers_provider.dart';
import 'package:qadha/providers/stats/stats_provider.dart';
import 'package:qadha/ui/app/app_theme.dart';

class StatsView extends ConsumerWidget {
  const StatsView({Key? key}) : super(key: key);

  LineChartData _buildYearlyData(WidgetRef ref) {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        horizontalInterval: 12.sp,
        show: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: AppTheme.deadColor.withOpacity(0.7),
            strokeWidth: 1.sp,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppTheme.deadColor.withOpacity(0.7),
            strokeWidth: 1.sp,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              reservedSize: 20.sp,
              showTitles: true,
              getTitlesWidget: (_, meta) {
                if (meta.formattedValue.contains(".")) {
                  return Container();
                }

                final date = DateTime(DateTime.now().year,
                    DateTime.now().month - 7 + int.parse(meta.formattedValue));

                final months = [
                  "Jan",
                  "Fév",
                  "Mars",
                  "Avr",
                  "Mai",
                  "Juin",
                  "Jui",
                  "Août",
                  "Sep",
                  "Oct",
                  "Nov",
                  "Déc"
                ];

                return Padding(
                    padding: EdgeInsets.only(top: 7.sp),
                    child: Text(months[date.month - 1],
                        style: TextStyle(
                            fontSize: 13.sp,
                            fontFamily: "Inter Regular",
                            color: date.year < DateTime.now().year
                                ? Colors.black54
                                : Colors.black)));
              }),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35.sp,
              interval: 20,
              getTitlesWidget: (_, meta) {
                return Text(meta.formattedValue,
                    style: TextStyle(color: Colors.black54, fontSize: 13.sp));
              }),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      lineBarsData: [
        LineChartBarData(
          spots: ref
              .watch(statsProvider.notifier)
              .generateYearlyStats(ref.watch(statsProvider).activities),
          color: AppTheme.secundaryColor,
          barWidth: 1.35.sp,
          dotData: FlDotData(
              show: true,
              getDotPainter: (_, __, ___, ____) {
                return FlDotCirclePainter(
                    color: AppTheme.secundaryColor,
                    radius: 3.5.sp,
                    strokeWidth: 0);
              }),
          belowBarData: BarAreaData(
              show: true, color: AppTheme.secundaryColor.withOpacity(0.1)),
        ),
      ],
    );
  }

  LineChartData _buildMonthlyData(WidgetRef ref) {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      gridData: FlGridData(
        show: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: AppTheme.deadColor.withOpacity(0.7),
            strokeWidth: 1.sp,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppTheme.deadColor.withOpacity(0.7),
            strokeWidth: 1.sp,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22.5.sp,
              getTitlesWidget: (_, meta) {
                final day = DateTime.now().subtract(
                    Duration(days: 30 - int.parse(meta.formattedValue)));

                return Padding(
                    padding: EdgeInsets.only(top: 9.sp),
                    child: Text(day.day.toString(),
                        style: TextStyle(
                            fontSize: 13.sp,
                            color: day.month < DateTime.now().month
                                ? Colors.black54
                                : Colors.black)));
              }),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35.sp,
              interval: 5,
              getTitlesWidget: (_, meta) {
                return Text(meta.formattedValue,
                    style: TextStyle(color: Colors.black54, fontSize: 13.sp));
              }),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      lineBarsData: [
        LineChartBarData(
          spots: ref
              .watch(statsProvider.notifier)
              .generateMonthlyStats(ref.watch(statsProvider).activities),
          color: AppTheme.secundaryColor,
          barWidth: 1.35.sp,
          dotData: FlDotData(
              show: true,
              getDotPainter: (_, __, ___, ____) {
                return FlDotCirclePainter(
                    color: AppTheme.secundaryColor,
                    radius: 3.5.sp,
                    strokeWidth: 0);
              }),
          belowBarData: BarAreaData(
              show: true, color: AppTheme.secundaryColor.withOpacity(0.06)),
        ),
      ],
    );
  }

  Widget _buildYearlyProgress(BuildContext context, WidgetRef ref) {
    final progressData = ref.watch(statsProvider.notifier).getGeneralProgress(
        ref.watch(remainingPrayersProvider), ref.watch(calendarProvider));

    return Container(
      width: 0.925.sw,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: AppTheme.deadColor,
          spreadRadius: 2,
          blurRadius: 15,
          offset: Offset(0, 4.sp),
        ),
      ], color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.sp),
            FractionallySizedBox(
                widthFactor: 0.785,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Performances annuelles",
                        style: TextStyle(
                            fontFamily: "Inter Regular", fontSize: 14.5.sp)),
                    Text("sur 7 mois",
                        style: TextStyle(
                            fontFamily: "Inter SemiBold",
                            fontSize: 13.sp,
                            color: AppTheme.secundaryColor))
                  ],
                )),
            SizedBox(height: 8.5.sp),
            FractionallySizedBox(
                widthFactor: 0.875, child: Divider(thickness: 1.5.sp)),
            SizedBox(height: 23.5.sp),
            SizedBox(
                height: 0.3.sh,
                width: 0.75.sw,
                child: LineChart(_buildYearlyData(ref))),
            SizedBox(height: 27.5.sp),
            FractionallySizedBox(
              widthFactor: 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Progression",
                      style: TextStyle(
                          fontFamily: "Inter Regular", fontSize: 14.sp)),
                  Row(
                    children: [
                      Container(
                          width: 11.5.sp,
                          height: 11.5.sp,
                          decoration: BoxDecoration(
                              color: AppTheme.secundaryColor,
                              borderRadius: BorderRadius.circular(360))),
                      SizedBox(width: 7.5.sp),
                      Text("Rattrapages par mois",
                          style: TextStyle(
                              fontFamily: "Inter Regular", fontSize: 12.5.sp)),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10.sp),
            FractionallySizedBox(
                widthFactor: 0.9,
                child: Opacity(
                  opacity: progressData[0] == -1 ? 0.4 : 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      LinearPercentIndicator(
                        lineHeight: 18.sp,
                        animationDuration: 2000,
                        percent: progressData[0] == -1
                            ? 0
                            : max(progressData[0] / 100, 0),
                        trailing: Text(
                            progressData[0] == -1
                                ? "0%"
                                : "${progressData[0]}%",
                            style: TextStyle(
                                fontFamily: "Inter Regular",
                                fontSize: 13.5.sp)),
                        barRadius: const Radius.circular(6),
                        backgroundColor: AppTheme.deadColor.withOpacity(0.65),
                        progressColor: AppTheme.accentColor,
                      ),
                      SizedBox(height: 12.sp),
                      Text(
                          progressData[1] != 0
                              ? "${progressData[1]} prières restantes"
                              : "aucune prière restante",
                          style: TextStyle(
                              fontFamily: "Inter Regular", fontSize: 13.5.sp)),
                    ],
                  ),
                )),
            SizedBox(height: 25.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyProgress(BuildContext context, WidgetRef ref) {
    return Container(
      width: 0.925.sw,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: AppTheme.deadColor,
          spreadRadius: 2,
          blurRadius: 15,
          offset: Offset(0, 4.sp),
        ),
      ], color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.sp),
            FractionallySizedBox(
                widthFactor: 0.785,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Performances mensuelles",
                        style: TextStyle(
                            fontFamily: "Inter Regular", fontSize: 14.5.sp)),
                    Text("sur 30 jours",
                        style: TextStyle(
                            fontFamily: "Inter SemiBold",
                            fontSize: 13.sp,
                            color: AppTheme.secundaryColor))
                  ],
                )),
            SizedBox(height: 8.5.sp),
            FractionallySizedBox(
                widthFactor: 0.875, child: Divider(thickness: 1.5.sp)),
            SizedBox(height: 23.5.sp),
            SizedBox(
                height: 0.3.sh,
                width: 0.75.sw,
                child: LineChart(_buildMonthlyData(ref))),
            SizedBox(height: 25.sp),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.sp),
        child: Column(
          children: [
            Center(
                child: Image.asset(
              "assets/images/qadha_blue.png",
              width: 50.sp,
            )),
            SizedBox(height: 22.5.sp),
            _buildYearlyProgress(context, ref),
            SizedBox(height: 25.sp),
            _buildMonthlyProgress(context, ref),
            SizedBox(height: 100.sp)
          ],
        ),
      ),
    );
  }
}
