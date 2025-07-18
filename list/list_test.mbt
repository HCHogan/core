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
test "from_array" {
  let ls = @list.of([1, 2, 3, 4, 5])
  let el : @list.T[Int] = @list.empty()
  inspect(ls, content="@list.of([1, 2, 3, 4, 5])")
  inspect(el, content="@list.of([])")
}

///|
test "pipe" {
  inspect(1 |> @list.T::prepend(@list.empty(), _), content="@list.of([1])")
}

///|
test "length" {
  let ls = @list.of([1, 2, 3, 4, 5])
  @json.inspect(ls.length(), content=5)
  @json.inspect(@list.singleton(11), content=[11])
}

///|
test "iter" {
  let ls = @list.of([1, 2, 3, 4, 5])
  let mut failed = false
  for i, x in ls {
    if x != i + 1 {
      failed = true
    }
  }
  inspect(failed, content="false")
}

///|
test "iteri" {
  let mut v = 0
  let mut failed = false
  let ls = @list.of([1, 2, 3, 4, 5])
  for i, x in ls {
    if x != i + 1 || i != v {
      failed = true
    }
    v = v + 1
  }
  inspect(failed, content="false")
}

///|
test "map" {
  let ls = @list.of([1, 2, 3, 4, 5])
  let rs : @list.T[Int] = @list.empty()
  inspect(ls.map(x => x * 2), content="@list.of([2, 4, 6, 8, 10])")
  inspect(rs.map(x => x * 2), content="@list.of([])")
}

///|
test "mapi" {
  let ls = @list.of([1, 2, 3, 4, 5])
  let el : @list.T[Int] = @list.empty()
  inspect(ls.mapi((i, x) => i * x), content="@list.of([0, 2, 6, 12, 20])")
  inspect(el.mapi((i, x) => i * x), content="@list.of([])")
}

///|
test "rev_map" {
  let ls = @list.of([1, 2, 3, 4, 5])
  let rs : @list.T[Int] = @list.empty()
  inspect(ls.rev_map(x => x * 2), content="@list.of([10, 8, 6, 4, 2])")
  inspect(rs.rev_map(x => x * 2), content="@list.of([])")
}

///|
test "to_array" {
  let list = @list.of([1, 2, 3, 4, 5])
  let empty : @list.T[Int] = @list.empty()
  let array = list.to_array()
  let earray = empty.to_array()
  inspect(array, content="[1, 2, 3, 4, 5]")
  inspect(earray, content="[]")
}

///|
test "filter" {
  let ls = @list.of([1, 2, 3, 4, 5])
  let rs : @list.T[Int] = @list.empty()
  inspect(ls.filter(x => x % 2 == 0), content="@list.of([2, 4])")
  inspect(rs.filter(x => x % 2 == 0), content="@list.of([])")
}

///|
test "all" {
  let ls = @list.of([1, 2, 3, 4, 5])
  inspect(ls.all(x => x > 0), content="true")
  inspect(ls.all(x => x > 1), content="false")
}

///|
test "any" {
  let ls = @list.of([1, 2, 3, 4, 5])
  inspect(ls.any(x => x > 4), content="true")
  inspect(ls.any(x => x > 5), content="false")
}

///|
test "unsafe_tail" {
  let ls = @list.of([1, 2, 3, 4, 5])
  inspect(ls.unsafe_tail(), content="@list.of([2, 3, 4, 5])")
}

///|
test "panic unsafe_tail" {
  let ls : @list.T[Int] = @list.empty()
  inspect(ls.unsafe_tail())
}

///|
test "head_exn" {
  let ls = @list.of([1, 2, 3, 4, 5])
  inspect(ls.head(), content="Some(1)")
}

///|
test "head" {
  let ls = @list.of([1, 2, 3, 4, 5])
  let el : @list.T[Int] = @list.of([])
  inspect(ls.head(), content="Some(1)")
  inspect(el.head(), content="None")
}

///|
test "last" {
  let ls = @list.of([1, 2, 3, 4, 5])
  inspect(ls.last(), content="Some(5)")
}

///|
test "concat" {
  let ls = @list.of([1, 2, 3, 4, 5])
  let rs = @list.of([6, 7, 8, 9, 10])
  inspect(ls.concat(@list.empty()), content="@list.of([1, 2, 3, 4, 5])")
  inspect(
    (@list.empty() : @list.T[Int]).concat(rs),
    content="@list.of([6, 7, 8, 9, 10])",
  )
  inspect(ls.concat(rs), content="@list.of([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])")
}

