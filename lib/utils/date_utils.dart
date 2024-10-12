DateTime midnightOf(DateTime date) {
  return DateTime.parse('${date.toString().split(' ').first} 00:00:00');
}