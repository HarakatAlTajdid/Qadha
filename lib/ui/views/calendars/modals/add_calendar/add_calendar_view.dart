import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/calendar/qadha_monthly_calendar.dart';
import 'package:qadha/ui/common/qadha_button.dart';

import 'state/add_calendar_viewmodel.dart';

class AddCalendarModal extends ConsumerWidget {
  const AddCalendarModal({Key? key}) : super(key: key);

@override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    
    final state = ref.watch(addCalendarProvider);

    return WillPopScope(
      onWillPop: () async {
        return ref.read(addCalendarProvider.notifier).reset();
      },
      child: Column(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(
              height: 20,
            ),
            Text("Ajouter un calendrier",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Inter SemiBold",
                    color: AppTheme.secundaryColor)),
            const SizedBox(height: 10),
            Divider(thickness: 0.5, color: AppTheme.deadColor),
            const SizedBox(height: 5),
            Container(
                width: size.width / 1.1,
                height: size.height / 2.6,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.deadColor.withOpacity(0.6),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: QadhaMonthlyCalendar(state.start, state.end,
                    allowInteraction: true, onInteraction: (day) {
                  ref.read(addCalendarProvider.notifier).select(day);
                }, key: UniqueKey())),
            SizedBox(height: state.end != null ? 20 : 30),
            if (state.end == null)
              FractionallySizedBox(
                widthFactor: 0.9,
                child: Text(
                    state.step == 1
                        ? "Choisissez le début du calendrier"
                        : "Choisissez la fin du calendrier",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontFamily: "Inter Bold", fontSize: 20)),
              ),
            if (state.end != null)
              Column(
                children: [
                  if (state.calendarOverlapError)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.5),
                      child: FractionallySizedBox(
                          widthFactor: 0.85,
                          child: Text(
                              "Ce calendrier empiète sur un autre calendrier, veuillez le corriger avant de continuer",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppTheme.alertColor,
                                  fontFamily: "Inter SemiBold"))),
                    ),
                  SizedBox(
                      width: size.width / 1.15,
                      height: 52.5,
                      child: QadhaButton(
                          text: "Valider",
                          isLoading: state.isWorking,
                          onTap: () async {
                            final added = await ref.read(addCalendarProvider.notifier).addCalendar();
                            if (added) {
                              // ignore: use_build_context_synchronously
                              AutoRouter.of(context).pop();
                            }
                          })),
                ],
              ),
            const SizedBox(height: 70),
          ]),
    );
  }
}