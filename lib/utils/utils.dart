import 'package:enter_training_me/models/models.dart';
import 'package:intl/intl.dart';

class Utils {
  static const defaultErrorMessage = "An error occured. Please try again later or contact us.";
  static final defaultVerboseDateFormatter = DateFormat('EEEE dd MMM H:m');
  static final defaultDateFormatter = DateFormat('dd/M/y');
  static String convertToTime(int elapsedTime) {
    if (elapsedTime >= 60 * 60) {
      int hour = (elapsedTime / (60 * 60)).floor();
      int minutes = ((elapsedTime - (hour * 60 * 60)) / 60).floor();
      int seconds = elapsedTime % 60;
      return "${hour.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    } else if (elapsedTime >= 60) {
      int minutes = (elapsedTime / 60).floor();
      int seconds = elapsedTime % 60;
      return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
    }
    int seconds = elapsedTime;
    return "00:${seconds.toString().padLeft(2, '0')}";
  }

  static String convertToDuration(int elapsedTime) {
    if (elapsedTime >= 60 * 60) {
      int hour = (elapsedTime / (60 * 60)).floor();
      int minutes = ((elapsedTime - (hour * 60 * 60)) / 60).floor();
      int seconds = elapsedTime % 60;
      return "${hour.toString().padLeft(2, '0')}h${minutes.toString()}m${seconds.toString().padLeft(2, '0')}";
    } else if (elapsedTime >= 60) {
      int minutes = (elapsedTime / 60).floor();
      int seconds = elapsedTime % 60;
      return "${minutes.toString()}m${seconds.toString().padLeft(2, '0')}";
    }
    int seconds = elapsedTime;
    return "${seconds.toString().padLeft(2, '0')}s";
  }

  static int estimateWorkoutTime(Training training) {
    return 60 * 60;
  }
}
