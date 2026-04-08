class NotificationStrings {
  static const _translations = {
    'soonTitle': {
      'en': 'You can donate soon',
      'uk': 'Незабаром можна здавати кров',
      'es': 'Pronto puedes donar',
    },
    'soonBody': {
      'en': 'Tomorrow you can donate blood again.',
      'uk': 'Завтра ви знову зможете здати кров.',
      'es': 'Mañana podrás donar sangre de nuevo.',
    },
    'todayTitle': {
      'en': 'You can donate today',
      'uk': 'Сьогодні можна робити донацію',
      'es': 'Puedes donar hoy',
    },
    'todayBody': {
      'en': 'Today you can donate blood again.',
      'uk': 'Сьогодні ви можете знову здати кров.',
      'es': 'Hoy puedes donar sangre de nuevo.',
    },
    'alreadyTitle': {
      'en': 'You can donate now',
      'uk': 'Ви вже можете здати кров',
      'es': 'Ya puedes donar',
    },
    'alreadyBody': {
      'en': 'You can already donate blood. Maybe it\'s time to plan your next donation.',
      'uk': 'Ви вже можете здати кров. Можливо, настав час запланувати наступну донацію.',
      'es': 'Ya puedes donar sangre. Quizás es hora de planear tu próxima donación.',
    },
    'longAgoTitle': {
      'en': 'It\'s been a while',
      'uk': 'Давно не було донацій',
      'es': 'Ha pasado mucho tiempo',
    },
    'longAgoBody': {
      'en': 'It\'s been a long time since your last donation. Maybe it\'s time to help again.',
      'uk': 'Давно не було донацій. Можливо, настав час допомогти знову.',
      'es': 'Ha pasado mucho tiempo desde tu última donación. Quizás es hora de ayudar de nuevo.',
    },
    'channelName': {
      'en': 'Donation reminders',
      'uk': 'Нагадування про донацію',
      'es': 'Recordatorios de donación',
    },
    'channelDescription': {
      'en': 'Reminders about your next possible donation',
      'uk': 'Нагадування про можливість наступної донації',
      'es': 'Recordatorios sobre tu próxima donación posible',
    },
  };

  static String get(String key, String locale) {
    return _translations[key]?[locale] ?? _translations[key]!['en']!;
  }
}