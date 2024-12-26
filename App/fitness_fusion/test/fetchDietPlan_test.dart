import 'package:fitness_fusion/database/retrieveDietPlan.dart';
import 'package:fitness_fusion/dataclass/Plan.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fetchDietPlan', () {
    test('dietplan', () async {
      DietPlan result = await retrieveDietPlan(4);
      expect(result.id, 1);
    });
  });
}
