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

import 'package:di_art/utils/Pair.dart';
import 'package:di_art/utils/lazy.dart';
import 'package:test/test.dart';

void main() {
  utilsFolderTests();
}


// `time` folder tests
utilsFolderTests() {
  group("`utils` folder", () {
    test('lazy class test', () {
      String key = "Key";
      String value = "Value";
      Pair<String, String> msg = Pair(key, value);
      int countInitialization = 0;
      var lazyValue = lazy<Pair>(() {
        countInitialization++;
        return msg;
      });

      expect(lazyValue(), msg);
      expect(countInitialization, 1);

      expect(lazyValue(), Pair(key, value));
      expect(countInitialization, 1);
    });

  });
}
