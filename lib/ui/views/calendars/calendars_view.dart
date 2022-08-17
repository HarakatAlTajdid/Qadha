import 'package:flutter/material.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/calendar/qadha_monthly_calendar.dart';

class CalendarsView extends StatefulWidget {
  const CalendarsView({Key? key}) : super(key: key);

  @override
  State<CalendarsView> createState() => _CalendarsViewState();
}

class _CalendarsViewState extends State<CalendarsView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: AppTheme.deadColor,
      child: Column(
        children: [
          const SizedBox(height: 50),
          Center(
            child: SizedBox(
                width: size.width / 1.2,
                height: size.height / 2.8,
                child: const QadhaMonthlyCalendar()),
          )
        ],
      ),
    );
  }
}
