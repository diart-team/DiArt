
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

  final Function _initializer;
  T _value;

  _LazyImpl(this._initializer);

  T call()  {
    if (_value == null) {
      _value = _initializer != null ? _initializer() : null;
    }
    return _value;
  }

}
