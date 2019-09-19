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
import 'package:di_art/src/qualifier/qualifier.dart';
import 'package:di_art/src/scope/scope.dart';

class BeanDefinition<T>{

  final Qualifier qualifier;

  final Qualifier scopeName;

  final Type primaryType;

  //Main data
  var secondaryTypes = <Type>[];
//  DefinitionInstance<T> instance = null;
  Definition<T> definition;

  BeanDefinition([this.qualifier, this.scopeName, this.primaryType]);

  factory BeanDefinition._createDefinition() => BeanDefinition();

}

enum Kind { single, factory, scoped }

typedef Definition<T> = T Function(Scope, DefinitionParameters);
typedef OnReleaseCallback<T> = void Function(T);
typedef OnCloseCallback<T> = void Function(T);