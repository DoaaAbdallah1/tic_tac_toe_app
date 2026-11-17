import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/constants/app_assets.dart';

import '../../../../core/constants/app_colors.dart';

class CustomItem extends StatelessWidget {
  final String symbol;
  final int index;
  final VoidCallback onTap;
  const CustomItem({
    super.key,
    required this.symbol,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: index % 3 != 2
                ? BorderSide(color: AppColors.black, width: 1)
                : BorderSide.none,
            bottom: index < 6
                ? BorderSide(color: AppColors.black, width: 1)
                : BorderSide.none,
          ),
        ),
        child: Center(
          child:symbol==""?SizedBox(height: 83,width: 83,): Image.asset(
            symbol=="x"?AppAssets.xImg:AppAssets.oImg,
            width: 83,
            height: 83,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
    ;
  }
}
