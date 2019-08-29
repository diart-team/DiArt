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
/// USAGE
///
/// Wrap the variable in the global lazy function:
/// String text = lazy<String>(() => "Text")();

/// API

Lazy<T> lazy<T>(T Function() function) => Lazy._lazy(function);

abstract class Lazy<T> {
  T call();
  factory Lazy._lazy(T Function() function) => _LazyImpl<T>(function);
}

/// Private
class _LazyImpl<T> implements Lazy<T>{

  final T Function() _initializer;
  T _value;

  _LazyImpl(this._initializer);

  @override
  T call()  => _value ??= (_initializer != null ? _initializer() : null);

}
