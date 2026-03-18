int calculateAge(DateTime birthday) {
  final now = DateTime.now();

  int age = now.year - birthday.year;

  if (now.month < birthday.month ||
      (now.month == birthday.month && now.day < birthday.day)) {
    age--;
  }

  return age;
}

String? validateName(String? value, String errorText) {
  if (value == null || value.trim().isEmpty) {
    return errorText;
  }
  return null;
}

String? validateBirthday(DateTime? birthday, String emptyError, String ageError) {
  if (birthday == null) return emptyError;

  if (calculateAge(birthday) < 18) {
    return ageError;
  }

  return null;
}

String? validateRequired(String? value, String errorText) {
  if (value == null) return errorText;
  return null;
}