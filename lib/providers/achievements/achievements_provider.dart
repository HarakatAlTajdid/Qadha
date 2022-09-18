import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qadha/providers/achievements/achievements_state.dart';
import 'package:qadha/services/achievements_service.dart';

final achievementsProvider =
    StateNotifierProvider<AchievementsNotifier, AchievementsState>((ref) {
  return AchievementsNotifier(ref);
});


class AchievementsNotifier extends StateNotifier<AchievementsState> {
  final StateNotifierProviderRef<AchievementsNotifier, AchievementsState> _ref;

  AchievementsNotifier(this._ref) : super(AchievementsState.initial()) {
    _loadData();
  }

  void _loadData() async {
    final achievements = await _ref.read(achievementsServiceProvider).loadAchievements();
    final challengeStatus = await _ref.read(achievementsServiceProvider).getChallengeStatus();
    final level = await _ref.read(achievementsServiceProvider).getLevel();
    state = state.copyWith(allAchievements: achievements, challengeStatus: challengeStatus, level: level);
  }

  void incrementLevel() {
    _ref.read(achievementsServiceProvider).incrementLevel();
    state = state.copyWith(level: state.level + 1);
  }

  void incrementChallenge(int increment) {
    if (state.challengeStatus == 0 && increment < 0) {
      return;
    }

    _ref.read(achievementsServiceProvider).incrementChallenge(increment);
    state = state.copyWith(challengeStatus: state.challengeStatus + increment);
  }

  void resetChallenge() {
    _ref.read(achievementsServiceProvider).incrementChallenge(-9);
    state = state.copyWith(challengeStatus: 0);
  }
}