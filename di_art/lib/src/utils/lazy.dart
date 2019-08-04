
/// USAGE
///
/// Example 1:
///
/// class SomeClass {
///  var _v  = new Lazy<int>(() {
///    return 10;
///  });
///  int get v => _v();
///}
///
/// void main() {
///  var sc = new SomeClass();
///  print(sc.v);
///}
///
/// Example 2:
///
/// class Fibonacci {
///  final int n;
///
///  var _result;
///  int get result => _result();
///
///  Fibonacci(this.n) {
///     _result = new Lazy<int>(() => _compute(this.n));
///  }
///
///  int _compute(n) {
///    if ( n == 0 )
///      return 0;
///   	else if ( n == 1 )
///      return 1;
///   	else
///      return (_compute(n-1) + _compute(n-2));
///  }
///}
///
///  void main() {
///    print(new Fibonacci(5).result);
///}


class Lazy<T> {

  // MARK: - Properties

  static final _cache = new Expando();
  final Function _func;
  const Lazy(this._func);

  // MARK: - API

  T call() {
    var result = _cache[this];
    if (identical(this, result)) {
      return null;
    }
    if (result != null) {
      return result;
    }
    result = _func();
    _cache[this] = (result == null) ? this : result;

    return result;
  }

}