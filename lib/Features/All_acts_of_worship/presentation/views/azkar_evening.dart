import 'dart:developer';

import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/core/utils/helper/mehtod_helper.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/manager/azkar_provider.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/azkar_morning_widget/elzeker_section_container.dart';
import 'package:azkark/Features/Home/presentation/widgets/customize_app_bar.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/custom_buttom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AzkarEvening extends StatelessWidget {
  const AzkarEvening({super.key});

  @override
  Widget build(BuildContext context) {
    final azkarEvening = context.read<AzkarProvider>().azkarEvening;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomizeAppBar(
          onTap: () {
            context.pop();
          },
          title: S.of(context).azkar_evening,
        ),
      ),
      body: azkarEvening.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: AppStyles.scaffoldBG,
                color: AppStyles.appBarTitleColor,
              ),
            )
          : ListView.builder(
              itemCount: azkarEvening.length,
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
                final zekrItem = azkarEvening[index];

                return Padding(
                  padding: const EdgeInsets.only(top: 20.9),
                  child: Row(
                    children: [
                      Expanded(
                        child: Selector<AzkarProvider, int>(
                          selector: (_, provider) => zekrItem.count,
                          builder: (context, count, child) {
                            return Selector<AzkarProvider, bool>(
                              selector: (_, provider) => zekrItem.isFav,
                              builder: (context, isFav, child) {
                                return ElzekerSectionContainer(
                                  onCountContainerTap: () {
                                    context
                                        .read<AzkarProvider>()
                                        .decrementCount(zekrItem);
                                  },
                                  onTap: () {
                                    context
                                        .read<AzkarProvider>()
                                        .toggleItemFavList(zekrItem);
                                  },
                                  elzekr: zekrItem.zekr,
                                  infoAboutzekr: zekrItem.description.isEmpty
                                      ? MehtodHelper.cleanText(zekrItem.search)
                                      : zekrItem.description,
                                  numOfZekr: index + 1,
                                  numOfZekrcount: count,
                                  isFav: isFav,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
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
