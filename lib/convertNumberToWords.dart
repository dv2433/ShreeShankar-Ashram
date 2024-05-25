String convertNumberToWords(int number) {
  if (number == 0) {
    return "zero";
  } else {
    final units = [
      "", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
      "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen",
      "seventeen", "eighteen", "nineteen"
    ];

    final tens = [
      "", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"
    ];

    String words = "";

    if (number >= 1000) {
      words += "${units[number ~/ 1000]} thousand ";
      number %= 1000;
    }

    if (number >= 100) {
      words += "${units[number ~/ 100]} hundred ";
      number %= 100;
    }

    if (number >= 20) {
      words += "${tens[number ~/ 10]} ";
      number %= 10;
    }

    if (number > 0) {
      words += "${units[number]}";
    }

    return words.trim();
  }
}