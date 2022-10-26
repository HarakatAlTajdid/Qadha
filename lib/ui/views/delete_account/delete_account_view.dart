import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    final size = MediaQuery.of(context).size;

    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppTheme.primaryColor,
        child: SizedBox(
          height: 440,
          child: Center(
            child: SizedBox(
              height: 370,
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
                    const SizedBox(height: 5),
                    if (state.formHasError)
                      Column(
                        children: [
                          const SizedBox(height: 5),
                          Text(state.errorMessage,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppTheme.alertColor,
                                  fontSize: 14,
                                  fontFamily: "Inter Regular")),
                        ],
                      ),
                    const SizedBox(height: 15),
                    SizedBox(
                        height: 53.5,
                        child: QadhaButton(
                            text: "Valider la suppression",
                            fontSize: 18.5,
                            isLoading: state.isWorking,
                            onTap: () async {
                              final registration = PhoneRegistration(
                                  _codeController.text,
                                  _numController.text,
                                  _passwordController.text);

                              if (await ref
                                  .read(deleteAccountProvider.notifier)
                                  .deleteUser(registration)) {
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                // ignore: use_build_context_synchronously
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