///|
test "rev_concat" {
  let ls = @list.of([1, 2, 3, 4, 5])
  let rs = @list.of([6, 7, 8, 9, 10])
  inspect(@list.empty().rev_concat(ls), content="@list.of([1, 2, 3, 4, 5])")
  inspect(rs.rev_concat(@list.empty()), content="@list.of([10, 9, 8, 7, 6])")
  inspect(
    ls.rev_concat(rs),
    content="@list.of([5, 4, 3, 2, 1, 6, 7, 8, 9, 10])",
  )
}

///|
test "rev" {
  let ls = @list.of([1, 2, 3, 4, 5])
  let rs = @list.of([5, 4, 3, 2, 1])
  inspect(rs.rev(), content="@list.of([1, 2, 3, 4, 5])")
  inspect(ls.rev().rev(), content="@list.of([1, 2, 3, 4, 5])")
}

///|
test "fold" {
  let ls = @list.of([1, 2, 3, 4, 5])
  let el : @list.T[Int] = @list.empty()
  inspect(el.fold((acc, x) => acc + x, init=0), content="0")
  inspect(ls.fold((acc, x) => acc + x, init=0), content="15")
}

///|
test "rev_fold" {
  let ls = @list.of(["1", "2", "3", "4", "5"])
  let el : @list.T[String] = @list.empty()
  inspect(ls.rev().fold((acc, x) => x + acc, init=""), content="12345")
  inspect(el.rev().fold((acc, x) => x + acc, init="init"), content="init")
}

///|
test "foldi" {
  let ls = @list.of([1, 2, 3, 4, 5])
  let el : @list.T[Int] = @list.empty()
  inspect(ls.foldi((i, acc, x) => acc + i * x, init=0), content="40")
  inspect(el.foldi((i, acc, x) => acc + i * x, init=0), content="0")
}

///|
test "rev_foldi" {
  let ls = @list.of([1, 2, 3, 4, 5])
  let el : @list.T[Int] = @list.empty()
  inspect(ls.rev().foldi((i, acc, x) => x * i + acc, init=0), content="20")
  inspect(el.rev().foldi((i, acc, x) => x * i + acc, init=0), content="0")
}

///|
test "zip" {
  let ls = @list.of([1, 2, 3, 4, 5])
  let rs = @list.of([6, 7, 8, 9, 10])
  inspect(
    ls.zip(rs),
    content="@list.of([(1, 6), (2, 7), (3, 8), (4, 9), (5, 10)])",
  )
}

///|
test "flat_map" {
  let ls = @list.of([1, 2, 3])
  let rs : @list.T[Int] = @list.empty()
  inspect(rs.flat_map(x => @list.of([x, x * 2])), content="@list.of([])")
  inspect(
    ls.flat_map(x => @list.of([x, x * 2])),
    content="@list.of([1, 2, 2, 4, 3, 6])",
  )
}

///|
test "filter_map" {
  let ls = @list.of([4, 2, 2, 6, 3, 1])
  let rs : @list.T[Int] = @list.empty()
  inspect(
    ls.filter_map(x => if x >= 3 { Some(x) } else { None }),
    content="@list.of([4, 6, 3])",
  )
  inspect(
    rs.filter_map(x => if x >= 3 { Some(x) } else { None }),
    content="@list.of([])",
  )
}

///|
test "nth" {
  let ls = @list.of([1, 2, 3, 4, 5])
  inspect(ls.nth(0), content="Some(1)")
  inspect(ls.nth(1), content="Some(2)")
}

///|
test "nth" {
  let ls = @list.of([1, 2, 3, 4, 5])
  inspect(ls.nth(0), content="Some(1)")
  inspect(ls.nth(20), content="None")
}

///|
test "repeat" {
  inspect(@list.repeat(5, 1), content="@list.of([1, 1, 1, 1, 1])")
  inspect(@list.repeat(0, 10), content="@list.of([])")
}

