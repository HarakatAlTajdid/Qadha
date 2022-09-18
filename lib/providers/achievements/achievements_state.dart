import 'package:qadha/models/achievement_model.dart';

class AchievementsState {
  final List<AchievementModel> allAchievements;
  final int level;
  final int challengeStatus;

  AchievementsState(
      {required this.allAchievements,
      required this.level,
      required this.challengeStatus});

  factory AchievementsState.initial() {
    return AchievementsState(allAchievements: [], level: 1, challengeStatus: 0);
  }

  AchievementsState copyWith(
      {List<AchievementModel>? allAchievements,
      int? level,
      int? challengeStatus}) {
    return AchievementsState(
        allAchievements: allAchievements ?? this.allAchievements,
        level: level ?? this.level,
        challengeStatus: challengeStatus ?? this.challengeStatus);
  }
}
