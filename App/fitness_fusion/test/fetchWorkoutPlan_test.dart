import 'package:fitness_fusion/database/retrieveWorkoutPlan.dart';
import 'package:fitness_fusion/dataclass/Plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fetchWorkoutPlan', () {
    test('testPlan', () async {
      WorkoutPlan result = await retriveWorkoutPlan(4);
      expect(result.id, 1);
    });
  });
}
