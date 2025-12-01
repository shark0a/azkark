import 'package:azkark/Features/Home/presentation/widgets/customize_app_bar.dart';
import 'package:azkark/core/utils/helper/app_styles.dart';
import 'package:azkark/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QiblaCompassScreen extends StatefulWidget {
  const QiblaCompassScreen({super.key});

  @override
  State<QiblaCompassScreen> createState() => _QiblaCompassScreenState();
}

class _QiblaCompassScreenState extends State<QiblaCompassScreen> {
  late final WebViewController controller;
  bool isLoading = true; // track loading state

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (_) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse("https://qiblafinder.withgoogle.com/intl/ar/"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 60.h),
        child: CustomizeAppBar(
          onTap: () {
            context.pop();
          },
          title: S.of(context).nearest_mosq,
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppStyles.activeColor),
            )
          : WebViewWidget(controller: controller),
    );
  }
}
