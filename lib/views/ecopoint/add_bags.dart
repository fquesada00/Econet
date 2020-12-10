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
      resizeToAvoidBottomInset: false,
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
                          return BagInfoRow(bagList, index, true,
                              setAncestorState: () => setState(() {}));
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
                            'ADD BAGS', () => _showAddBagDialogs(context),
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

  void _showAddBagDialogs(BuildContext context) {
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
                                }, bagSize: bagSize, bagWeight: bagWeight)));
                      })));
            })));
  }
}

class BagInfoRow extends StatefulWidget {
  final List<Bag> bagList;
  final int index;
  final bool isEditable;
  final Function setAncestorState;

  BagInfoRow(this.bagList, this.index, this.isEditable,
      {this.setAncestorState});

  @override
  _BagInfoRowState createState() =>
      _BagInfoRowState(bagList, index, isEditable);
}

class _BagInfoRowState extends State<BagInfoRow> {
  List<Bag> bagList;
  int index;
  bool isEditable;

  _BagInfoRowState(this.bagList, this.index, this.isEditable);

  @override
  Widget build(BuildContext context) {
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
                      color: _getBagInfoColor(bagSize: bagList[index].size),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  alignment: Alignment.center,
                  child: Text(bagSizeToString(bagList[index].size),
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
                      color: _getBagInfoColor(bagWeight: bagList[index].weight),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  alignment: Alignment.center,
                  child: Text(bagWeightToString(bagList[index].weight),
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
                'x' + bagList[index].qty.toString(),
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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        _BagDialog(_EditBagDialogContent(bagList, index, () {
                      setState(() {});
                      widget.setAncestorState();
                    })),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _EditBagDialogContent extends StatefulWidget {
  final List<Bag> bagList;
  final int index;
  static Bag bagDataEdit;
  final Function setAncestorState;

  _EditBagDialogContent(this.bagList, this.index, this.setAncestorState) {
    if (bagDataEdit == null) {
      bagDataEdit = new Bag(
          bagList[index].size, bagList[index].weight, bagList[index].qty);
    }
  }

  @override
  __EditBagDialogContentState createState() =>
      __EditBagDialogContentState(bagDataEdit);
}

class __EditBagDialogContentState extends State<_EditBagDialogContent> {
  Bag bagDataEdit;

  __EditBagDialogContentState(this.bagDataEdit);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _EditBagDialogContent.bagDataEdit = null;
        return true;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Edit bags/objets information',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          Column(
            children: <Widget>[
              Text('Quantity',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      fontFamily: 'SFProText')),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  showDialog(
                      context: context,
                      builder: (context) =>
                          _BagDialog(_BagQtyDialogContent((int qty) {
                            bagDataEdit.qty = qty;
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) => _BagDialog(
                                  _EditBagDialogContent(widget.bagList,
                                      widget.index, widget.setAncestorState)),
                            );
                          }, isEdit: true, initQty: bagDataEdit.qty)));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  width: 230,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: EDIT_COLOR,
                      borderRadius: BorderRadius.circular(7)),
                  child: Text(
                    bagDataEdit.qty.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          RaisedButton(
              elevation: 0,
              highlightElevation: 0,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 18),
              color: ERROR_COLOR,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              onPressed: () {
                widget.bagList.removeAt(widget.index);
                widget.setAncestorState();
                Navigator.pop(context);
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                      size: 30,
                    ),
                    Text('DELETE',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        )),
                  ])),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Button1(
                btnData: ButtonData(
                  'SAVE',
                  () {
                    int idx = widget.index;
                    widget.bagList[idx] = bagDataEdit;
                    // widget.bagList[idx].size = bagDataEdit.size;
                    // widget.bagList[idx].weight = bagDataEdit.weight;
                    // widget.bagList[idx].qty = bagDataEdit.qty;
                    _EditBagDialogContent.bagDataEdit = null;
                    widget.setAncestorState();
                    Navigator.pop(context);
                  },
                  backgroundColor: GREEN_DARK,
                  adjust: true,
                  height: 40,
                  width: 100,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Button1(
                btnData: ButtonData(
                  'DISCARD',
                  () {
                    _EditBagDialogContent.bagDataEdit = null;
                    Navigator.pop(context);
                  },
                  backgroundColor: RED_MEDIUM,
                  adjust: true,
                  height: 40,
                  width: 100,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ],
          )
        ],
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
  final int initQty;
  final bool isEdit;
  int bagQty;

  _BagQtyDialogContent(this.setBagQty,
      {this.bagSize, this.bagWeight, this.initQty, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        isEdit
            ? Text(
                'Edit bag quantity',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              )
            : RichText(
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
                          style: TextStyle(
                              color: _getBagInfoColor(bagSize: bagSize))),
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
            initialValue: initQty == null ? '0' : initQty.toString(),
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
        isEdit
            ? Button1(
                btnData: ButtonData('EDIT', () {
                if (_qtyFormKey.currentState.validate()) setBagQty(bagQty);
              }, height: 40, adjust: true, fontWeight: FontWeight.w600))
            : Button1(
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
