import 'package:flutter/material.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:stacked/stacked.dart';

import 'qadha_monthly_calendar_viewmodel.dart';

class QadhaMonthlyCalendar extends StatefulWidget {
  const QadhaMonthlyCalendar(this.selectionStart, this.selectionEnd,
      {Key? key, this.allowInteraction = false, this.onInteraction, this.allowDeletion = false, this.onDeletion})
      : super(key: key);

  final DateTime? selectionStart;
  final DateTime? selectionEnd;
  final bool allowInteraction;
  final Function(DateTime)? onInteraction;
  final bool allowDeletion;
  final Function()? onDeletion;

  @override
  State<QadhaMonthlyCalendar> createState() => _QadhaMonthlyCalendarState();
}

class _QadhaMonthlyCalendarState extends State<QadhaMonthlyCalendar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemWidth = (size.width - 20) / 7;

    const tableDescriptorStyle = TextStyle(fontFamily: "Inter Regular");

    return ViewModelBuilder<QadhaMonthlyCalendarViewModel>.reactive(
        builder: (context, model, child) => Container(
            decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              color: AppTheme.primaryColor,
                              child: InkWell(
                                  customBorder: const CircleBorder(),
                                  onTap: () {
                                    model.setFrame(-1);
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.all(7.5),
                                      child: Row(
                                        children: [
                                          if (model.selectionEnd != null &&
                                              model.currentFrame.month >
                                                  model.selectionEnd!.month)
                                            Container(
                                                width: 7.5,
                                                height: 7.5,
                                                decoration: BoxDecoration(
                                                    color: AppTheme.secundaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(360))),
                                          const SizedBox(width: 9),
                                          Icon(Icons.arrow_back_ios,
                                              color: AppTheme.metallicColor,
                                              size: 15),
                                        ],
                                      ))),
                            ),
                            Text(model.prettyCurrentFrame().toUpperCase(),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Inter Regular",
                                    color: AppTheme.metallicColor)),
                            Material(
                              color: AppTheme.primaryColor,
                              child: InkWell(
                                  customBorder: const CircleBorder(),
                                  onTap: () {
                                    model.setFrame(1);
                                  },
                                  child: Padding(
                                      padding: const EdgeInsets.all(7.5),
                                      child: Row(
                                        children: [
                                          Icon(Icons.arrow_forward_ios,
                                              color: AppTheme.metallicColor,
                                              size: 15),
                                          const SizedBox(width: 5),
                                          if (model.selectionStart != null &&
                                              model.currentFrame.month <
                                                  model.selectionStart!.month)
                                            Container(
                                                width: 7.5,
                                                height: 7.5,
                                                decoration: BoxDecoration(
                                                    color: AppTheme.secundaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(360))),
                                        ],
                                      ))),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (widget.allowDeletion)
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Material(
                          child: InkWell(
                            onTap: widget.onDeletion,
                            borderRadius: BorderRadius.circular(360),
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Icon(Icons.close_rounded, color: AppTheme.metallicColor, size: 22,)))),
                      )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                      thickness: 1.25,
                      color: AppTheme.deadColor.withOpacity(0.6)),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text("LUN", style: tableDescriptorStyle),
                      Text("MAR", style: tableDescriptorStyle),
                      Text("MER", style: tableDescriptorStyle),
                      Text("JEU", style: tableDescriptorStyle),
                      Text("VEN", style: tableDescriptorStyle),
                      Text("SAM", style: tableDescriptorStyle),
                      Text("DIM", style: tableDescriptorStyle),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.count(
                      childAspectRatio: 1.45,
                      crossAxisCount: 7,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(model.days.length, (index) {
                        final day = model.days[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Stack(children: [
                            if (model.selectionStart != null &&
                                    model.selectionEnd != null &&
                                    day == model.selectionStart ||
                                day == model.selectionEnd)
                              Row(
                                mainAxisAlignment: day == model.selectionStart
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Container(
                                      width: itemWidth / 2,
                                      color: AppTheme.purpleColor
                                          .withOpacity(0.5)),
                                ],
                              ),
                            if (model.selectionStart != null &&
                                model.selectionEnd != null &&
                                day.difference(model.selectionStart!).inDays >
                                    0 &&
                                day.difference(model.selectionEnd!).inDays < 0)
                              Container(
                                  color: AppTheme.purpleColor.withOpacity(0.5)),
                            Center(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(360),
                                  splashColor:
                                      AppTheme.secundaryColor.withOpacity(0.5),
                                  onTap: widget.allowInteraction
                                      ? () {
                                          widget.onInteraction!(day);
                                        }
                                      : null,
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    constraints:
                                        const BoxConstraints(minWidth: 27),
                                    decoration: day == model.selectionStart ||
                                            day == model.selectionEnd
                                        ? BoxDecoration(
                                            color: AppTheme.secundaryColor,
                                            borderRadius:
                                                BorderRadius.circular(360))
                                        : null,
                                    child: Text(day.day.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "Inter SemiBold",
                                            fontSize: 13,
                                            color: day ==
                                                        model.selectionStart ||
                                                    day == model.selectionEnd
                                                ? AppTheme.primaryColor
                                                : day.month !=
                                                        model.currentFrame.month
                                                    ? AppTheme.deadColor
                                                    : AppTheme.metallicColor)),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        );
                      }),
                    ),
                  ),
                )
              ],
            )),
        viewModelBuilder: () => QadhaMonthlyCalendarViewModel(
            widget.selectionStart, widget.selectionEnd));
  }
}
