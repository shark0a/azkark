import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/core/utils/helper/mehtod_helper.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/manager/azkar_provider.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/azkar_morning_widget/elzeker_section_container.dart';
import 'package:azkark/Features/Home/presentation/widgets/customize_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class VariousZekr extends StatelessWidget {
  const VariousZekr({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AzkarProvider>();
    final specificZekr = provider.specificZekr;
    String title = GoRouter.of(context).state.extra as String;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomizeAppBar(
          onTap: () {
            context.pop();
          },
          title: title,
        ),
      ),
      body: specificZekr.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: AppStyles.scaffoldBG,
                color: AppStyles.appBarTitleColor,
              ),
            )
          : ListView.builder(
              itemCount: specificZekr.length,
              padding: EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
                final zekrItem = specificZekr[index];
                ValueNotifier<int> zekrCountNotifier = ValueNotifier<int>(
                  zekrItem.count == 0 ? 1 : zekrItem.count,
                );
                ValueNotifier<bool> isFavNotifier = ValueNotifier<bool>(
                  zekrItem.isFav,
                );

                return ValueListenableBuilder<bool>(
                  valueListenable: isFavNotifier,
                  builder: (context, isFav, child) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.9),
                      child: ElzekerSectionContainer(
                        onTap: () {
                          isFavNotifier.value = !isFavNotifier.value;
                          zekrItem.isFav = isFavNotifier.value;
                          provider.toggleItemFavList(zekrItem);
                        },
                        elzekr: zekrItem.zekr,
                        infoAboutzekr: zekrItem.description.isEmpty
                            ? MehtodHelper.cleanText(zekrItem.search)
                            : zekrItem.description,
                        numOfZekr: index + 1,
                        numOfZekrcount: zekrCountNotifier,
                        isFav: isFav,
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
