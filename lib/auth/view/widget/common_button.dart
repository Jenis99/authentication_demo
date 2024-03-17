import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:palflock/widget/bouncing.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/constants.dart';

class CommonButton extends StatelessWidget {
  final String btnName;
  final void Function() onPressed;
  final Color color;
  final String iconData;

  const CommonButton({super.key, required this.btnName, required this.onPressed, required this.color, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Bouncing(
        onPressed: onPressed,
        child: Container(
          height: 52.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              SvgPicture.asset(iconData).paddingAll(14.w),
              Expanded(
                child: Text(
                  btnName,
                  style: TextStyle(color: AppColors.white, fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
              ),
              SvgPicture.asset(ImageAssets.rightArrowImage).paddingAll(14.w),
            ],
          ),
        )).paddingOnly(left: 12.w, right: 12.w, top: 12.w);
  }
}
