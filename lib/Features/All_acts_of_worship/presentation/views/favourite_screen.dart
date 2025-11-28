import 'package:azkark/core/utils/helper/mehtod_helper.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/manager/azkar_provider.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/azkar_morning_widget/elzeker_section_container.dart';
import 'package:azkark/Features/Home/presentation/widgets/customize_app_bar.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/custom_buttom_navigation_bar.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AzkarProvider>();
    final favList = provider.favList.values.toList();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomizeAppBar(title: S.of(context).Fav),
      ),
      body: favList.isEmpty
          ?  Center(child: Text(S.of(context).ListisEmpty))
          : ListView.builder(
              itemCount: favList.length,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
                final zekrItem = favList[index];
                return KeyedSubtree(
                  key: ValueKey(zekrItem.id),
                  child: Selector<AzkarProvider, bool>(
                    selector: (context, provider) =>
                        provider.favList.containsKey(zekrItem.id),
                    builder: (context, isFav, child) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20.9),
                        child: ElzekerSectionContainer(
                          onTap: () {
                            provider.toggleItemFavList(zekrItem);
                          },
                          elzekr: zekrItem.zekr,
                          infoAboutzekr: zekrItem.description.isEmpty
                              ? MehtodHelper.cleanText(zekrItem.search)
                              : zekrItem.description,
                          numOfZekr: index + 1,
                          numOfZekrcount: ValueNotifier(
                            zekrItem.count == 0 ? 1 : zekrItem.count,
                          ),
                          isFav: isFav,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: CustomButtomNavigationBar(
        provider: context.watch<HomeController>(),
      ),
    );
  }
}
