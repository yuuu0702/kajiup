import 'package:intl/intl.dart';

class Housework {
  final String type;
  final String schedule;
  final int level;
  final bool isCompleted;

  Housework(this.type, this.schedule, this.level, this.isCompleted);

  factory Housework.fromJson(Map<String, dynamic> json) {
    return Housework(
      json['type'],
      json['schedule'],
      json['level'],
      json['isCompleted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'schedule': schedule,
      'level': level,
      'isCompleted': isCompleted,
    };
  }

  String get formattedSchedule => DateFormat('yyyy/MM/dd HH:mm').format(schedule.toDate());
}
