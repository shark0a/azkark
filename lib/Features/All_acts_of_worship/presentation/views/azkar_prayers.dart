import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/manager/azkar_provider.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/azkar_morning_widget/elzeker_section_container.dart';
import 'package:azkark/Features/Home/presentation/widgets/customize_app_bar.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/custom_buttom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AzkarPrayers extends StatelessWidget {
  const AzkarPrayers({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AzkarProvider>();
    final azkarPrayers = provider.azkarPrayers;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomizeAppBar(title: 'أذكار الصلاه'),
      ),
      body: azkarPrayers.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: AppStyles.scaffoldBG,
                color: AppStyles.appBarTitleColor,
              ),
            )
          : ListView.builder(
              itemCount: azkarPrayers.length,
              padding: EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
                final zekrItem = azkarPrayers[index];
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
                            ? zekrItem.search.replaceAll("- الصلاة الصلاه", ' ')
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

      bottomNavigationBar: CustomButtomNavigationBar(
        provider: context.watch<HomeController>(),
      ),
    );
  }
}
