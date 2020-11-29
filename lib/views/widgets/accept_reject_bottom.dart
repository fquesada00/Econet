import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:flutter/cupertino.dart';

class AcceptOrRejectBottom extends StatelessWidget {
  String positiveButtonTExt;
  String negativeButtonText;
  Function positiveButtonFunction;
  Function negativeButtonFunction;

  AcceptOrRejectBottom(this.positiveButtonTExt, this.negativeButtonText,
      this.positiveButtonFunction, this.negativeButtonFunction);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: GREEN_DARK,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Button1(
            btnData: ButtonData(
              'SAVE',
              positiveButtonFunction,
              backgroundColor: GREEN_LIGHT,
              adjust: true,
              height: 60,
              width: 130,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          Button1(
            btnData: ButtonData(
              'DISCARD',
              negativeButtonFunction,
              backgroundColor: RED_MEDIUM,
              adjust: true,
              height: 60,
              width: 130,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
