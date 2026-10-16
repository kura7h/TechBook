const List<String> _monthsGenitive = [
  'січня',
  'лютого',
  'березня',
  'квітня',
  'травня',
  'червня',
  'липня',
  'серпня',
  'вересня',
  'жовтня',
  'листопада',
  'грудня',
];

/// 87430 -> "87 430" (з нерозривним пробілом).
String formatInt(int value) {
  final negative = value < 0;
  final digits = value.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    final remaining = digits.length - i;
    buffer.write(digits[i]);
    if (remaining > 1 && remaining % 3 == 1) {
      buffer.write('\u00A0');
    }
  }
  return negative ? '-$buffer' : buffer.toString();
}

String formatKm(int value) => '${formatInt(value)}\u00A0км';

String formatUah(int value) => '${formatInt(value)}\u00A0грн';

/// ₴ 3 200 (для карток статистики).
String formatUahSymbol(int value) => '₴\u00A0${formatInt(value)}';

String _two(int n) => n.toString().padLeft(2, '0');

/// 15.09.2026
String formatDate(DateTime date) =>
    '${_two(date.day)}.${_two(date.month)}.${date.year}';

/// 29 вересня 2026 р.
String formatDateLong(DateTime date) =>
    '${date.day} ${_monthsGenitive[date.month - 1]} ${date.year} р.';
