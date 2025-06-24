// wolf_libary/input_formatters/wolf_date_input_formatter.dart

import 'package:flutter/services.dart';

/// Formata uma data no formato dd/mm/yyyy enquanto o usuário digita.
/// Corrige automaticamente:
/// - Dias maiores que 31
/// - Meses maiores que 12
/// - Fevereiro com no máximo 29
/// - Meses com no máximo 30 dias, se aplicável
/// - Comportamento natural ao apagar (inclusive barras)
class WolfDateInputFormatter extends TextInputFormatter {
  static const Map<int, int> _maxDaysPerMonth = {
    1: 31,
    2: 29,
    3: 31,
    4: 30,
    5: 31,
    6: 30,
    7: 31,
    8: 31,
    9: 30,
    10: 31,
    11: 30,
    12: 31,
  };

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final oldText = oldValue.text;
    final newText = newValue.text;
    final isDeleting = oldText.length > newText.length;

    final digits = newText.replaceAll(RegExp(r'[^0-9]'), '');
    String day = '';
    String month = '';
    String year = '';

    if (digits.length >= 2) {
      day = digits.substring(0, 2);
    } else if (digits.length >= 1) {
      day = digits.substring(0, 1);
    }

    if (digits.length >= 4) {
      month = digits.substring(2, 4);
    } else if (digits.length >= 3) {
      month = digits.substring(2, 3);
    }

    if (digits.length > 4) {
      year = digits.substring(4);
    }

    int? monthInt = int.tryParse(month);
    if (monthInt != null && monthInt > 12) {
      month = '12';
    }

    int? dayInt = int.tryParse(day);
    if (dayInt != null && monthInt != null) {
      final maxDay = _maxDaysPerMonth[monthInt] ?? 31;
      if (dayInt > maxDay) {
        day = maxDay.toString().padLeft(2, '0');
      }
    }

    final buffer = StringBuffer();
    int cursorPosition = 0;

    if (day.isNotEmpty) {
      buffer.write(day);
      cursorPosition = buffer.length;
    }
    if (day.length == 2 && (month.isNotEmpty || !isDeleting)) {
      buffer.write('/');
      cursorPosition = buffer.length;
    }

    if (month.isNotEmpty) {
      buffer.write(month);
      cursorPosition = buffer.length;
    }
    if (month.length == 2 && (year.isNotEmpty || !isDeleting)) {
      buffer.write('/');
      cursorPosition = buffer.length;
    }

    if (year.isNotEmpty) {
      buffer.write(year);
      cursorPosition = buffer.length;
    }

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}
