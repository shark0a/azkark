import 'package:azkark/Features/All_acts_of_worship/data/all_options_models.dart';
import 'package:azkark/core/utils/routes/app_routes.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/all_option_container.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AllOptionGridView extends StatelessWidget {
  const AllOptionGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      sliver: SliverGrid.builder(
        itemCount: allOtionsItems.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            switch (index) {
              case 0:
                context.push(AppRoutes.kAzkarEvening);
                break;
              case 1:
                context.push(AppRoutes.kAzkarMorning);
                break;
              case 2:
                context.push(AppRoutes.kAzkarPrayers);
                break;
              case 3:
                context.push(AppRoutes.kAllPrayers);
                break;
              case 4:
                context.push(AppRoutes.kPraiseSrceen);
                break;
              case 5:
                context.push(AppRoutes.kIslamicCalendar);
                break;
              case 6:
                context.push(AppRoutes.kFavouriteScreen);
                break;
              case 7:
                break;
              case 8:
                context.push(AppRoutes.kVariousAzkar);
                break;
              default:
            }
          },
          child: AllOptionContainer(
            icon: allOtionsItems[index].icon,
            title: allOtionsItems[index].title,
          ),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 15,
        ),
      ),
    );
  }
}
