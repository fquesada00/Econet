import 'package:econet/model/bag.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddBags extends StatefulWidget {
  @override
  _AddBagsState createState() => _AddBagsState();
}

class _AddBagsState extends State<AddBags> {
  Bag bagData1 = new Bag(BagSize.small, BagWeight.light, 2);
  Bag bagData2 = new Bag(BagSize.medium, BagWeight.veryHeavy, 2);
  Bag bagData3 = new Bag(BagSize.extraLarge, BagWeight.veryHeavy, 5);

  List<Bag> bagList;

  @override
  void initState() {
    super.initState();

    bagList = [bagData1, bagData2, bagData3];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BROWN_LIGHT,
      appBar: NavBar(
        backgroundColor: BROWN_LIGHT,
        withBack: true,
        textColor: BROWN_DARK,
        text: "Select your residue bags / objects",
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InfoCardContainer(
              content: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      height: 330,
                      width: 300,
                      child: ListView.separated(
                        padding: EdgeInsets.all(15),
                        itemCount: bagList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BagInfoRow(bagList[index], true);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(height: 8),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Button1(
                        btnData: ButtonData('ADD BAGS', () {},
                            height: 40,
                            adjust: true,
                            fontWeight: FontWeight.w600,
                            icon: Icon(Icons.add_circle))),
                  )
                ],
              ),
            ),
            Button1(
                btnData: ButtonData('CONTINUE', () {},
                    backgroundColor: BROWN_MEDIUM))
          ],
        ),
      ),
    );
  }
}

class BagInfoRow extends StatefulWidget {
  final Bag bagData;
  final bool isEditable;

  BagInfoRow(this.bagData, this.isEditable);

  @override
  _BagInfoRowState createState() => _BagInfoRowState(bagData, isEditable);
}

class _BagInfoRowState extends State<BagInfoRow> {
  Bag bagData;
  bool isEditable;

  _BagInfoRowState(this.bagData, this.isEditable);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE5E2E2),
        borderRadius: BorderRadius.all(Radius.circular(13)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  'Size',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SFProText'),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                      color: _getBagInfoColor(bagSize: bagData.size),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  alignment: Alignment.center,
                  child: Text(bagSizeToString(bagData.size),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      )),
                )
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'Weight',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SFProText'),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                      color: _getBagInfoColor(bagWeight: bagData.weight),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  alignment: Alignment.center,
                  child: Text(bagWeightToString(bagData.weight),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      )),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: Text(
                'x' + bagData.qty.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ),
            if (isEditable)
              IconButton(
                icon: Icon(Icons.edit),
                color: EDIT_COLOR,
                iconSize: 30,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                onPressed: () {},
              ),
          ],
        ),
      ),
    );
  }

  Color _getBagInfoColor({BagSize bagSize, BagWeight bagWeight}) {
    if (bagSize != null) {
      switch (bagSize) {
        case BagSize.small:
          return GREEN_MEDIUM;
        case BagSize.medium:
          return WARNING_COLOR;
        case BagSize.large:
          return RED_MEDIUM;
        case BagSize.extraLarge:
          return RED_DARK;
      }
    } else if (bagWeight != null) {
      switch (bagWeight) {
        case BagWeight.light:
          return GREEN_MEDIUM;
        case BagWeight.heavy:
          return WARNING_COLOR;
        case BagWeight.veryHeavy:
          return RED_MEDIUM;
      }
    }

    return null;
  }
}

class InfoCardContainer extends StatelessWidget {
  final Widget content;
  final String header;
  final IconData icon;

  InfoCardContainer({this.content, this.header, this.icon});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (header != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                header,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                  color: GREEN_DARK,
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (icon != null)
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      bottom: 20,
                    ),
                    child: Icon(
                      icon,
                      size: 40,
                    ),
                  ),
                ),
              Expanded(
                flex: 10,
                child: content,
              ),
            ],
          )
        ],
      ),
    );
  }
}
