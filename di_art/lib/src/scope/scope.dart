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
import 'package:di_art/src/definition/bean_definition.dart';
import 'package:di_art/src/diart.dart';
import 'package:di_art/src/instance/definition_instance.dart';
import 'package:meta/meta.dart';

class Scope {
  final String id;
  final bool isRoot;
  final DiArt _diArt;

  ScopeDefinition scopeDefinition;
  final _callbacks = <ScopeCallback>[];

  Scope({@required this.id, this.isRoot = false, @required DiArt diArt})
      : _diArt = diArt;

  ///
  /// Lazy inject a DiArt instance
  /// @param qualifier
  /// @param scope
  ///@param parameters
  ///
  /// @return Lazy instance of type T
  ///
  Lazy<T> inject<T>([Qualifier qualifier, ParametersDefinition parameters]) =>
      lazy(get(qualifier: qualifier, parameters: parameters));

  ///
  /// Lazy inject a DiArt instance if available
  /// @param qualifier
  /// @param scope
  /// @param parameters
  ///
  /// @return Lazy instance of type T or null
  ////
  Lazy<T> injectOrNull<T>(
          [Qualifier qualifier, ParametersDefinition parameters]) =>
      lazy(getOrNull(qualifier, parameters));

  ///
  /// Get a DiArt instance if available
  /// @param qualifier
  /// @param scope
  /// @param parameters
  ///
  ///@return instance of type T or null
  ///
  T getOrNull<T>([Qualifier qualifier, ParametersDefinition parameters]) {
    try {
      return get(clazz: T, qualifier: qualifier, parameters: parameters);
    } on Exception catch (e) {
      //Todo DiArt application and logger
      return null;
    }
  }

  ///
  /// Get a DiArt instance
  /// @param Type
  /// @param qualifier
  /// @param parameters
  ///
  T get<T>({Type clazz, Qualifier qualifier, ParametersDefinition parameters}) {
    final type = clazz ?? T;
    //Todo logger and diart application
    resolveInstance(qualifier, type, parameters);
  }

  T resolveInstance<T>(
      Qualifier qualifier, Type clazz, ParametersDefinition parameters) {
    return findDefinition(qualifier, clazz).resolveInstance(
        InstanceContext(diart: _diArt, scope: this, initParams: parameters));
  }

  BeanDefinition findDefinition(Qualifier qualifier, Type clazz) {
    //Todo bean registry
//    var definition = beanRegistry.findDefinition(qualifier, clazz);
//    if(definition == null){
//      if(isRoot){
//        throw NoBeanDefFoundException("No definition for '$clazz' has been found. Check your module definitions.");
//      }else{
//        definition = _diArt.rootScope.findDefinition(qualifier, clazz);
//      }
//    }
//    return definition;
  }

  createEagerInstances() {
    if (isRoot) {
      //Todo bean registry
//      final definitions = beanRegistry.findAllCreatedAtStartDefinition();
//      if (definitions.isNotEmpty()) {
//        definitions.forEach { (item) =>
//          item.resolveInstance<Object>(InstanceContext(diart : this._diArt, scope : this));
//        }
//      }
    }
  }

  ///
  /// Declare a component definition from the given instance
  ///  This result of declaring a scoped/single definition of type T, returning the given instance
  ///  (single definition of th current scope is root)
  ///
  /// @param instance The instance you're declaring.
  /// @param qualifier Qualifier for this declaration
  /// @param secondaryTypes List of secondary bound types
  /// @param override Allows to override a previous declaration of the same type (default to false).
  ///
  declare<T>(Type instance,
      {Qualifier qualifier, List<Type> secondaryTypes, bool override = false}) {
    final definition = isRoot
        ? BeanDefinition.createSingle(
            (scope, definitionParameters) => instance, qualifier)
        : BeanDefinition.createScoped((scope, definitionParameters) => instance,
            qualifier, scopeDefinition?.qualifier);
    if (secondaryTypes != null) {
      definition.secondaryTypes.addAll(secondaryTypes);
    }
    definition.options.override = override;
    // Todo beanRegistry.saveDefinition(definition)
  }

  ///
  /// Get current DiArt instance
  ///
  DiArt getDiArt() => _diArt;

  ///
  /// Get Scope
  /// @param scopeID
  ///
  Scope getScope(String scopeID) => getDiArt().getScope(scopeID);

  ///
  /// Register a callback for this Scope Instance
  ///
  registerCallback(ScopeCallback callback) {
    _callbacks.add(callback);
  }

  ///
  /// Get a all instance for given inferred class (in primary or secondary type)
  /// @param clazz T is optional
  ///
  ///  @return list of instances of type T
  ///
  List<T> getAll<T>([Type clazz]) {
    //Todo bean registry
  }

  ///
  /// Get instance of primary type P and secondary type S
  /// (not for scoped instances)
  ///
  /// @return instance of type S
  ///
  S bind<S, P>(
      [Type primaryType, Type secondaryType, ParametersDefinition parameters]) {
//    final seconType = secondaryType ?? S;
//    final primType = primaryType ?? P;
    //Todo bean registry
  }

  ///
  /// Retrieve a property
  /// @param key
  ///
  T getPropertyOrNull<T>(String key) {
    //Todo DiArt
  }

  ///
  /// Retrieve a property
  /// @param key
  /// @param defaultValue
  ///
  T getProperty<T>(String key, [T defaultValue]) {
    //Todo DiArt
  }

  declareDefinitionsFromScopeSet() {
    // ignore: avoid_function_literals_in_foreach_calls
    scopeDefinition?.definitions?.forEach((definition) {
      //Todo bean registry
      //beanRegistry.saveDefinition(definition);
      definition.createInstanceHolder();
    });
  }

  ///
  ///Close all instances from this scope
  ///
  close() {
    //Todo logger and Dart application
    //call on close from callbacks
    _callbacks
      ..forEach((item) => item.onScopeClose(this))
      ..clear();

    scopeDefinition?.release(this);
    //Todo bean registry
    //Todo DiArt
  }

  @override
  String toString() {
    final scopeDef = ",set:'${scopeDefinition?.qualifier}'";
    return "Scope[id:'$id'$scopeDef]";
  }
}

///
///Internal Scope Definition
///
class ScopeDefinition {
  final Qualifier qualifier;

  final definitions = <BeanDefinition<Type>>{};

  ScopeDefinition(this.qualifier);

  release(Scope instance) {
    for (var item in definitions) {
      item.instance?.release(InstanceContext(scope: instance));
    }
  }
}

///
/// Scope Callback
///
abstract class ScopeCallback {
  ///
  ///Called when scope is closing
  ///@param scope
  ///
  onScopeClose(Scope scope);
}
