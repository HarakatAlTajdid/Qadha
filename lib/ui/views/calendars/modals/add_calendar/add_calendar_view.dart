import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qadha/models/calendar_model.dart';
import 'package:qadha/providers/remaining_prayers_provider.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/calendar/qadha_calendar.dart';
import 'package:qadha/ui/common/qadha_button.dart';

import 'state/add_calendar_viewmodel.dart';

class AddCalendarModal extends ConsumerWidget {
  const AddCalendarModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addCalendarProvider);

    return WillPopScope(
      onWillPop: () async {
        return ref.read(addCalendarProvider.notifier).reset();
      },
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
          height: 20.sp,
        ),
        Text("Ajouter un calendrier",
            style: TextStyle(
                fontSize: 18.sp,
                fontFamily: "Inter SemiBold",
                color: AppTheme.secundaryColor)),
        SizedBox(height: 10.sp),
        Divider(thickness: 0.5, color: AppTheme.deadColor),
        SizedBox(height: 5.sp),
        Container(
            width: 0.9.sw,
            height: 0.9.sw,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppTheme.deadColor.withOpacity(0.6),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 2.sp),
                ),
              ],
            ),
            child: QadhaCalendar(state.start, state.end,
            allowYearChange: true,
                allowInteraction: true, onInteraction: (day) {
              ref.read(addCalendarProvider.notifier).select(day);
            }, key: UniqueKey())),
        SizedBox(height: state.end != null ? 20.sp : 30.sp),
        if (state.calendarOverlapError)
                Padding(
                  padding: EdgeInsets.only(bottom: 12.sp),
                  child: FractionallySizedBox(
                      widthFactor: 0.85,
                      child: Text(
                          "Ce calendrier empiète sur un autre calendrier, veuillez réessayer sur une autre période.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppTheme.alertColor,
                              fontFamily: "Inter SemiBold",
                              fontSize: 14.sp))),
                ),
        if (state.end == null)
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Text(
                state.step == 1
                    ? "Choisissez le début du calendrier"
                    : "Choisissez la fin du calendrier",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "Inter Bold", fontSize: 20.sp)),
          ),
        if (state.end != null)
          Column(
            children: [
              
              SizedBox(
                  width: 0.85.sw,
                  height: 54.sp,
                  child: QadhaButton(
                      text: "Valider",
                      isLoading: state.isWorking,
                      fontSize: 22,
                      onTap: () async {
                        final added = await ref
                            .read(addCalendarProvider.notifier)
                            .addCalendar();
                        if (added) {
                          final days = CalendarModel(
                                  state.start!,
                                  state.end!)
                              .totalDays();
                          ref
                              .read(remainingPrayersProvider.notifier)
                              .incrementWithCalendar(days);

                          // ignore: use_build_context_synchronously
                          AutoRouter.of(context).pop();
                        }
                      })),
            ],
          ),
        SizedBox(height: 40.sp),
      ]),
    );
  }
}
