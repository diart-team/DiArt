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
  T get(InstanceContext context);

  ///
  ///Create an instance
  ///@param context
  ///@return T
  ///
  T create(InstanceContext context) {
    ///Todo logger
    try {
      var parameters = context.parameters;
      if (context.scope == null) {
        error(
            "Can't execute definition instance while this context is not registered against any Koin instance");
      }
      return beanDefinition.definition(context.scope, parameters);
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
  bool release(InstanceContext context);

  ///
  ///close the instance allocation from registry
  ///
  close();
}

class InstanceContext {
  final DiArt diart;
  final ParametersDefinition _parameters;
  final Scope scope;
  final DefinitionParameters parameters;

  InstanceContext([this.diart, Scope scope, this._parameters])
      : scope = scope ?? diart?.rootScope,
        parameters = _parameters?.call() ?? emptyParametersHolder();
}
