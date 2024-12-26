import 'package:fitness_fusion/database/login.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('validPassword', () {

    test('testifvalidAdmin', () async {
    int res = await checkValidPassword("admin","adminpassword");
      expect(res, 1);
    });  
    test('testifvalidTrainer', () async {
    int res = await checkValidPassword("mok","pass");
      expect(res, 2);
    });  
    test('testifvalidUser', () async {
    int res = await checkValidPassword("temp","pass");
      expect(res, 3);
    });  
    test('testInvalid', () async {
    int res = await checkValidPassword("user1","pass");
      expect(res, 0);
    });  
  });
}
