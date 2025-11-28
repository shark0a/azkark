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

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AzkarProvider>();
    final variousDoaa = provider.variousDoaa;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomizeAppBar(title: S.of(context).VariuosAzkar),
      ),
      body: variousDoaa.isEmpty
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: AppStyles.scaffoldBG,
                color: AppStyles.appBarTitleColor,
              ),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: variusAzkarItem.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GestureDetector(
                  onTap: () {
                    provider.searcBySpecific(variusAzkarItem[index].title);
                    context.push(
                      AppRoutes.kVariousZekr,
                      extra: index == variusAzkarItem.length - 1
                          ? "${variusAzkarItem[index].title}الدعاء"
                          : variusAzkarItem[index].title,
                    );
                  },
                  child: CustomizeListTile(
                    title: index == variusAzkarItem.length - 1
                        ? "${variusAzkarItem[index].title}الدعاء"
                        : variusAzkarItem[index].title,
                    leading: Icon(Icons.arrow_back, color: Colors.black),
                    active: false,
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
