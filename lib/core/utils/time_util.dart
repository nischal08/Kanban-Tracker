String convertMinutesToDHM(String minutesStr) {
  try {
    final totalMinutes = int.parse(minutesStr);
    if (totalMinutes < 0) {
      throw ArgumentError("Input minutes cannot be negative.");
    }

    final days = totalMinutes ~/ (24 * 60);
    final hours = (totalMinutes % (24 * 60)) ~/ 60;
    final minutes = totalMinutes % 60;

    final dayStr = days > 0 ? "$days day${days > 1 ? 's' : ''}" : "";
    final hourStr = hours > 0 ? "$hours hr${hours > 1 ? 's' : ''}" : "";
    final minuteStr = minutes > 0 ? "$minutes min" : "";

    final parts = [dayStr, hourStr, minuteStr];
    return parts.where((part) => part.isNotEmpty).join(", ");
  } on FormatException {
    return "Invalid input. Please enter a valid number of minutes.";
  } on ArgumentError catch (e) {
    return e.message!;
  }
}
