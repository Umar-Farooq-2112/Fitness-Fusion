import 'package:fitness_fusion/database/retrieveFeedBack.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fetchFeedback', () {

    test('feedbackentries', () async {
    await retrieveFeedback();
      expect(All_Feedbacks[0].userName, "mok");
      expect(All_Feedbacks[1].userName, "mok");
    });

    test('feedbackLength', () async {
    await retrieveFeedback();
      expect(All_Feedbacks.length, 3);
    });
  
  });
}