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

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNow;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @feeling.
  ///
  /// In en, this message translates to:
  /// **'Feeling'**
  String get feeling;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get days;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @daysAgo1.
  ///
  /// In en, this message translates to:
  /// **'{count} day ago'**
  String daysAgo1(int count);

  /// No description provided for @daysAgo2.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String daysAgo2(int count);

  /// No description provided for @daysAgoMany.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String daysAgoMany(int count);

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Track your blood donations'**
  String get welcomeSubtitle;

  /// No description provided for @createProfile.
  ///
  /// In en, this message translates to:
  /// **'Create profile'**
  String get createProfile;

  /// No description provided for @restoreFromBackup.
  ///
  /// In en, this message translates to:
  /// **'Restore from file'**
  String get restoreFromBackup;

  /// No description provided for @createProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile creation'**
  String get createProfileTitle;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @nameError.
  ///
  /// In en, this message translates to:
  /// **'Enter a name'**
  String get nameError;

  /// No description provided for @birthdayLabel.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get birthdayLabel;

  /// No description provided for @birthdayError.
  ///
  /// In en, this message translates to:
  /// **'Select your date of birth'**
  String get birthdayError;

  /// No description provided for @birthdayValidation.
  ///
  /// In en, this message translates to:
  /// **'Age must be 18 or older'**
  String get birthdayValidation;

  /// No description provided for @genderLabel.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get genderLabel;

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

  /// No description provided for @genderError.
  ///
  /// In en, this message translates to:
  /// **'Select gender'**
  String get genderError;

  /// No description provided for @bloodTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Blood type'**
  String get bloodTypeLabel;

  /// No description provided for @bloodTypeError.
  ///
  /// In en, this message translates to:
  /// **'Select blood type'**
  String get bloodTypeError;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated!'**
  String get profileUpdated;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @logoutConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get logoutConfirmTitle;

  /// No description provided for @logoutConfirmContent.
  ///
  /// In en, this message translates to:
  /// **'All data will be removed from the device. Are you sure?'**
  String get logoutConfirmContent;

  /// No description provided for @welcomeUser.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name} 👋'**
  String welcomeUser(Object name);

  /// No description provided for @journalTitle.
  ///
  /// In en, this message translates to:
  /// **'Donation journal'**
  String get journalTitle;

  /// No description provided for @statsTitle.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statsTitle;

  /// No description provided for @achievementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievementsTitle;

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

  /// No description provided for @tooEarlyToDonate.
  ///
  /// In en, this message translates to:
  /// **'Too early to donate blood'**
  String get tooEarlyToDonate;

  /// No description provided for @ageLimitBanner.
  ///
  /// In en, this message translates to:
  /// **'After 65, blood donation is allowed only with a doctor\'s permission.'**
  String get ageLimitBanner;

  /// No description provided for @motivational1.
  ///
  /// In en, this message translates to:
  /// **'You have donated {count} times — this has saved approximately {countTimesThree} lives!'**
  String motivational1(int count, int countTimesThree);

  /// No description provided for @motivational2.
  ///
  /// In en, this message translates to:
  /// **'Your donations ({count}) have helped save {countTimesThree} people!'**
  String motivational2(int count, int countTimesThree);

  /// No description provided for @motivational3.
  ///
  /// In en, this message translates to:
  /// **'Well done, {name}! You have already done a good deed {count} times'**
  String motivational3(String name, int count);

  /// No description provided for @motivational4.
  ///
  /// In en, this message translates to:
  /// **'Amazing! {count} donations — that’s really cool, {name}!'**
  String motivational4(int count, String name);

  /// No description provided for @motivational5.
  ///
  /// In en, this message translates to:
  /// **'{name}, remember — every donation matters. It’s been {daysSince} days since your last one!'**
  String motivational5(String name, int daysSince);

  /// No description provided for @motivational6.
  ///
  /// In en, this message translates to:
  /// **'Your strength helps change the world, {name}!'**
  String motivational6(String name);

  /// No description provided for @motivational7.
  ///
  /// In en, this message translates to:
  /// **'{name}, you are a true hero for the people around you!'**
  String motivational7(String name);

  /// No description provided for @motivational8.
  ///
  /// In en, this message translates to:
  /// **'Every drop of blood counts — and you know it!'**
  String get motivational8;

  /// No description provided for @motivational9.
  ///
  /// In en, this message translates to:
  /// **'Thank you, {name}! The world is better thanks to your donations'**
  String motivational9(String name);

  /// No description provided for @addDonation.
  ///
  /// In en, this message translates to:
  /// **'Add donation'**
  String get addDonation;

  /// No description provided for @editDonation.
  ///
  /// In en, this message translates to:
  /// **'Edit donation'**
  String get editDonation;

  /// No description provided for @donationType.
  ///
  /// In en, this message translates to:
  /// **'Donation type'**
  String get donationType;

  /// No description provided for @donationTypeError.
  ///
  /// In en, this message translates to:
  /// **'Select donation type'**
  String get donationTypeError;

  /// No description provided for @donationWholeBlood.
  ///
  /// In en, this message translates to:
  /// **'Whole blood'**
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

  /// No description provided for @dateError.
  ///
  /// In en, this message translates to:
  /// **'Select a date'**
  String get dateError;

  /// No description provided for @timeError.
  ///
  /// In en, this message translates to:
  /// **'Select a time'**
  String get timeError;

  /// No description provided for @feelingError.
  ///
  /// In en, this message translates to:
  /// **'Select your feeling'**
  String get feelingError;

  /// No description provided for @notesHint.
  ///
  /// In en, this message translates to:
  /// **'Additional comments'**
  String get notesHint;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all required fields'**
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

  /// No description provided for @step.
  ///
  /// In en, this message translates to:
  /// **'Step'**
  String get step;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @confirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirmation'**
  String get confirmation;

  /// No description provided for @thankYouTitle.
  ///
  /// In en, this message translates to:
  /// **'Thank you for donating!'**
  String get thankYouTitle;

  /// No description provided for @thankYouBody.
  ///
  /// In en, this message translates to:
  /// **'Your donation can save up to three lives. You are making the world better.'**
  String get thankYouBody;

  /// No description provided for @goToJournal.
  ///
  /// In en, this message translates to:
  /// **'Go to journal'**
  String get goToJournal;

  /// No description provided for @detailsView.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get detailsView;

  /// No description provided for @noDonations.
  ///
  /// In en, this message translates to:
  /// **'No donations yet'**
  String get noDonations;

  /// No description provided for @deleteDonation.
  ///
  /// In en, this message translates to:
  /// **'Delete donation'**
  String get deleteDonation;

  /// No description provided for @deleteDonationTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete entry?'**
  String get deleteDonationTitle;

  /// No description provided for @deleteDonationContent.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this donation entry? This action cannot be undone.'**
  String get deleteDonationContent;

  /// No description provided for @statsTotalDonations.
  ///
  /// In en, this message translates to:
  /// **'donations'**
  String get statsTotalDonations;

  /// No description provided for @statsLivesLabel.
  ///
  /// In en, this message translates to:
  /// **'people saved'**
  String get statsLivesLabel;

  /// No description provided for @statsPerYear.
  ///
  /// In en, this message translates to:
  /// **'By year'**
  String get statsPerYear;

  /// No description provided for @statsDonationsYear.
  ///
  /// In en, this message translates to:
  /// **'donations per year'**
  String get statsDonationsYear;

  /// No description provided for @statsDetails.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get statsDetails;

  /// No description provided for @statsLastDonation.
  ///
  /// In en, this message translates to:
  /// **'Last donation'**
  String get statsLastDonation;

  /// No description provided for @statsAvgInterval.
  ///
  /// In en, this message translates to:
  /// **'Average interval'**
  String get statsAvgInterval;

  /// No description provided for @daysUntilNextDonation.
  ///
  /// In en, this message translates to:
  /// **'days until next donation'**
  String get daysUntilNextDonation;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @themeLabel.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeLabel;

  /// No description provided for @lightThemeLabel.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightThemeLabel;

  /// No description provided for @darkThemeLabel.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkThemeLabel;

  /// No description provided for @systemThemeLabel.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemThemeLabel;

  /// No description provided for @backupTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backupTitle;

  /// No description provided for @exportBackup.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get exportBackup;

  /// No description provided for @importBackup.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get importBackup;

  /// No description provided for @importSuccess.
  ///
  /// In en, this message translates to:
  /// **'Data restored successfully'**
  String get importSuccess;

  /// No description provided for @importError.
  ///
  /// In en, this message translates to:
  /// **'Error: invalid file format'**
  String get importError;

  /// No description provided for @widgetSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Widget'**
  String get widgetSectionTitle;

  /// No description provided for @widgetPromptTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep your finger on the pulse'**
  String get widgetPromptTitle;

  /// No description provided for @widgetPromptBody.
  ///
  /// In en, this message translates to:
  /// **'Add a widget to your home screen — and always know how many days are left until your next donation without opening the app.'**
  String get widgetPromptBody;

  /// No description provided for @widgetPromptAdd.
  ///
  /// In en, this message translates to:
  /// **'How to add a widget'**
  String get widgetPromptAdd;

  /// No description provided for @widgetInstructionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Adding a widget'**
  String get widgetInstructionsTitle;

  /// No description provided for @widgetStep1.
  ///
  /// In en, this message translates to:
  /// **'Long-press on an empty spot on your home screen'**
  String get widgetStep1;

  /// No description provided for @widgetStep2.
  ///
  /// In en, this message translates to:
  /// **'Select \'Widgets\' from the menu'**
  String get widgetStep2;

  /// No description provided for @widgetStep3.
  ///
  /// In en, this message translates to:
  /// **'Find \'Bloody\' in the widget list'**
  String get widgetStep3;

  /// No description provided for @widgetStep4.
  ///
  /// In en, this message translates to:
  /// **'Drag the widget to a convenient spot'**
  String get widgetStep4;

  /// No description provided for @permissionDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Blood donation permission'**
  String get permissionDialogTitle;

  /// No description provided for @permissionDialogDescription.
  ///
  /// In en, this message translates to:
  /// **'You are over 65. Do you have medical permission to donate blood?'**
  String get permissionDialogDescription;

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

  /// No description provided for @achievementOtherTitle.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get achievementOtherTitle;

  /// No description provided for @achievementFirstStep.
  ///
  /// In en, this message translates to:
  /// **'First step'**
  String get achievementFirstStep;

  /// No description provided for @achievementFirstStepDescription.
  ///
  /// In en, this message translates to:
  /// **'Creating a profile in the app'**
  String get achievementFirstStepDescription;

  /// No description provided for @achievementUniversal.
  ///
  /// In en, this message translates to:
  /// **'Universal'**
  String get achievementUniversal;

  /// No description provided for @achievementUniversalDescription.
  ///
  /// In en, this message translates to:
  /// **'Donated all types'**
  String get achievementUniversalDescription;

  /// No description provided for @achievementHolidayDonor.
  ///
  /// In en, this message translates to:
  /// **'Holiday donor'**
  String get achievementHolidayDonor;

  /// No description provided for @achievementHolidayDonorDescription.
  ///
  /// In en, this message translates to:
  /// **'Donated on a holiday'**
  String get achievementHolidayDonorDescription;

  /// No description provided for @achievementEarlyBird.
  ///
  /// In en, this message translates to:
  /// **'Early bird'**
  String get achievementEarlyBird;

  /// No description provided for @achievementEarlyBirdDescription.
  ///
  /// In en, this message translates to:
  /// **'Donate before 10:00 AM'**
  String get achievementEarlyBirdDescription;

  /// No description provided for @achievementWholeBlood1.
  ///
  /// In en, this message translates to:
  /// **'First blood'**
  String get achievementWholeBlood1;

  /// No description provided for @achievementWholeBlood3.
  ///
  /// In en, this message translates to:
  /// **'Brave one'**
  String get achievementWholeBlood3;

  /// No description provided for @achievementWholeBlood5.
  ///
  /// In en, this message translates to:
  /// **'Red protector'**
  String get achievementWholeBlood5;

  /// No description provided for @achievementWholeBlood10.
  ///
  /// In en, this message translates to:
  /// **'Steel heart'**
  String get achievementWholeBlood10;

  /// No description provided for @achievementWholeBlood25.
  ///
  /// In en, this message translates to:
  /// **'Blood hero'**
  String get achievementWholeBlood25;

  /// No description provided for @achievementWholeBlood50.
  ///
  /// In en, this message translates to:
  /// **'Tireless donor'**
  String get achievementWholeBlood50;

  /// No description provided for @achievementWholeBlood100.
  ///
  /// In en, this message translates to:
  /// **'Legend of life'**
  String get achievementWholeBlood100;

  /// No description provided for @achievementWholeBlood1Description.
  ///
  /// In en, this message translates to:
  /// **'Brave beginner – your first drop of whole blood saved a life.'**
  String get achievementWholeBlood1Description;

  /// No description provided for @achievementWholeBlood3Description.
  ///
  /// In en, this message translates to:
  /// **'Three steps of courage: you are on the path of a true donor.'**
  String get achievementWholeBlood3Description;

  /// No description provided for @achievementWholeBlood5Description.
  ///
  /// In en, this message translates to:
  /// **'Red protector: five donations — five lives saved.'**
  String get achievementWholeBlood5Description;

  /// No description provided for @achievementWholeBlood10Description.
  ///
  /// In en, this message translates to:
  /// **'Steel heart: ten times you gave hope to those in need.'**
  String get achievementWholeBlood10Description;

  /// No description provided for @achievementWholeBlood25Description.
  ///
  /// In en, this message translates to:
  /// **'Blood hero: twenty-five donations — your contribution saved hundreds.'**
  String get achievementWholeBlood25Description;

  /// No description provided for @achievementWholeBlood50Description.
  ///
  /// In en, this message translates to:
  /// **'Tireless donor: fifty times you showed true dedication.'**
  String get achievementWholeBlood50Description;

  /// No description provided for @achievementWholeBlood100Description.
  ///
  /// In en, this message translates to:
  /// **'Legend of life: one hundred donations — a legendary deed for humanity.'**
  String get achievementWholeBlood100Description;

  /// No description provided for @achievementPlasma1.
  ///
  /// In en, this message translates to:
  /// **'Drop of kindness'**
  String get achievementPlasma1;

  /// No description provided for @achievementPlasma3.
  ///
  /// In en, this message translates to:
  /// **'Silver wave'**
  String get achievementPlasma3;

  /// No description provided for @achievementPlasma5.
  ///
  /// In en, this message translates to:
  /// **'Ray of hope'**
  String get achievementPlasma5;

  /// No description provided for @achievementPlasma10.
  ///
  /// In en, this message translates to:
  /// **'Life defender'**
  String get achievementPlasma10;

  /// No description provided for @achievementPlasma25.
  ///
  /// In en, this message translates to:
  /// **'Golden stream'**
  String get achievementPlasma25;

  /// No description provided for @achievementPlasma50.
  ///
  /// In en, this message translates to:
  /// **'Plasma guardian'**
  String get achievementPlasma50;

  /// No description provided for @achievementPlasma100.
  ///
  /// In en, this message translates to:
  /// **'Immortal donor'**
  String get achievementPlasma100;

  /// No description provided for @achievementPlasma1Description.
  ///
  /// In en, this message translates to:
  /// **'Drop of kindness: first plasma donation — small but important.'**
  String get achievementPlasma1Description;

  /// No description provided for @achievementPlasma3Description.
  ///
  /// In en, this message translates to:
  /// **'Silver wave: three plasma donations — feel the power of help.'**
  String get achievementPlasma3Description;

  /// No description provided for @achievementPlasma5Description.
  ///
  /// In en, this message translates to:
  /// **'Ray of hope: five times your plasma became a ray of life.'**
  String get achievementPlasma5Description;

  /// No description provided for @achievementPlasma10Description.
  ///
  /// In en, this message translates to:
  /// **'Life defender: ten donations — a reliable shield for those in need.'**
  String get achievementPlasma10Description;

  /// No description provided for @achievementPlasma25Description.
  ///
  /// In en, this message translates to:
  /// **'Golden stream: twenty-five times your plasma gave hope.'**
  String get achievementPlasma25Description;

  /// No description provided for @achievementPlasma50Description.
  ///
  /// In en, this message translates to:
  /// **'Plasma guardian: fifty donations — your help is invaluable.'**
  String get achievementPlasma50Description;

  /// No description provided for @achievementPlasma100Description.
  ///
  /// In en, this message translates to:
  /// **'Immortal donor: one hundred donations — your kindness leaves a mark over time.'**
  String get achievementPlasma100Description;

  /// No description provided for @achievementPlatelets1.
  ///
  /// In en, this message translates to:
  /// **'Tiny hero'**
  String get achievementPlatelets1;

  /// No description provided for @achievementPlatelets3.
  ///
  /// In en, this message translates to:
  /// **'Little savior'**
  String get achievementPlatelets3;

  /// No description provided for @achievementPlatelets5.
  ///
  /// In en, this message translates to:
  /// **'White knight'**
  String get achievementPlatelets5;

  /// No description provided for @achievementPlatelets10.
  ///
  /// In en, this message translates to:
  /// **'Blood defender'**
  String get achievementPlatelets10;

  /// No description provided for @achievementPlatelets25.
  ///
  /// In en, this message translates to:
  /// **'Thrombo-master'**
  String get achievementPlatelets25;

  /// No description provided for @achievementPlatelets50.
  ///
  /// In en, this message translates to:
  /// **'Life guard'**
  String get achievementPlatelets50;

  /// No description provided for @achievementPlatelets100.
  ///
  /// In en, this message translates to:
  /// **'Legend of rescue'**
  String get achievementPlatelets100;

  /// No description provided for @achievementPlatelets1Description.
  ///
  /// In en, this message translates to:
  /// **'Tiny hero: first platelets — the first step to a great deed.'**
  String get achievementPlatelets1Description;

  /// No description provided for @achievementPlatelets3Description.
  ///
  /// In en, this message translates to:
  /// **'Little savior: three platelet donations — you are already changing the world.'**
  String get achievementPlatelets3Description;

  /// No description provided for @achievementPlatelets5Description.
  ///
  /// In en, this message translates to:
  /// **'White knight: five times your platelets became a shield for life.'**
  String get achievementPlatelets5Description;

  /// No description provided for @achievementPlatelets10Description.
  ///
  /// In en, this message translates to:
  /// **'Blood defender: ten donations — a reliable protector of humanity.'**
  String get achievementPlatelets10Description;

  /// No description provided for @achievementPlatelets25Description.
  ///
  /// In en, this message translates to:
  /// **'Thrombo-master: twenty-five donations — mastery in every drop.'**
  String get achievementPlatelets25Description;

  /// No description provided for @achievementPlatelets50Description.
  ///
  /// In en, this message translates to:
  /// **'Life guard: fifty platelet donations — your dedication impresses.'**
  String get achievementPlatelets50Description;

  /// No description provided for @achievementPlatelets100Description.
  ///
  /// In en, this message translates to:
  /// **'Legend of rescue: one hundred donations — you are a true hero of humanity.'**
  String get achievementPlatelets100Description;

  /// No description provided for @shareTitle.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareTitle;

  /// No description provided for @emptyDescription.
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get emptyDescription;

  /// No description provided for @shareAchievementText.
  ///
  /// In en, this message translates to:
  /// **'I earned the achievement “{title}” in Bloody!'**
  String shareAchievementText(String title);
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
