import 'package:flutter/material.dart';
import 'package:qadha/models/calendar_model.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/calendar/qadha_monthly_calendar.dart';
import 'package:stacked/stacked.dart';

import 'calendars_viewmodel.dart';
import 'modals/add_calendar_modal.dart';

class CalendarsView extends StatefulWidget {
  const CalendarsView({Key? key}) : super(key: key);

  @override
  State<CalendarsView> createState() => _CalendarsViewState();
}

class _CalendarsViewState extends State<CalendarsView> {
  late final CalendarsViewModel _viewModel;
  bool isActionHovered = false;

  void _showAddCalendarModal() async {
    if (_viewModel.isWorking) {
      return;
    }

    await showModalBottomSheet(
        barrierColor: Colors.black54,
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        backgroundColor: AppTheme.primaryColor,
        builder: (ctx) => AddCalendarModal(_viewModel.calendars));
    //widget.closetVm.loadSneakers();
    _viewModel.loadCalendars();
  }

  @override
  void initState() {
    _viewModel = CalendarsViewModel();
    _viewModel.loadCalendars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ViewModelBuilder<CalendarsViewModel>.reactive(
      builder: (context, model, child) => SingleChildScrollView(
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
                child: model.isWorking
                    ? const Center(
                      child: Text("Chargement des calendriers...",
                          style: TextStyle(fontSize: 16, fontFamily: "Inter Regular")),
                    )
                    : Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showAddCalendarModal();
                              //model.calendarsService.addCalendar(CalendarModel(
                              //    DateTime(2022, 08, 22), DateTime(2022, 08, 28)));
                            },
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
                          if (model.calendars.isEmpty)
                            Column(
                              children: [
                                const SizedBox(height: 15),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 20),
                                  decoration: BoxDecoration(
                                      color: AppTheme.primaryColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: const [
                                      FractionallySizedBox(
                                          widthFactor: 0.8,
                                          child: Text(
                                              "Pour permettre à l'application de calculer les prières à rattraper, ajoutez des calendriers liés aux différentes périodes pendant lesquelles vous estimez ne pas avoir prié.",
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  fontFamily: "Inter Regular",
                                                  fontSize: 17))),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                          Column(
                              children: model.calendars
                                  .map((calendar) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.5),
                                        child: SizedBox(
                                            width: size.width / 1.2,
                                            height: size.height / 2.8,
                                            child: QadhaMonthlyCalendar(
                                                calendar.start, calendar.end,
                key: UniqueKey(),
                                                allowDeletion: true,
                                                onDeletion: () {
                                                  model.deleteCalendar(calendar);
                                                })),
                                      ))
                                  .toList()),
                          Column(
                            children: const [
                              SizedBox(height: 17.5),
                              Text(
                                  "لَا يُكَلِّفُ ٱللَّهُ نَفْسًا إِلَّا وُسْعَهَا",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.blueGrey)),
                              FractionallySizedBox(
                                  widthFactor: 0.6,
                                  child: Text(
                                      "Allah n'impose à aucune âme une charge supérieure à sa capacité.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 12,
                                          fontFamily: "Inter Regular"))),
                              SizedBox(height: 7.5),
                            ],
                          )
                        ],
                      ),
              ),
            )
          ]),
        ),
      ),
      viewModelBuilder: () => _viewModel,
    );
  }
}
