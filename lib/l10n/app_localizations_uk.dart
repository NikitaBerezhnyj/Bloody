// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Bloody';

  @override
  String get profile => 'Профіль';

  @override
  String welcomeUser(Object name) {
    return 'Привіт, $name 👋';
  }

  @override
  String get journal => 'Журнал донацій';

  @override
  String get stats => 'Статистика';

  @override
  String get tooEarlyToDonate => 'Ще зарано здавати кров';

  @override
  String get addDonation => 'Додати донацію';

  @override
  String get canDonate => 'Можна здавати кров';

  @override
  String cannotDonate(Object days) {
    return 'Кров можна здати знову через $days днів';
  }

  @override
  String motivational1(Object count, Object countTimesThree) {
    return 'Ви вже здали $count разів — це врятувало приблизно $countTimesThree життів!';
  }

  @override
  String motivational2(Object count, Object countTimesThree) {
    return 'Ваші донації ($count) допомогли врятувати $countTimesThree людей!';
  }

  @override
  String motivational3(Object count, Object name) {
    return 'Молодець, $name! Ви вже $count разів робили добру справу';
  }

  @override
  String motivational4(Object count, Object name) {
    return 'Вражаюче! $count донацій — це реально круто, $name!';
  }

  @override
  String motivational5(Object daysSince, Object name) {
    return '$name, не забувайте — кожна донація важлива. Минуло вже $daysSince днів!';
  }

  @override
  String motivational6(Object name) {
    return 'Ваша сила допомагає змінювати світ, $name!';
  }

  @override
  String motivational7(Object name) {
    return '$name, ви справжній герой для людей навколо!';
  }

  @override
  String get motivational8 =>
      'Кожна крапля крові має значення — і ви це знаєте!';

  @override
  String motivational9(Object name) {
    return 'Дякуємо, $name! Світ стає кращим завдяки вашим донаціям';
  }

  @override
  String get fillProfile => 'Заповніть профіль';

  @override
  String get name => 'Ім’я';

  @override
  String get enterName => 'Введіть ім’я';

  @override
  String get age => 'Вік';

  @override
  String get enterAge => 'Введіть вік';

  @override
  String get ageValidation => 'Вік має бути від 18 років';

  @override
  String get gender => 'Стать';

  @override
  String get selectGender => 'Оберіть стать';

  @override
  String get bloodType => 'Група крові';

  @override
  String get selectBloodType => 'Оберіть групу крові';

  @override
  String get save => 'Зберегти';

  @override
  String get male => 'Чоловік';

  @override
  String get female => 'Жінка';

  @override
  String get date => 'Дата';

  @override
  String get selectDate => 'Оберіть дату';

  @override
  String get donationType => 'Тип донації';

  @override
  String get selectDonationType => 'Оберіть тип донації';

  @override
  String get donationWholeBlood => 'Цільна кров';

  @override
  String get donationPlasma => 'Плазма';

  @override
  String get donationPlatelets => 'Тромбоцити';

  @override
  String get feeling => 'Самопочуття';

  @override
  String get selectFeeling => 'Оберіть самопочуття';

  @override
  String get notes => 'Нотатки';

  @override
  String get notesHint => 'Додаткові коментарі';

  @override
  String get saveDonation => 'Зберегти донацію';

  @override
  String get fillAllFields => 'Будь ласка, заповніть всі обов\'язкові поля';

  @override
  String get feelingGood => 'Добре';

  @override
  String get feelingNormal => 'Нормально';

  @override
  String get feelingTired => 'Втомлений';

  @override
  String get journalTitle => 'Журнал донацій';

  @override
  String get noDonations => 'Поки що немає жодної донації';

  @override
  String feelingLabel(Object feeling) {
    return 'Самопочуття: $feeling';
  }

  @override
  String notesLabel(Object notes) {
    return 'Нотатки: $notes';
  }

  @override
  String get statsTitle => 'Статистика';

  @override
  String get noDonationsStats => 'Ще немає жодної донації';

  @override
  String totalDonations(Object count) {
    return 'Загальна кількість донацій: $count';
  }

  @override
  String donationsByType(Object plasma, Object platelets, Object wb) {
    return 'Whole Blood: $wb, Plasma: $plasma, Platelets: $platelets';
  }

  @override
  String averageInterval(Object days) {
    return 'Середній інтервал між донаціями: $days днів';
  }

  @override
  String get donationsPerMonth => 'Донації по місяцях';

  @override
  String get month1 => 'Січ';

  @override
  String get month2 => 'Лют';

  @override
  String get month3 => 'Бер';

  @override
  String get month4 => 'Кві';

  @override
  String get month5 => 'Тра';

  @override
  String get month6 => 'Чер';

  @override
  String get month7 => 'Лип';

  @override
  String get month8 => 'Сер';

  @override
  String get month9 => 'Вер';

  @override
  String get month10 => 'Жов';

  @override
  String get month11 => 'Лис';

  @override
  String get month12 => 'Гру';

  @override
  String get profileTitle => 'Профіль';

  @override
  String get nameLabel => 'Ім’я';

  @override
  String get ageLabel => 'Вік';

  @override
  String get ageMin18 => 'Вік має бути від 18 років';

  @override
  String get genderLabel => 'Стать';

  @override
  String get bloodTypeLabel => 'Група крові';

  @override
  String get saveChanges => 'Зберегти зміни';

  @override
  String get profileUpdated => 'Профіль оновлено!';

  @override
  String get logout => 'Вийти з акаунта';

  @override
  String get logoutConfirmTitle => 'Вийти з акаунта?';

  @override
  String get logoutConfirmContent =>
      'Якщо ви вийдете, всі дані будуть видалені. Ви впевнені?';

  @override
  String get cancel => 'Скасувати';

  @override
  String get settingsTitle => 'Налаштування';

  @override
  String get languageLabel => 'Мова:';

  @override
  String get achievementsTitle => 'Досягення';

  @override
  String get achievementTotalTitle => 'Загальна кількість донацій';

  @override
  String get achievementWholeBlood1 => 'Новачок';

  @override
  String get achievementWholeBlood3 => 'Досвідчений';

  @override
  String get achievementWholeBlood5 => 'Регулярний донор';

  @override
  String get achievementWholeBlood10 => 'Ветеран крові';

  @override
  String get achievementWholeBlood25 => 'Супердонор';

  @override
  String get achievementWholeBlood50 => 'Легенда крові';

  @override
  String get achievementWholeBlood100 => 'Майстер крові';

  @override
  String get achievementPlasma1 => 'Плазмовий новачок';

  @override
  String get achievementPlasma3 => 'Плазмовий друг';

  @override
  String get achievementPlasma5 => 'Плазмовий герой';

  @override
  String get achievementPlasma10 => 'Плазмовий ветеран';

  @override
  String get achievementPlasma25 => 'Плазмовий супергерой';

  @override
  String get achievementPlasma50 => 'Плазмовий майстер';

  @override
  String get achievementPlasma100 => 'Плазмовий легендар';

  @override
  String get achievementPlatelets1 => 'Тромбоцитовий новачок';

  @override
  String get achievementPlatelets3 => 'Тромбоцитовий друг';

  @override
  String get achievementPlatelets5 => 'Тромбоцитовий герой';

  @override
  String get achievementPlatelets10 => 'Тромбоцитовий ветеран';

  @override
  String get achievementPlatelets25 => 'Тромбоцитовий супергерой';

  @override
  String get achievementPlatelets50 => 'Тромбоцитовий майстер';

  @override
  String get achievementPlatelets100 => 'Тромбоцитовий легендар';

  @override
  String get achievementTotal1 => 'Перший крок';

  @override
  String get achievementTotal3 => 'Досвідчений крок';

  @override
  String get achievementTotal5 => 'Регулярний';

  @override
  String get achievementTotal10 => 'Ветеран';

  @override
  String get achievementTotal25 => 'Супердонор';

  @override
  String get achievementTotal50 => 'Легенда';

  @override
  String get achievementTotal100 => 'Майстер';

  @override
  String get achievementOtherTitle => 'Інше';

  @override
  String get achievementFirstStep => 'Перший крок';

  @override
  String get achievementFirstStepDescription => 'Створення профілю в додатку';

  @override
  String get achievementUniversal => 'Універсал';

  @override
  String get achievementUniversalDescription => 'Здав усі типи донацій';

  @override
  String get achievementHolidayDonor => 'Святковий донор';

  @override
  String get achievementHolidayDonorDescription =>
      'Здача крові в святковий день';
}
