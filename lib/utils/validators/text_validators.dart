class TextValidators {
  static String? loanName(String? name) {
    if (!(name!.length < 1 || name.length > 100)) {
      return null;
    }
    return 'Loan name should be between 1 and 100';
  }

  static String? number(String? number) {
    if (isNumeric(number!)) {
      return null;
    }
    return 'Should be a number';
  }

  static String? integer(String? number) {
    if (isInteger(number!)) {
      return null;
    }
    return 'Should be an integer';
  }
}

bool isNumeric(String s) {
  return double.tryParse(s) != null;
}

bool isInteger(String s) {
  return int.tryParse(s) != null;
}
