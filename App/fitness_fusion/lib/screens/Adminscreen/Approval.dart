import 'package:fitness_fusion/database/requestTrainer.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/dataclass/Plan.dart';
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
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${approval.name}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text('Date Of Birth: ${getStringDate(approval.date_of_birth)}'),
            const SizedBox(height: 8.0),
            Text('Contacts Info: ${approval.contact} / ${approval.email}'),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    onApprove();
                  },
                  child: const Text('Approve'),
                ),
                ElevatedButton(
                  onPressed: () {
                    onReject();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.red),
                  ),
                  child: const Text('Reject'),
                ),
              ],
            ),
          ],
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
        appBar: buildAppBar(screenHeight, screenWidth),
        body: ListView.builder(
          itemCount: Requests.length,
          itemBuilder: (context, index) {
            return ApprovalCardWidget(
              approval: Requests[index],
              onApprove: () {
                setState(() async {
                  if (await manageRequest(context, Requests[index].user_id, 1)) {
                    Requests.removeAt(index);
                  }
                });
              },
              onReject: () {
                setState(() async {
                  if (await manageRequest(context, Requests[index].user_id, 0)) {
                    Requests.removeAt(index);
                  }
                });
              },
            );
          },
        ));
  }
}
