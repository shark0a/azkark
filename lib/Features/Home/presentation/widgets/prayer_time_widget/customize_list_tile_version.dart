import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomizeListTileVersion extends StatelessWidget {
  const CustomizeListTileVersion({
    super.key,
    required this.prayerTime,
    required this.prayerName,
    required this.active,
  });
  final String prayerTime;
  final bool active;
  final String prayerName;
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
            prayerTime,
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
          Icon(
            active ? Icons.volume_up_sharp : Icons.volume_off_rounded,
            color: active
                ? AppStyles.inActiveColor
                : AppStyles.appBarTitleColor,
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            prayerName,
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
            colorFilter: ColorFilter.mode(
              AppStyles.inActiveColor,
              BlendMode.srcIn,
            ),
            width: 25.5,
            height: 25.5,
          ),
        ],
      ),
    );
  }
}
