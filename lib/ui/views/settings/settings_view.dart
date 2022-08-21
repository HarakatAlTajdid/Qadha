import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  Widget _buildTile(String iconName, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.85,
              child: Row(
                children: [
                  SvgPicture.asset("assets/images/icons/blue/$iconName.svg"),
                  Expanded(
                      child: Center(
                          child: Text(text,
                              style: const TextStyle(
                                  fontSize: 19, fontFamily: "Inter Regular"))))
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1.75,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          height: size.height / 2.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTile("bell", "Notifications"),
              _buildTile("u", "Mentions légales et CGU"),
              _buildTile("cog", "Mises à jour"),
              _buildTile("about", "À propos de Qadha")],
          ),
        )
      ]),
    );
  }
}
