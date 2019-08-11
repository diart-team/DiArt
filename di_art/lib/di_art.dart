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

library di_art;

//import 'package:di_art/registry/ScoreRegistry.dart';
//import 'package:di_art/registry/PropertyRegistry.dart';
//import 'package:di_art/score/Scope.dart';
//import 'package:di_art/parameter/DefinitionParameters.dart';
import 'package:di_art/utils/lazy.dart';

/// DiArt
/// Gather main features to use on DiArt context
class DiArt {

  //var scopeRegistry = ScopeRegistry();
  //var propertyRegistry = PropertyRegistry();
  //var rootScope = Scope("-Root-", isRoot: true, _diArt: this);

  /// Lazy inject a DiArt instance
  /// Returns: Lazy instance of type T
  //Lazy<T> inject<T>({Qualifier qualifier: null}, {DefinitionParameters noinlineParameters: null}) {
    //return rootScore.inject(qualifier, parameters)
  //}

  // TODO: injectOrNull

  /// Get a DiArt instance
//  T get<T>({Qualifier qualifier: null}, {DefinitionParameters noinlineParameters: null}) {
//    return rootScope.get(qualifier, parameters);
//  }

  // TODO: getOrNull

  // TODO: reflections??

  /// Get a all instance for given inferred class (in primary or secondary type)
//  List<dynamic> getAll() {
//    return rootScope.getAll();
//  }

  // TODO: bind??

//  _createEagerInstances() {
//    rootScore.createEagerInstances();
//  }

  /// Create a Scope instance
//  Scope createScope(ScopeId scopeId, Qualifier qualifier) {
//    return scopeRegistry.createScopeInstance(this, scopeId, qualifier);
//  }

  /// Get or Create a Scope instance
//  Scope getOrCreateScope(ScopeId scopeId, Qualifier qualifier) {
//    return scopeRegistry.getScopeInstanceOrNull(scopeId) ?? createScope(scopeId, qualifier);
//  }

  /// Get a scope instance
//  Score getScope(ScopeId scopeId) {
//    return scopeRegistry.getScopeInstance(scopeId);
//  }

  // TODO: getScopeOrNull

  /// Delete a scope instance
//  void deleteScope(ScopeId scopeId) {
//    scopeRegistry.deleteScopeInstance(scopeId);
//  }

  /// Retrieve property
//  T getProperty<T>(String key, T defaultValue) {
//    return propertyRegistry.getProperty<T>(key) ?? defaultValue;
//  }

  /// Save property
//  void setProperty<T>(String key, T value) {
//    propertyRegistry.savePropert(key, value);
//  }

  /// Close all resources from the context
//  void close() {
//    scopeRegistry.close();
//    rootScope.close();
//    propertyRegistry.close();
//  }

}
