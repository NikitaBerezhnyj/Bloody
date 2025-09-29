// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Bloody';

  @override
  String get profile => 'Perfil';

  @override
  String welcomeUser(Object name) {
    return '¡Hola, $name 👋';
  }

  @override
  String get journal => 'Diario de donaciones';

  @override
  String get stats => 'Estadísticas';

  @override
  String get tooEarlyToDonate => 'Todavía es pronto para donar';

  @override
  String get addDonation => 'Agregar Donación';

  @override
  String get canDonate => 'Puedes donar sangre';

  @override
  String cannotDonate(Object days) {
    return 'Podrás donar sangre en $days días';
  }

  @override
  String motivational1(Object count, Object countTimesThree) {
    return 'Ha donado $count veces — ¡esto ha salvado aproximadamente $countTimesThree vidas!';
  }

  @override
  String motivational2(Object count, Object countTimesThree) {
    return 'Sus donaciones ($count) ayudaron a salvar $countTimesThree personas!';
  }

  @override
  String motivational3(Object count, Object name) {
    return '¡Bien hecho, $name! Ha hecho una buena acción $count veces!';
  }

  @override
  String motivational4(Object count, Object name) {
    return '¡Impresionante! $count donaciones son realmente geniales, $name!';
  }

  @override
  String motivational5(Object daysSince, Object name) {
    return '$name, no olvides — cada donación es importante. Han pasado $daysSince días!';
  }

  @override
  String motivational6(Object name) {
    return '¡Tu fuerza ayuda a cambiar el mundo, $name!';
  }

  @override
  String motivational7(Object name) {
    return '¡$name, eres un verdadero héroe para la gente que te rodea!';
  }

  @override
  String get motivational8 => 'Cada gota de sangre importa — ¡y tú lo sabes!';

  @override
  String motivational9(Object name) {
    return '¡Gracias, $name! El mundo se vuelve mejor gracias a tus donaciones!';
  }

  @override
  String get fillProfile => 'Completa tu perfil';

  @override
  String get name => 'Nombre';

  @override
  String get enterName => 'Ingrese su nombre';

  @override
  String get age => 'Edad';

  @override
  String get enterAge => 'Ingrese su edad';

  @override
  String get ageValidation => 'La edad debe ser al menos 18';

  @override
  String get gender => 'Género';

  @override
  String get selectGender => 'Seleccione género';

  @override
  String get bloodType => 'Tipo de sangre';

  @override
  String get selectBloodType => 'Seleccione tipo de sangre';

  @override
  String get save => 'Guardar';

  @override
  String get male => 'Hombre';

  @override
  String get female => 'Mujer';

  @override
  String get date => 'Fecha';

  @override
  String get selectDate => 'Seleccione una fecha';

  @override
  String get donationType => 'Tipo de donación';

  @override
  String get selectDonationType => 'Seleccione tipo de donación';

  @override
  String get donationWholeBlood => 'Sangre total';

  @override
  String get donationPlasma => 'Plasma';

  @override
  String get donationPlatelets => 'Plaquetas';

  @override
  String get feeling => 'Estado';

  @override
  String get selectFeeling => 'Seleccione su estado';

  @override
  String get notes => 'Notas';

  @override
  String get notesHint => 'Comentarios adicionales';

  @override
  String get saveDonation => 'Guardar Donación';

  @override
  String get fillAllFields =>
      'Por favor, complete todos los campos obligatorios';

  @override
  String get feelingGood => 'Bien';

  @override
  String get feelingNormal => 'Normal';

  @override
  String get feelingTired => 'Cansado';

  @override
  String get journalTitle => 'Diario de Donaciones';

  @override
  String get noDonations => 'Aún no hay donaciones';

  @override
  String feelingLabel(Object feeling) {
    return 'Estado: $feeling';
  }

  @override
  String notesLabel(Object notes) {
    return 'Notas: $notes';
  }

  @override
  String get statsTitle => 'Estadísticas';

  @override
  String get noDonationsStats => 'Aún no hay donaciones';

  @override
  String totalDonations(Object count) {
    return 'Total de donaciones: $count';
  }

  @override
  String donationsByType(Object plasma, Object platelets, Object wb) {
    return 'Sangre completa: $wb, Plasma: $plasma, Plaquetas: $platelets';
  }

  @override
  String averageInterval(Object days) {
    return 'Intervalo promedio entre donaciones: $days días';
  }

  @override
  String get donationsPerMonth => 'Donaciones por mes';

  @override
  String get month1 => 'Ene';

  @override
  String get month2 => 'Feb';

  @override
  String get month3 => 'Mar';

  @override
  String get month4 => 'Abr';

  @override
  String get month5 => 'May';

  @override
  String get month6 => 'Jun';

  @override
  String get month7 => 'Jul';

  @override
  String get month8 => 'Ago';

  @override
  String get month9 => 'Sep';

  @override
  String get month10 => 'Oct';

  @override
  String get month11 => 'Nov';

  @override
  String get month12 => 'Dic';

  @override
  String get profileTitle => 'Perfil';

  @override
  String get nameLabel => 'Nombre';

  @override
  String get ageLabel => 'Edad';

  @override
  String get ageMin18 => 'La edad debe ser al menos 18';

  @override
  String get genderLabel => 'Género';

  @override
  String get bloodTypeLabel => 'Tipo de sangre';

  @override
  String get saveChanges => 'Guardar cambios';

  @override
  String get profileUpdated => '¡Perfil actualizado!';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get logoutConfirmTitle => '¿Cerrar sesión?';

  @override
  String get logoutConfirmContent =>
      'Si cierra sesión, todos los datos serán eliminados. ¿Está seguro?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get languageLabel => 'Idioma:';

  @override
  String get achievementsTitle => 'Logros';

  @override
  String get achievementWholeBlood1 => 'Primer Paso';

  @override
  String get achievementWholeBlood3 => 'Valiente';

  @override
  String get achievementWholeBlood5 => 'Guardián Rojo';

  @override
  String get achievementWholeBlood10 => 'Corazón de Acero';

  @override
  String get achievementWholeBlood25 => 'Héroe de la Sangre';

  @override
  String get achievementWholeBlood50 => 'Donante Incansable';

  @override
  String get achievementWholeBlood100 => 'Leyenda de la Vida';

  @override
  String get achievementPlasma1 => 'Gota de Bondad';

  @override
  String get achievementPlasma3 => 'Ola de Plata';

  @override
  String get achievementPlasma5 => 'Rayo de Esperanza';

  @override
  String get achievementPlasma10 => 'Protector de la Vida';

  @override
  String get achievementPlasma25 => 'Corriente Dorada';

  @override
  String get achievementPlasma50 => 'Guardián del Plasma';

  @override
  String get achievementPlasma100 => 'Donante Inmortal';

  @override
  String get achievementPlatelets1 => 'Pequeño Héroe';

  @override
  String get achievementPlatelets3 => 'Pequeño Salvador';

  @override
  String get achievementPlatelets5 => 'Caballero Blanco';

  @override
  String get achievementPlatelets10 => 'Defensor de la Sangre';

  @override
  String get achievementPlatelets25 => 'Trombo-Maestro';

  @override
  String get achievementPlatelets50 => 'Guardián de la Vida';

  @override
  String get achievementPlatelets100 => 'Leyenda del Rescate';

  @override
  String get achievementOtherTitle => 'Otros';

  @override
  String get achievementFirstStep => 'Primer Paso';

  @override
  String get achievementFirstStepDescription =>
      'Creación de un perfil en la aplicación';

  @override
  String get achievementUniversal => 'Donante Universal';

  @override
  String get achievementUniversalDescription =>
      'Realizó todos los tipos de donación';

  @override
  String get achievementHolidayDonor => 'Donante Festivo';

  @override
  String get achievementHolidayDonorDescription =>
      'Hizo una donación en un día festivo';
}
