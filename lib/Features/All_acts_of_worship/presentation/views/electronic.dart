import 'dart:developer';

import 'package:azkark/core/utils/app_styles.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/custom_buttom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Electronic extends StatelessWidget {
  const Electronic({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> count = ValueNotifier(0);
    ValueNotifier<String> dropButtonValue = ValueNotifier("اختار الذكر");
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage("assets/tBG.jpg"),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                ValueListenableBuilder(
                  valueListenable: dropButtonValue,
                  builder: (context, value, child) => ValueListenableBuilder<String>(
                    valueListenable: dropButtonValue,
                    builder: (context, value, child) => DropdownButton<String>(
                      value: value,
                      style: AppStyles.regular16,
                      isExpanded:
                          false, // يخلي العرض يملأ المساحة ويعطي مجال للتحاذي
                      alignment: Alignment.center,
                      items: [
                        DropdownMenuItem(
                          value: "اختار الذكر",
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("اختار الذكر"),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "اللهم صلي علي سيدنا محمد",
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text("اللهم صلي علي سيدنا محمد"),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "سبحان الله",
                          alignment: Alignment.centerRight,

                          child: Text("سبحان الله"),
                        ),
                        DropdownMenuItem(
                          value: "الحمد الله",
                          alignment: Alignment.centerRight,

                          child: Text("الحمد الله"),
                        ),
                        DropdownMenuItem(
                          value: "الله اكبر",
                          alignment: Alignment.centerRight,

                          child: Text("الله اكبر"),
                        ),
                        DropdownMenuItem(
                          value: "سبحان الله وبحمده",
                          alignment: Alignment.centerRight,

                          child: Text("سبحان الله وبحمده"),
                        ),
                        DropdownMenuItem(
                          value: "استغفر الله",
                          alignment: Alignment.centerRight,

                          child: Text("استغفر الله"),
                        ),
                      ],
                      onChanged: (dropvalue) {
                        if (dropvalue != null) {
                          dropButtonValue.value = dropvalue;
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                ValueListenableBuilder(
                  valueListenable: count,
                  builder: (context, value, child) {
                    return InkWell(
                      onTap: () {
                        count.value++;
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 8,
                              // blurStyle: ,
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ],
                          border: Border.all(
                            color: AppStyles.appBarTitleColor,
                            width: 6,
                          ),
                          shape: BoxShape.circle,
                        ),

                        child: Center(
                          child: Text(
                            count.value == 0 ? "بدء" : "${count.value}",
                            style: AppStyles.blod20.copyWith(fontSize: 25),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 5,
                color: Color.fromRGBO(0, 0, 0, 10),
              ),
            ],
          ),
          child: CustomButtomNavigationBar(
            provider: context.watch<HomeController>(),
          ),
        ),
      ),
    );
  }
}
