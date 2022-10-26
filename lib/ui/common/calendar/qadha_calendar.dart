import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:qadha/ui/app/app_theme.dart';

class QadhaCalendar extends StatefulWidget {
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
  State<QadhaCalendar> createState() => _QadhaCalendarState();
}

class _QadhaCalendarState extends State<QadhaCalendar> {
  late DateTime currentFrame;
  late List<DateTime> days; // 42 days needed

  @override
  void initState() {
    if (widget.selectionEnd == null) {
      if (widget.selectionStart == null) {
        currentFrame = DateTime(DateTime.now().year, DateTime.now().month);
      } else {
        currentFrame =
            DateTime(widget.selectionStart!.year, widget.selectionStart!.month);
      }
    } else {
      currentFrame =
          DateTime(widget.selectionEnd!.year, widget.selectionEnd!.month);
    }

    days = [];
    retrieveCurrentFrame();
    super.initState();
  }

  String prettyCurrentFrame() {
    return DateFormat("MMMM yyyy", "fr_fr").format(currentFrame);
  }

  void setFrame(int increment) {
    currentFrame = DateTime(currentFrame.year, currentFrame.month + increment);
    retrieveCurrentFrame();
  }

  // Retrieves a list of 42 days to be displayed for current frame
  void retrieveCurrentFrame() {
    days.clear();

    final currentFrameDaysCount =
        DateTime(currentFrame.year, currentFrame.month + 1, 0).day;
    final currentFrameFirstDay =
        DateTime.utc(currentFrame.year, currentFrame.month, 1).weekday;

    // First day is not Monday, generate the preceeding days from
    // the preceeding frame, like a visual padding
    if (currentFrameFirstDay != 1) {
      for (int i = 1; i < currentFrameFirstDay; i++) {
        final day =
            currentFrame.subtract(Duration(days: currentFrameFirstDay - i));
        days.add(day);
      }
    }

    for (int i = 1; i <= currentFrameDaysCount; i++) {
      final day = DateTime(currentFrame.year, currentFrame.month, i);
      days.add(day);
    }

    if (days.length < 42) {
      final missingDaysCount = 42 - days.length;
      for (int i = 0; i < missingDaysCount; i++) {
        final day =
            DateTime(days.last.year, days.last.month, days.last.day + 1);
        days.add(day);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itemWidth = (size.width - 20) / 7;

    const tableDescriptorStyle = TextStyle(fontFamily: "Inter Regular");

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
                                setFrame(-1);
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(7.5),
                                  child: Row(
                                    children: [
                                      if (widget.selectionEnd != null &&
                                          (currentFrame.year >
                                                  widget.selectionEnd!.year ||
                                              (currentFrame.year ==
                                                      widget
                                                          .selectionEnd!.year &&
                                                  currentFrame.month >
                                                      widget.selectionEnd!
                                                          .month)))
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
                        Text(prettyCurrentFrame().toUpperCase(),
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Inter Regular",
                                color: AppTheme.metallicColor)),
                        Material(
                          color: AppTheme.primaryColor,
                          child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () {
                                setFrame(1);
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(7.5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_forward_ios,
                                          color: AppTheme.metallicColor,
                                          size: 15),
                                      const SizedBox(width: 5),
                                      if (widget.selectionStart != null &&
                                          (currentFrame.year <
                                                  widget.selectionStart!.year ||
                                              (currentFrame.year ==
                                                      widget.selectionStart!
                                                          .year &&
                                                  currentFrame.month <
                                                      widget.selectionStart!
                                                          .month)))
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
                if (widget.allowDeletion)
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Material(
                        child: InkWell(
                            onTap: widget.onDeletion,
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
                  children: List.generate(days.length, (index) {
                    final day = days[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Stack(children: [
                        if (widget.selectionStart != null &&
                                widget.selectionEnd != null &&
                                day == widget.selectionStart ||
                            day == widget.selectionEnd)
                          Row(
                            mainAxisAlignment: day == widget.selectionStart
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: itemWidth / 2,
                                  color: AppTheme.purpleColor.withOpacity(0.5)),
                            ],
                          ),
                        if (widget.selectionStart != null &&
                            widget.selectionEnd != null &&
                            day.difference(widget.selectionStart!).inDays > 0 &&
                            day.difference(widget.selectionEnd!).inDays < 0)
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
                                  ? () => widget.onInteraction!(day)
                                  : null,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                constraints: const BoxConstraints(minWidth: 27),
                                decoration: day == widget.selectionStart ||
                                        day == widget.selectionEnd
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
                                        color: day == widget.selectionStart ||
                                                day == widget.selectionEnd
                                            ? AppTheme.primaryColor
                                            : day.month != currentFrame.month
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
