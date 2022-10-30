import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qadha/models/achievement_model.dart';
import 'package:qadha/providers/achievements/achievements_provider.dart';
import 'package:qadha/ui/app/app_theme.dart';

class AchievementsView extends ConsumerWidget {
  const AchievementsView({Key? key}) : super(key: key);

  void _showModal(BuildContext context, AchievementModel achievement) async {
    await showModalBottomSheet(
        barrierColor: Colors.black38,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        backgroundColor: AppTheme.primaryColor,
        builder: (ctx) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.sp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 25.sp),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                          achievement.type == "Hadith"
                              ? "Hadith authentique"
                              : "Verset coranique",
                          style: TextStyle(
                              fontSize: 17.sp, fontFamily: "Inter SemiBold"))),
                  Divider(thickness: 1.5.sp),
                  SizedBox(height: 10.sp),
                  SelectableText(achievement.text,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 17.5.sp, fontFamily: "Inter Regular")),
                  SizedBox(height: 150.sp),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final achievements = ref.watch(achievementsProvider).allAchievements;
    final level =
        ref.watch(achievementsProvider).level;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.sp),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 SizedBox(height: 30.sp),
                Center(
                    child: Text("Niveau $level",
                        style:  TextStyle(
                            fontFamily: "Inter Regular", fontSize: 22.sp))),
                 SizedBox(height: 10.sp),
                RatingBar.builder(
                  itemSize: 25.sp,
                  initialRating:
                      (level / achievements.length < 0.25)
                          ? 1
                          : ((level /
                                      achievements.length <
                                  0.5)
                              ? 2
                              : ((level /
                                          achievements.length <
                                      0.75)
                                  ? 3
                                  : ((level /
                                              achievements.length <
                                          0.85)
                                      ? 4
                                      : 5))),
                  ignoreGestures: true,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemPadding:  EdgeInsets.symmetric(horizontal: 1.5.sp),
                  itemBuilder: (context, _) =>
                      Icon(Icons.star_rounded, color: AppTheme.goldenColor),
                  unratedColor: Colors.black,
                  onRatingUpdate: (double value) {},
                ),
                 SizedBox(height: 45.sp),
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.purpleColor,
                    borderRadius:  const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                  child: Column(
                    children: [
                       SizedBox(height: 20.sp),
                       Text("Sagesses débloquées",
                          style: TextStyle(
                              fontFamily: "Inter SemiBold", fontSize: 19.sp)),
                       SizedBox(height: 12.sp),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: achievements.length,
                        physics:  const NeverScrollableScrollPhysics(),
                        gridDelegate:
                             const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          final achievement = achievements[index];
                          return Opacity(
                            opacity:
                                index >= level ? 0.8 : 1,
                            child: Stack(children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: index % 2 == 0 ? 10 : 5,
                                      right: index % 2 == 0 ? 5 : 10,
                                      top: 5,
                                      bottom: 5),
                                  child: Material(
                                    color: AppTheme.primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                    child: InkWell(
                                      onTap: index >= level
                                          ? null
                                          : () {
                                              _showModal(
                                                  context, achievement);
                                            },
                                      splashColor: AppTheme.secundaryColor
                                          .withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(10),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                                width: 35.sp,
                                                padding:
                                                     EdgeInsets.all(6.5.sp),
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppTheme.primaryColor,
                                                    borderRadius:
                                                         const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    7.5)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: AppTheme
                                                            .deadColor,
                                                        spreadRadius: 1,
                                                        blurRadius: 10,
                                                      ),
                                                    ]),
                                                child: Center(
                                                    child: Text(
                                                        (index + 1)
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontFamily:
                                                                "Inter SemiBold",
                                                            color:
                                                                AppTheme.metallicColor)))),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Blur(
                                                  colorOpacity: index >=
                                                          level
                                                      ? 0.75
                                                      : 0,
                                                  blur: index >=
                                                          level
                                                      ? 2.75
                                                      : 0,
                                                  child: Text(
                                                      achievement.type,
                                                      style:  TextStyle(
                                                          fontSize: 18.5.sp,
                                                          fontFamily:
                                                              "Inter Regular")),
                                                ),
                                                 SizedBox(height: 5.sp),
                                                Padding(
                                                  padding:  EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15.sp),
                                                  child: Blur(
                                                    colorOpacity: index >=
                                                            level
                                                        ? 0.5
                                                        : 0,
                                                    blur: index >=
                                                            level
                                                        ? 2
                                                        : 0,
                                                    child: Text(
                                                        achievement
                                                            .presentationText,
                                                        maxLines: 4,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.justify,
                                                        style: TextStyle(
                                                            fontSize: 14.sp,
                                                            fontFamily:
                                                                "Inter SemiBold",
                                                            color: AppTheme
                                                                .metallicColor
                                                                .withOpacity(
                                                                    0.85))),
                                                  ),
                                                ),
                                                 SizedBox(height: 40.sp)
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              if (index >= level)
                                 Center(
                                    child: Text("🔐",
                                        style: TextStyle(fontSize: 45.5.sp)))
                            ]),
                          );
                        },
                      ),
                       SizedBox(height: 30.sp),
                    ],
                  ),
                ),
                 SizedBox(height: 100.sp),
              ])),
    );
  }
}
