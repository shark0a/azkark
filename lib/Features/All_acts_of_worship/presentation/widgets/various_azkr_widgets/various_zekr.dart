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
    final provider = context.read<AzkarProvider>();
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

                return Padding(
                  padding: const EdgeInsets.only(top: 20.9),
                  child: Selector<AzkarProvider, int>(
                    selector: (_, provider) => zekrItem.count,
                    builder: (context, count, child) {
                      return Selector<AzkarProvider, bool>(
                        selector: (_, provider) => zekrItem.isFav,
                        builder: (context, isFav, child) {
                          return ElzekerSectionContainer(
                            onCountContainerTap: () =>
                                provider.decrementCount(zekrItem),

                            onTap: () {
                              provider.toggleItemFavList(zekrItem);
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
                );
              },
            ),
    );
  }
}