///|
test "intersperse" {
  let ls = @list.of(["1", "2", "3", "4", "5"])
  let el : @list.T[String] = empty()
  inspect(
    ls.intersperse("|"),
    content=
      #|@list.of(["1", "|", "2", "|", "3", "|", "4", "|", "5"])
    ,
  )
  inspect(el.intersperse("|"), content="@list.of([])")
}

///|
test "is_empty" {
  let ls = @list.of([1, 2, 3, 4, 5])
  inspect(ls.is_empty(), content="false")
  inspect((@list.empty() : @list.T[Unit]).is_empty(), content="true")
}

///|
test "unzip" {
  let ls = @list.of([(1, 2), (3, 4), (5, 6)])
  let (a, b) = ls.unzip()
  inspect(a, content="@list.of([1, 3, 5])")
  inspect(b, content="@list.of([2, 4, 6])")
}

///|
test "flatten" {
  let ls = @list.of([
    @list.of([1, 2, 3]),
    @list.of([4, 5, 6]),
    @list.of([7, 8, 9]),
  ])
  let el : @list.T[@list.T[Int]] = @list.empty()
  inspect(ls.flatten(), content="@list.of([1, 2, 3, 4, 5, 6, 7, 8, 9])")
  inspect(el.flatten(), content="@list.of([])")
}

///|
test "maximum" {
  let ls = @list.of([1, 123, 52, 3, 6, 0, -6, -76])
  inspect(ls.maximum(), content="Some(123)")
}

///|
test "minimum" {
  let ls = @list.of([1, 123, 52, 3, 6, 0, -6, -76])
  inspect(ls.minimum(), content="Some(-76)")
}

///|
test "sort" {
  let ls = @list.of([1, 123, 52, 3, 6, 0, -6, -76])
  let el : @list.T[Int] = @list.empty()
  inspect(el.sort(), content="@list.of([])")
  inspect(ls.sort(), content="@list.of([-76, -6, 0, 1, 3, 6, 52, 123])")
}

///|
test "sort-stack-safety" {
  let arr = FixedArray::makei(100_000, x => x)
  arr.rev_inplace()
  let ls = @list.of(arr)
  ls.sort() |> ignore
}

///|
test "contain" {
  let ls = @list.of([1, 2, 3])
  inspect(ls.contains(1), content="true")
  inspect(ls.contains(2), content="true")
  inspect(ls.contains(3), content="true")
  inspect(ls.contains(0), content="false")
  inspect(ls.contains(4), content="false")
}

///|
test "unfold" {
  let ls = @list.unfold(init=0, i => if i == 3 {
    None
  } else {
    Some((i, i + 1))
  })
  inspect(ls, content="@list.of([0, 1, 2])")
}

///|
test "rev_unfold" {
  let ls = @list.rev_unfold(init=0, i => if i == 3 {
    None
  } else {
    Some((i, i + 1))
  })
  inspect(ls, content="@list.of([2, 1, 0])")
}

///|
test "take" {
  let ls = @list.of([1, 2, 3, 4, 5])
  inspect(ls.take(3), content="@list.of([1, 2, 3])")
  inspect(ls.take(-1), content="@list.of([])")
  inspect(ls.take(7), content="@list.of([1, 2, 3, 4, 5])")
  inspect(ls.take(0), content="@list.of([])")
  inspect(ls.take(5), content="@list.of([1, 2, 3, 4, 5])")
}

///|
test "drop" {
  let ls = @list.of([1, 2, 3, 4, 5]).drop(3)
  let el : @list.T[Int] = @list.empty()
  inspect(ls, content="@list.of([4, 5])")
  inspect(ls.drop(-10), content="@list.of([4, 5])")
  inspect(ls.drop(10), content="@list.of([])")
  inspect(ls.drop(2), content="@list.of([])")
  inspect(ls.drop(0), content="@list.of([4, 5])")
  inspect(el.drop(0), content="@list.of([])")
}

///|
test "take_while" {
  let ls = @list.of([0, 1, 2, 3, 4]).take_while(x => x < 3)
  let el : @list.T[Int] = @list.empty().take_while(_e => true)
  inspect(ls, content="@list.of([0, 1, 2])")
  inspect(el, content="@list.of([])")
}

///|
test "drop_while" {
  let ls = @list.of([0, 1, 2, 3, 4]).drop_while(x => x < 3)
  let el : @list.T[Int] = @list.empty().drop_while(_e => true)
  inspect(ls, content="@list.of([3, 4])")
  inspect(el, content="@list.of([])")
}

