import 'package:azkark/core/utils/routes/app_routes.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/Home/presentation/widgets/customize_app_bar.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/custom_buttom_navigation_bar.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/prasise_widget/customize_list_tile.dart';
import 'package:azkark/generated/l10n.dart';
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
        child: CustomizeAppBar(
          onTap: () {
            context.pop();
          },
          title: S.of(context).tasbih_title,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                context.push(AppRoutes.kAzkarPraiseEst);
              },
              child: CustomizeListTile(
                activeleading: false,
                title: S.of(context).tasbih_azkar,
                tralling: Icon(Icons.arrow_forward, color: Colors.black),
                active: false,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                context.push(AppRoutes.kElectronic);
              },
              child: CustomizeListTile(
                activeleading: false,
                title: S.of(context).electronic_counter,
                tralling: Icon(Icons.arrow_forward, color: Colors.black),
                active: false,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomButtomNavigationBar(
        provider: context.watch<HomeController>(),
      ),
    );
  }
}
