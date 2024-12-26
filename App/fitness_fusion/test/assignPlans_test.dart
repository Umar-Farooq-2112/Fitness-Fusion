import 'package:fitness_fusion/database/assignPlans.dart';
import 'package:fitness_fusion/database/retrieveDietPlan.dart';
import 'package:fitness_fusion/database/retrieveWorkoutPlan.dart';
import 'package:fitness_fusion/dataclass/Plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('assignPlans', () {

    test('assignWorkoutPlan', () async {
      List<int> ids= [1 ,2];
      int id = 3;
      await findMatchingWorkoutPlan(ids,id);

      WorkoutPlan wresult = await retriveWorkoutPlan(id);

      expect(wresult.id, 2);

    });
    test('assignDietPlan', () async {
      List<int> ids= [1 ,2];
      int id = 3;
      await findMatchingDietPlan(ids,id);

      DietPlan dresult = await retrieveDietPlan(id);

      expect(dresult.id, 2);

    });


  });
}
