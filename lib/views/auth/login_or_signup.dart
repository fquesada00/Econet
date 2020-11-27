import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:econet/presentation/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:econet/views/widgets/button1.dart';

class LoginOrSignup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Nos da datos sobre la resolucion de la pantalla
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                //Contenedor con los circulos
                Container(
                  width: size.width,
                  height: size.height * 0.55,
                  child: CustomPaint(
                    painter: _DrawCircles(),
                  ),
                ),
                //Contenedor con el logo
                Container(
                  width: size.width * 0.65,
                  child: SvgPicture.asset(
                    'assets/icons/econet-white-logo.svg',
                    semanticsLabel: 'Econet Logo',
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.1),
            Button1(
                btnData: ButtonData(
              'SIGN UP',
              () {
                Navigator.pushNamed(context, '/signup_method');
              },
              backgroundColor: GREEN_MEDIUM,

            )),
            SizedBox(height: size.height * 0.03),
            Button1(
                btnData: ButtonData(
              'LOG IN',
              () {
                Navigator.pushNamed(context, '/login');
              },
              backgroundColor: BROWN_MEDIUM,
            )),
          ],
        ));
  }
}

class _DrawCircles extends CustomPainter {
  var _paint = Paint()..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    Point center = Point(size.width / 2, size.height / 2);
    _paint.color = GREEN_MEDIUM;
    canvas.drawCircle(
        Offset(-center.x * 0.2, center.y * 0.4), size.width / 2 * 0.75, _paint);
    _paint.color = BROWN_LIGHT.withOpacity(0.74);
    canvas.drawCircle(
        Offset(center.x * 0.4, center.y * 1.2), size.width / 2 * 0.70, _paint);
    _paint.color = GREEN_LIGHT.withOpacity(0.46);
    canvas.drawCircle(
        Offset(-center.x * 0.3, center.y * 1.7), size.width / 2 * 0.60, _paint);
    _paint.color = GREEN_LIGHT.withOpacity(1);
    canvas.drawCircle(
        Offset(center.x * 2.3, center.y * 1.9), size.width / 2 * 0.70, _paint);
    _paint.color = GREEN_LIGHT.withOpacity(0.46);
    canvas.drawCircle(
        Offset(center.x * 1.4, center.y * 1.7), size.width / 2 * 0.60, _paint);
    _paint.color = BROWN_DARK;
    canvas.drawCircle(
        Offset(center.x, center.y), size.width / 2 * 0.75, _paint);
    _paint.color = GREEN_MEDIUM.withOpacity(0.61);
    canvas.drawCircle(
        Offset(center.x * 1.7, -center.y * 0.3), size.width / 2 * 0.9, _paint);
    _paint.color = BROWN_DARK.withOpacity(0.59);
    canvas.drawCircle(
        Offset(center.x * 2, center.y), size.width / 2 * 0.7, _paint);
    canvas.drawCircle(
        Offset(center.x * 0.7, -center.y * 0.6), size.width / 2 * 1.2, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
