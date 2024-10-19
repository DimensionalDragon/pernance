DateTime midnightOf(DateTime date) {
  return DateTime.parse('${date.toString().split(' ').first} 00:00:00');
}

bool isSameDate(DateTime date1, DateTime date2) {
  return DateTime(date1.year, date1.month, date1.day) == DateTime(date2.year, date2.month, date2.day);
}

DateTime getFirstDayOfMonth(DateTime date) {
  return DateTime(date.year, date.month, 1);
}

DateTime getLastDayOfMonth(DateTime date) {
  return DateTime(date.year, date.month + 1, 1).subtract(const Duration(days: 1));
}

DateTime getFirstDayOfThisMonth() {
  return getFirstDayOfMonth(DateTime.now());
}

DateTime getLastDayOfThisMonth() {
  return getLastDayOfMonth(DateTime.now());
}