///|
test "scan_left" {
  let el = @list.empty().scan_left((acc, x) => acc + x, init=0)
  let ls = @list.of([1, 2, 3, 4, 5]).scan_left((acc, x) => acc + x, init=0)
  let ls2 = @list.of([1, 2, 3, 4]).scan_left((acc, x) => acc - x, init=100)
  inspect(el, content="@list.of([0])")
  inspect(ls, content="@list.of([0, 1, 3, 6, 10, 15])")
  inspect(ls2, content="@list.of([100, 99, 97, 94, 90])")
}

///|
test "scan_right" {
  let el = @list.empty().scan_right((acc, x) => x + acc, init=0)
  let ls = @list.of([1, 2, 3, 4]).scan_right((acc, x) => x + acc, init=0)
  let ls2 = @list.of([1, 2, 3, 4]).scan_right((acc, x) => x - acc, init=100)
  inspect(el, content="@list.of([0])")
  inspect(ls, content="@list.of([10, 9, 7, 4, 0])")
  inspect(ls2, content="@list.of([98, -97, 99, -96, 100])")
}

///|
test "lookup" {
  let ls = @list.of([(1, "a"), (2, "b"), (3, "c")])
  let el : @list.T[(Int, Int)] = @list.empty()
  inspect(el.lookup(1), content="None")
  inspect(
    ls.lookup(3),
    content=
      #|Some("c")
    ,
  )
  inspect(ls.lookup(4), content="None")
}

///|
test "find" {
  inspect(
    @list.of([1, 3, 5, 8]).find(element => element % 2 == 0),
    content="Some(8)",
  )
  inspect(
    @list.of([1, 3, 5, 7]).find(element => element % 2 == 0),
    content="None",
  )
  inspect(
    (@list.empty() : @list.T[Int]).find(element => element % 2 == 0),
    content="None",
  )
}

///|
test "findi" {
  inspect(
    @list.of([1, 3, 5, 8]).findi((element, i) => element % 2 == 0 && i == 3),
    content="Some(8)",
  )
  inspect(
    @list.of([1, 3, 8, 5]).findi((element, i) => element % 2 == 0 && i == 3),
    content="None",
  )
  inspect(
    (@list.empty() : @list.T[Int]).findi((element, i) => element % 2 == 0 &&
      i == 3),
    content="None",
  )
}

///|
test "remove_at" {
  let ls = @list.of([1, 2, 3, 4, 5])
  inspect(ls.remove_at(2), content="@list.of([1, 2, 4, 5])")
  inspect(ls.remove_at(0), content="@list.of([2, 3, 4, 5])")
  inspect(
    @list.of(["a", "b", "c", "d", "e"]).remove_at(2),
    content=
      #|@list.of(["a", "b", "d", "e"])
    ,
  )
  inspect(
    @list.of(["a", "b", "c", "d", "e"]).remove_at(5),
    content=
      #|@list.of(["a", "b", "c", "d", "e"])
    ,
  )
}

///|
test "remove" {
  inspect(@list.of([1, 2, 3, 4, 5]).remove(3), content="@list.of([1, 2, 4, 5])")
  inspect(
    @list.of(["a", "b", "c", "d", "e"]).remove("c"),
    content=
      #|@list.of(["a", "b", "d", "e"])
    ,
  )
  inspect(
    @list.of(["a", "b", "c", "d", "e"]).remove("f"),
    content=
      #|@list.of(["a", "b", "c", "d", "e"])
    ,
  )
}

///|
test "is_prefix" {
  inspect(
    @list.of([1, 2, 3, 4, 5]).is_prefix(@list.of([1, 2, 3])),
    content="true",
  )
  inspect(
    @list.of([1, 2, 3, 4, 5]).is_prefix(@list.of([3, 2, 3])),
    content="false",
  )
  inspect(@list.empty().is_prefix(@list.of([1, 2, 3])), content="false")
}

///|
test "equal" {
  inspect(@list.of([1, 2, 3]) == @list.of([1, 2, 3]), content="true")
  inspect(@list.of([1, 2, 3]) == @list.of([1, 3, 3]), content="false")
  inspect(@list.empty() == @list.of([1]), content="false")
}

