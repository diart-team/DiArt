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

///
/// Bean Definitions options
///
class Options {
  bool override;
  bool isCreatedAtStart;

  Options([this.isCreatedAtStart = false, this.override = false]);

  String toString() =>
      'Options{isCreatedAtStart: $isCreatedAtStart, override: $override}';

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Options &&
          runtimeType == other.runtimeType &&
          override == other.override &&
          isCreatedAtStart == other.isCreatedAtStart;

  int get hashCode => override.hashCode ^ isCreatedAtStart.hashCode;
}
