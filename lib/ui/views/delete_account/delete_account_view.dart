import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qadha/models/welcome/phone_registration.dart';
import 'package:qadha/ui/app/app_router.gr.dart';
import 'package:qadha/ui/app/app_theme.dart';
import 'package:qadha/ui/common/qadha_button.dart';
import 'package:qadha/ui/views/delete_account/state/delete_account_viewmodel.dart';
import 'package:qadha/ui/views/welcome/account_box_view.dart';

class DeleteAccountView extends ConsumerWidget {
  DeleteAccountView({Key? key}) : super(key: key);

  final TextEditingController _codeController =
      TextEditingController(text: "33");
  final TextEditingController _numController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(deleteAccountProvider);

    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppTheme.primaryColor,
        child: SizedBox(
          height: 475.sp,
          child: Center(
            child: SizedBox(
              height: 360.sp,
              child: AccountBoxView(
                title: "Pour continuer, confirmez votre identité",
                subtitle: "Toutes vos données seront effacées",
                redSubtitle: true,
                codeController: _codeController,
                numController: _numController,
                passwordController: _passwordController,
                interactiveText: "",
                onInteractiveTap: (e) {},
                confirmWidget: Column(
                  children: [
                     SizedBox(height: 5.sp),
                    if (state.formHasError)
                      Column(
                        children: [
                           SizedBox(height: 5.sp),
                          Text(state.errorMessage,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppTheme.alertColor,
                                  fontSize: 14.sp,
                                  fontFamily: "Inter Regular")),
                        ],
                      ),
                     SizedBox(height: 12.5.sp),
                    SizedBox(
                        height: 53.5.sp,
                        child: QadhaButton(
                            text: "Valider la suppression",
                            fontSize: 16,
                            isLoading: state.isWorking,
                            onTap: () async {
                              final registration = PhoneRegistration(
                                  _codeController.text,
                                  _numController.text,
                                  _passwordController.text);

                              if (await ref
                                  .read(deleteAccountProvider.notifier)
                                  .deleteUser(registration)) {
                                Navigator.pop(context);
                                AutoRouter.of(context).replace(
                                    RegisterRoute(checkSession: false));
                              }
                            })),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
