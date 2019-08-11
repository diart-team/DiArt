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

//import 'package:di_art/module/module.dart';
import 'package:di_art/di_art.dart';

class DiArtApplication {

  static final DiArtApplication _instance = DiArtApplication._internal();
  DiArtApplication._internal();
  factory DiArtApplication() {
    var app = DiArtApplication();
    app._loadDefaults();
    return _instance;
  }

  var diArt = DiArt();

  _loadDefaults() {
    //diArt.scopeRegistry.loadDefaultScopes(diArt);
  }

  /// Load definitions from modules
//  DiArtApplication modules(List<Module> modules) {
//    // TODO: logger level check
//    _loadModulesAndScopes(modules);
//    return this;
//  }

//  _loadModulesAndScopes(Iterable<Module> modules) {
//    diArt.rootScope.beanRegistry.loadModules(modules);
//    diArt.scopeRegistry.loadScopes(modules);
//  }

  /// Load properties from Map
//  DiArtApplication properties(Map<String, dynamic> values) {
//    diArt.propertyRegistry.saveProperties(values);
//    return this;
//  }

  /// Load properties from File
//    DiArtApplication fileProperties({String fileName: "/diArt.properties"}) {
//      diArt.propertyRegistry.loadPropertiesFromFile(fileName);
//      return this;
//    }

  /// Load properties from Enviroment
//  DiArtApplication enviromentProperties() {
//    diArt.propertyRegistry.loadEnviromentProperties();
//    return this;
//  }

  // TODO: logger??

//  DiArtApplication createEagerInstances() {
//    // TODO: logger level check
//    diArt.createEagerInstances();
//    return this;
//  }

  /// Close all resources from DiArt & remove Standalone DiArt instance
  /// WARNING: needs to be synchronized
//  void close() {
////    diArt.close();
////  }

//  DiArtApplication unloadModules(List<Module> modules) {
//    diArt.rootScope.beanRegistry.unloadModules(modules);
//    diArt.scopeRegistry.unloadScopedDefinitions(modules);
//    return this;
//  }

}