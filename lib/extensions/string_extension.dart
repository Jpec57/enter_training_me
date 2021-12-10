extension StringExtension on String {
  String padLeft(int minLength, String character) {
    if (length >= minLength) {
      return this;
    }
    int lengthToPad = minLength - length;
    String pad = "";
    for (var i = 0; i < lengthToPad; i++) {
      pad += character;
    }
    return pad + this;
  }
}
