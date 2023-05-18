// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// import '../colors.dart';

// class buildServiceIconsList extends StatefulWidget {
//   buildServiceIconsList({
//     super.key,
//     required this.iconsList,
//   });
//   final List iconsList;

//   @override
//   State<buildServiceIconsList> createState() => _buildServiceIconsListState();
// }

// class _buildServiceIconsListState extends State<buildServiceIconsList> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 56,
//       margin: const EdgeInsets.only(top: 12),
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: widget.iconsList.length,
//           itemBuilder: (context, index) {
//             String key = widget.iconsList.elementAt(index).toString();
//             String value = widget.iconsList[index].toString();
//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       backgroundColor: Colors.white,
//                       content: Container(
//                         margin: const EdgeInsets.all(12),
//                         padding: const EdgeInsets.all(24),
//                         decoration: BoxDecoration(
//                           color: AppColors.primaryColor,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: const Text('Dịch vụ chưa khả dụng'),
//                       ),
//                     ),
//                   );
//                 });
//               },
//               child: Container(
//                 width: 56,
//                 height: 56,
//                 margin: const EdgeInsets.only(right: 12),
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Image.asset(
//                   value,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }
