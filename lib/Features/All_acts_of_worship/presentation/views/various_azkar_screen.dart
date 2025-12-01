import 'package:azkark/Features/All_acts_of_worship/data/varoius_azkar_model.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/manager/azkar_provider.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/prasise_widget/customize_list_tile.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/Home/presentation/widgets/customize_app_bar.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/custom_buttom_navigation_bar.dart';
import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/core/utils/routes/app_routes.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class VariousAzkarScreen extends StatelessWidget {
  const VariousAzkarScreen({super.key});

  String _getLocalizedTitle(BuildContext context, String key) {
    final s = S.of(context);
    switch (key) {
      case 'zekr_azan':
        return s.zekr_azan;
      case 'zekr_awaken':
        return s.zekr_awaken;
      case 'ruqya_quran':
        return s.ruqya_quran;
      case 'ruqya_sunnah':
        return s.ruqya_sunnah;
      case 'zekr_night_waking':
        return s.zekr_night_waking;
      case 'zekr_enter_home':
        return s.zekr_enter_home;
      case 'zekr_exit_home':
        return s.zekr_exit_home;
      case 'zekr_wudhu':
        return s.zekr_wudhu;
      case 'zekr_prayer_virtue':
        return s.zekr_prayer_virtue;
      case 'zekr_prayer_answered':
        return s.zekr_prayer_answered;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AzkarProvider>();
    final variousDoaa = provider.variousDoaa;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomizeAppBar(onTap: () {
            context.pop();
          },title: S.of(context).VariuosAzkar),
      ),
      body: variousDoaa.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: AppStyles.scaffoldBG,
                color: AppStyles.appBarTitleColor,
              ),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: List.generate(variusAzkarItem.length, (index) {
                  final item = variusAzkarItem[index];
                  final localized = _getLocalizedTitle(
                    context,
                    item.localizationKey,
                  );
                  final displayTitle = index == variusAzkarItem.length - 1
                      ? "$localized${S.of(context).AlDoaa}"
                      : localized;
                  return Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                      left: 16,
                      right: 16,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        provider.searcBySpecific(item.title);
                        context.push(
                          AppRoutes.kVariousZekr,
                          extra: displayTitle,
                        );
                      },
                      child: CustomizeListTile(
                        activeleading: false,
                        title: displayTitle,
                        tralling: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
                        active: false,
                      ),
                    ),
                  );
                }),
              ),
            ),

      bottomNavigationBar: CustomButtomNavigationBar(
        provider: context.watch<HomeController>(),
      ),
    );
  }
}
