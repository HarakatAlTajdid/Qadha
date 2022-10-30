import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:qadha/ui/app/app_theme.dart';

class QadhaCalendar extends StatefulWidget {
  const QadhaCalendar(this.selectionStart, this.selectionEnd,
      {Key? key,
      this.allowYearChange = false,
      this.allowInteraction = false,
      this.onInteraction,
      this.allowDeletion = false,
      this.onDeletion})
      : super(key: key);

  final DateTime? selectionStart;
  final DateTime? selectionEnd;
  final bool allowYearChange;
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
    final highlighterHeight = 27.5.sp;

    final tableDescriptorStyle = TextStyle(fontFamily: "Inter Regular", fontSize: 13.sp);

    return Container(
        decoration: BoxDecoration(
            color: AppTheme.primaryColor,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            SizedBox(height: 15.sp),
            if (widget.allowYearChange)
              Padding(
                padding: EdgeInsets.only(bottom: 2.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 17.5.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Material(
                              color: AppTheme.primaryColor,
                              child: InkWell(
                                  customBorder: const CircleBorder(),
                                  onTap: () {
                                    setFrame(-12);
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.all(7.5.sp),
                                      child: Row(
                                        children: [
                                          if (widget.selectionEnd != null &&
                                              (currentFrame.year >
                                                      widget
                                                          .selectionEnd!.year))
                                            Container(
                                                width: 7.5.sp,
                                                height: 7.5.sp,
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppTheme.secundaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            360))),
                                          SizedBox(width: 9.sp),
                                          Icon(Icons.arrow_back_ios,
                                              color: AppTheme.metallicColor,
                                              size: 15.sp),
                                        ],
                                      ))),
                            ),
                            Text(DateFormat("yyyy").format(currentFrame),
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily: "Inter Regular",
                                    color: AppTheme.metallicColor)),
                            Material(
                              color: AppTheme.primaryColor,
                              child: InkWell(
                                  customBorder: const CircleBorder(),
                                  onTap: () {
                                    setFrame(12);
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.all(7.5.sp),
                                      child: Row(
                                        children: [
                                          Icon(Icons.arrow_forward_ios,
                                              color: AppTheme.metallicColor,
                                              size: 15.sp),
                                          SizedBox(width: 5.sp),
                                          if (widget.selectionStart != null &&
                                              (currentFrame.year <
                                                      widget.selectionStart!
                                                          .year))
                                            Container(
                                                width: 7.5.sp,
                                                height: 7.5.sp,
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppTheme.secundaryColor,
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
                  ],
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 17.5.sp),
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
                                  padding: EdgeInsets.all(7.5.sp),
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
                                            width: 7.5.sp,
                                            height: 7.5.sp,
                                            decoration: BoxDecoration(
                                                color: AppTheme.secundaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        360))),
                                      SizedBox(width: 9.sp),
                                      Icon(Icons.arrow_back_ios,
                                          color: AppTheme.metallicColor,
                                          size: 15.sp),
                                    ],
                                  ))),
                        ),
                        Text(
                            DateFormat(widget.allowYearChange ? "MMMM" : "MMMM yyyy", "fr_fr")
                                .format(currentFrame)
                                .toUpperCase(),
                            style: TextStyle(
                                fontSize: 15.sp,
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
                                  padding: EdgeInsets.all(7.5.sp),
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_forward_ios,
                                          color: AppTheme.metallicColor,
                                          size: 15.sp),
                                      SizedBox(width: 5.sp),
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
                                            width: 7.5.sp,
                                            height: 7.5.sp,
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
                    padding: EdgeInsets.only(right: 20.sp),
                    child: Material(
                      color: AppTheme.primaryColor,
                        child: InkWell(
                            onTap: widget.onDeletion,
                            borderRadius: BorderRadius.circular(360),
                            child: Padding(
                                padding: EdgeInsets.all(3.sp),
                                child: Icon(
                                  Icons.close_rounded,
                                  color: AppTheme.metallicColor,
                                  size: 22.sp,
                                )))),
                  )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.sp),
              child: Divider(
                  thickness: 1.25, color: AppTheme.deadColor.withOpacity(0.6)),
            ),
            Padding(
              padding: EdgeInsets.all(10.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
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
            SizedBox(height: 5.sp),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                child: GridView.count(
                  childAspectRatio: 1.45,
                  crossAxisCount: 7,
                  physics: const NeverScrollableScrollPhysics(),
                  children: List.generate(days.length, (index) {
                    final day = days[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.sp),
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
                              Center(
                                child: Container(
                                    width: itemWidth / 2,
                                    height: highlighterHeight,
                                    color: AppTheme.purpleColor.withOpacity(0.5)),
                              ),
                            ],
                          ),
                        if (widget.selectionStart != null &&
                            widget.selectionEnd != null &&
                            day.difference(widget.selectionStart!).inDays > 0 &&
                            day.difference(widget.selectionEnd!).inDays < 0)
                          Center(
                            child: Container(
                                height: highlighterHeight,
                                color: AppTheme.purpleColor.withOpacity(0.5)),
                          ),
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
                                padding: EdgeInsets.all(6.sp),
                                constraints: BoxConstraints(minWidth: 27.sp),
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
                                        fontSize: 13.sp,
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
