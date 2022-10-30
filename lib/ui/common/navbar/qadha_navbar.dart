import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qadha/ui/app/app_theme.dart';

import 'qadha_navbar_item.dart';

class QadhaNavbar extends StatefulWidget {
  const QadhaNavbar(
      {Key? key,
      required this.initialIndex,
      required this.onSelectionChanged,
      required this.items})
      : super(key: key);

  final int initialIndex;
  final List<QadhaNavbarItem> items;
  final Function(int) onSelectionChanged;

  @override
  State<QadhaNavbar> createState() => _QadhaNavbarState();
}

class _QadhaNavbarState extends State<QadhaNavbar> {
  late QadhaNavbarItem selectedItem;

  @override
  void initState() {
    selectedItem = widget.items[widget.initialIndex];
    super.initState();
  }

  Widget _buildItem(QadhaNavbarItem item) {
    return Container(
      width: 1.sw / widget.items.length,
      height: 100.sp,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: selectedItem.label == item.label
                      ? AppTheme.secundaryColor
                      : AppTheme.primaryColor,
                  width: 4.sp))),
      child: Padding(
          padding: EdgeInsets.only(bottom: 40.sp, top: 10.sp),
          child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                setState(() {
                  selectedItem = item;
                });
                widget.onSelectionChanged(item.index);
              },
              child: Center(
                child: SizedBox(
                  width: 40.sp,
                  height: item.label == "Trophées" ? 32.sp : 25.sp,
                  child: SvgPicture.asset(item.assetPath, fit: BoxFit.contain)),
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.items.map(_buildItem).toList());
  }
}
