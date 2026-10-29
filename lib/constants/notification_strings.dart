class NotificationStrings {
  static const _translations = {
    'soonTitle': {
      'en': 'You can donate soon',
      'uk': 'Незабаром можна здавати кров',
      'es': 'Pronto puedes donar',
      'fr': 'Vous pourrez bientôt donner votre sang',
    },
    'soonBody': {
      'en': 'Tomorrow you can donate blood again.',
      'uk': 'Завтра ви знову зможете здати кров.',
      'es': 'Mañana podrás donar sangre de nuevo.',
      'fr': 'Demain, vous pourrez à nouveau donner votre sang.',
    },
    'todayTitle': {
      'en': 'You can donate today',
      'uk': 'Сьогодні можна робити донацію',
      'es': 'Puedes donar hoy',
      'fr': 'Vous pouvez donner votre sang aujourd’hui',
    },
    'todayBody': {
      'en': 'Today you can donate blood again.',
      'uk': 'Сьогодні ви можете знову здати кров.',
      'es': 'Hoy puedes donar sangre de nuevo.',
      'fr': 'Aujourd’hui, vous pouvez à nouveau donner votre sang.',
    },
    'alreadyTitle': {
      'en': 'You can donate now',
      'uk': 'Ви вже можете здати кров',
      'es': 'Ya puedes donar',
      'fr': 'Vous pouvez donner votre sang dès maintenant',
    },
    'alreadyBody': {
      'en':
          'You can already donate blood. Maybe it\'s time to plan your next donation.',
      'uk':
          'Ви вже можете здати кров. Можливо, настав час запланувати наступну донацію.',
      'es':
          'Ya puedes donar sangre. Quizás es hora de planear tu próxima donación.',
      'fr':
          'Vous pouvez à nouveau donner votre sang. C’est peut-être le moment de planifier votre prochain don.',
    },
    'longAgoTitle': {
      'en': 'It\'s been a while',
      'uk': 'Давно не було донацій',
      'es': 'Ha pasado mucho tiempo',
      'fr': 'Cela fait longtemps',
    },
    'longAgoBody': {
      'en':
          'It\'s been a long time since your last donation. Maybe it\'s time to help again.',
      'uk': 'Давно не було донацій. Можливо, настав час допомогти знову.',
      'es':
          'Ha pasado mucho tiempo desde tu última donación. Quizás es hora de ayudar de nuevo.',
      'fr':
          'Cela fait longtemps que vous n’avez pas donné votre sang. C’est peut-être le moment d’aider à nouveau.',
    },
    'channelName': {
      'en': 'Donation reminders',
      'uk': 'Нагадування про донацію',
      'es': 'Recordatorios de donación',
      'fr': 'Rappels de don',
    },
    'channelDescription': {
      'en': 'Reminders about your next possible donation',
      'uk': 'Нагадування про можливість наступної донації',
      'es': 'Recordatorios sobre tu próxima donación posible',
      'fr': 'Rappels concernant la date de votre prochain don possible',
    },
  };

  static String get(String key, String locale) {
    return _translations[key]?[locale] ?? _translations[key]!['en']!;
  }
}
