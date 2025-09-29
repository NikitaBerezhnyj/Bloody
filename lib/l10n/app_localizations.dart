import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
    Locale('uk'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Bloody'**
  String get appTitle;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @welcomeUser.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name} 👋'**
  String welcomeUser(Object name);

  /// No description provided for @journal.
  ///
  /// In en, this message translates to:
  /// **'Donation Journal'**
  String get journal;

  /// No description provided for @stats.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get stats;

  /// No description provided for @tooEarlyToDonate.
  ///
  /// In en, this message translates to:
  /// **'Too early to donate'**
  String get tooEarlyToDonate;

  /// No description provided for @addDonation.
  ///
  /// In en, this message translates to:
  /// **'Add Donation'**
  String get addDonation;

  /// No description provided for @canDonate.
  ///
  /// In en, this message translates to:
  /// **'You can donate blood'**
  String get canDonate;

  /// No description provided for @cannotDonate.
  ///
  /// In en, this message translates to:
  /// **'You can donate blood again in {days} days'**
  String cannotDonate(Object days);

  /// No description provided for @motivational1.
  ///
  /// In en, this message translates to:
  /// **'You have donated {count} times — this has saved approximately {countTimesThree} lives!'**
  String motivational1(Object count, Object countTimesThree);

  /// No description provided for @motivational2.
  ///
  /// In en, this message translates to:
  /// **'Your donations ({count}) helped save {countTimesThree} people!'**
  String motivational2(Object count, Object countTimesThree);

  /// No description provided for @motivational3.
  ///
  /// In en, this message translates to:
  /// **'Well done, {name}! You have made a good deed {count} times!'**
  String motivational3(Object count, Object name);

  /// No description provided for @motivational4.
  ///
  /// In en, this message translates to:
  /// **'Amazing! {count} donations is really great, {name}!'**
  String motivational4(Object count, Object name);

  /// No description provided for @motivational5.
  ///
  /// In en, this message translates to:
  /// **'{name}, don\'t forget — every donation counts. It\'s been {daysSince} days!'**
  String motivational5(Object daysSince, Object name);

  /// No description provided for @motivational6.
  ///
  /// In en, this message translates to:
  /// **'Your strength helps change the world, {name}!'**
  String motivational6(Object name);

  /// No description provided for @motivational7.
  ///
  /// In en, this message translates to:
  /// **'{name}, you are a true hero for people around you!'**
  String motivational7(Object name);

  /// No description provided for @motivational8.
  ///
  /// In en, this message translates to:
  /// **'Every drop of blood matters — and you know it!'**
  String get motivational8;

  /// No description provided for @motivational9.
  ///
  /// In en, this message translates to:
  /// **'Thank you, {name}! The world becomes better thanks to your donations!'**
  String motivational9(Object name);

  /// No description provided for @fillProfile.
  ///
  /// In en, this message translates to:
  /// **'Fill your profile'**
  String get fillProfile;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterName;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @enterAge.
  ///
  /// In en, this message translates to:
  /// **'Enter your age'**
  String get enterAge;

  /// No description provided for @ageValidation.
  ///
  /// In en, this message translates to:
  /// **'Age must be at least 18'**
  String get ageValidation;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @selectGender.
  ///
  /// In en, this message translates to:
  /// **'Select gender'**
  String get selectGender;

  /// No description provided for @bloodType.
  ///
  /// In en, this message translates to:
  /// **'Blood type'**
  String get bloodType;

  /// No description provided for @selectBloodType.
  ///
  /// In en, this message translates to:
  /// **'Select blood type'**
  String get selectBloodType;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select a date'**
  String get selectDate;

  /// No description provided for @donationType.
  ///
  /// In en, this message translates to:
  /// **'Donation Type'**
  String get donationType;

  /// No description provided for @selectDonationType.
  ///
  /// In en, this message translates to:
  /// **'Select donation type'**
  String get selectDonationType;

  /// No description provided for @donationWholeBlood.
  ///
  /// In en, this message translates to:
  /// **'Whole Blood'**
  String get donationWholeBlood;

  /// No description provided for @donationPlasma.
  ///
  /// In en, this message translates to:
  /// **'Plasma'**
  String get donationPlasma;

  /// No description provided for @donationPlatelets.
  ///
  /// In en, this message translates to:
  /// **'Platelets'**
  String get donationPlatelets;

  /// No description provided for @feeling.
  ///
  /// In en, this message translates to:
  /// **'Feeling'**
  String get feeling;

  /// No description provided for @selectFeeling.
  ///
  /// In en, this message translates to:
  /// **'Select your feeling'**
  String get selectFeeling;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @notesHint.
  ///
  /// In en, this message translates to:
  /// **'Additional comments'**
  String get notesHint;

  /// No description provided for @saveDonation.
  ///
  /// In en, this message translates to:
  /// **'Save Donation'**
  String get saveDonation;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields'**
  String get fillAllFields;

  /// No description provided for @feelingGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get feelingGood;

  /// No description provided for @feelingNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get feelingNormal;

  /// No description provided for @feelingTired.
  ///
  /// In en, this message translates to:
  /// **'Tired'**
  String get feelingTired;

  /// No description provided for @journalTitle.
  ///
  /// In en, this message translates to:
  /// **'Donation Journal'**
  String get journalTitle;

  /// No description provided for @noDonations.
  ///
  /// In en, this message translates to:
  /// **'No donations yet'**
  String get noDonations;

  /// No description provided for @feelingLabel.
  ///
  /// In en, this message translates to:
  /// **'Feeling: {feeling}'**
  String feelingLabel(Object feeling);

  /// No description provided for @notesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes: {notes}'**
  String notesLabel(Object notes);

  /// No description provided for @statsTitle.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statsTitle;

  /// No description provided for @noDonationsStats.
  ///
  /// In en, this message translates to:
  /// **'No donations yet'**
  String get noDonationsStats;

  /// No description provided for @totalDonations.
  ///
  /// In en, this message translates to:
  /// **'Total donations: {count}'**
  String totalDonations(Object count);

  /// No description provided for @donationsByType.
  ///
  /// In en, this message translates to:
  /// **'Whole Blood: {wb}, Plasma: {plasma}, Platelets: {platelets}'**
  String donationsByType(Object plasma, Object platelets, Object wb);

  /// No description provided for @averageInterval.
  ///
  /// In en, this message translates to:
  /// **'Average interval between donations: {days} days'**
  String averageInterval(Object days);

  /// No description provided for @donationsPerMonth.
  ///
  /// In en, this message translates to:
  /// **'Donations per month'**
  String get donationsPerMonth;

  /// No description provided for @month1.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get month1;

  /// No description provided for @month2.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get month2;

  /// No description provided for @month3.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get month3;

  /// No description provided for @month4.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get month4;

  /// No description provided for @month5.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get month5;

  /// No description provided for @month6.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get month6;

  /// No description provided for @month7.
  ///
  /// In en, this message translates to:
  /// **'Jul'**
  String get month7;

  /// No description provided for @month8.
  ///
  /// In en, this message translates to:
  /// **'Aug'**
  String get month8;

  /// No description provided for @month9.
  ///
  /// In en, this message translates to:
  /// **'Sep'**
  String get month9;

  /// No description provided for @month10.
  ///
  /// In en, this message translates to:
  /// **'Oct'**
  String get month10;

  /// No description provided for @month11.
  ///
  /// In en, this message translates to:
  /// **'Nov'**
  String get month11;

  /// No description provided for @month12.
  ///
  /// In en, this message translates to:
  /// **'Dec'**
  String get month12;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @ageLabel.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get ageLabel;

  /// No description provided for @ageMin18.
  ///
  /// In en, this message translates to:
  /// **'Age must be at least 18'**
  String get ageMin18;

  /// No description provided for @genderLabel.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get genderLabel;

  /// No description provided for @bloodTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Blood Type'**
  String get bloodTypeLabel;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get saveChanges;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated!'**
  String get profileUpdated;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Logout?'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmContent.
  ///
  /// In en, this message translates to:
  /// **'If you logout, all data will be deleted. Are you sure?'**
  String get logoutConfirmContent;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language:'**
  String get languageLabel;

  /// No description provided for @achievementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievementsTitle;

  /// No description provided for @achievementTotalTitle.
  ///
  /// In en, this message translates to:
  /// **'Total Donations'**
  String get achievementTotalTitle;

  /// No description provided for @achievementWholeBlood1.
  ///
  /// In en, this message translates to:
  /// **'Rookie'**
  String get achievementWholeBlood1;

  /// No description provided for @achievementWholeBlood3.
  ///
  /// In en, this message translates to:
  /// **'Experienced'**
  String get achievementWholeBlood3;

  /// No description provided for @achievementWholeBlood5.
  ///
  /// In en, this message translates to:
  /// **'Regular Donor'**
  String get achievementWholeBlood5;

  /// No description provided for @achievementWholeBlood10.
  ///
  /// In en, this message translates to:
  /// **'Blood Veteran'**
  String get achievementWholeBlood10;

  /// No description provided for @achievementWholeBlood25.
  ///
  /// In en, this message translates to:
  /// **'Super Donor'**
  String get achievementWholeBlood25;

  /// No description provided for @achievementWholeBlood50.
  ///
  /// In en, this message translates to:
  /// **'Blood Legend'**
  String get achievementWholeBlood50;

  /// No description provided for @achievementWholeBlood100.
  ///
  /// In en, this message translates to:
  /// **'Blood Master'**
  String get achievementWholeBlood100;

  /// No description provided for @achievementPlasma1.
  ///
  /// In en, this message translates to:
  /// **'Plasma Rookie'**
  String get achievementPlasma1;

  /// No description provided for @achievementPlasma3.
  ///
  /// In en, this message translates to:
  /// **'Plasma Friend'**
  String get achievementPlasma3;

  /// No description provided for @achievementPlasma5.
  ///
  /// In en, this message translates to:
  /// **'Plasma Hero'**
  String get achievementPlasma5;

  /// No description provided for @achievementPlasma10.
  ///
  /// In en, this message translates to:
  /// **'Plasma Veteran'**
  String get achievementPlasma10;

  /// No description provided for @achievementPlasma25.
  ///
  /// In en, this message translates to:
  /// **'Plasma Superhero'**
  String get achievementPlasma25;

  /// No description provided for @achievementPlasma50.
  ///
  /// In en, this message translates to:
  /// **'Plasma Master'**
  String get achievementPlasma50;

  /// No description provided for @achievementPlasma100.
  ///
  /// In en, this message translates to:
  /// **'Plasma Legend'**
  String get achievementPlasma100;

  /// No description provided for @achievementPlatelets1.
  ///
  /// In en, this message translates to:
  /// **'Platelet Rookie'**
  String get achievementPlatelets1;

  /// No description provided for @achievementPlatelets3.
  ///
  /// In en, this message translates to:
  /// **'Platelet Friend'**
  String get achievementPlatelets3;

  /// No description provided for @achievementPlatelets5.
  ///
  /// In en, this message translates to:
  /// **'Platelet Hero'**
  String get achievementPlatelets5;

  /// No description provided for @achievementPlatelets10.
  ///
  /// In en, this message translates to:
  /// **'Platelet Veteran'**
  String get achievementPlatelets10;

  /// No description provided for @achievementPlatelets25.
  ///
  /// In en, this message translates to:
  /// **'Platelet Superhero'**
  String get achievementPlatelets25;

  /// No description provided for @achievementPlatelets50.
  ///
  /// In en, this message translates to:
  /// **'Platelet Master'**
  String get achievementPlatelets50;

  /// No description provided for @achievementPlatelets100.
  ///
  /// In en, this message translates to:
  /// **'Platelet Legend'**
  String get achievementPlatelets100;

  /// No description provided for @achievementTotal1.
  ///
  /// In en, this message translates to:
  /// **'First Step'**
  String get achievementTotal1;

  /// No description provided for @achievementTotal3.
  ///
  /// In en, this message translates to:
  /// **'Experienced Step'**
  String get achievementTotal3;

  /// No description provided for @achievementTotal5.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get achievementTotal5;

  /// No description provided for @achievementTotal10.
  ///
  /// In en, this message translates to:
  /// **'Veteran'**
  String get achievementTotal10;

  /// No description provided for @achievementTotal25.
  ///
  /// In en, this message translates to:
  /// **'Super Donor'**
  String get achievementTotal25;

  /// No description provided for @achievementTotal50.
  ///
  /// In en, this message translates to:
  /// **'Legend'**
  String get achievementTotal50;

  /// No description provided for @achievementTotal100.
  ///
  /// In en, this message translates to:
  /// **'Master'**
  String get achievementTotal100;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
