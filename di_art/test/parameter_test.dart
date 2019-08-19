/*
 * Copyright 2019 DiArt.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:di_art/parameter/definition_parameters.dart';
import 'package:test/test.dart';

void main() {
  parameterFolderTests();
}

// `parameter` folder tests
parameterFolderTests() {
  group("`parameter` folder", () {
    test('create a parameters holder', () {
      String myString = "empty";
      int myInt = 42;

      DefinitionParameters parameterHolder = parametersOf([myString, myInt]);

      expect(parameterHolder.size(), 2);
      expect(parameterHolder.isNotEmpty(), isTrue);
    });

    test('create an empty parameters holder', () {
      DefinitionParameters parameterHolder = parametersOf();

      expect(parameterHolder.size(), 0);
      expect(parameterHolder.isEmpty(), isTrue);
    });

    test('get parameters from a parameter holder', () {
      String myString = "empty";
      int myInt = 42;

      DefinitionParameters parameterHolder = parametersOf([myString, myInt]);
      var component1 = parameterHolder.component1();
      var component2 = parameterHolder.component2();
      expect(myString, component1);
      expect(myInt, component2);
    });

    test('can`t create parameters more than max params', () {
      try {
        parametersOf([1, 2, 3, 4, 5, 6]);
        fail("Can't build more than $MAX_PARAMS");
      } on TestFailure catch (e, s) {
        print(s);
      }
    });
  });
}
