import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:qadha/providers/achievements/achievements_provider.dart';
import 'package:qadha/providers/calendar_provider.dart';
import 'package:qadha/providers/remaining_prayers_provider.dart';
import 'package:qadha/providers/stats/stats_provider.dart';
import 'package:qadha/ui/app/app_router.gr.dart';
import 'package:qadha/ui/app/app_theme.dart';

import 'package:flutter/foundation.dart';
import 'package:qadha/ui/common/qadha_button.dart';

import 'challenge_modal.dart';

class MainView extends ConsumerWidget {
  const MainView({Key? key}) : super(key: key);

  void _showChallengeModal(BuildContext context, int newLevel) async {
    await showDialog(
        barrierColor: Colors.black54,
        context: context,
      barrierDismissible: false,
        builder: (ctx) => ChallengeModal(
          newLevel: newLevel,
          onAccept: () {
          AutoRouter.of(context).navigate(const AchievementsRoute());
        },));
  }

  Widget _buildSign(IconData icon, Function() onTap) {
    return Material(
      color: AppTheme.secundaryColor,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 42.5,
            )),
      ),
    );
  }

  Widget _buildSalatTile(
      BuildContext context, WidgetRef ref, String name, int remaining) {
    final size = MediaQuery.of(context).size;

    final challengeStatus = ref.watch(achievementsProvider).challengeStatus;

    final progress = ref.read(statsProvider.notifier).getSpecificProgress(
        name.toLowerCase(), remaining, ref.watch(calendarProvider));

    return Opacity(
      opacity: remaining == 0 ? 0.5 : 1,
      child: AbsorbPointer(
        absorbing: remaining == 0,
        child: Column(
          children: [
            SizedBox(
              width: size.width / 1.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                      opacity: progress == 0 ? 0.5 : 1,
                      child: AbsorbPointer(
                        absorbing: progress == 0,
                        child: _buildSign(Icons.remove, () {
                          ref
                              .read(statsProvider.notifier)
                              .incrementDailyPrayer(name.toLowerCase(), -1);
                          ref.read(achievementsProvider.notifier).incrementChallenge(-1);
                        }),
                      )),
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
                  InkWell(
                      onTap: () {},
                      child: _buildSign(Icons.add, () {
                        ref
                            .read(statsProvider.notifier)
                            .incrementDailyPrayer(name.toLowerCase(), 1);
                        if (challengeStatus == 9) {
                          ref.read(achievementsProvider.notifier).incrementLevel();
                          ref.read(achievementsProvider.notifier).resetChallenge();
                          _showChallengeModal(context, ref.read(achievementsProvider).level);
                        }
                        else {
                          ref.read(achievementsProvider.notifier).incrementChallenge(1);
                        }
                      }))
                ],
              ),
            ),
            const SizedBox(height: 1),
            if (progress != -1)
              FractionallySizedBox(
                  widthFactor: 0.987,
                  child: LinearPercentIndicator(
                    lineHeight: 2,
                    animationDuration: 2000,
                    percent: max(progress, 0),
                    trailing: Text(
                        remaining == 0
                            ? "aucune prière à rattraper      "
                            : remaining == 1
                                ? "encore 1 prière à rattraper    "
                                : "encore $remaining prières à rattraper  ",
                        style: const TextStyle(
                            fontFamily: "Inter Regular", fontSize: 13)),
                    barRadius: const Radius.circular(6),
                    backgroundColor: AppTheme.deadColor.withOpacity(0.65),
                    progressColor: AppTheme.accentColor,
                  )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remainingPrayers = ref.watch(remainingPrayersProvider);
    final challengeStatus = ref.watch(achievementsProvider).challengeStatus;

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
              const SizedBox(height: 25),
              if (!listEquals(remainingPrayers, [0, 0, 0, 0, 0]))
                const Text("Combien de prières rattrapées aujourd'hui ?",
                    style:
                        TextStyle(fontSize: 14.5, fontFamily: "Inter Regular")),
              const SizedBox(height: 7.5),
              Expanded(
                child: listEquals(remainingPrayers, [0, 0, 0, 0, 0])
                    ? Column(
                        children: [
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            decoration: BoxDecoration(
                              color: AppTheme.purpleColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                const FractionallySizedBox(
                                    widthFactor: 0.85,
                                    child: Text(
                                        "Pour permettre à Qadha de calculer les prières à rattraper, ajoutez des calendriers liés aux différentes périodes pendant lesquelles vous estimez ne pas avoir prié.",
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
                                            fontFamily: "Inter Regular",
                                            fontSize: 18))),
                                const SizedBox(height: 25),
                                FractionallySizedBox(
                                  widthFactor: 0.8,
                                  child: IntrinsicWidth(
                                    child: QadhaButton(
                                      text: "Créer mon calendrier",
                                      radius: 22.5,
                                      onTap: () {
                                        AutoRouter.of(context).navigate(CalendarsRoute());
                                      }),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 5),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildSalatTile(
                              context, ref, "FAJR", remainingPrayers[0]),
                          _buildSalatTile(
                              context, ref, "DHOR", remainingPrayers[1]),
                          _buildSalatTile(
                              context, ref, "ASR", remainingPrayers[2]),
                          _buildSalatTile(
                              context, ref, "MAGHREB", remainingPrayers[3]),
                          _buildSalatTile(
                              context, ref, "ICHA", remainingPrayers[4]),
                        ],
                      ),
              ),
              const SizedBox(height: 10),
              Opacity(
                opacity:
                    listEquals(remainingPrayers, [0, 0, 0, 0, 0]) ? 0.6 : 1,
                child: Column(
                  children: [
                    FractionallySizedBox(
                        widthFactor: 0.75,
                        child: LinearPercentIndicator(
                          lineHeight: 18,
                          percent: challengeStatus / 10,
                          trailing: Text("${challengeStatus * 10}%",
                              style: const TextStyle(fontFamily: "Inter Regular")),
                          barRadius: const Radius.circular(6),
                          backgroundColor: AppTheme.deadColor.withOpacity(0.65),
                          progressColor: AppTheme.accentColor,
                        )),
                    const SizedBox(height: 12.5),
                    Text(
                        "Plus que ${10 - challengeStatus} avant de débloquer une nouvelle sagesse",
                        style: const TextStyle(
                            fontFamily: "Inter Regular", fontSize: 13.5)),
                  ],
                ),
              ),
              const SizedBox(height: 5)
            ],
          ),
        ],
      ),
    );
  }
}
