
import 'package:flutter/material.dart';
import 'package:azkark/core/utils/helper/app_styles.dart';

class CalendarButtons extends StatelessWidget {
  final bool isHijri;
  final Function(bool) onChanged;
  final bool isSmallScreen;

  const CalendarButtons({
    super.key,
    required this.isHijri,
    required this.onChanged,
    this.isSmallScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(isSmallScreen ? 8.0 : 16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => onChanged(false),
              style: ElevatedButton.styleFrom(
                backgroundColor: !isHijri ? Colors.blue : AppStyles.inActiveColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 10 : 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'الميلادي',
                style: AppStyles.semiblod14.copyWith(
                  fontSize: isSmallScreen ? 14 : 18,
                ),
              ),
            ),
          ),
          SizedBox(width: isSmallScreen ? 8 : 16),
          Expanded(
            child: ElevatedButton(
              onPressed: () => onChanged(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: isHijri ? Colors.green : AppStyles.inActiveColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 10 : 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'الهجري',
                style: AppStyles.semiblod14.copyWith(
                  fontSize: isSmallScreen ? 14 : 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}