class QadhaCalendarState {
  final DateTime currentFrame;
  final List<DateTime> days; // 42 days needed

  QadhaCalendarState(
      {required this.currentFrame,
      required this.days});

  factory QadhaCalendarState.initial() {
    return QadhaCalendarState(
        currentFrame: DateTime(DateTime.now().year, DateTime.now().month),
        days: []);
  }

  QadhaCalendarState copyWith(
      {DateTime? currentFrame,
      List<DateTime>? days,
      DateTime? selectionStart,
      DateTime? selectionEnd}) {
    return QadhaCalendarState(
        currentFrame: currentFrame ?? this.currentFrame,
        days: days ?? this.days);
  }
}
