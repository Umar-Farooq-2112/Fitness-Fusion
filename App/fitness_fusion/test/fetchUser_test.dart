import 'package:fitness_fusion/database/login.dart';
import 'package:fitness_fusion/dataclass/User.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fetchUserData', () {
    test('testAdmin', () async {
      User result = await fetchUserData(1);
      expect(result.user_id, 1);
      expect(result.name, "Admin");
    });
    test('testUser', () async {
      User result = await fetchUserData(2);
      expect(result.user_id, 2);
      expect(result.name, "Muhammad Owais Khan");
    });
  });
}
