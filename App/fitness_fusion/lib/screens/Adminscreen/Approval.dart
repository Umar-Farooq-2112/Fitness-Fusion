import 'package:fitness_fusion/database/requestTrainer.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/Plan.dart';
import 'package:fitness_fusion/dataclass/ThemeContent.dart';
import 'package:fitness_fusion/dataclass/User.dart';
import 'package:fitness_fusion/screens/Adminscreen/mywidgets.dart';
import 'package:flutter/material.dart';



class ApprovalCardWidget extends StatelessWidget {
  final User approval;
  final Function onApprove;
  final Function onReject;

  const ApprovalCardWidget({
    Key? key,
    required this.approval,
    required this.onApprove,
    required this.onReject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: ThemeColors.homescreenfont,
          width: 3
        )
      ),
      child: Card(
        color: ThemeColors.primary,
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: ${approval.name}',
                style: TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.homescreenfont),
              ),
              const SizedBox(height: 8.0),
              Text('Date Of Birth: ${getStringDate(approval.date_of_birth)}',style: TextStyle(color: ThemeColors.homescreenfont),),
              const SizedBox(height: 8.0),
              Text('Contacts Info: ${approval.contact} / ${approval.email}',style: TextStyle(color: ThemeColors.homescreenfont),),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      side: WidgetStateProperty.all(BorderSide(
                        color: ThemeColors.homescreenfont,
                        width: 2
                      )),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(ThemeColors.primary),
                    ),
                    onPressed: () {
                      onApprove();
                    },
                    child: Text('Approve',style: TextStyle(color: ThemeColors.homescreenfont),),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      onReject();
                    },
                    style: ButtonStyle(
                      side: WidgetStateProperty.all(BorderSide(
                        color: ThemeColors.homescreenfont,
                        width: 2
                      )),
                      backgroundColor:
                          WidgetStateProperty.all<Color>(ThemeColors.primary),
                    ),
                    child: Text('Reject',style: TextStyle(color: ThemeColors.homescreenfont),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ApprovalList extends StatefulWidget {
  const ApprovalList({super.key});

  @override
  _ApprovalListState createState() => _ApprovalListState();
}

class _ApprovalListState extends State<ApprovalList> {

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ThemeColors.primary,
        appBar: buildAppBar(screenHeight, screenWidth),
        body: ListView.builder(
          itemCount: Requests.length,
          itemBuilder: (context, index) {
            return ApprovalCardWidget(
              approval: Requests[index],
              onApprove: () {
                setState(() async {
                  if (await manageRequest( Requests[index].user_id, 1)) {
                    Requests.removeAt(index);
                  }
                });
              },
              onReject: () {
                setState(() async {
                  if (await manageRequest( Requests[index].user_id, 0)) {
                    Requests.removeAt(index);
                  }
                });
              },
            );
          },
        ));
  }
}
