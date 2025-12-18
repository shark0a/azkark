import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/prasise_widget/customize_list_tile.dart';
import 'package:azkark/Features/Home/data/setting_items_models.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/Home/presentation/widgets/customize_home_app_bar.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/custom_buttom_navigation_bar.dart';
import 'package:azkark/core/services/service_locator.dart';
import 'package:azkark/core/utils/cache/shared_pre.dart';
import 'package:azkark/core/utils/cache/shared_pref_keys.dart';
import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/core/utils/helper/show_snack_bar.dart';
import 'package:azkark/core/utils/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang =
        sl.get<SharedPref>().getString(SharedPrefKeys.langKey) ??
        Localizations.localeOf(context).countryCode;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60.h),
        child: CustomizeHomeAppBar(
          title: S.of(context).settings_title,
          icon: Icon(Icons.settings, color: AppStyles.appBarTitleColor),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: settingItemsModel.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: GestureDetector(
              onTap: () async {
                switch (index) {
                  case 0:
                    context.push(AppRoutes.kPrayerSetting);

                    break;
                  case 1:
                    context.read<HomeController>().toggleLocale();
                    break;
                  case 2:
                    if (context.read<HomeController>().isLoadingLocation ||
                        context.read<HomeController>().isFetchingPrayerTimes) {
                      showInfoSnackBar(
                        context,
                        S.of(context).pleaseWaitItLoading,
                      );
                    } else {
                      try {
                        await context.read<HomeController>().initLocation();
                        await context
                            .read<HomeController>()
                            .fetchPrayersTimes();
                        context.read<HomeController>().errorMsg.isEmpty
                            ? showSuccessSnackBar(
                                context,
                                S.of(context).LocationUpdateMessage,
                              )
                            : showErrorSnackBar(
                                context,

                                S.of(context).LocationUpdatFAliure,
                              );
                      } catch (e) {}
                    }

                    break;
                  default:
                    break;
                }
              },
              child: CustomizeListTile(
                activeleading: false,
                active: index == 3,
                title: _getLocalizedSettingTitle(context, index),
                tralling: index == 0
                    ? Icon(
                        Icons.arrow_forward,
                        color: AppStyles.arrow_forward_Icon_Color,
                      )
                    : index == 1
                    ? Icon(
                        size: 55.r,
                        lang != 'ar' ? Icons.toggle_on_sharp : Icons.toggle_on,
                        color: lang != 'ar'
                            ? AppStyles.iconActiveColor
                            : AppStyles.inActiveColor,
                      )
                    : index == 2
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            size: 30.r,
                            Icons.repeat_outlined,
                            color: AppStyles.iconActiveColor,
                          ),
                          Text(
                            context
                                    .read<HomeController>()
                                    .prayerTimesHive
                                    ?.meta
                                    .timezone ??
                                '',
                          ),
                        ],
                      )
                    : Text(
                        '${S.of(context).version_label} 1.0.0',
                        style: AppStyles.light14,
                      ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomButtomNavigationBar(
        provider: context.watch<HomeController>(),
      ),
    );
  }

  String _getLocalizedSettingTitle(BuildContext context, int index) {
    final S l10n = S.of(context);
    switch (index) {
      case 0:
        return l10n.prayer_settings;
      case 1:
        return l10n.english_lang;
      case 2:
        return l10n.update_location;
      case 3:
        return l10n.app_version;
      default:
        return settingItemsModel[index].title;
    }
  }
}
