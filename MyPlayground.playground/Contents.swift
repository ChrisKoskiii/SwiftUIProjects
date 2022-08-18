import UIKit

func uniqueMorseRepresentations(_ words: [String]) -> Int {
  let morseArray = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
  
  let alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  
  var myArray = [String]()
  
  for word in words {
    var myString = ""
    for char in word {
      if let index = alphabet.firstIndex(of: String(char)) {
        myString.append(morseArray[index])
      }
    }
    myArray.append(myString)
  }
  return Set(myArray).count
}

uniqueMorseRepresentations(["gin","zen","gig","msg"])

