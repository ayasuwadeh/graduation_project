
class Language {
  String code;
  String name;

  Language(this.code, this.name);

  static List<Language> getLanguages() {
    return <Language>[
      Language('ru', 'Russian'),
      Language('tr', 'Turkish'),
      Language('ar', 'Arabic'),
      Language('en', 'English'),
      Language('ja', 'Japanese'),
      Language('hi', 'Indian'),
      Language('es', 'Spain'),
      Language('fr', 'French'),
      Language('it', 'Italian'),
      Language('de', 'German'),
      

    ];
  }
}
