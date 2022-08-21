import 'package:flutter/material.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/calendar/qadha_monthly_calendar.dart';

class CalendarsView extends StatefulWidget {
  const CalendarsView({Key? key}) : super(key: key);

  @override
  State<CalendarsView> createState() => _CalendarsViewState();
}

class _CalendarsViewState extends State<CalendarsView> {
  bool isActionHovered = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Center(
              child: Image.asset(
            "assets/images/qadha_blue.png",
            width: 52.5,
          )),
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.purpleColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(12.5),
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.5),
              child: Column(
                children: [
                  GestureDetector(
                    onTapDown: (e) {
                      setState(() {
                        isActionHovered = true;
                      });
                    },
                    onTapUp: (e) {
                      setState(() {
                        isActionHovered = false;
                      });
                      Feedback.forTap(context);
                    },
                    onTapCancel: () {
                      setState(() {
                        isActionHovered = false;
                      });
                    },
                    child: Container(
                      color: AppTheme.purpleColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 26,
                            color: isActionHovered
                                ? AppTheme.primaryColor
                                : Colors.black,
                          ),
                          const SizedBox(width: 2.5),
                          Text("Remplir un nouveau calendrier",
                              style: TextStyle(
                                  color: isActionHovered
                                      ? AppTheme.primaryColor
                                      : Colors.black,
                                  fontSize: 15))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Column(
                      children: [0, 1, 2]
                          .map((x) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.5),
                                child: SizedBox(
                                    width: size.width / 1.2,
                                    height: size.height / 2.8,
                                    child: const QadhaMonthlyCalendar()),
                              ))
                          .toList()),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
