

import 'package:di_art/qualifier/qualifier.dart';
import 'package:test/test.dart';

void main(){
  qualifierFolderTests();
}

// `qualifier` folder tests
qualifierFolderTests() {
  group("`qualifier` folder", () {
      String name = "Name";
      qualifierTest<StringQualifier>(named(name), name);
      qualifierTest<TypeQualifier>(named<String>(), name.runtimeType.toString());
      qualifierTest<StringQualifier>(named<int>(name), name);
  });
}

qualifierTest<T extends Qualifier>(Qualifier qualifier, String name) {
  test('$T test', () {
    expect(qualifier.toString(), name);
    expect(qualifier, isA<T>());
  });
}