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

import 'package:di_art/src/definition/bean_definition.dart';
import 'package:logart/logart.dart';

///
/// Koin Instance Holder
/// create/get/release an instance of given definition
///
abstract class DefinitionInstance<T>{
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
  T create(InstanceContext context){
    if (logger.isAt(Level.DEBUG)) {
      debug("| create instance for $beanDefinition");
    }
    try {
      val parameters: DefinitionParameters = context.parameters
      val result = beanDefinition.definition(context.scope ?: error("Can't execute definition instance while this context is not registered against any Koin instance"), parameters)
      return result as T
    } catch (e: Exception) {
    val stack =
    e.toString() + ERROR_SEPARATOR + e.stackTrace.takeWhile { !it.className.contains("sun.reflect") }
        .joinToString(ERROR_SEPARATOR)
    logger.error("Instance creation error : could not create instance for $beanDefinition: $stack")
    throw InstanceCreationException("Could not create instance for $beanDefinition", e)
    }
  }
}

class InstanceContext{}