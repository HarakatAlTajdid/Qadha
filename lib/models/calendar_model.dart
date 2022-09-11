import 'package:qadha/utils/date_utils.dart';

class CalendarModel {
  final DateTime start;
  final DateTime end;
  final String? id;

  CalendarModel(this.start, this.end, {this.id});

  static fromJson(Map<String, dynamic> json, String? id_) => CalendarModel(
      parseDate(json["start"] as String), parseDate(json["end"] as String),
      id: id_);

  Map<String, dynamic> toJson() =>
      {"start": formatDate(start), "end": formatDate(end)};

  bool intersectsWith(CalendarModel other) {
    return start == other.start ||
        start == other.end ||
        end == other.start ||
        end == other.end ||
        (start.isAfter(other.start) && start.isBefore(other.end)) ||
        (end.isAfter(other.start) && end.isBefore(other.end));
  }

  int totalDays() {
    return end.difference(start).inDays + 1;
  }
}
