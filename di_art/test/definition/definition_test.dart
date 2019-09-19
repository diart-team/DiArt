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

import 'package:di_art/di_art.dart' show MissingPropertyException, Properties, Options;
import 'package:test/test.dart';

void main() {
  definitionFolderTests();
}

// `parameter` folder tests
definitionFolderTests() {
  final key1 = 'Key1';
  final key2 = 'Key2';
  final nonexistentKey = 'nonexistent';
  final value1 = 'Value1';
  final value2 = 2;
  final map = <String, Object>{key1: value1, key2: value2};
  final properties = Properties(map);

  group('`definition` folder', () {
    group('`properties` file', () {
      test('create a properties holder', () {
        final properties1 = Properties();
        final properties2 = Properties({});
        final properties3 = Properties(map);

        expect(properties1, equals(properties2));
        expect(properties1, isNot(equals(properties3)));
        expect(properties2, isNot(equals(properties3)));
      });

      test('get properties from a properties holder', () {
        expect(properties.get(key1), equals(value1));
        expect(properties.get(key1), isA<String>());
        expect(properties.get(key2), equals(value2));
        expect(properties.get(key2), isA<int>());
      });

      test('can`t get nonexistent properties from a properties holder', () {
        expect(() => properties.get(nonexistentKey),
            allOf([throwsException, throwsA(isA<MissingPropertyException>())]));
      });

      test('can`t get properties with different type from a properties holder',
          () {
        expect(() => properties.get<int>(key1),
            allOf([throwsException, throwsA(isA<MissingPropertyException>())]));
      });

      test('get properties from a properties holder or null', () {
        expect(properties.get(key1), equals(value1));
        expect(properties.get(key1), isA<String>());
        expect(properties.getOrNull(nonexistentKey), isNull);
        expect(properties.getOrNull<int>(key1), isNull);
      });

      test('set properties to a properties holder', () {
        final properties = Properties({});

        expect(properties.getOrNull(key1), isNull);

        properties.set(key1, value1);

        expect(properties.get(key1), equals(value1));
        expect(properties.get(key1), isA<String>());
      });
    });
    group('`options` file', () {
      test('create a options holder', () {
        final options1 = Options(false, false);
        final options2 = Options();
        final options3 = Options(true, false);
        expect(options1, equals(options2));
        expect(options1.toString(), equals(options2.toString()));
        expect(options1, isNot(equals(options3)));

        options2.isCreatedAtStart = true;
        expect(options1, isNot(equals(options2)));
        expect(options1.toString(), isNot(equals(options2.toString())));
        expect(options2, equals(options3));
        expect(options2.toString(), equals(options3.toString()));
      });
    });
  });
}
