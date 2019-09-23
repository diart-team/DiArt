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

import 'package:di_art/src/diart.dart';
import 'package:di_art/src/definition/bean_definition.dart';
import 'package:di_art/src/error/errors.dart';
import 'package:di_art/src/parameter/definition_parameters.dart';
import 'package:di_art/src/scope/scope.dart';

///
/// DiArt Instance Holder
/// create/get/release an instance of given definition
///
abstract class DefinitionInstance<T> {
  static const error_separator = '\n\t';
  final BeanDefinition<T> beanDefinition;

  DefinitionInstance(this.beanDefinition);

  ///
  ///Retrieve an instance
  ///@param context
  ///@return T
  ///
  // ignore: avoid_shadowing_type_parameters
  T get<T>(InstanceContext context);

  ///
  ///Create an instance
  ///@param context
  ///@return T
  ///
  // ignore: avoid_shadowing_type_parameters
  T create<T>(InstanceContext context) {
    ///Todo logger
    try {
      var parameters = context.parameters;
      if (context.scope == null) {
        error(
            "Can't execute definition instance while this context is not registered against any Koin instance");
      }
      return beanDefinition.definition(context.scope, parameters) as T;
    } on Exception catch (e) {
      throw InstanceCreationException(
          'Could not create instance for $beanDefinition', e);
    }
  }

  ///
  ///Is instance created
  ///
  bool isCreated(InstanceContext context);

  ///
  ///Release the held instance (if hold)
  ///
  release(InstanceContext context);

  ///
  ///close the instance allocation from registry
  ///
  close();
}

///
///Instance resolution Context
///Help support DefinitionContext & DefinitionParameters when resolving definition function
///
class InstanceContext {
  final DiArt diart;
  final Scope scope;
  final DefinitionParameters parameters;

  InstanceContext({this.diart, Scope scope, ParametersDefinition initParams})
      : scope = scope ?? diart?.rootScope,
        parameters = initParams?.call() ?? emptyParametersHolder();
}

///
/// Factory Instance Holder
///
class FactoryDefinitionInstance<T> extends DefinitionInstance<T> {
  FactoryDefinitionInstance(BeanDefinition<T> beanDefinition)
      : super(beanDefinition);

  @override
  close() {
    beanDefinition.onClose?.call(null);
  }

  @override
  // ignore: avoid_shadowing_type_parameters
  T get<T>(InstanceContext context) => create(context);

  @override
  bool isCreated(InstanceContext context) => false;

  @override
  release(InstanceContext context) {}
}

///
/// Factory Instance Holder
///
class ScopeDefinitionInstance<T> extends DefinitionInstance<T> {
  ScopeDefinitionInstance(BeanDefinition<T> beanDefinition)
      : super(beanDefinition);

  final values = <String, T>{};

  @override
  close() {
    beanDefinition.onClose?.call(null);
    values.clear();
  }

  @override
  // ignore: avoid_shadowing_type_parameters
  T get<T>(InstanceContext context) {
    if (context.diart == null) {
      error('ScopeDefinitionInstance has no registered Koin instance');
    }

    if (context.scope == context.diart.rootScope) {
      throw ScopeNotCreatedException(
          'No scope instance created to resolve $beanDefinition');
    }
    final scope = context.scope;
    if (scope == null) {
      error('ScopeDefinitionInstance has no scope in context');
    }
    _checkScopeResolution(beanDefinition, scope);
    final internalId = scope.id;
    final current = (values[internalId] ??= create(context));
    if (current == null) {
      error('Instance creation from $beanDefinition should not be null');
    }
    return current as T;
  }

  @override
  bool isCreated(InstanceContext context) {
    return context.scope == null ? false : values[context.scope.id] != null;
  }

  @override
  release(InstanceContext context) {
    ///Todo logger
    final scope = context.scope;
    if (scope == null) {
      error('ScopeDefinitionInstance has no scope in context');
    }
    beanDefinition.onRelease?.call(values[scope.id]);
    values.remove(scope.id);
  }

  _checkScopeResolution(BeanDefinition definition, Scope scope) {
    final scopeInstanceName = scope.scopeDefinition?.qualifier;
    final beanScopeName = definition.scopeName;
    if (beanScopeName != scopeInstanceName) {
      if (scopeInstanceName == null) {
        throw BadScopeInstanceException(
            "Can't use definition $definition defined for scope '$beanScopeName', with an open scope instance $scope. Use a scope instance with scope '$beanScopeName'");
      } else if (beanScopeName != null) {
        throw BadScopeInstanceException(
            "Can't use definition $definition defined for scope '$beanScopeName' with scope instance $scope. Use a scope instance with scope '$beanScopeName'.");
      }
    }
  }
}

///
/// Single instance holder
///
class SingleDefinitionInstance<T> extends DefinitionInstance<T> {
  T _value;

  SingleDefinitionInstance(BeanDefinition<T> beanDefinition)
      : super(beanDefinition);

  @override
  close() {
    beanDefinition.onClose?.call(_value);
    _value = null;
  }

  @override
  // ignore: avoid_shadowing_type_parameters
  T get<T>(InstanceContext context) {
    _value ??= create(context);
    if (_value == null || (_value is T) == false) {
      error("Single instance created couldn't return value");
    }
    return _value as T;
  }

  @override
  bool isCreated(InstanceContext context) => _value != null;

  @override
  release(InstanceContext context) {}
}
