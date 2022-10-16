import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qadha/ui/app/app_router.gr.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/qadha_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({Key? key}) : super(key: key);

  Widget _buildTile(String iconName, String text, {Function()? onTap}) {
    return Opacity(
      opacity: onTap == null ? 0.6 : 1,
      child: Material(
        child: InkWell(
          splashColor: AppTheme.deadColor,
          onTap: onTap,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 17.5, right: 20, bottom: 2.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.85,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                            "assets/images/icons/blue/$iconName.svg"),
                        Expanded(
                            child: Center(
                                child: Text(text,
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontFamily: "Inter Regular"))))
                      ],
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.75,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Center(
            child: Image.asset(
          "assets/images/qadha_blue.png",
          width: 52.5,
        )),
        SizedBox(height: size.height / 16),
        SizedBox(
          height: size.height / 3,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTile("bell", "Notifications (wip...)"),
                _buildTile("u", "Mentions légales", onTap: () async {
                  const tosUrl =
                      "https://firebasestorage.googleapis.com/v0/b/qadha-bad5c.appspot.com/o/TOS.html?alt=media";
                  await launchUrl(Uri.parse(tosUrl));
                }),
                //_buildTile("cog", "Mises à jour"),
                _buildTile("about", "À propos de Qadha", onTap: () async {
                  const repoUrl = "https://github.com/HarakatAlTajdid/Qadha#readme";
                  await launchUrl(Uri.parse(repoUrl));
                }),
              ]),
        ),
        const Spacer(),
        FractionallySizedBox(
            widthFactor: 0.9,
            child: QadhaButton(
                text: "Se déconnecter",
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                  // ignore: use_build_context_synchronously
                  AutoRouter.of(context)
                      .replace(RegisterRoute(checkSession: false));
                })),
        const SizedBox(height: 30)
      ]),
    );
  }
}
