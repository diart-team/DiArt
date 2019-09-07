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

import 'package:di_art/error/errors.dart';
import 'package:equatable/equatable.dart';

///
/// DefinitionParameters - Parameter holder
/// Usable with exploded declaration
///
class DefinitionParameters extends Equatable {
  final List params;

  DefinitionParameters([this.params = const[]]) :super([params]);

  T _elementAt<T>(int i) {
    if (params.length > i) {
      return params[i] as T;
    } else {
      throw NoParameterFoundException(
          'Can\'t get parameter value #$i from $this');
    }
  }

  T component1<T>() => _elementAt(0);

  T component2<T>() => _elementAt(1);

  T component3<T>() => _elementAt(2);

  T component4<T>() => _elementAt(3);

  T component5<T>() => _elementAt(4);

  ///
  /// Get element at given index
  /// return T
  ///
  T get<T>([int i]) {
    if (i == null) {
      return _first();
    } else {
      return params[i] as T;
    }
  }

  ///
  /// Number of contained elements
  ///
  int size() => params.length;

  ///
  /// Tells if it has no parameter
  ///
  bool isEmpty() => params.isEmpty;

  ///
  /// Tells if it has parameters
  ///
  bool isNotEmpty() => !isEmpty();

  ///
  /// Get first element of given type T
  /// return T
  ///
  T _first<T>() => params.firstWhere((p) => p is T) as T;
}

const maxParams = 5;
const tag = 'DefinitionParameters';

DefinitionParameters parametersOf(List parameters) {
  if (parameters.length <= maxParams) {
    return DefinitionParameters(parameters);
  } else {
    throw Exception(
        '$tag: Can\'t build DefinitionParameters for more than $maxParams arguments');
  }
}

DefinitionParameters emptyParametersHolder() => DefinitionParameters();

///
/// Help define a DefinitionParameters
///
typedef ParametersDefinition = DefinitionParameters Function();
