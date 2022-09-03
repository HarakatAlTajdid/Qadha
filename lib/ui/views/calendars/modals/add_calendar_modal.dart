import 'package:flutter/material.dart';
import 'package:qadha/models/calendar_model.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/calendar/qadha_monthly_calendar.dart';
import 'package:qadha/ui/common/qadha_button.dart';
import 'package:stacked/stacked.dart';

import 'add_calendar_viewmodel.dart';

class AddCalendarModal extends StatefulWidget {
  const AddCalendarModal(this.calendars, {Key? key}) : super(key: key);

  final List<CalendarModel> calendars;

  @override
  State<AddCalendarModal> createState() => _AddCalendarModalState();
}

class _AddCalendarModalState extends State<AddCalendarModal>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ViewModelBuilder<AddCalendarViewModel>.reactive(
      builder: (context, model, child) =>
          Column(mainAxisSize: MainAxisSize.min, children: [
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
            child: QadhaMonthlyCalendar(model.start, model.end,
                allowInteraction: true, onInteraction: (day) {
              model.select(day);
            }, key: UniqueKey())),
        SizedBox(height: model.end != null ? 20 : 30),
        if (model.end == null)
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Text(
                model.step == 1
                    ? "Choisissez le début du calendrier"
                    : "Choisissez la fin du calendrier",
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: "Inter Bold", fontSize: 20)),
          ),
        if (model.end != null)
          Column(
            children: [
              if (model.calendarOverlapError)
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
                      isLoading: model.isWorking,
                      onTap: () {
                        model.addCalendar(context);
                      })),
            ],
          ),
        const SizedBox(height: 70),
      ]),
      viewModelBuilder: () => AddCalendarViewModel(widget.calendars),
    );
  }
}
