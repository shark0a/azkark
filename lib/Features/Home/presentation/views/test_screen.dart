// import 'package:azkark/core/services/back_ground_service/notification_handler/notification_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class NotificationTestScreen extends StatelessWidget {
//   const NotificationTestScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff00133F),
//       appBar: AppBar(
//         backgroundColor: const Color(0xff00133F),
//         elevation: 0,
//         title: const Text(
//           "اختبار الإشعارات",
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: Center(
//         child: Container(
//           width: 300.w,
//           padding: EdgeInsets.all(20.w),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(20.r),
//             border: Border.all(color: Colors.white24, width: 1.2),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 "جرّب إشعار فوري بعد 5 ثواني.\n"
//                 "اقفل التطبيق من الخلفية وشوف الإشعار هيجيلك ولا لأ.",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.white70, fontSize: 16.sp),
//               ),
//               SizedBox(height: 25.h),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   foregroundColor: Colors.black,
//                   padding: EdgeInsets.symmetric(
//                     vertical: 14.h,
//                     horizontal: 30.w,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.r),
//                   ),
//                 ),
//                 onPressed: () async {
//                   // Initialize the notification service if not already done
//                   await NotificationService.instance.init();

//                   await NotificationService.instance.scheduleDailyPrayers();

//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text(
//                         "✔ تم جدولة الإشعار — اقفل التطبيق واستنى 5 ثواني",
//                       ),
//                     ),
//                   );
//                 },
//                 child: Text(
//                   "تشغيل الإشعار التجريبي",
//                   style: TextStyle(fontSize: 16.sp),
//                 ),
//               ),
//               SizedBox(height: 20.h),
//               Text(
//                 "🔔 يعمل حتى لو التطبيق مقفول 🔒",
//                 style: TextStyle(color: Colors.white54, fontSize: 14.sp),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
