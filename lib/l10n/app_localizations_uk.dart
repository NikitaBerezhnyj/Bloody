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
  String get birthdayLabel => 'Дата народження';

  @override
  String get enterBirthday => 'Введіть дату народження';

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
  String get ageLabel => 'Age';

  @override
  String get enterAge => 'Введіть вік';

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
  String get achievementWholeBlood1 => 'Перша кров';

  @override
  String get achievementWholeBlood3 => 'Сміливець';

  @override
  String get achievementWholeBlood5 => 'Червоний захисник';

  @override
  String get achievementWholeBlood10 => 'Сталеве серце';

  @override
  String get achievementWholeBlood25 => 'Кровний герой';

  @override
  String get achievementWholeBlood50 => 'Невтомний донор';

  @override
  String get achievementWholeBlood100 => 'Легенда життя';

  @override
  String get achievementPlasma1 => 'Краплина добра';

  @override
  String get achievementPlasma3 => 'Срібна хвиля';

  @override
  String get achievementPlasma5 => 'Промінь надії';

  @override
  String get achievementPlasma10 => 'Захисник життя';

  @override
  String get achievementPlasma25 => 'Золотий струм';

  @override
  String get achievementPlasma50 => 'Хранитель плазми';

  @override
  String get achievementPlasma100 => 'Безсмертний донор';

  @override
  String get achievementPlatelets1 => 'Крихітний герой';

  @override
  String get achievementPlatelets3 => 'Маленький рятівник';

  @override
  String get achievementPlatelets5 => 'Білий лицар';

  @override
  String get achievementPlatelets10 => 'Захисник крові';

  @override
  String get achievementPlatelets25 => 'Тромбо-майстер';

  @override
  String get achievementPlatelets50 => 'Вартовий життя';

  @override
  String get achievementPlatelets100 => 'Легенда порятунку';

  @override
  String get achievementWholeBlood1Description =>
      'Відважний початківець – твоя перша крапля цільової крові врятувала життя.';

  @override
  String get achievementWholeBlood3Description =>
      'Три кроки від сміливості: ти вже на шляху справжнього донора.';

  @override
  String get achievementWholeBlood5Description =>
      'Червоний захисник: п’ять донацій – п’ять врятованих життів.';

  @override
  String get achievementWholeBlood10Description =>
      'Сталеве серце: десять разів ти подарував надію тим, хто потребує.';

  @override
  String get achievementWholeBlood25Description =>
      'Кровний герой: двадцять п’ять донацій – твій внесок у порятунок сотень.';

  @override
  String get achievementWholeBlood50Description =>
      'Невтомний донор: півсотні разів ти проявив справжню відданість.';

  @override
  String get achievementWholeBlood100Description =>
      'Легенда життя: сто донацій – легендарний подвиг на користь людства.';

  @override
  String get achievementPlasma1Description =>
      'Краплина добра: перша донація плазми – маленький, але важливий внесок.';

  @override
  String get achievementPlasma3Description =>
      'Срібна хвиля: три донації плазми – ти вже відчуваєш силу допомоги.';

  @override
  String get achievementPlasma5Description =>
      'Промінь надії: п’ять разів твоя плазма стала променем життя.';

  @override
  String get achievementPlasma10Description =>
      'Захисник життя: десять донацій – ти надійний щит для тих, хто потребує.';

  @override
  String get achievementPlasma25Description =>
      'Золотий струм: двадцять п’ять разів твоя плазма дарувала надію.';

  @override
  String get achievementPlasma50Description =>
      'Хранитель плазми: півсотні донацій – твоя допомога безцінна.';

  @override
  String get achievementPlasma100Description =>
      'Безсмертний донор: сто донацій – твоя доброта залишає слід у часі.';

  @override
  String get achievementPlatelets1Description =>
      'Крихітний герой: перші тромбоцити – перший крок до великої справи.';

  @override
  String get achievementPlatelets3Description =>
      'Маленький рятівник: три донації тромбоцитів – ти вже змінюєш світ.';

  @override
  String get achievementPlatelets5Description =>
      'Білий лицар: п’ять разів твої тромбоцити стали щитом для життя.';

  @override
  String get achievementPlatelets10Description =>
      'Захисник крові: десять донацій – ти надійний оборонець людства.';

  @override
  String get achievementPlatelets25Description =>
      'Тромбо-майстер: двадцять п’ять донацій – майстерність у кожній краплі.';

  @override
  String get achievementPlatelets50Description =>
      'Вартовий життя: півсотні донацій тромбоцитів – твоя відданість вражає.';

  @override
  String get achievementPlatelets100Description =>
      'Легенда порятунку: сто донацій – ти справжній герой людства.';

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

  @override
  String get achievementEarlyBird => 'Рання пташка';

  @override
  String get achievementEarlyBirdDescription =>
      'Здійсніть донацію до 10:00 ранку';

  @override
  String get shareTitle => 'Поділитись';

  @override
  String get emptyDescription => 'Без опису';

  @override
  String shareAchievementText(Object title) {
    return 'Я здобув досягнення «$title» у Bloody!';
  }
}
