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

class BadScopeInstanceException implements Exception {
  final String s;

  BadScopeInstanceException(this.s);

  @override
  String toString() => 'BadScopeInstanceException: $s';
}

class DefinitionOverrideException implements Exception {
  final String msg;

  DefinitionOverrideException(this.msg);

  @override
  String toString() => 'DefinitionOverrideException: $msg';
}

class DiArtAppAlreadyStartedException implements Exception {
  final String msg;

  DiArtAppAlreadyStartedException(this.msg);

  @override
  String toString() => 'DiArtAppAlreadyStartedException: $msg';
}

class InstanceCreationException implements Exception {
  final String msg;

  final Exception parent;

  InstanceCreationException(this.msg, this.parent);

  @override
  String toString() => 'InstanceCreationException: $msg';
}

class MissingPropertyException implements Exception {
  final String msg;

  MissingPropertyException(this.msg);

  @override
  String toString() => 'MissingPropertyException: $msg';
}

class NoBeanDefFoundException implements Exception {
  final String msg;

  NoBeanDefFoundException(this.msg);

  @override
  String toString() => 'NoBeanDefFoundException: $msg';
}

class NoParameterFoundException implements Exception {
  final String msg;

  NoParameterFoundException(this.msg);

  @override
  String toString() => 'NoParameterFoundException: $msg';
}

class NoPropertyFileFoundException implements Exception {
  final String msg;

  NoPropertyFileFoundException(this.msg);

  @override
  String toString() => 'NoPropertyFileFoundException: $msg';
}

class NoScopeDefinitionFoundException implements Exception {
  final String s;

  NoScopeDefinitionFoundException(this.s);

  @override
  String toString() => 'NoScopeDefinitionFoundException: $s';
}

class ScopeAlreadyCreatedException implements Exception {
  final String s;

  ScopeAlreadyCreatedException(this.s);

  @override
  String toString() => 'ScopeAlreadyCreatedException: $s';
}

class ScopeNotCreatedException implements Exception {
  final String msg;

  ScopeNotCreatedException(this.msg);

  @override
  String toString() => 'ScopeNotCreatedException: $msg';
}

error(String message) => throw Exception(message);
