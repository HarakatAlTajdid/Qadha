import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width / widget.items.length,
      height: 100,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: selectedItem.label == item.label
                      ? AppTheme.secundaryColor
                      : AppTheme.primaryColor,
                  width: 3))),
      child: Padding(
          padding: const EdgeInsets.only(bottom: 40, top: 10),
          child: InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () {
                setState(() {
                  selectedItem = item;
                });
                widget.onSelectionChanged(item.index);
              },
              child: SvgPicture.asset(item.assetPath, fit: BoxFit.none))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.items.map(_buildItem).toList());
  }
}
