// import 'package:flutter/material.dart';
// import 'package:azkark/core/utils/app_styles.dart';

// class CalendarButtons extends StatelessWidget {
//   final bool isHijri;
//   final Function(bool) onChanged;

//   const CalendarButtons({
//     Key? key,
//     required this.isHijri,
//     required this.onChanged,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () => onChanged(false),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: !isHijri ? Colors.blue : AppStyles.inActiveColor,
//                 foregroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: Text(
//                 'التقويم الميلادي',
//                 style: AppStyles.semiblod14.copyWith(fontSize: 18),
//               ),
//             ),
//           ),
//           SizedBox(width: 16),
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () => onChanged(true),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: isHijri ? Colors.green : AppStyles.inActiveColor,
//                 foregroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(vertical: 15),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: Text(
//                 'التقويم الهجري',
//                 style: AppStyles.semiblod14.copyWith(fontSize: 18),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:azkark/core/utils/app_styles.dart';

class CalendarButtons extends StatelessWidget {
  final bool isHijri;
  final Function(bool) onChanged;
  final bool isSmallScreen;

  const CalendarButtons({
    Key? key,
    required this.isHijri,
    required this.onChanged,
    this.isSmallScreen = false,
  }) : super(key: key);

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