///|
test "is_suffix" {
  inspect(
    @list.of([1, 2, 3, 4, 5]).is_suffix(@list.of([3, 4, 5])),
    content="true",
  )
  inspect(
    @list.of([1, 2, 3, 4, 5]).is_suffix(@list.of([3, 4, 6])),
    content="false",
  )
}

///|
test "intercalate" {
  let ls = @list.of([
    @list.of([1, 2, 3]),
    @list.of([4, 5, 6]),
    @list.of([7, 8, 9]),
  ])
  let el : @list.T[@list.T[Int]] = @list.empty()
  inspect(
    ls.intercalate(@list.of([0])),
    content="@list.of([1, 2, 3, 0, 4, 5, 6, 0, 7, 8, 9])",
  )
  inspect(el.intersperse(@list.of([1])), content="@list.of([])")
}

///|
test "default" {
  let ls : @list.T[Int] = @list.default()
  inspect(ls, content="@list.of([])")
}

///|
test "iter" {
  let ls = @list.of([1, 2, 3, 4, 5])
  inspect(ls.iter().map(x => x + 1).fold((a, b) => a + b, init=0), content="20")
}

///|
test "List::output with non-empty list" {
  let buf = StringBuilder::new(size_hint=100)
  let list = @list.of([1, 2, 3, 4, 5])
  Show::output(list, buf)
  inspect(buf, content="@list.of([1, 2, 3, 4, 5])")
}

///|
test "List::output with empty list" {
  let buf = StringBuilder::new(size_hint=100)
  let list : @list.T[Int] = @list.empty()
  Show::output(list, buf)
  inspect(buf, content="@list.of([])")
}

///|
test "List::to_json with non-empty list" {
  let list = @list.of([1, 2, 3, 4, 5])
  @json.inspect(ToJson::to_json(list), content=[1, 2, 3, 4, 5])
}

///|
test "List::to_json with empty list" {
  let list : @list.T[Int] = empty()
  @json.inspect(ToJson::to_json(list), content=[])
}

///|
test "List::from_json" {
  for xs in (@quickcheck.samples(20) : Array[@list.T[Int]]) {
    assert_eq(xs, @json.from_json(xs.to_json()))
  }
}

///|
test "to_json/from_json" {
  let list = @list.of([1, 2, 3, 4, 5])
  let json_expected : Json = [1, 2, 3, 4, 5]
  @json.inspect(list, content=json_expected)
  let list2 : @list.T[Int] = @json.from_json(json_expected)
  @json.inspect(list2, content=json_expected)
  let v : Result[@list.T[Int], @json.JsonDecodeError] = try? @json.from_json({
      "a": 1,
    })
  @json.inspect(v, content={
    "Err": {
      "$tag": "JsonDecodeError",
      "0": ["$", "@list.from_json: expected array"],
    },
  })
  let v2 : @list.T[Int] = @list.from_json([1, 2, 3, 4])
  @json.inspect(v2, content=[1, 2, 3, 4])
}

///|
test "eachi" {
  let list = @list.of([1, 2, 3, 4, 5])
  let mut acc = 0
  list.eachi((i, x) => acc += x * i)
  assert_eq(acc, 40)
}

///|
test "List::head_exn with non-empty list" {
  let list = @list.of([1, 2, 3, 4, 5])
  let head = list.head()
  assert_eq(head, Some(1))
}

///|
test "List::last with non-empty list" {
  let list = @list.of([1, 2, 3, 4, 5])
  let last = list.last()
  assert_eq(last, Some(5))
}

///|
test "List::zip with lists of equal length" {
  let list1 = @list.of([1, 2, 3])
  let list2 = @list.of(["a", "b", "c"])
  let zipped = list1.zip(list2)
  let expected = @list.of([(1, "a"), (2, "b"), (3, "c")])
  assert_eq(zipped, expected)
}

///|
test "@list.zip with empty list" {
  inspect(
    @list.of([1]).zip((@list.empty() : @list.T[Int])),
    content="@list.of([])",
  )
}

///|
test "List::nth_exn with valid index" {
  let list = @list.of([1, 2, 3, 4, 5])
  let nth = list.nth(2)
  assert_eq(nth, Some(3))
}

///|
test "List::maximum with non-empty list" {
  let list = @list.of([1, 3, 5, 2, 4])
  let max = list.maximum()
  assert_eq(max, Some(5))
}

