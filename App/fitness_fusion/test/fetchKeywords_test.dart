import 'package:fitness_fusion/database/keywordsManagement.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fetchKeywords', () {

    test('KeywordsFirstEntry', () async {
    await retrieveKeywords();
      expect(All_Keywords[0].keyword, "Fat loss");
      expect(All_Keywords[1].keyword, "Muscle Gain");
    });

    test('KeywordsLength', () async {
    await retrieveKeywords();
      expect(All_Keywords.length, 5);
    });
  
  });
}
