import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:flutter/material.dart';

class NumberOfCountContainer extends StatelessWidget {
  const NumberOfCountContainer({super.key, required this.countOfZekr});
  final ValueNotifier<int> countOfZekr;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: countOfZekr,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            if (value > 0) {
              countOfZekr.value = value - 1;
            }
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: ShapeDecoration(
              color: value <= 0 ? Color(0xff01B7F1) : null,
              shape: CircleBorder(
                side: BorderSide(color: Color(0xff01B7F1), width: 3),
              ),
            ),
            child: Center(
              child: value > 0
                  ? Text(
                      '$value',
                      style: AppStyles.semiblod14.copyWith(
                        color: Color(0xff01B7F1),
                      ),
                    )
                  : Icon(Icons.check, color: AppStyles.scaffoldBG),
            ),
          ),
        );
      },
    );
  }
}
