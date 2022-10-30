import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/qadha_button.dart';

class ChallengeModal extends StatefulWidget {
  const ChallengeModal(
      {required this.newLevel, required this.onAccept, Key? key})
      : super(key: key);

  final int newLevel;
  final Function() onAccept;

  @override
  State<ChallengeModal> createState() => _ChallengeModalState();
}

class _ChallengeModalState extends State<ChallengeModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: AppTheme.primaryColor,
        child: SizedBox(
            height: 315.sp,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bravo! (Niveau ${widget.newLevel})",
                      style: TextStyle(
                          fontSize: 24.sp, fontFamily: "Inter Regular")),
                  SizedBox(height: 12.5.sp),
                  Text(
                      "Grâce à vos efforts, vous venez de débloquer le niveau supérieur !\nVous avez débloqué une nouvelle sagesse : lisez la maintenant, ou plus tard en cliquant sur le trophée en bas au centre de l'écran.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 15.5.sp, fontFamily: "Inter Regular")),
                  SizedBox(height: 27.5.sp),
                  Row(
                    children: [
                      Expanded(
                          child: Opacity(
                              opacity: 0.7,
                              child: QadhaButton(
                                  text: "PLUS TARD",
                                  fontSize: 17.sp,
                                  onTap: () {
                                    Navigator.pop(context);
                                  }))),
                      SizedBox(
                        width: 5.sp,
                      ),
                      Expanded(
                          child: QadhaButton(
                              text: "LIRE",
                              fontSize: 17.sp,
                              onTap: () {
                                Navigator.pop(context);
                                widget.onAccept();
                              })),
                    ],
                  ),
                ],
              ),
            )));
  }
}
