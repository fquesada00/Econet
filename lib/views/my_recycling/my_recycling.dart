import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/drawer.dart';
import 'package:econet/views/widgets/tab_slide_choose.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_recycling_deliveries_tab.dart';
import 'my_recycling_ecopoints_tab.dart';

class MyRecycling extends StatelessWidget {
  final List<String> tabNames = ["My Deliveries", "My Ecopoints"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.white,
            child: DefaultTabController(
              length: tabNames.length,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 26, right: 26),
                    child: TabSlideChoose(
                        tabNames, Colors.grey.withOpacity(0.5), GREEN_DARK),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        MyRecyclingDeliveriesTab(),
                        MyRecyclingEcopointsTab()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
//
// //si se usa en otro lado extraer como widget
// class NavBar2 extends StatelessWidget implements PreferredSizeWidget {
//   final String text;
//   final Color backgroundColor;
//   final Color textColor;
//   final double height;
//
//   NavBar2({this.text, this.backgroundColor, this.textColor, this.height = 120});
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//
//     return Container(
//       color: backgroundColor,
//       height: height,
//       width: size.width,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: <Widget>[
//           Expanded(
//             child: Align(
//               alignment: Alignment(1, 1),
//               child: GestureDetector(
//                 onTap: () {
//                   print(Scaffold.of(context).isDrawerOpen);
//                   Scaffold.of(context).openDrawer();
//                 },
//                 child: Icon(
//                   Icons.menu,
//                   size: 36,
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 4,
//             child: Padding(
//               padding: const EdgeInsets.all(7.0),
//               child: Text(
//                 text,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: textColor,
//                   fontSize: 25,
//                   fontFamily: 'SFProDisplay',
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//           ),
//           Spacer(),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(height);
// }
