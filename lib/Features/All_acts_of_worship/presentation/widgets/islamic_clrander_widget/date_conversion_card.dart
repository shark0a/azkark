import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateConversionCard extends StatelessWidget {
  final String title;
  final String date;
  final Color color;
  final bool isSmallScreen;

  const DateConversionCard({
    super.key,
    required this.title,
    required this.date,
    required this.color,
    this.isSmallScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: (isSmallScreen ? 8 : 16).w,
        vertical: 4.h,
      ),
      padding: EdgeInsets.all((isSmallScreen ? 12 : 16).r),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              textDirection: TextDirection.rtl,
              date,
              style: TextStyle(
                fontSize: (isSmallScreen ? 14 : 18).sp,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: (isSmallScreen ? 4 : 8).w),
          Text(
            title,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: (isSmallScreen ? 14 : 16).sp,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
