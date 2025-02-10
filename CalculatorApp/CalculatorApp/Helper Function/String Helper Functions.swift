import Foundation

func getLastChar (str: String) -> String {
  return str.isEmpty ? "" : String(str.last!)
}

func lastCharacterIsEqualTo (str: String, char: String) -> Bool {
  let last = getLastChar(str: str)
  return last == char
}

func formatResult (val: Double) -> String {
  let numberFormatter = NumberFormatter()
  numberFormatter.numberStyle = .decimal
  numberFormatter.maximumFractionDigits = 16
  
  return numberFormatter
    .string(from: NSNumber(value: val)) ?? "0"
}

func lastCharIsDigit(str: String) -> Bool {
  return "0123456789".contains(getLastChar(str: str))
}

func lastCharIsDigitOrPercent(str: String) -> Bool {
  return "0123456789%".contains(getLastChar(str: str))
}

func lastCharacterIsAnOperator(str: String) -> Bool {
  let last = getLastChar(str: str)
  return operators.contains(last)
}
