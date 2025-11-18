// import 'package:azkark/core/utils/helper/mehtod_helper.dart';
// import 'package:azkark/data/all_azkar_model.dart';
// import 'package:flutter/material.dart';

// class AzkarScreen extends StatefulWidget {
//   const AzkarScreen({super.key});

//   @override
//   State<AzkarScreen> createState() => _AzkarScreenState();
// }

// class _AzkarScreenState extends State<AzkarScreen> {
//   late Future<List<AzkarModel>> futureAzkar;

//   @override
//   void initState() {
//     super.initState();
//     futureAzkar = MehtodHelper().loadAzkar();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("أذكار الصباح")),
//       body: FutureBuilder(
//         future: futureAzkar,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }

//           final azkar = snapshot.data!;

//           return ListView.builder(
//             padding: EdgeInsets.all(12),
//             itemCount: 80,
//             itemBuilder: (context, index) {
           
//               return Card(
//                 child: ListTile(
//                   subtitleTextStyle: TextStyle(),
//                   title: Text('$spec', textDirection: TextDirection.rtl),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     textDirection: TextDirection.ltr,

//                     // children: [
//                     //   if (item.description.isNotEmpty)
//                     //     Text(
//                     //       textDirection: TextDirection.rtl,
//                     //       item.description,
//                     //     ),
//                     //   Text(
//                     //     textDirection: TextDirection.rtl,
//                     //     "عدد التكرار: ${item.count}",
//                     //   ),
//                     //   Text(
//                     //     textDirection: TextDirection.rtl,

//                     //     "المرجع: ${item.reference}",
//                     //   ),
//                     // ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
