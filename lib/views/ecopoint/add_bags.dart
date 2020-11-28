import 'package:econet/model/bag.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class AddBags extends StatefulWidget {
  @override
  _AddBagsState createState() => _AddBagsState();
}

class _AddBagsState extends State<AddBags> {
  Bag bagData1 = new Bag(BagSize.small, BagWeight.light, 2);
  Bag bagData2 = new Bag(BagSize.medium, BagWeight.veryHeavy, 2);
  Bag bagData3 = new Bag(BagSize.extraLarge, BagWeight.veryHeavy, 5);

  List<Bag> bagList;
  BagSize bagSize;
  BagWeight bagWeight;
  int bagQty;

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
            BagInfoCardContainer(
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
                        btnData: ButtonData(
                            'ADD BAGS', () => _showDialogs(context),
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

  void _showDialogs(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => _BagDialog(_BagSizeDialogContent((BagSize size) {
              bagSize = size;
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) =>
                      _BagDialog(_BagWeightDialogContent((BagWeight weight) {
                        bagWeight = weight;
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) =>
                                _BagDialog(_BagQtyDialogContent((int qty) {
                                  bagQty = qty;
                                  Bag newBag =
                                      new Bag(bagSize, bagWeight, bagQty);
                                  int idx;
                                  if ((idx = bagList.indexOf(newBag)) != -1) {
                                    if (bagList[idx].qty + bagQty > 99) {
                                      bagList[idx].qty = 99;
                                    } else
                                      bagList[idx].qty =
                                          bagList[idx].qty + bagQty;
                                  } else {
                                    bagList.add(newBag);
                                  }
                                  setState(() {});
                                  Navigator.pop(context);
                                }, bagSize, bagWeight)));
                      })));
            })));
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
}

class _BagSizeDialogContent extends StatelessWidget {
  final Function(BagSize size) setBagSize;

  _BagSizeDialogContent(this.setBagSize);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Select your bags' and/or objects' size",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20),
        Wrap(
          spacing: 7,
          runSpacing: 7,
          alignment: WrapAlignment.center,
          children: BagSize.values
              .map(
                (size) => RaisedButton(
                  color: _getBagInfoColor(bagSize: size),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  padding: EdgeInsets.zero,
                  onPressed: () => setBagSize(size),
                  child: Container(
                    height: 120,
                    width: 120,
                    alignment: Alignment.center,
                    child: Text(
                      bagSizeToString(size).toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(height: 20),
        RaisedButton(
          color: INFO_COLOR,
          onPressed: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Text(
            "How can I determine my bags' sizes?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}

class _BagWeightDialogContent extends StatelessWidget {
  final Function(BagWeight weight) setBagWeight;

  _BagWeightDialogContent(this.setBagWeight);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Select your bags' and/or objects' weight",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 20),
        Wrap(
          spacing: 7,
          runSpacing: 7,
          alignment: WrapAlignment.center,
          children: BagWeight.values
              .map(
                (weight) => RaisedButton(
                  color: _getBagInfoColor(bagWeight: weight),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  padding: EdgeInsets.zero,
                  onPressed: () => setBagWeight(weight),
                  child: Container(
                    height: 120,
                    width: 120,
                    alignment: Alignment.center,
                    child: Text(
                      bagWeightToString(weight).toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(height: 20),
        RaisedButton(
          color: INFO_COLOR,
          onPressed: () {},
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Text(
            "How can I determine my bags' weights?",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}

class _BagQtyDialogContent extends StatelessWidget {
  final Function(int qty) setBagQty;
  final BagSize bagSize;
  final BagWeight bagWeight;
  final _qtyFormKey = GlobalKey<FormState>();
  int bagQty;

  _BagQtyDialogContent(this.setBagQty, this.bagSize, this.bagWeight);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "How many ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: bagSizeToString(bagSize).toLowerCase(),
                    style:
                        TextStyle(color: _getBagInfoColor(bagSize: bagSize))),
                TextSpan(text: ' and '),
                TextSpan(
                    text: bagWeightToString(bagWeight).toLowerCase(),
                    style: TextStyle(
                        color: _getBagInfoColor(bagWeight: bagWeight))),
                TextSpan(text: ' bags or objects will you deliver?')
              ]),
        ),
        Form(
          key: _qtyFormKey,
          child: TextFormField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: TextStyle(
              fontSize: 20,
            ),
            decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: 'Quantity',
                errorStyle: TextStyle(
                  fontSize: 16,
                )),
            validator: (value) {
              int qty = int.parse(value.isEmpty ? '0' : value);
              if (qty <= 0 || qty > 99)
                return 'Insert a value between 0 and 99';
              else {
                bagQty = qty;
                return null;
              }
            },
          ),
        ),
        Text(
          'Add up to 99 bags',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: EDIT_COLOR),
        ),
        Button1(
            btnData: ButtonData('ADD BAGS', () {
          if (_qtyFormKey.currentState.validate()) setBagQty(bagQty);
        },
                height: 40,
                adjust: true,
                fontWeight: FontWeight.w600,
                icon: Icon(Icons.add_circle))),
      ],
    );
  }
}

class _BagDialog extends StatelessWidget {
  final Widget content;

  _BagDialog(this.content);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentHolder(context),
    );
  }

  Widget contentHolder(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 500,
          padding: EdgeInsets.fromLTRB(16, 70, 16, 16),
          margin: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(17),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: content,
        ),
        Positioned(
            top: 0,
            left: 1,
            right: 1,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: SvgPicture.asset(
                'assets/artwork/recycle-bag.svg',
                semanticsLabel: 'Recycling bag',
              ),
              radius: 50,
            )),
        Positioned(
          top: 60,
          left: 10,
          child: CupertinoNavigationBarBackButton(
            color: Colors.black,
          ),
        )
      ],
    );
  }
}

class BagInfoCardContainer extends StatelessWidget {
  final Widget content;
  final String header;
  final IconData icon;

  BagInfoCardContainer({this.content, this.header, this.icon});

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
