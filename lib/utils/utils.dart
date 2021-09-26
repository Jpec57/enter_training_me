class Utils {

  static String convertToTime(int elapsedTime){
    if (elapsedTime >= 60 * 60){
      int hour = (elapsedTime / 60 * 60).floor();
      int minutes = ((elapsedTime - (hour * 60 * 60)) / 60).floor();
      int seconds = elapsedTime % 60;
      return "${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    } else if (elapsedTime >= 60){
      int minutes = (elapsedTime / 60).floor();
      int seconds = elapsedTime % 60;
      return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    }
    int seconds = elapsedTime;
    return "00:${seconds.toString().padLeft(2, '0')}";
  }
}