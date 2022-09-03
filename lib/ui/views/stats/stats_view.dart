import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:qadha/ui/app/app_theme.dart';

class StatsView extends StatefulWidget {
  const StatsView({Key? key}) : super(key: key);

  @override
  State<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  LineChartData _buildYearlyData() {
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
                final months = [
                  "Jan",
                  "Fev",
                  "Mar",
                  "Avr",
                  "Mai",
                  "Juin",
                  "Juil"
                ];

                return Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: Text(months[int.parse(meta.formattedValue)]));
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
          spots: const [
            FlSpot(0, 40),
            FlSpot(1, 55),
            FlSpot(2, 47),
            FlSpot(3, 65),
            FlSpot(4, 40),
            FlSpot(5, 55),
            FlSpot(6, 90),
          ],
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

  LineChartData _buildMonthlyData() {
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
                return Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: Text(meta.formattedValue,
                        style: TextStyle(
                            color: int.parse(meta.formattedValue) < 15
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
          spots: const [
            FlSpot(1, 5),
            FlSpot(2, 0),
            FlSpot(3, 0),
            FlSpot(4, 0),
            FlSpot(5, 1),
            FlSpot(6, 2),
            FlSpot(7, 6),
            FlSpot(8, 1),
            FlSpot(9, 0),
            FlSpot(10, 0),
            FlSpot(11, 0),
            FlSpot(12, 0),
            FlSpot(13, 0),
            FlSpot(14, 0),
            FlSpot(15, 0),
            FlSpot(16, 0),
            FlSpot(17, 8),
            FlSpot(18, 0),
            FlSpot(19, 1),
            FlSpot(20, 2),
            FlSpot(21, 3),
            FlSpot(22, 5),
            FlSpot(23, 4),
            FlSpot(24, 6),
            FlSpot(25, 7),
            FlSpot(26, 8),
            FlSpot(27, 9),
            FlSpot(28, 1),
            FlSpot(29, 2),
          ],
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

  Widget _buildYearlyProgress() {
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
                    const Text("Performances annuelles",
                        style: TextStyle(
                            fontFamily: "Inter Regular", fontSize: 14.5)),
                    Text("+10% (1 mois)",
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
                child: LineChart(_buildYearlyData())),
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
            FractionallySizedBox(
                widthFactor: 0.9,
                child: LinearPercentIndicator(
                  animation: true,
                  lineHeight: 18,
                  animationDuration: 2000,
                  percent: 0.65,
                  trailing: const Text("65%",
                      style: TextStyle(fontFamily: "Inter Regular")),
                  barRadius: const Radius.circular(6),
                  backgroundColor: AppTheme.deadColor.withOpacity(0.65),
                  progressColor: AppTheme.accentColor,
                )),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyProgress() {
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
                    Text("Ce mois-ci",
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
                child: LineChart(_buildMonthlyData())),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            _buildYearlyProgress(),
            const SizedBox(height: 25),
            _buildMonthlyProgress(),
            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}
