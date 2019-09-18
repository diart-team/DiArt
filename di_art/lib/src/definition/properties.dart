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

import 'package:di_art/di_art.dart';

///
/// Definitions Properties
///
class Properties {

  final Map<String, Object> _data;

  Properties([Map<String, Object> data]): _data = data ?? {};

  set<T>(String key, T value){
    _data[key] = value;
  }

  T getOrNull<T>(String key){
    final value = _data[key];
    if(value is T){
      return value;
    }else{
      return null;
    }
  }

  T get<T>(String key) {
    final value = _data[key];
    if(value != null && value is T){
      return value;
    }else{
      throw MissingPropertyException("missing property for '$key'");
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Properties &&
              runtimeType == other.runtimeType &&
              toString() == other.toString();

  @override
  int get hashCode => _data.hashCode;

  @override
  String toString() {
    return 'Properties{_data: $_data}';
  }

}