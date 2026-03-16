int calculateAge(DateTime birthday) {
  final now = DateTime.now();

  int age = now.year - birthday.year;

  if (now.month < birthday.month ||
      (now.month == birthday.month && now.day < birthday.day)) {
    age--;
  }

  return age;
}