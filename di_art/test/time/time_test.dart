/*
 * Copyright 2019 DiArt.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import 'dart:io';

import 'package:di_art/time/measure.dart';
import 'package:test/test.dart';

void main() {
  timeFolderTests();
}


// `time` folder tests
timeFolderTests() {
  const delay = 2;
  group('`time` folder', () {

    test('measure duration only test', () {
      var isExecuted = false;
      var result = measureDurationOnly((){
        isExecuted = true;
        sleep(const Duration(seconds: delay));
      });
      expect(result.toInt(), delay);
      expect(isExecuted, isTrue);
    });

    test('measure duration test', () {
      var isExecuted = false;
      final resultStr = 'Success!';
      var result = measureDuration((){
        isExecuted = true;
        sleep(const Duration(seconds: delay));
        return resultStr;
      });
      expect(result.second.toInt(), delay);
      expect(isExecuted, isTrue);
      expect(result.first, resultStr);
    });

  });
}
