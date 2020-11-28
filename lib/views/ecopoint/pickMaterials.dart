import 'package:econet/model/create_ecopoint_view_model.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/views/widgets/button1.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class PickMaterials extends StatefulWidget {
  @override
  _PickMaterialsState createState() => _PickMaterialsState();
}

class _PickMaterialsState extends State<PickMaterials> {
  List<String> residues;

  List<String> selectedResidues = List();


  void fillList() {
    residues.add('Paper');
    residues.add('Metal');
    residues.add('Glass');
    residues.add('Plastic');
    residues.add('Electronics');
    residues.add('Wood');
    residues.add('Textile');
    residues.add('Ecopoints Only');
    residues.add('Recycling Plants Only');
  }

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context).settings.arguments as Map;
    Size size = MediaQuery.of(context).size;
    residues = List();
    fillList();
    return Scaffold(
      backgroundColor: BROWN_LIGHT,
      appBar: NavBar(
        backgroundColor: BROWN_LIGHT,
        withBack: true,
        text: 'Select the materials you can deliver',
        textColor: BROWN_DARK,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              width: size.width * 0.8,
              height: 430 /*arguments['materialsList'].length * 110*/,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ResiduesChip(
                      list: residues,
                      onSelectedItem: (newList) {
                        setState(() {
                          selectedResidues = newList;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Button1(
              btnData: ButtonData(
                "CONTINUE",
                () {
                  if (selectedResidues.length == 0) {
                    //TODO show snackbar
                  } else {
                    final createEcopointModel = CreateEcopointModel.instance;
                    createEcopointModel.selectedResidues = selectedResidues;
                    Navigator.pushNamed(context, '/pickDeliveryDate');
                  }
                },
                backgroundColor: BROWN_MEDIUM,
                textColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResiduesChip extends StatefulWidget {
  List<String> list;
  Function(List<String>) onSelectedItem;

  ResiduesChip({this.list, this.onSelectedItem});

  @override
  _ResiduesChipState createState() => _ResiduesChipState();
}

class _ResiduesChipState extends State<ResiduesChip> {
  List<String> selectedChoices = List();
  List<Widget> list = List();

  _buildChoiceList() {
    List<Widget> choices = List();
    widget.list.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(4.0),
        child: ChoiceChip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          label: Container(
            width: 270,
            height: 40,
            child: Text(
              item,
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'SFProDisplay',
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: CHIP_DATA[item],
          selectedColor: TinyColor(CHIP_DATA[item]).darken(30).color,
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectedItem(selectedChoices);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    list = _buildChoiceList();
    return ListView.builder(
      itemBuilder: (context, idx) {
        return list[idx];
      },
      itemCount: list.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      controller: ScrollController(),
    );
  }
}
