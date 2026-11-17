import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/constants/app_assets.dart';
import 'package:tic_tac_toe/core/constants/app_colors.dart';
import 'package:tic_tac_toe/features/home/presentation/screens/home_screen.dart';

import '../widgets/button_custom.dart';

class FirstScreen extends StatelessWidget {
  static String routeName = '/first';
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Image.asset(AppAssets.background, width: double.infinity),
              Spacer(),
              Text(
                "Pick who goes first?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: .w500,
                  color: AppColors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16,
                  children: [
                    ButtonCustom(
                      imagePath: AppAssets.xImg,
                      onTap: () {
                        Navigator.pushNamed(context, HomeScreen.routeName,arguments:"x");
                      },
                    ),
                    ButtonCustom(
                      imagePath: AppAssets.oImg,
                      onTap: () {
                        Navigator.pushNamed(context, HomeScreen.routeName,arguments: "o");
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
