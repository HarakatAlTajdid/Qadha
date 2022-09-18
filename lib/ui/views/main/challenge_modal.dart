import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/qadha_button.dart';

class ChallengeModal extends StatefulWidget {
  const ChallengeModal({required this.newLevel, required this.onAccept, Key? key}) : super(key: key);

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
            height: 315,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bravo! (Niveau ${widget.newLevel})",
                      style:
                          const TextStyle(fontSize: 24, fontFamily: "Inter Regular")),
                  const SizedBox(height: 12.5),
                  const Text(
                      "Grâce à vos efforts, vous venez de débloquer le niveau supérieur !\nVous avez débloqué une nouvelle sagesse : lisez la maintenant, ou plus tard en cliquant sur le trophée en bas au centre de l'écran.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 15.5, fontFamily: "Inter Regular")),
                  const SizedBox(height: 27.5),
                  Row(
                    children: [
                      Expanded(
                          child: Opacity(
                              opacity: 0.65,
                              child: QadhaButton(
                                  text: "PLUS TARD",
                                  onTap: () {
                                    Navigator.pop(context);
                                  }))),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(child: QadhaButton(text: "LIRE", onTap: () {
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
