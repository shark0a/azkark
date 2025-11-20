import 'package:azkark/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllOptionContainer extends StatelessWidget {
  const AllOptionContainer({
    super.key,
    required this.icon,
    required this.title,
  });
  final String icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withAlpha(60),
            blurRadius: 19.52,
            offset: Offset(0, 2.44),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(icon),
          Text(
            maxLines: 2,
            textAlign: TextAlign.center,
            title,
            style: AppStyles.semiblod14.copyWith(color: Color(0xff348698)),
          ),
        ],
      ),
    );
  }
}
