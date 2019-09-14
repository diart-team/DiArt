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
import 'package:di_art/error/errors.dart';
import 'package:test/test.dart';

void main() {
  errorFolderTests();
}

// `error` folder tests
errorFolderTests() {
  final msg = 'Message';
  group('`error` folder', () {
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
        allOf([throwsException, throwsA(isA<T>())]));
    expect(exception.toString(), equals('$T: $msg'));
  });
}
