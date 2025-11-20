import 'package:azkark/core/utils/app_styles.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/azkar_morning_widget/elzekr_container.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/azkar_morning_widget/info_about_zekr.dart';
import 'package:flutter/material.dart';

class ElzekerSectionContainer extends StatelessWidget {
  const ElzekerSectionContainer({
    super.key,
    required this.elzekr,
    required this.infoAboutzekr,
    required this.numOfZekrcount,
    required this.numOfZekr,
    required this.onTap,
    required this.isFav,
  });
  final String elzekr;
  final String infoAboutzekr;
  final ValueNotifier<int> numOfZekrcount;
  final int numOfZekr;
  final void Function() onTap;
  final bool isFav;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        width: double.infinity,

        decoration: BoxDecoration(
          color: AppStyles.scaffoldBG,
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 8,
              blurStyle: BlurStyle.inner,
              color: Color.fromRGBO(0, 0, 0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
          shape: BoxShape.rectangle,
        ),
        child: Column(
          children: [
            ElzekrContainer(elzekr: elzekr, numOfZeker: numOfZekr),
            const SizedBox(height: 22.93),
            InfoAboutZekr(
              isFav: isFav,
              onTap: onTap,
              countOfZekr: numOfZekrcount,
              info: infoAboutzekr,
            ),
          ],
        ),
      ),
    );
  }
}
