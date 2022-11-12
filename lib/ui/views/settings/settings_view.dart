import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qadha/ui/app/app_router.gr.dart';
import 'package:qadha/ui/common/qadha_button.dart';
import 'package:qadha/ui/views/delete_account/delete_account_view.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({Key? key}) : super(key: key);

  Widget _buildTile(String iconName, String text, {Function()? onTap}) {
    return Opacity(
      opacity: onTap == null ? 0.6 : 1,
      child: Material(
        child: InkWell(
          splashColor: Colors.blue.shade100,
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.only(
                left: 20.sp, top: 17.5.sp, right: 20.sp, bottom: 2.5.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: FractionallySizedBox(
                    widthFactor: 0.85,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20.sp,
                          height: 20.sp,
                          child: SvgPicture.asset(
                              "assets/images/icons/blue/$iconName.svg"),
                        ),
                        Expanded(
                            child: Center(
                                child: Text(text,
                                    style: TextStyle(
                                        fontSize: 18.5.sp,
                                        fontFamily: "Inter Regular"))))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 4.sp),
                Divider(
                  thickness: 1.75.sp,
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
      padding: EdgeInsets.symmetric(vertical: 20.sp),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Center(
            child: Image.asset(
          "assets/images/qadha_blue.png",
          width: 50.sp,
        )),
        SizedBox(height: 12.5.sp),
        Text("Une initiative de Hira Islam", style: TextStyle(fontSize: 14.sp)),
        const Spacer(flex: 1),
        SizedBox(
          height: size.height / 3,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTile("bell", "Notifications (bientôt)"),
                _buildTile("u", "Mentions légales", onTap: () async {
                  const tosUrl =
                      "https://firebasestorage.googleapis.com/v0/b/qadha-bad5c.appspot.com/o/TOS.html?alt=media";
                  await launchUrl(Uri.parse(tosUrl));
                }),
                _buildTile("about", "À propos de Qadha", onTap: () async {
                  const repoUrl =
                      "https://github.com/HarakatAlTajdid/Qadha#readme";
                  await launchUrl(Uri.parse(repoUrl));
                }),
                _buildTile("warning", "Supprimer mon compte", onTap: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DeleteAccountView();
                      });
                }),
              ]),
        ),
        const Spacer(flex: 2),
        FractionallySizedBox(
            widthFactor: 0.9,
            child: QadhaButton(
                text: "Se déconnecter",
                fontSize: 16,
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pop(context);
                  AutoRouter.of(context)
                      .replace(RegisterRoute(checkSession: false));
                })),
        SizedBox(height: 15.sp),
        if (FirebaseAuth.instance.currentUser != null)
          SelectableText("Code utilisateur : ${FirebaseAuth.instance.currentUser!.uid}",
              style: TextStyle(fontSize: 14.sp)),
        SizedBox(height: 15.sp)
      ]),
    );
  }
}
