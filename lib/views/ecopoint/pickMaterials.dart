import 'package:econet/model/create_ecopoint_view_model.dart';
import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/residue.dart';
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
  List<String> selectedChoices = List();
  Ecopoint ecopoint;
  bool alreadyCreated = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (!alreadyCreated) {
      ecopoint = ModalRoute.of(context).settings.arguments;
      if (ecopoint != null) {
        ecopoint.residues.forEach((element) {
          print("NUEVO ELEMENTO DE ID: " + element.toString());
          selectedChoices.add(residueToString(element));
        });
      }
      alreadyCreated = !alreadyCreated;
    }
    return Scaffold(
      backgroundColor: BROWN_LIGHT,
      appBar: NavBar(
        backgroundColor: BROWN_LIGHT,
        withBack: true,
        text: 'Select the materials you can deliver',
        textColor: BROWN_DARK,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        ResiduesChip(
                          onSelectedItem: (newList) {
                            setState(() {
                              selectedChoices = newList;
                            });
                          },
                          selectedChoices: selectedChoices,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Button1(
                  btnData: ButtonData(
                    "CONTINUE",
                    () {
                      if (selectedChoices.length == 0) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Center(
                            heightFactor: 1,
                            child: Text(
                              'Please select a residue type',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ));
                      } else {
                        if (ecopoint != null) {
                          //TODO: POST A API CON NUEVOS RESIDUOS Y CAMBIO VIEWMODEL

                          Navigator.pop(context);
                        } else {
                          final createEcopointModel =
                              CreateEcopointModel.instance;
                          createEcopointModel.selectedResidues =
                              selectedChoices;
                          Navigator.pushNamed(context, '/pickDeliveryDate');
                        }
                      }
                    },
                    backgroundColor: BROWN_MEDIUM,
                    textColor: Colors.white,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ResiduesChip extends StatefulWidget {
  Function(List<String>) onSelectedItem;
  List<String> selectedChoices;

  ResiduesChip({this.onSelectedItem, this.selectedChoices});

  @override
  _ResiduesChipState createState() => _ResiduesChipState();
}

class _ResiduesChipState extends State<ResiduesChip> {
  List<Widget> list = List();

  _buildChoiceList() {
    List<Widget> choices = List();
    RESIDUES.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(4.0),
        child: ChoiceChip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          pressElevation: 0,
          label: Container(
            width: 250,
            height: 40,
            alignment: Alignment.center,
            child: Text(
              widget.selectedChoices.contains(item) ? '✓ ' + item : item,
              style: TextStyle(
                fontSize: 27,
                fontFamily: 'SFProDisplay',
                color: widget.selectedChoices.contains(item)
                    ? Colors.black
                    : Colors.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          backgroundColor: CHIP_DATA[item],
          selectedColor: TinyColor(CHIP_DATA[item]).brighten(20).color,
          selected: widget.selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              widget.selectedChoices.contains(item)
                  ? widget.selectedChoices.remove(item)
                  : widget.selectedChoices.add(item);
              widget.onSelectedItem(widget.selectedChoices);
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
