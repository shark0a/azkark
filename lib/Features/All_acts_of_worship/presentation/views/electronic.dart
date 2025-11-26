import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/Features/Home/presentation/controller/home_controller.dart';
import 'package:azkark/Features/Home/presentation/widgets/home_widgets/custom_buttom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:provider/provider.dart';

class Electronic extends StatelessWidget {
  const Electronic({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> count = ValueNotifier(0);
    ValueNotifier<String> dropButtonValue = ValueNotifier(
      S.of(context).choose_zekr,
    );
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
                SizedBox(height: 50.h),
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
                          value: S.of(context).choose_zekr,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(S.of(context).choose_zekr),
                          ),
                        ),
                        DropdownMenuItem(
                          value: S.of(context).may_allah_bless,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(S.of(context).may_allah_bless),
                          ),
                        ),
                        DropdownMenuItem(
                          value: S.of(context).subhanallah,
                          alignment: Alignment.centerRight,
                          child: Text(S.of(context).subhanallah),
                        ),
                        DropdownMenuItem(
                          value: S.of(context).alhamdulillah,
                          alignment: Alignment.centerRight,
                          child: Text(S.of(context).alhamdulillah),
                        ),
                        DropdownMenuItem(
                          value: S.of(context).allahu_akbar,
                          alignment: Alignment.centerRight,
                          child: Text(S.of(context).allahu_akbar),
                        ),
                        DropdownMenuItem(
                          value: S.of(context).subhanallah_bihamdihi,
                          alignment: Alignment.centerRight,
                          child: Text(S.of(context).subhanallah_bihamdihi),
                        ),
                        DropdownMenuItem(
                          value: S.of(context).astaghfirallah,
                          alignment: Alignment.centerRight,
                          child: Text(S.of(context).astaghfirallah),
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
                SizedBox(height: 50.h),
                ValueListenableBuilder(
                  valueListenable: count,
                  builder: (context, value, child) {
                    return InkWell(
                      onTap: () {
                        count.value++;
                      },
                      child: Container(
                        width: 100.w,
                        height: 100.w,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2.h),
                              blurRadius: 8.r,
                              // blurStyle: ,
                              color: Color.fromRGBO(0, 0, 0, 1),
                            ),
                          ],
                          border: Border.all(
                            color: AppStyles.appBarTitleColor,
                            width: 6.w,
                          ),
                          shape: BoxShape.circle,
                        ),

                        child: Center(
                          child: Text(
                            count.value == 0
                                ? S.of(context).start_label
                                : S.of(context).count_label(count.value),
                            style: AppStyles.blod20.copyWith(fontSize: 25.sp),
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
