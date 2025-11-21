import 'package:azkark/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomizeListTileVersion extends StatelessWidget {
  const CustomizeListTileVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Color.fromRGBO(245, 245, 245, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      contentPadding: EdgeInsets.symmetric(horizontal: 8),
      titleAlignment: ListTileTitleAlignment.center,
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '04:55',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0x7F1E1E1E),
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              letterSpacing: -0.30,
            ),
          ),

          const SizedBox(width: 10),
          Icon(Icons.volume_up_sharp, color: AppStyles.inActiveColor),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'الفجر',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0x7F1E1E1E),
              fontSize: 18,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              letterSpacing: -0.30,
            ),
          ),

          const SizedBox(width: 19.5),
          SvgPicture.asset(
            "assets/m6.svg",
            color: AppStyles.inActiveColor,
            width: 25.5,
            height: 25.5,
          ),
        ],
      ),
      // leading: Row(
      //   mainAxisSize: MainAxisSize.min,

      //   children: [],
      // ),
    );
  }
}
