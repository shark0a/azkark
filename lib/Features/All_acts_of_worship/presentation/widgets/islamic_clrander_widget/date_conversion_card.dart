// import 'package:flutter/material.dart';
// import 'package:hijri_date/hijri_date.dart';

// class DateConversionCard extends StatelessWidget {
//   final String title;
//   final String date;
//   final Color color;

//   const DateConversionCard({
//     Key? key,
//     required this.title,
//     required this.date,
//     required this.color,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: color),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             date,
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//           ),
//           SizedBox(width: 8),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: color,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class DateConversionCard extends StatelessWidget {
  final String title;
  final String date;
  final Color color;
  final bool isSmallScreen;

  const DateConversionCard({
    Key? key,
    required this.title,
    required this.date,
    required this.color,
    this.isSmallScreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 8 : 16,
        vertical: 4,
      ),
      padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
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
                fontSize: isSmallScreen ? 14 : 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: isSmallScreen ? 4 : 8),
          Text(
            title,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: isSmallScreen ? 14 : 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
