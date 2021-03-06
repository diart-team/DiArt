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
import 'package:di_art/utils/pair.dart';

double measureDurationOnly(Function code){
  var start = DateTime.now().microsecondsSinceEpoch;
  code();
  return (DateTime.now().microsecondsSinceEpoch - start) / 1000000.0;
}

Pair<T, double> measureDuration<T>(T Function() code){
  final start = DateTime.now().microsecondsSinceEpoch;
  final result = code();
  final duration = (DateTime.now().microsecondsSinceEpoch - start) / 1000000.0;
  return Pair(result, duration);
}

