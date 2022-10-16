import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
        horizontalInterval: 12,
        show: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: AppTheme.deadColor.withOpacity(0.7),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppTheme.deadColor.withOpacity(0.7),
            strokeWidth: 1,
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
              getTitlesWidget: (_, meta) {
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
                    padding: const EdgeInsets.only(top: 7),
                    child: Text(months[date.month - 1],
                        style: TextStyle(
                            fontSize: 13,
                            fontFamily: "Inter Regular",
                            color: date.year < DateTime.now().year
                                ? Colors.black54
                                : Colors.black)));
              }),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              getTitlesWidget: (_, meta) {
                return Text(meta.formattedValue,
                    style:
                        const TextStyle(color: Colors.black54, fontSize: 13));
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
          barWidth: 1.35,
          dotData: FlDotData(
              show: true,
              getDotPainter: (_, __, ___, ____) {
                return FlDotCirclePainter(
                    color: AppTheme.secundaryColor,
                    radius: 3.75,
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
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: AppTheme.deadColor.withOpacity(0.7),
            strokeWidth: 1,
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
              getTitlesWidget: (_, meta) {
                final day = DateTime.now().subtract(
                    Duration(days: 30 - int.parse(meta.formattedValue)));

                return Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: Text(day.day.toString(),
                        style: TextStyle(
                            color: day.month < DateTime.now().month
                                ? Colors.black54
                                : Colors.black)));
              }),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              getTitlesWidget: (_, meta) {
                return Text(meta.formattedValue,
                    style:
                        const TextStyle(color: Colors.black54, fontSize: 13));
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
          barWidth: 1.35,
          dotData: FlDotData(
              show: true,
              getDotPainter: (_, __, ___, ____) {
                return FlDotCirclePainter(
                    color: AppTheme.secundaryColor,
                    radius: 3.75,
                    strokeWidth: 0);
              }),
          belowBarData: BarAreaData(
              show: true, color: AppTheme.secundaryColor.withOpacity(0.06)),
        ),
      ],
    );
  }

  Widget _buildYearlyProgress(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final progressData = ref.watch(statsProvider.notifier).getGeneralProgress(
        ref.watch(remainingPrayersProvider), ref.watch(calendarProvider));

    return Container(
      width: size.width / 1.075,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: AppTheme.deadColor,
          spreadRadius: 2,
          blurRadius: 15,
          offset: const Offset(0, 4),
        ),
      ], color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            FractionallySizedBox(
                widthFactor: 0.785,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Performances annuelles",
                        style: TextStyle(
                            fontFamily: "Inter Regular", fontSize: 14.5)),
                    Text("sur 7 mois",
                        style: TextStyle(
                            fontFamily: "Inter SemiBold",
                            fontSize: 13,
                            color: AppTheme.secundaryColor))
                  ],
                )),
            const SizedBox(height: 8.5),
            const FractionallySizedBox(
                widthFactor: 0.875, child: Divider(thickness: 1.5)),
            const SizedBox(height: 23.5),
            SizedBox(
                height: size.height / 3.4,
                width: size.width / 1.4,
                child: LineChart(_buildYearlyData(ref))),
            const SizedBox(height: 27.5),
            FractionallySizedBox(
              widthFactor: 0.85,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Progression",
                      style:
                          TextStyle(fontFamily: "Inter Regular", fontSize: 14)),
                  Row(
                    children: [
                      Container(
                          width: 11.5,
                          height: 11.5,
                          decoration: BoxDecoration(
                              color: AppTheme.secundaryColor,
                              borderRadius: BorderRadius.circular(360))),
                      const SizedBox(width: 7.5),
                      const Text("Rattrapages par mois",
                          style: TextStyle(
                              fontFamily: "Inter Regular", fontSize: 12.5)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (true)
            FractionallySizedBox(
                widthFactor: 0.9,
                child: Opacity(
                  opacity: progressData[0] == -1 ? 0.4 : 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      LinearPercentIndicator(
                        lineHeight: 18,
                        animationDuration: 2000,
                        percent: progressData[0] == -1 ? 0 : max(progressData[0] / 100, 0),
                        trailing: Text(progressData[0] == -1 ? "0%" : "${progressData[0]}%",
                            style: const TextStyle(fontFamily: "Inter Regular")),
                        barRadius: const Radius.circular(6),
                        backgroundColor: AppTheme.deadColor.withOpacity(0.65),
                        progressColor: AppTheme.accentColor,
                      ),
                      const SizedBox(height: 12.5),
                      Text(progressData[1] != 0 ? "${progressData[1]} prières restantes" : "aucune prière restante",
                          style: const TextStyle(
                              fontFamily: "Inter Regular", fontSize: 13.5)),
                    ],
                  ),
                )),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyProgress(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width / 1.075,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: AppTheme.deadColor,
          spreadRadius: 2,
          blurRadius: 15,
          offset: const Offset(0, 4),
        ),
      ], color: AppTheme.primaryColor, borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            FractionallySizedBox(
                widthFactor: 0.785,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Performances mensuelles",
                        style: TextStyle(
                            fontFamily: "Inter Regular", fontSize: 14.5)),
                    Text("sur 30 jours",
                        style: TextStyle(
                            fontFamily: "Inter SemiBold",
                            fontSize: 13,
                            color: AppTheme.secundaryColor))
                  ],
                )),
            const SizedBox(height: 8.5),
            const FractionallySizedBox(
                widthFactor: 0.875, child: Divider(thickness: 1.5)),
            const SizedBox(height: 23.5),
            SizedBox(
                height: size.height / 3.4,
                width: size.width / 1.4,
                child: LineChart(_buildMonthlyData(ref))),
            const SizedBox(height: 25),
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
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Center(
                child: Image.asset(
              "assets/images/qadha_blue.png",
              width: 52.5,
            )),
            const SizedBox(height: 22.5),
            _buildYearlyProgress(context, ref),
            const SizedBox(height: 25),
            _buildMonthlyProgress(context, ref),
            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}
