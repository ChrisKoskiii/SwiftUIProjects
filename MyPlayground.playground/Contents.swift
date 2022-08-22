import UIKit

func challenge(str1: String, str2: String) -> Bool {
  return str1.sorted() == str2.sorted()
}


challenge(str1: "Hello", str2: "eHllo")
