import 'package:di_art/error/errors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  errorFolderTests();
}

errorFolderTests() {
  String msg = "Message";
  group("error folder", () {
    exceptionTest<BadScopeInstanceException>(BadScopeInstanceException(msg), msg);
    exceptionTest<DefinitionOverrideException>(DefinitionOverrideException(msg), msg);
    exceptionTest<DiArtAppAlreadyStartedException>(DiArtAppAlreadyStartedException(msg), msg);
    exceptionTest<InstanceCreationException>(InstanceCreationException(msg, Exception()), msg);
    exceptionTest<MissingPropertyException>(MissingPropertyException(msg), msg);
    exceptionTest<NoBeanDefFoundException>(NoBeanDefFoundException(msg), msg);
    exceptionTest<NoParameterFoundException>(NoParameterFoundException(msg), msg);
    exceptionTest<NoPropertyFileFoundException>(NoPropertyFileFoundException(msg), msg);
    exceptionTest<NoScopeDefinitionFoundException>(NoScopeDefinitionFoundException(msg), msg);
    exceptionTest<ScopeAlreadyCreatedException>(ScopeAlreadyCreatedException(msg), msg);
    exceptionTest<ScopeAlreadyCreatedException>(ScopeAlreadyCreatedException(msg), msg);
  });
}

exceptionTest<T extends Exception>(Exception exception, String msg) {
  test('$T test', () {
    expect(() => throw exception,
        allOf([throwsException, throwsA(isInstanceOf<T>())]));
    expect(exception.toString(), equals("$T: $msg"));
  });
}
