import 'package:econet/model/create_delivery_view_model.dart';
import 'package:econet/model/ecopoint_delivery.dart';
import 'package:econet/model/my_user.dart';
import 'package:econet/presentation/constants.dart';
import 'package:econet/services/delivery_repository.dart';
import 'package:econet/services/user.dart';
import 'package:econet/views/widgets/delivery_info_list.dart';
import 'package:econet/views/widgets/navbar.dart';
import 'package:econet/views/widgets/positive_negative_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeliveryOverview extends StatefulWidget {
  @override
  _DeliveryOverviewState createState() => _DeliveryOverviewState();
}

class _DeliveryOverviewState extends State<DeliveryOverview> {
  EcopointDelivery delivery;
  final viewModel = CreateDeliveryModel.instance;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    createDelivery();
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
                    text: 'Ecopoint delivery overview',
                    withBack: true,
                    backgroundColor: GREEN_LIGHT,
                    textColor: GREEN_DARK,
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      SingleChildScrollView(
                        child: DeliveryInfoList(delivery, GREEN_DARK),
                      ),
                      Positioned(
                        bottom: 0,
                        child:
                            PositiveNegativeButtons("CONFIRM", "DISCARD", () {
                          _isLoading = true;
                          setState(() {});

                          Provider.of<DeliveryProvider>(context, listen: false)
                              .createDelivery(delivery)
                              .then((value) {
                            if (value) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  '/home_econet',
                                  ModalRoute.withName('/ecopointExpanded'));
                            } else {
                              _isLoading = false;
                              setState(() {});
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Center(
                                  heightFactor: 1,
                                  child: Text(
                                    "Error while creating delivery. Make sure you have an internet connection",
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

  Future<void> createDelivery() async {
    MyUser user;

    AuthProvider provider =
        await Provider.of<AuthProvider>(context, listen: false);
    await provider.getCurrentUser().then((value) {
      user = value;
    });

    DateTime deadline = new DateTime(
        viewModel.deliveryDate.year,
        viewModel.deliveryDate.month,
        viewModel.deliveryDate.day,
        viewModel.deliveryTime.hour,
        viewModel.deliveryTime.minute);

    delivery = new EcopointDelivery(viewModel.ecopoint, deadline,
        viewModel.bags, user, false, false, false);

    _isLoading = false;
    setState(() {});
  }
}
