import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qadha/providers/calendar_provider.dart';
import 'package:qadha/providers/remaining_prayers_provider.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/calendar/qadha_calendar.dart';

import 'modals/add_calendar/add_calendar_view.dart';

// ignore: must_be_immutable
class CalendarsView extends ConsumerWidget {
  const CalendarsView({Key? key}) : super(key: key);

  void _showAddCalendarModal(BuildContext context) async {
    await showModalBottomSheet(
        barrierColor: Colors.black54,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        backgroundColor: AppTheme.primaryColor,
        builder: (ctx) => const AddCalendarModal());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calendars = ref.watch(calendarProvider);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.sp),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Center(
              child: Image.asset(
            "assets/images/qadha_blue.png",
            width: 50.sp,
          )),
          SizedBox(height: 25.sp),
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
              padding: EdgeInsets.symmetric(vertical: 18.5.sp),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      _showAddCalendarModal(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 26.sp,
                          color: Colors.black,
                        ),
                        SizedBox(width: 2.5.sp),
                        Text("Remplir un nouveau calendrier",
                            style:
                                TextStyle(color: Colors.black, fontSize: 17.sp))
                      ],
                    ),
                  ),
                  SizedBox(height: 5.sp),
                  if (calendars.isEmpty)
                    Column(
                      children: [
                        SizedBox(height: 15.sp),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.sp, vertical: 20.sp),
                          decoration: BoxDecoration(
                              color: AppTheme.primaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              FractionallySizedBox(
                                  widthFactor: 0.8,
                                  child: Text(
                                      "Pour permettre à Qadha de calculer les prières à rattraper, ajoutez des calendriers liés aux différentes périodes pendant lesquelles vous estimez ne pas avoir prié.",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontFamily: "Inter Regular",
                                          fontSize: 17.sp))),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.sp),
                      ],
                    ),
                  Column(
                      children: calendars
                          .map((calendar) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.5.sp),
                                child: Container(
                                    width: 0.9.sw,
                                    height: 0.8.sw,
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 2,
                                        blurRadius: 20,
                                        offset: Offset(0, 4.sp),
                                      ),
                                    ]),
                                    child: QadhaCalendar(
                                        calendar.start, calendar.end,
                                        key: UniqueKey(),
                                        allowDeletion: true, onDeletion: () {
                                      ref
                                          .read(calendarProvider.notifier)
                                          .deleteCalendar(calendar);

                                      final days = calendar.totalDays();
                                      ref
                                          .read(
                                              remainingPrayersProvider.notifier)
                                          .incrementWithCalendar(days,
                                              add: false);
                                    })),
                              ))
                          .toList()),
                  Column(
                    children: [
                      SizedBox(height: 17.5.sp),
                      Text("لَا يُكَلِّفُ ٱللَّهُ نَفْسًا إِلَّا وُسْعَهَا",
                          style:
                              TextStyle(fontSize: 18.sp, color: Colors.blueGrey)),
                      FractionallySizedBox(
                          widthFactor: 0.6,
                          child: Text(
                              "Allah n'impose à aucune âme une charge supérieure à sa capacité.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 12.sp,
                                  fontFamily: "Inter Regular"))),
                      SizedBox(height: 7.5.sp),
                    ],
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
