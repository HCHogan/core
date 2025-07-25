// Copyright 2025 International Digital Economy Academy
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

///|
type StringBuilder Ref[String]

///|
/// Creates a new string builder with an optional initial capacity hint.
///
/// Parameters:
///
/// * `size_hint` : An optional initial capacity hint for the internal buffer. If
/// less than 1, a minimum capacity of 1 is used. Defaults to 0. It is the size of bytes, 
/// not the size of characters. `size_hint` may be ignored on some platforms, JS for example.
///
/// Returns a new `StringBuilder` instance with the specified initial capacity.
///
pub fn StringBuilder::new(size_hint~ : Int = 0) -> StringBuilder {
  ignore(size_hint)
  { val: "" }
}

///|
/// Return whether the given buffer is empty.
pub fn StringBuilder::is_empty(self : StringBuilder) -> Bool {
  self.val == ""
}

///|
/// Writes a string to the StringBuilder.
pub impl Logger for StringBuilder with write_string(self, str) {
  self.val += str
}

///|
#intrinsic("%char.to_string")
fn char_to_string(char : Char) -> String {
  [char]
}

///|
/// Writes a character to the StringBuilder.
pub impl Logger for StringBuilder with write_char(self, ch) {
  self.val += char_to_string(ch)
}

///|
/// Writes a part of the given string to the StringBuilder.
/// 
/// Parameters:
///
/// * `self` : The StringBuilder to write to.
/// * `str` : The given string.
/// * `start` : The start index of the substring to write.
/// * `len` : The length of the substring to write.
///
/// Example:
///
/// ```moonbit
///   let sb = StringBuilder::new()
///   sb.write_substring("Hello, world!", 0, 5)
///   assert_eq(sb.to_string(), "Hello")
/// ```
pub impl Logger for StringBuilder with write_substring(
  self : StringBuilder,
  str : String,
  start : Int,
  len : Int,
) -> Unit {
  self.val += str.substring(start~, end=start + len)
}

///|
pub impl Show for StringBuilder with output(self, logger) {
  logger.write_string(self.val)
}

///| 
/// Returns the current content of the StringBuilder as a string.
pub fn StringBuilder::to_string(self : StringBuilder) -> String {
  self.val
}

///| 
/// Resets the string builder to an empty state.
pub fn StringBuilder::reset(self : StringBuilder) -> Unit {
  self.val = ""
}
