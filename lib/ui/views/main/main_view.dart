import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:qadha/providers/stats_provider.dart';
import 'package:qadha/ui/app/app_theme.dart';

class MainView extends ConsumerWidget {
  const MainView({Key? key}) : super(key: key);

  Widget _buildSign(IconData icon) {
    return Container(
        decoration: BoxDecoration(
            color: AppTheme.secundaryColor,
            borderRadius: BorderRadius.circular(5)),
        child: Icon(
          icon,
          color: AppTheme.primaryColor,
          size: 42.5,
        ));
  }

  Widget _buildSalatTile(BuildContext context, String name, int remaining) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(
          width: size.width / 1.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Opacity(opacity: true ? 0.6 : 1, child: _buildSign(Icons.remove)),
              Stack(alignment: Alignment.centerRight, children: [
                SizedBox(
                  width: size.width / 1.75,
                  child: Container(
                    height: 42.5,
                    decoration: BoxDecoration(
                        color: AppTheme.secundaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(name,
                          style: TextStyle(
                              color: AppTheme.primaryColor,
                              fontSize: 16,
                              fontFamily: "Inter Bold")),
                    ),
                  ),
                ),
                Container(
                    height: 30,
                    constraints: const BoxConstraints(minWidth: 27.5),
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                        borderRadius: BorderRadius.circular(3)),
                    child: const Center(
                        child: Text("0",
                            style: TextStyle(
                                fontSize: 16, fontFamily: "Inter Bold")))),
              ]),
              _buildSign(Icons.add)
            ],
          ),
        ),
        FractionallySizedBox(
            widthFactor: 0.987,
            child: LinearPercentIndicator(
              animation: true,
              lineHeight: 2,
              animationDuration: 2000,
              percent: name.length * 0.07,
              trailing: Text("reste encore $remaining   ",
                  style: const TextStyle(
                      fontFamily: "Inter Regular", fontSize: 12)),
              barRadius: const Radius.circular(6),
              backgroundColor: AppTheme.deadColor.withOpacity(0.65),
              progressColor: AppTheme.accentColor,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsState = ref.watch(statsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        children: [
          SvgPicture.asset(
            "assets/images/ladderbg.svg",
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Image.asset(
                "assets/images/qadha_blue.png",
                width: 52.5,
              )),
              const SizedBox(height: 30),
              const Text("Combien de prières rattrapées aujourd'hui ?",
                  style:
                      TextStyle(fontSize: 14.5, fontFamily: "Inter Regular")),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSalatTile(context, "FAJR", statsState.remainingPrayers[0]),
                    _buildSalatTile(context, "DHOR", statsState.remainingPrayers[1]),
                    _buildSalatTile(context, "ASR", statsState.remainingPrayers[2]),
                    _buildSalatTile(context, "MAGHREB", statsState.remainingPrayers[3]),
                    _buildSalatTile(context, "ICHA", statsState.remainingPrayers[4]),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              FractionallySizedBox(
                  widthFactor: 0.75,
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
              const SizedBox(height: 12.5),
              const Text("Plus que 10 avant de débloquer une nouvelle sagesse",
                  style:
                      TextStyle(fontFamily: "Inter Regular", fontSize: 13.5)),
              const SizedBox(height: 5)
            ],
          ),
        ],
      ),
    );
  }
}
