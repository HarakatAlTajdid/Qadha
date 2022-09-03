import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:qadha/ui/app/app_theme.dart';

class RewardsView extends StatefulWidget {
  const RewardsView({Key? key}) : super(key: key);

  @override
  State<RewardsView> createState() => _RewardsViewState();
}

class _RewardsViewState extends State<RewardsView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 35),
                  const Center(
                      child: Text("Niveau : Débutant",
                          style: TextStyle(
                              fontFamily: "Inter Regular", fontSize: 20))),
                  const SizedBox(height: 10),
                  RatingBar.builder(
                    itemSize: 25,
                    initialRating: 1,
                    ignoreGestures: true,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.5),
                    itemBuilder: (context, _) =>
                        Icon(Icons.star_rounded, color: AppTheme.goldenColor),
                    unratedColor: Colors.black,
                    onRatingUpdate: (double value) {},
                  ),
                  const SizedBox(height: 45),
                  Container(
                    decoration: BoxDecoration(
              color: AppTheme.purpleColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35),
              ),
            ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text("Sagesses débloquées",
                            style: TextStyle(
                                fontFamily: "Inter SemiBold", fontSize: 19)),
                        const SizedBox(height: 12),
                        GridView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding: EdgeInsets.only(
                                    left: index % 2 == 0 ? 10 : 5,
                                    right: index % 2 == 0 ? 5 : 10,
                                    top: 5,
                                    bottom: 5),
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: AppTheme.primaryColor,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(child: Text(index.toString()))));
                          },
                        ),
                        const SizedBox(height: 25),
                        const Text("... encore 19 à débloquer", style: TextStyle(fontFamily: "Inter Regular", fontSize: 16)),
                        Text("ان شاء الله", style: TextStyle(fontSize: 25, color: Colors.green.shade900)),
                      const SizedBox(height: 17.5),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                ]),
          )),
    );
  }
}
