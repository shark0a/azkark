import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ElzekrContainer extends StatelessWidget {
  const ElzekrContainer({
    super.key,
    required this.elzekr,
    required this.numOfZeker,
  });
  final String elzekr;
  final int numOfZeker;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppStyles.azkarContainerBG,
        borderRadius: BorderRadius.only(topRight: Radius.circular(8)),
      ),
      width: double.infinity,

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.29, horizontal: 8.5),
                decoration: ShapeDecoration(
                  color: Color(0xff005773),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                    ),
                  ),
                ),
                child: Text(
                  '$numOfZeker',
                  style: AppStyles.regular12.copyWith(color: Color(0xffFFFFFF)),
                ),
              ),
            ],
          ),
          SvgPicture.asset("assets/azker_upper_frame.svg"),
          const SizedBox(height: 9.98),
          SizedBox(
            width: 300.16,
            child: Text(
              elzekr,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF005773),
                fontSize: 15,
                fontFamily: 'Emara',
                fontWeight: FontWeight.w800,
                height: 1.74,
              ),
            ),
          ),
          const SizedBox(height: 15.98),
          SvgPicture.asset("assets/azker_upper_frame.svg"),
          const SizedBox(height: 8.51),
        ],
      ),
    );
  }
}
