import 'package:azkark/core/utils/app_styles.dart';
import 'package:azkark/core/utils/routes/app_routes.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/Home/presentation/widgets/customize_app_bar.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/custom_buttom_navigation_bar.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/prasise_widget/customize_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PraiseSrceen extends StatelessWidget {
  const PraiseSrceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60),
        child: CustomizeAppBar(title: 'التسبيح'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              context.push(AppRoutes.kAzkarPraiseEst);
            },
            child: CustomizeListTile(
              title: "أذكار التسبيح والاستغفار",
              icon: Icons.arrow_back,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              context.push(AppRoutes.kElectronic);
            },
            child: CustomizeListTile(
              title: "المسبحه الالكترونيه",
              icon: Icons.arrow_back,
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomButtomNavigationBar(
        provider: context.watch<HomeController>(),
      ),
    );
  }
}
