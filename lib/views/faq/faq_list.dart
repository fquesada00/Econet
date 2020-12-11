import 'package:econet/presentation/constants.dart';
import 'package:econet/views/faq/qa.dart';
import 'package:flutter/material.dart';

class FAQList extends StatelessWidget {
  final List<QA> questionList = [
    QA('How can I recycle with this application?',
        'Econet provides a simple and easy way to connect ecollectors with people who are willing to recycle. The aim of this app is to provide users who have certain materials to recycle with information about recycling plants and contact information of people who have planned trips to plants. This wishes to make the recycling process easier for everybody.'),
    QA('What is an Ecollector?',
        'Ecollectors are specific users of Econet willing to receive different types of residues in order to take them to recycling plants and centers. The only requirement to receive others residues is to provide an address for waste drop off. All of this can be done from within Econet.'),
    QA('How can I become an Ecollector?',
        'You can become an ecollector anytime from within our application. The option is within our navigation drawer. We recommend you to visit the “What is an Ecollector?” question if you are not sure as to whether to become an ecollector or not.'),
    QA('What is an Ecopoint?',
        'Ecopoints are addresses provided by ecollectors that are available in specified times and days for residue drop off. If you are an ecollector you can create your ecopoints so that other people can take different types of waste to that address. Ecopoints are assigned different waste materials that can be taken to that address.'),
    QA('How can I create an Ecopoint?',
        'To create an ecopoint you have to follow some simple steps. Firstly make sure that you are already an ecollector. If you are not, and don’t know how to become one, visit the “How can I become an ecollector?” question. Once you are an ecollector, to create an ecopoint you should tap on the recycling plant where you will be taking the gathered residues, and tap on the button “Create Ecopoint”. Information will be asked so that people can later choose your ecopoint according to their needs.'),
    QA('How can I contact an Ecollector?',
        'Once you have picked an ecopoint where you will be taking your residues, you will find information about the ecopoint’s owner. From the ecopoint screen you can schedule a delivery to that ecopoint (For more information visit “How can I schedule a delivery to an Ecopoint?”. Ecollector’s contact information will be provided in case any issue arises.'),
    QA('How can I know which ecopoint to go to?',
        'You can choose an ecopoint according to the materials you want to recycle. That is, if you separate plastic from other residues at home you can search for ecopoints that collect plastic specifically. We have a filter system for the ecopoint search. If you want to recycle but are not quite sure which residues you should be separating you can search ecopoints by location and see what materials do these ecopoints gather.'),
    QA('How can I close an Ecopoint?',
        "Access My Recycling through the navigation drawer, switch to your Ecopoints' tab, select an Ecopoint, and press the delete button on the top right corner."),
    QA('How can I schedule a delivery to an Ecopoint?',
        'In order to schedule a delivery to an Ecopoint, click on an Ecopoint from within the map, and select "Open Ecopoint". Once the Ecopoint details are loaded, click the "Recycle" button, and the process for scheduling a delivery will begin.')
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        color: GREEN_MEDIUM,
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 15),
        child: Column(
          children: List.generate(questionList.length, (index) {
            return GestureDetector(
              onTap: () {
                QA qa = questionList[index];
                Navigator.pushNamed(context, '/faq_answer', arguments: qa);
              },
              child: Container(
                height: 100,
                margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.white,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Expanded(
                      flex: 5,
                      child: Text(
                        questionList[index].question,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: GREEN_DARK,
                          fontSize: 22,
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.chevron_right,
                          size: 36,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
