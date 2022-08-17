import 'package:flutter/material.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:stacked/stacked.dart';

import 'qadha_monthly_calendar_viewmodel.dart';

class QadhaMonthlyCalendar extends StatefulWidget {
  const QadhaMonthlyCalendar({Key? key}) : super(key: key);

  @override
  State<QadhaMonthlyCalendar> createState() => _QadhaMonthlyCalendarState();
}

class _QadhaMonthlyCalendarState extends State<QadhaMonthlyCalendar> {
  @override
  Widget build(BuildContext context) {
    const tableDescriptorStyle = TextStyle(fontFamily: "Inter Regular");

    return ViewModelBuilder<QadhaMonthlyCalendarViewModel>.reactive(
        builder: (context, model, child) => Container(
            decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
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
                                child: Icon(Icons.arrow_back_ios,
                                    color: AppTheme.metallicColor, size: 15))),
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
                                child: Icon(Icons.arrow_forward_ios,
                                    color: AppTheme.metallicColor, size: 15))),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                      thickness: 1.25,
                      color: AppTheme.deadColor.withOpacity(0.6)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                const SizedBox(height: 12.5),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.count(
                      childAspectRatio: 1.45,
                      crossAxisCount: 7,
                      physics: const NeverScrollableScrollPhysics(),
                      children: List.generate(model.days.length, (index) {
                        final day = model.days[index];
                        return Text(
                          day.day.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(color: day.month != model.currentFrame.month ? AppTheme.metallicColor : Colors.black)
                        );
                      }),
                    ),
                  ),
                )
              ],
            )),
        viewModelBuilder: () => QadhaMonthlyCalendarViewModel());
  }
}
