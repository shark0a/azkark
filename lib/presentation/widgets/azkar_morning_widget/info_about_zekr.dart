import 'package:azkark/core/utils/app_styles.dart';
import 'package:azkark/presentation/widgets/azkar_morning_widget/number_of_count_container.dart';
import 'package:flutter/material.dart';

class InfoAboutZekr extends StatelessWidget {
  const InfoAboutZekr({
    super.key,
    required this.info,
    required this.countOfZekr,
    required this.onTap,
    required this.isFav,
  });
  final String info;
  final ValueNotifier<int> countOfZekr;
  final void Function() onTap;
  final bool isFav;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 305,
          child: Text(
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: AppStyles.regular10.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
            info,
          ),
        ),
        const SizedBox(height: 17.87),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.share, color: Color(0xff005773), size: 40),
            const SizedBox(width: 30),
            Icon(Icons.edit, color: Color(0xff005773), size: 40),
            const SizedBox(width: 30),
            NumberOfCountContainer(countOfZekr: countOfZekr),
            const SizedBox(width: 30),
            GestureDetector(
              onTap: onTap,
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: Color(0xff005773),
                size: 40,
              ),
            ),
            const SizedBox(width: 30),
          ],
        ),
        const SizedBox(height: 17.56),
      ],
    );
  }
}
