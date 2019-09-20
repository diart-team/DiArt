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
import 'package:di_art/src/instance/definition_instance.dart';
import 'package:di_art/src/qualifier/qualifier.dart';
import 'package:di_art/src/scope/scope.dart';

class BeanDefinition<T> {
  final Qualifier qualifier;

  final Qualifier scopeName;

  final Type primaryType;

  BeanDefinition(this.primaryType, [this.qualifier, this.scopeName]);

  factory BeanDefinition.createSingle(Definition<T> definition,
          [Qualifier qualifier, Qualifier scopeName]) =>
      BeanDefinition._createDefinition(
          qualifier, definition, Kind.single, scopeName);

  factory BeanDefinition.createScoped(Definition<T> definition,
          [Qualifier qualifier, Qualifier scopeName]) =>
      BeanDefinition._createDefinition(
          qualifier, definition, Kind.scoped, scopeName);

  factory BeanDefinition.createFactory(Definition<T> definition,
          [Qualifier qualifier, Qualifier scopeName]) =>
      BeanDefinition._createDefinition(
          qualifier, definition, Kind.factory, scopeName);

  factory BeanDefinition._createDefinition(Qualifier qualifier,
          Definition<T> definition, Kind kind, Qualifier scopeName) =>
      BeanDefinition<T>(T, qualifier, scopeName)
        ..definition = definition
        ..kind = kind;

  //Main data
  var secondaryTypes = <Type>[];
  DefinitionInstance<T> instance;
  Definition<T> definition;
  var options = Options();
  var properties = Properties();
  Kind kind;

  // lifecycle
  OnReleaseCallback<T> onRelease;
  OnCloseCallback<T> onClose;

  bool hasScopeSet() => scopeName != null;

  ///
  /// Create the associated Instance Holder
  ///
  createInstanceHolder() {
    switch (kind) {
      case Kind.single:
        break;
      case Kind.factory:
        break;
      case Kind.scoped:
        break;
    }
  }

  ///
  /// Resolve instance
  ///
  T resolveInstance(InstanceContext context) {
    var result = instance?.get(context);
    if (result == null) {
      error('Definition without any InstanceContext - $this');
    }
    return result;
  }

  @override
  String toString() {
    var defKind = kind.toString();
    var defName = qualifier != null ? "name:'$qualifier', " : '';
    var defScope = scopeName != null ? "scope:'$scopeName', " : '';
    var defType = "primary_type:'$primaryType'";
    var defOtherTypes =
        secondaryTypes.isNotEmpty ? secondaryTypes.join(',') : '';
    return '[type:$defKind,$defScope$defName$defType$defOtherTypes]';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BeanDefinition &&
          runtimeType == other.runtimeType &&
          qualifier == other.qualifier &&
          primaryType == other.primaryType;

  @override
  int get hashCode {
    var result = qualifier?.hashCode ?? 0;
    result = 31 * result + primaryType.hashCode;
    return result;
  }

  close() {
    instance?.close();
    instance = null;
  }
}

enum Kind { single, factory, scoped }

typedef Definition<T> = T Function(Scope, DefinitionParameters);
typedef OnReleaseCallback<T> = void Function(T);
typedef OnCloseCallback<T> = void Function(T);