///|
test "@list.maximum with empty list" {
  inspect((@list.empty() : @list.T[Int]).maximum(), content="None")
}

///|
test "List::minimum with non-empty list" {
  let list = @list.of([1, 3, 5, 2, 4])
  let min = list.minimum()
  assert_eq(min, Some(1))
}

///|
test "@list.minimum with empty list" {
  (@list.empty() : @list.T[Int]).minimum() |> ignore
}

///|
test "op_add" {
  inspect(@list.of([1]) + @list.of([]), content="@list.of([1])")
  inspect(@list.of([]) + @list.of([1]), content="@list.of([1])")
  inspect(@list.of([1]) + @list.of([1]), content="@list.of([1, 1])")
  inspect(
    (@list.empty() : @list.T[Int]) + (@list.empty() : @list.T[Int]),
    content="@list.of([])",
  )
}

///|
test "from_iter multiple elements iter" {
  inspect(@list.from_iter([1, 2, 3].iter()), content="@list.of([1, 2, 3])")
}

///|
test "from_iter_rev multiple elements iter" {
  inspect(@list.from_iter_rev([1, 2, 3].iter()), content="@list.of([3, 2, 1])")
}

///|
test "from_iter single element iter" {
  inspect(@list.from_iter([1].iter()), content="@list.of([1])")
}

///|
test "from_iter empty iter" {
  let pq : @list.T[Int] = @list.from_iter(Iter::empty())
  inspect(pq, content="@list.of([])")
}

///|
test "hash" {
  let l1 = @list.of([1, 2, 3, 4, 5])
  let l2 = @list.of([1, 2, 3, 4, 5])
  inspect(l1.hash() == l2.hash(), content="true")
  let l3 = @list.of([5, 4, 3, 2, 1])
  inspect(l1.hash() == l3.hash(), content="false")
  let l4 : @list.T[Int] = @list.of([])
  inspect(l1.hash() == l4.hash(), content="false")
  inspect(l4.hash() == l4.hash(), content="true")
}

///|
test "immutability" {
  let l1 = @list.of([1, 2])
  let l2 = @list.of([l1, l1, l1, l1]).flatten()
  inspect(l2, content="@list.of([1, 2, 1, 2, 1, 2, 1, 2])")
  inspect(l1, content="@list.of([1, 2])")
  let l3 = l1.flat_map(_ => l1)
  inspect(l3, content="@list.of([1, 2, 1, 2])")
  inspect(l1, content="@list.of([1, 2])")
}

