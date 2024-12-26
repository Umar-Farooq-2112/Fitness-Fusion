import 'package:fitness_fusion/database/DataRetrival.dart';
import 'package:fitness_fusion/dataclass/GlobalData.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group('fetchFoodItems', () {
    test('AllFoodItemsFirstEntry', () async {
      await fetchAndSetFoodItems();
      expect(All_Food_Items[0].name, "Broccoli");
      expect(All_Food_Items[0].id, 1);
      expect(All_Food_Items[0].sugar, 0);
    });

    test('AllFoodItemsLength', () async {
      await fetchAndSetFoodItems();
      expect(All_Food_Items.length, equals(9));
    });
  });
}
