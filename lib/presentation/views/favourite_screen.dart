import 'package:azkark/core/utils/helper/provider/app_provider.dart';
import 'package:azkark/presentation/controller/home_controller.dart';
import 'package:azkark/presentation/widgets/azkar_morning_widget/elzeker_section_container.dart';
import 'package:azkark/presentation/widgets/customize_app_bar.dart';
import 'package:azkark/presentation/widgets/home_widgets/custom_buttom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppProvider>();
    final favList = provider.favList.values.toList();
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomizeAppBar(title: 'المفضله'),
      ),
      body: favList.isEmpty
          ? const Center(child: Text("List is Empty"))
          : ListView.builder(
              itemCount: favList.length,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
                final zekrItem = favList[index];

                return KeyedSubtree(
                  key: ValueKey(zekrItem.id),
                  child: Selector<AppProvider, bool>(
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
                          infoAboutzekr: zekrItem.description,
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
