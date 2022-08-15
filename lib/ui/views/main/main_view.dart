import 'package:flutter/material.dart';
import 'package:qadha/ui/app/app_theme.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  Widget _buildSign(IconData icon) {
    return Container(
        decoration: BoxDecoration(
            color: AppTheme.secundaryColor,
            borderRadius: BorderRadius.circular(5)),
        child: Icon(
          icon,
          color: AppTheme.primaryColor,
          size: 45,
        ));
  }

  Widget _buildSalatTile(String name) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width / 1.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildSign(Icons.remove),
          Stack(alignment: Alignment.centerRight, children: [
            SizedBox(
              width: size.width / 1.75,
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                    color: AppTheme.secundaryColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(name,
                      style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 17,
                          fontFamily: "Inter Bold")),
                ),
              ),
            ),
            Container(
                height: 30,
                constraints: const BoxConstraints(minWidth: 27.5),
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(3)),
                child: const Center(
                    child: Text("2",
                        style: TextStyle(
                            fontSize: 16, fontFamily: "Inter Bold")))),
          ]),
          _buildSign(Icons.add)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Center(
            child: Image.asset(
          "assets/images/qadha_blue.png",
          width: 52.5,
        )),
        const SizedBox(height: 30),
        const Text("Combien de prières avez-vous rattrapées aujourd'hui ?",
            style: TextStyle(fontSize: 14.5, fontFamily: "Inter Regular")),
        SizedBox(
          height: size.height / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSalatTile("FAJR"),
              _buildSalatTile("DHOR"),
              _buildSalatTile("ASR"),
              _buildSalatTile("MAGHREB"),
              _buildSalatTile("ISHAA"),
            ],
          ),
        ),
      ],
    );
  }
}
