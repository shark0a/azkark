import 'dart:io';
import 'package:azkark/core/utils/helper/show_snack_bar.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/azkar_morning_widget/elzekr_container.dart';
import 'package:azkark/Features/All_acts_of_worship/presentation/widgets/azkar_morning_widget/info_about_zekr.dart';

class ElzekerSectionContainer extends StatelessWidget {
  ElzekerSectionContainer({
    super.key,
    required this.elzekr,
    required this.infoAboutzekr,
    required this.numOfZekrcount,
    required this.numOfZekr,
    required this.onTap,
    required this.isFav,
    required this.onCountContainerTap,
  });

  final String elzekr;
  final String infoAboutzekr;
  // final ValueNotifier<int> numOfZekrcount;
  final int numOfZekrcount;
  final int numOfZekr;
  final void Function() onTap;
  final void Function() onCountContainerTap;

  final bool isFav;

  // Screenshot controller for this widget
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: Screenshot(
        controller: screenshotController, // wrap the whole card
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppStyles.scaffoldBG,
            boxShadow: [
              BoxShadow(
                offset: Offset(2.w, 2.h),
                blurRadius: 8.r,
                blurStyle: BlurStyle.inner,
                color: Color.fromRGBO(0, 0, 0, 0.1),
              ),
            ],
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              ElzekrContainer(elzekr: elzekr, numOfZeker: numOfZekr),
              SizedBox(height: 22.93.h),
              InfoAboutZekr(
                onCountContainerTap: onCountContainerTap,
                isFav: isFav,
                onTap: onTap,
                countOfZekr: numOfZekrcount,
                info: infoAboutzekr,
                shareonTap: () async {
                  try {
                    // Capture the widget
                    final image = await screenshotController.capture();
                    if (image == null) return;

                    // Save temporarily
                    final directory = await getTemporaryDirectory();
                    final imagePath = await File(
                      '${directory.path}/zekr_$numOfZekr.png',
                    ).create();
                    await imagePath.writeAsBytes(image);
                    // Share
                    await SharePlus.instance.share(
                      ShareParams(
                        subject: S.of(context).Sharethis,
                        text: S.of(context).Sharethis,
                        files: [XFile(imagePath.path)],
                      ),
                    );
                    // await Share.shareXFiles([XFile(imagePath.path)]);
                  } catch (e) {
                    showErrorSnackBar(context, '${S.current.Sharethis}: $e');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
