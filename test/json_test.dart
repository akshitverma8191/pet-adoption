import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test("Unit test asset data source", () async {

    // Load JSON
    final String loadedJsonString = await rootBundle.loadString('assets/data/animal_list.json');
    final List<dynamic> jsonList = jsonDecode(loadedJsonString);

    // Assertions
    expect(jsonList[0], isA<Map<String,dynamic>>());
    expect(jsonList[0]['name'], equals("Bruno"));
    expect(jsonList[0]['category'], equals("cat"));
  });
}
