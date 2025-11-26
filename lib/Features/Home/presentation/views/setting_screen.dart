import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/prasise_widget/customize_list_tile.dart';
import 'package:azkark/Features/Home/data/setting_items_models.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/custom_buttom_navigation_bar.dart';
import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60.h),
        child: CustomizeHomeAppBar(
          title: S.of(context).settings_title,
          icon: Icon(Icons.settings, color: AppStyles.appBarTitleColor),
        ),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: settingItemsModel.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(top: 24.h),
          child: CustomizeListTile(
            active: index == 3,
            title: _getLocalizedSettingTitle(context, index),
            leading: index == 0
                ? Icon(Icons.arrow_back, color: Colors.black)
                : index == 1
                ? Icon(
                    size: 60.r,
                    Icons.toggle_off_sharp,
                    color: AppStyles.appBarTitleColor,
                  )
                : index == 2
                ? GestureDetector(
                    onTap: () async {
                      if (context.read<HomeController>().currentLocation !=
                          null) {
                        await context
                            .read<HomeController>()
                            .fetchPrayersTimes();
                      } else {
                        await context.read<HomeController>().initLocation();
                      }
                    },
                    child: Icon(
                      size: 30.r,
                      Icons.repeat_outlined,
                      color: const Color.fromARGB(255, 118, 12, 255),
                    ),
                  )
                : Text(
                    textDirection: TextDirection.rtl,
                    '${S.of(context).version_label} 1.0.0',
                    style: AppStyles.light14,
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

class CustomizeHomeAppBar extends StatelessWidget {
  const CustomizeHomeAppBar({
    super.key,
    required this.title,
    required this.icon,
  });
  final String title;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: AppStyles.scaffoldBG,
      surfaceTintColor: AppStyles.scaffoldBG,
      centerTitle: true,

      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textDirection: TextDirection.rtl,
            style: AppStyles.semiblod18.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(width: 10.w),
          icon,
        ],
      ),
    );
  }
}
