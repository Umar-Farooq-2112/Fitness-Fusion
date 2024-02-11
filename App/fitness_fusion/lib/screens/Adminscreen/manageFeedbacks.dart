import 'package:fitness_fusion/dataclass/FeedBack.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:fitness_fusion/screens/Adminscreen/mywidgets.dart';
import 'package:flutter/material.dart';


class FeedbackDisplayWidget extends StatelessWidget {
  final UserFeedback feedback;

  const FeedbackDisplayWidget({
    Key? key,
    required this.feedback,
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
              'User: ${feedback.userName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text('Date: ${_formatDate(feedback.date)}'),
            const SizedBox(height: 8.0),
            Text('Feedback: ${feedback.description}'),
            const SizedBox(height: 16.0),

          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}

class FeedbackList extends StatefulWidget {
  const FeedbackList({super.key});

  @override
  _FeedbackListState createState() => _FeedbackListState();
}

class _FeedbackListState extends State<FeedbackList> {


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: buildAppBar(screenHeight, screenWidth),
        body: ListView.builder(
          itemCount: All_Feedbacks.length,
          itemBuilder: (context, index) {
            return FeedbackDisplayWidget(
              feedback: All_Feedbacks[index],

            );
          },
        ));
  }
}
