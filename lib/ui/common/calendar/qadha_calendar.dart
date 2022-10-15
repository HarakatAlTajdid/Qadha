import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/calendar/state/qadha_calendar_viewmodel.dart';

class QadhaCalendar extends ConsumerWidget {
  const QadhaCalendar(this.selectionStart, this.selectionEnd,
      {Key? key,
      this.allowInteraction = false,
      this.onInteraction,
      this.allowDeletion = false,
      this.onDeletion})
      : super(key: key);

  final DateTime? selectionStart;
  final DateTime? selectionEnd;
  final bool allowInteraction;
  final Function(DateTime)? onInteraction;
  final bool allowDeletion;
  final Function()? onDeletion;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final itemWidth = (size.width - 20) / 7;

    const tableDescriptorStyle = TextStyle(fontFamily: "Inter Regular");

    final state = ref.watch(qadhaCalendarProvider);

    return Container(
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
                                ref
                                    .read(qadhaCalendarProvider.notifier)
                                    .setFrame(-1);
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(7.5),
                                  child: Row(
                                    children: [
                                      if (selectionEnd != null &&
                                          (state.currentFrame.year >
                                                  selectionEnd!.year ||
                                              (state.currentFrame.year ==
                                                      selectionEnd!.year &&
                                                  state.currentFrame.month >
                                                      selectionEnd!.month)))
                                        Container(
                                            width: 7.5,
                                            height: 7.5,
                                            decoration: BoxDecoration(
                                                color: AppTheme.secundaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        360))),
                                      const SizedBox(width: 9),
                                      Icon(Icons.arrow_back_ios,
                                          color: AppTheme.metallicColor,
                                          size: 15),
                                    ],
                                  ))),
                        ),
                        Text(
                            ref
                                .read(qadhaCalendarProvider.notifier)
                                .prettyCurrentFrame()
                                .toUpperCase(),
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Inter Regular",
                                color: AppTheme.metallicColor)),
                        Material(
                          color: AppTheme.primaryColor,
                          child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () {
                                ref
                                    .read(qadhaCalendarProvider.notifier)
                                    .setFrame(1);
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(7.5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_forward_ios,
                                          color: AppTheme.metallicColor,
                                          size: 15),
                                      const SizedBox(width: 5),
                                      if (selectionStart != null &&
                                          (state.currentFrame.year <
                                                  selectionStart!.year ||
                                              (state.currentFrame.year ==
                                                      selectionStart!.year &&
                                                  state.currentFrame.month <
                                                      selectionStart!.month)))
                                        Container(
                                            width: 7.5,
                                            height: 7.5,
                                            decoration: BoxDecoration(
                                                color: AppTheme.secundaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        360))),
                                    ],
                                  ))),
                        ),
                      ],
                    ),
                  ),
                ),
                if (allowDeletion)
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Material(
                        child: InkWell(
                            onTap: onDeletion,
                            borderRadius: BorderRadius.circular(360),
                            child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: Icon(
                                  Icons.close_rounded,
                                  color: AppTheme.metallicColor,
                                  size: 22,
                                )))),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                  thickness: 1.25, color: AppTheme.deadColor.withOpacity(0.6)),
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
                  children: List.generate(state.days.length, (index) {
                    final day = state.days[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Stack(children: [
                        if (selectionStart != null &&
                                selectionEnd != null &&
                                day == selectionStart ||
                            day == selectionEnd)
                          Row(
                            mainAxisAlignment: day == selectionStart
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: itemWidth / 2,
                                  color: AppTheme.purpleColor.withOpacity(0.5)),
                            ],
                          ),
                        if (selectionStart != null &&
                            selectionEnd != null &&
                            day.difference(selectionStart!).inDays > 0 &&
                            day.difference(selectionEnd!).inDays < 0)
                          Container(
                              color: AppTheme.purpleColor.withOpacity(0.5)),
                        Center(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(360),
                              splashColor:
                                  AppTheme.secundaryColor.withOpacity(0.5),
                              onTap: allowInteraction
                                  ? () => onInteraction!(day)
                                  : null,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                constraints: const BoxConstraints(minWidth: 27),
                                decoration:
                                    day == selectionStart || day == selectionEnd
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
                                        color: day == selectionStart ||
                                                day == selectionEnd
                                            ? AppTheme.primaryColor
                                            : day.month !=
                                                    state.currentFrame.month
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
        ));
  }
}
