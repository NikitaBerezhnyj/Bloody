// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Bloody';

  @override
  String get profile => 'Profile';

  @override
  String welcomeUser(Object name) {
    return 'Hello, $name 👋';
  }

  @override
  String get journal => 'Donation Journal';

  @override
  String get stats => 'Statistics';

  @override
  String get tooEarlyToDonate => 'Too early to donate';

  @override
  String get addDonation => 'Add Donation';

  @override
  String get canDonate => 'You can donate blood';

  @override
  String cannotDonate(Object days) {
    return 'You can donate blood again in $days days';
  }

  @override
  String motivational1(Object count, Object countTimesThree) {
    return 'You have donated $count times — this has saved approximately $countTimesThree lives!';
  }

  @override
  String motivational2(Object count, Object countTimesThree) {
    return 'Your donations ($count) helped save $countTimesThree people!';
  }

  @override
  String motivational3(Object count, Object name) {
    return 'Well done, $name! You have made a good deed $count times!';
  }

  @override
  String motivational4(Object count, Object name) {
    return 'Amazing! $count donations is really great, $name!';
  }

  @override
  String motivational5(Object daysSince, Object name) {
    return '$name, don\'t forget — every donation counts. It\'s been $daysSince days!';
  }

  @override
  String motivational6(Object name) {
    return 'Your strength helps change the world, $name!';
  }

  @override
  String motivational7(Object name) {
    return '$name, you are a true hero for people around you!';
  }

  @override
  String get motivational8 => 'Every drop of blood matters — and you know it!';

  @override
  String motivational9(Object name) {
    return 'Thank you, $name! The world becomes better thanks to your donations!';
  }

  @override
  String get fillProfile => 'Fill your profile';

  @override
  String get name => 'Name';

  @override
  String get enterName => 'Enter your name';

  @override
  String get birthdayLabel => 'Birthday';

  @override
  String get enterBirthday => 'Enter your birthday';

  @override
  String get ageValidation => 'Age must be at least 18';

  @override
  String get gender => 'Gender';

  @override
  String get selectGender => 'Select gender';

  @override
  String get bloodType => 'Blood type';

  @override
  String get selectBloodType => 'Select blood type';

  @override
  String get save => 'Save';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get date => 'Date';

  @override
  String get selectDate => 'Select a date';

  @override
  String get donationType => 'Donation Type';

  @override
  String get selectDonationType => 'Select donation type';

  @override
  String get donationWholeBlood => 'Whole Blood';

  @override
  String get donationPlasma => 'Plasma';

  @override
  String get donationPlatelets => 'Platelets';

  @override
  String get feeling => 'Feeling';

  @override
  String get selectFeeling => 'Select your feeling';

  @override
  String get notes => 'Notes';

  @override
  String get notesHint => 'Additional comments';

  @override
  String get saveDonation => 'Save Donation';

  @override
  String get fillAllFields => 'Please fill all required fields';

  @override
  String get feelingGood => 'Good';

  @override
  String get feelingNormal => 'Normal';

  @override
  String get feelingTired => 'Tired';

  @override
  String get journalTitle => 'Donation Journal';

  @override
  String get noDonations => 'No donations yet';

  @override
  String feelingLabel(Object feeling) {
    return 'Feeling: $feeling';
  }

  @override
  String notesLabel(Object notes) {
    return 'Notes: $notes';
  }

  @override
  String get statsTitle => 'Statistics';

  @override
  String get noDonationsStats => 'No donations yet';

  @override
  String totalDonations(Object count) {
    return 'Total donations: $count';
  }

  @override
  String donationsByType(Object plasma, Object platelets, Object wb) {
    return 'Whole Blood: $wb, Plasma: $plasma, Platelets: $platelets';
  }

  @override
  String averageInterval(Object days) {
    return 'Average interval between donations: $days days';
  }

  @override
  String get donationsPerMonth => 'Donations per month';

  @override
  String get month1 => 'Jan';

  @override
  String get month2 => 'Feb';

  @override
  String get month3 => 'Mar';

  @override
  String get month4 => 'Apr';

  @override
  String get month5 => 'May';

  @override
  String get month6 => 'Jun';

  @override
  String get month7 => 'Jul';

  @override
  String get month8 => 'Aug';

  @override
  String get month9 => 'Sep';

  @override
  String get month10 => 'Oct';

  @override
  String get month11 => 'Nov';

  @override
  String get month12 => 'Dec';

  @override
  String get profileTitle => 'Profile';

  @override
  String get nameLabel => 'Name';

  @override
  String get ageLabel => 'Age';

  @override
  String get enterAge => 'Enter your age';

  @override
  String get ageMin18 => 'Age must be at least 18';

  @override
  String get genderLabel => 'Gender';

  @override
  String get bloodTypeLabel => 'Blood Type';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get profileUpdated => 'Profile updated!';

  @override
  String get logout => 'Logout';

  @override
  String get logoutConfirmTitle => 'Logout?';

  @override
  String get logoutConfirmContent =>
      'If you logout, all data will be deleted. Are you sure?';

  @override
  String get cancel => 'Cancel';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get languageLabel => 'Language:';

  @override
  String get achievementsTitle => 'Achievements';

  @override
  String get achievementWholeBlood1 => 'First Step';

  @override
  String get achievementWholeBlood3 => 'Braveheart';

  @override
  String get achievementWholeBlood5 => 'Red Guardian';

  @override
  String get achievementWholeBlood10 => 'Steel Heart';

  @override
  String get achievementWholeBlood25 => 'Blood Hero';

  @override
  String get achievementWholeBlood50 => 'Tireless Donor';

  @override
  String get achievementWholeBlood100 => 'Legend of Life';

  @override
  String get achievementPlasma1 => 'Drop of Kindness';

  @override
  String get achievementPlasma3 => 'Silver Wave';

  @override
  String get achievementPlasma5 => 'Ray of Hope';

  @override
  String get achievementPlasma10 => 'Life Protector';

  @override
  String get achievementPlasma25 => 'Golden Stream';

  @override
  String get achievementPlasma50 => 'Plasma Keeper';

  @override
  String get achievementPlasma100 => 'Immortal Donor';

  @override
  String get achievementPlatelets1 => 'Tiny Hero';

  @override
  String get achievementPlatelets3 => 'Little Rescuer';

  @override
  String get achievementPlatelets5 => 'White Knight';

  @override
  String get achievementPlatelets10 => 'Blood Defender';

  @override
  String get achievementPlatelets25 => 'Thrombo-Master';

  @override
  String get achievementPlatelets50 => 'Guardian of Life';

  @override
  String get achievementPlatelets100 => 'Rescue Legend';

  @override
  String get achievementOtherTitle => 'Other';

  @override
  String get achievementFirstStep => 'First Step';

  @override
  String get achievementFirstStepDescription => 'Creating a profile in the app';

  @override
  String get achievementUniversal => 'Universal Donor';

  @override
  String get achievementUniversalDescription =>
      'Donated all types of donations';

  @override
  String get achievementHolidayDonor => 'Holiday Donor';

  @override
  String get achievementHolidayDonorDescription =>
      'Made a donation on a holiday';

  @override
  String get achievementEarlyBird => 'Early Bird';

  @override
  String get achievementEarlyBirdDescription =>
      'Make a donation before 10:00 AM';
}
