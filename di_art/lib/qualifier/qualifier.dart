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

Qualifier named<T>([String name]) => name != null ? Qualifier._byName(name) : Qualifier._byType(T);

// Help qualify a component
abstract class Qualifier{

  // Give a String qualifier
  factory Qualifier._byName(String name)=> StringQualifier(name);

  // Give a Type based qualifier
  factory Qualifier._byType(Type type) => TypeQualifier(type);
}

/// Private
class StringQualifier implements Qualifier{

  final String _name;

  StringQualifier(this._name);

  @override
  String toString() => _name;

}

class TypeQualifier implements Qualifier{

  final Type _type;

  TypeQualifier(this._type);

  @override
  String toString() => _type.toString();

}

