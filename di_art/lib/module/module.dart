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

import 'package:di_art/definition/bean_definition.dart';
import 'package:di_art/definition/options.dart';
import 'package:di_art/scope/scope_definition.dart';

class Module {
  final bool _isCreatedAtStart;
  final bool _override;

  Module(this._isCreatedAtStart, this._override);

  final definitions = List<BeanDefinition<Object>>();
  final scopes = List<ScopeDefinition>();

  ///
  /// Declare a definition in current Module
  ///
  void declareDefinition<T>(BeanDefinition<T> definition, Options options) {
    definition.updateOptions(options);
    definitions.add(definition);
  }

  ///
  /// Declare a definition in current Module
  ///
  void declareScope(ScopeDefinition scope) {
    scopes.add(scope);
  }

  BeanDefinition<T> single<T>(
      [String name = null,
      bool createdAtStart = false,
      bool override = false,
      Definition<T> definition]) {}
}
