import 'package:econet/model/create_ecopoint_view_model.dart';
import 'package:econet/model/ecopoint.dart';
import 'package:econet/model/my_user.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/services/ecopoint_repository.dart';
import 'package:econet/services/user.dart';
import 'package:econet/views/widgets/ecopoint_info_list.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:econet/views/widgets/positive_negative_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EcopointOveriew extends StatefulWidget {
  @override
  _EcopointOveriewState createState() => _EcopointOveriewState();
}

class _EcopointOveriewState extends State<EcopointOveriew> {
  final CreateEcopointModel viewModel = CreateEcopointModel.instance;
  Ecopoint ecopoint;
  MyUser _ecollector;
  bool _isLoading;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _additionalInfoController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    createEcopoint();
  }

  Future<void> createEcopoint() async {
    AuthProvider provider =
        await Provider.of<AuthProvider>(context, listen: false);
    await provider.getCurrentUser().then((value) {
      _ecollector = value;
    });

    DateTime deadline = new DateTime(
        viewModel.deliveryDate.year,
        viewModel.deliveryDate.month,
        viewModel.deliveryDate.day,
        viewModel.deliveryTime.hour,
        viewModel.deliveryTime.minute);
    ecopoint = new Ecopoint(
        _ecollector,
        false,
        viewModel.selectedResidues,
        viewModel.plant.id,
        deadline,
        viewModel.timeslotsWeekdays,
        viewModel.additionalInfo,
        viewModel.name,
        viewModel.address,
        viewModel.coordinates);

    _isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: GREEN_LIGHT,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: NavBar(
                    text: 'Ecopoint overview',
                    withBack: true,
                    backgroundColor: GREEN_LIGHT,
                    textColor: GREEN_DARK,
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                        padding: EdgeInsets.only(bottom: 100),
                        //tamanio del widget inferior
                        child: EcopointInfoList(
                          ecopoint,
                          true,
                          null,
                          _nameController,
                          _additionalInfoController,
                          editable: true,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child:
                            PositiveNegativeButtons("CONFIRM", "DISCARD", () {
                          _isLoading = true;
                          setState(() {});

                          Provider.of<EcopointProvider>(context, listen: false)
                              .createEcopoint(ecopoint)
                              .then((value) {
                            if (value) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/home_econet',
                                  ModalRoute.withName('/createEcopoint'));
                            } else {
                              _isLoading = false;
                              setState(() {});
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Center(
                                  heightFactor: 1,
                                  child: Text(
                                    "Error while creating Ecopoint. Make sure you have an internet connection",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ));
                            }
                          });
                        }, () {
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/home_econet',
                              ModalRoute.withName('/home_econet'));
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
