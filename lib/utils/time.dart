class DateParser {
  static int dueDateInDays(String date) {
    final parseDate = DateTime.tryParse(date);
    if (parseDate != null) {
      return parseDate.difference(DateTime.now()).inDays;
    }
    return 0;
  }
}
