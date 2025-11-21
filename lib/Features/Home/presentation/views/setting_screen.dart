import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/prasise_widget/customize_list_tile.dart';
import 'package:azkark/Features/Home/data/setting_items_models.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/custom_buttom_navigation_bar.dart';
import 'package:azkark/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomizeHomeAppBar(
          title: "الاعدادات",
          icon: Icon(
            Icons.settings,
            color: AppStyles.appBarTitleColor,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: settingItemsModel.length,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(top: 24),
          child: CustomizeListTile(
            active: index == 3,
            title: settingItemsModel[index].title,
            leading: index == 0
                ? Icon(Icons.arrow_back, color: Colors.black)
                : index == 1
                ? Icon(
                    size: 60,
                    Icons.toggle_off_sharp,
                    color: AppStyles.appBarTitleColor,
                  )
                : index == 2
                ? Icon(
                    size: 30,
                    Icons.repeat_outlined,
                    color: const Color.fromARGB(255, 118, 12, 255),
                  )
                : Text(
                    textDirection: TextDirection.rtl,
                    "1.0.0 اصدار",
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
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(width: 10),
          icon,
        ],
      ),
    );
  }
}