///|
test "advanced list manipulations" {
  // Test multiple operations chained together
  let l = @list.of([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

  // Filter even numbers, double them, and take first 3
  let result = l.filter(x => x % 2 == 0).map(x => x * 2).take(3)
  inspect(result, content="@list.of([4, 8, 12])")

  // Perform multiple transformations and ensure original list stays unchanged
  let orig = @list.of([3, 1, 4, 1, 5, 9, 2, 6])
  let sorted = orig.sort()
  let filtered = orig.filter(x => x > 3)
  let mapped = orig.map(x => x * x)
  inspect(orig, content="@list.of([3, 1, 4, 1, 5, 9, 2, 6])")
  inspect(sorted, content="@list.of([1, 1, 2, 3, 4, 5, 6, 9])")
  inspect(filtered, content="@list.of([4, 5, 9, 6])")
  inspect(mapped, content="@list.of([9, 1, 16, 1, 25, 81, 4, 36])")
}

///|
test "scan_right complex operations" {
  // Test scan_right with more complex operations
  let l1 = @list.of([1, 2, 3, 4])

  // Calculate running product from right to left
  let products = l1.scan_right((acc, x) => x * acc, init=1)
  inspect(products, content="@list.of([24, 24, 12, 4, 1])")

  // Test with string concatenation
  let l2 = @list.of(["a", "b", "c"])
  let concat = l2.scan_right((acc, x) => x + acc, init="")
  inspect(concat, content="@list.of([\"abc\", \"bc\", \"c\", \"\"])")

  // Test with more complex function
  let l3 = @list.of([10, 5, 8, 2])
  let result = l3.scan_right((acc, x) => if x > acc { x } else { acc }, init=0)
  inspect(result, content="@list.of([10, 8, 8, 2, 0])")
}

///|
test "drop advanced cases" {
  // Test drop with various edge cases
  let l = @list.of([1, 2, 3, 4, 5])

  // Drop negative number (should be treated as 0)
  inspect(l.drop(-3), content="@list.of([1, 2, 3, 4, 5])")

  // Drop exact length
  inspect(l.drop(5), content="@list.of([])")

  // Drop more than length
  inspect(l.drop(10), content="@list.of([])")

  // Drop from empty list
  let empty : @list.T[Int] = @list.empty()
  inspect(empty.drop(3), content="@list.of([])")

  // Drop 0
  inspect(l.drop(0), content="@list.of([1, 2, 3, 4, 5])")
}

///|
test "list manual grouping implementation" {
  // Test manual grouping implementation
  let mixed = @list.of([1, 2, 3, 4, 5, 6, 7, 8, 9])

  // Manually implement partition for even/odd
  let evens = mixed.filter(x => x % 2 == 0)
  let odds = mixed.filter(x => x % 2 != 0)

  // Check our manual implementation
  inspect(evens, content="@list.of([2, 4, 6, 8])")
  inspect(odds, content="@list.of([1, 3, 5, 7, 9])")
  assert_eq(evens.length(), 4)
  assert_eq(odds.length(), 5)
}

///|
test "equality" {
  // Test equality operators
  let l1 = @list.of([1, 2, 3])
  let l2 = @list.of([1, 2, 3])
  let l3 = @list.of([1, 2, 4])
  let l4 = @list.of([1, 2])
  let l5 = @list.of([1, 2, 3, 4])

  // Test equality
  assert_eq(l1, l2)
  assert_not_eq(l1, l3)
  assert_not_eq(l1, l4)
  assert_not_eq(l1, l5)
}

///|
test "advanced folding operations" {
  let l = @list.of([1, 2, 3, 4, 5])

  // Test fold for sum of squares
  let result = l.fold((acc, x) => acc + x * x, init=0)
  inspect(result, content="55")

  // Test fold with more complex operations
  let texts = @list.of(["hello", "world", "moonbit"])
  let counts = texts.fold((acc, s) => acc + s.length(), init=0)
  inspect(counts, content="17")

  // Test with multiple fold operations
  let list = @list.of([10, 20, 30, 40, 50])
  let sum = list.fold((acc, x) => acc + x, init=0)
  let max = list.fold(
    (acc, x) => if x > acc { x } else { acc },
    init=list.head().unwrap(),
  )
  let product = list.fold((acc, x) => acc * x, init=1)
  assert_eq(sum, 150)
  assert_eq(max, 50)
  assert_eq(product, 12000000)
}

///|
test "remove_at edge cases" {
  let l = @list.of([1, 2, 3, 4, 5])

  // Remove at negative index (should not change list)
  inspect(l.remove_at(-1), content="@list.of([1, 2, 3, 4, 5])")

  // Remove at exact last position
  inspect(l.remove_at(4), content="@list.of([1, 2, 3, 4])")

  // Remove at middle
  inspect(l.remove_at(2), content="@list.of([1, 2, 4, 5])")

  // Remove from empty list
  let empty : @list.T[Int] = @list.empty()
  inspect(empty.remove_at(0), content="@list.of([])")

  // Remove multiple elements
  let result = l.remove_at(0).remove_at(0).remove_at(0)
  inspect(result, content="@list.of([4, 5])")
}

///|
test "nested lists operations" {
  // Test operations on nested lists
  let nested = @list.of([@list.of([1, 2]), @list.of([3, 4]), @list.of([5, 6])])

  // Map each inner list
  let mapped = nested.map(inner => inner.map(x => x * 2))
  inspect(
    mapped,
    content="@list.of([@list.of([2, 4]), @list.of([6, 8]), @list.of([10, 12])])",
  )

  // Flatten and then map
  let flat_mapped = nested.flatten().map(x => x * 2)
  inspect(flat_mapped, content="@list.of([2, 4, 6, 8, 10, 12])")

  // Map and then flatten (should be equivalent to flat_map)
  let map_flatten = nested.map(inner => inner.map(x => x * 2)).flatten()
  inspect(map_flatten, content="@list.of([2, 4, 6, 8, 10, 12])")

  // Use flat_map directly
  let direct_flat_map = nested.flat_map(inner => inner.map(x => x * 2))
  inspect(direct_flat_map, content="@list.of([2, 4, 6, 8, 10, 12])")
}

///|
test "find and filter combination" {
  let l = @list.of([1, 2, 3, 4, 5])

  // Find first even number
  let first_even = l.find(x => x % 2 == 0)
  inspect(first_even, content="Some(2)")

  // Find when nothing matches
  let find_none = l.find(x => x > 10)
  inspect(find_none, content="None")

  // Manual implementation to find and transform
  let first_even_val = first_even.unwrap()
  let first_even_times_10 = first_even_val * 10

  // Check our manual transformation
  inspect(Some(first_even_times_10), content="Some(20)")

  // Filter and map combination to get squares of even numbers
  let filtered = l.filter(x => x % 2 == 0)
  let mapped = filtered.map(x => x * x)
  inspect(mapped, content="@list.of([4, 16])")
}

///|
test "intersperse with complex values" {
  // Test intersperse with different types of elements

  // String elements
  let words = @list.of(["hello", "moonbit", "world"])
  inspect(
    words.intersperse(", "),
    content="@list.of([\"hello\", \", \", \"moonbit\", \", \", \"world\"])",
  )

  // List elements
  let lists = @list.of([@list.of([1, 2]), @list.of([3, 4]), @list.of([5, 6])])
  let separator = @list.of([0, 0])
  let result = lists.intersperse(separator)
  inspect(result.length(), content="5")

  // Empty list with intersperse
  let empty : @list.T[Int] = @list.empty()
  inspect(empty.intersperse(0), content="@list.of([])")

  // Single element list with intersperse
  let single = @list.of(["a"])
  inspect(single.intersperse(","), content="@list.of([\"a\"])")
}

///|
test "complex list recursion safety" {
  // Create very large lists and ensure operations are stack safe

  // Create a large list using unfold
  let large = @list.unfold(init=0, i => if i < 10000 {
    Some((i, i + 1))
  } else {
    None
  })

  // Verify operations on large list work correctly without stack overflow
  assert_eq(large.length(), 10000)
  assert_eq(large.nth(9999), Some(9999))
  assert_eq(large.last(), Some(9999))

  // Test operations that traverse the entire list
  let sum = large.fold((acc, x) => acc + x, init=0)
  assert_eq(sum, 49995000) // Sum of numbers 0 to 9999

  // Test filter on large list
  let filtered = large.filter(x => x % 1000 == 0)
  assert_eq(filtered.length(), 10)
}

///|
test "is_prefix and is_suffix complex cases" {
  let l = @list.of([1, 2, 3, 4, 5])

  // Test is_prefix with various scenarios
  assert_true(l.is_prefix(@list.of([1])))
  assert_true(l.is_prefix(@list.of([1, 2])))
  assert_true(l.is_prefix(@list.of([1, 2, 3])))
  assert_false(l.is_prefix(@list.of([2, 3])))
  assert_false(l.is_prefix(@list.of([0, 1, 2])))

  // Test is_suffix with various scenarios
  assert_true(l.is_suffix(@list.of([5])))
  assert_true(l.is_suffix(@list.of([4, 5])))
  assert_true(l.is_suffix(@list.of([3, 4, 5])))
  assert_false(l.is_suffix(@list.of([2, 5])))
  assert_false(l.is_suffix(@list.of([3, 4, 6])))

  // Test with empty list
  let empty : @list.T[Int] = @list.empty()
  assert_true(empty.is_prefix(@list.of([])))
  assert_true(empty.is_suffix(@list.of([])))
  assert_true(l.is_prefix(@list.of([])))
  assert_true(l.is_suffix(@list.of([])))
}

///|
test "find_index" {
  // empty
  let empty = @list.empty()
  inspect(empty.find_index(x => x > 0), content="None")
  // basic
  let ls = @list.of([1, 2, 3, 4, 5])
  inspect(ls.find_index(x => x > 3), content="Some(3)")
  inspect(ls.find_index(x => x < 0), content="None")
  inspect(ls.find_index(x => x == 1), content="Some(0)")
  // all-match
  let ls = @list.of([2, 4, 6, 8, 10])
  inspect(ls.find_index(x => x % 2 == 0), content="Some(0)")
}
