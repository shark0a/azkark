import 'package:azkark/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class DateAndLocationDetails extends StatelessWidget {
  const DateAndLocationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 33.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('المكان', style: AppStyles.regular12),
              const SizedBox(height: 4),
              Text('القاهرة، مصر', style: AppStyles.medium15),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('12 الثلاثاء ديسمبر 2023', style: AppStyles.regular12),
              const SizedBox(height: 4),
              Text('الأحد ربيع الأول 1445', style: AppStyles.light15),
            ],
          ),
        ],
      ),
    );
  }
}
