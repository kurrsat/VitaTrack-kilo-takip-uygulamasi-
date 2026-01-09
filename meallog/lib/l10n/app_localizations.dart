import 'package:flutter/widgets.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const supportedLocales = [
    Locale('tr'),
    Locale('en'),
  ];

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'tr': {
      'appTitle': 'MealLog',
      'today': 'Bug�n',
      'search': 'Ara',
      'settings': 'Ayarlar',
      'breakfast': 'Kahvalt�',
      'lunch': '��le Yeme�i',
      'dinner': 'Ak�am Yeme�i',
      'snack': 'Ara ���n',
      'calories': 'Kalori',
      'protein': 'Protein',
      'carbs': 'Karbonhidrat',
      'fat': 'Ya�',
      'add': 'Ekle',
      'addFood': 'Yiyecek Ekle',
      'portion': 'Porsiyon',
      'grams': 'Gram',
      'searchHint': 'Yiyecek ara (�r. domates)',
      'recent': 'Son Kullan�lanlar',
      'favorites': 'Favoriler',
      'manualEntry': 'Manuel Yiyecek',
      'offlineNotice': '�nternet yok. Cache sonu� g�steriliyor.',
      'emptySearch': 'Sonu� bulunamad�.',
      'total': 'Toplam',
      'per100g': '100g',
      'verified': 'Do�rulanm��',
      'save': 'Kaydet',
      'cancel': '�ptal',
      'editEntry': 'Kayd� D�zenle',
      'delete': 'Sil',
      'entryDeleted': 'Kay�t silindi',
      'undo': 'Geri Al',
      'notes': 'Not',
      'macroShort': 'P/K/Y',
      'summary': 'G�n �zeti',
      'tapToSee': 'Detaylar� g�rmek i�in dokun',
      'dailyTotal': 'G�nl�k Toplam',
      'noEntries': 'Hen�z kay�t yok.',
      'tryAgain': 'Tekrar Dene',
      'networkFallback': 'A� eri�imi yok, �rnek veri g�steriliyor.',
      'brand': 'Marka',
      'name': '�sim',
      'nameRequired': '�sim gerekli',
      'kcalPer100g': '100g Kalori',
      'proteinPer100g': '100g Protein',
      'carbPer100g': '100g Karb',
      'fatPer100g': '100g Ya�',
      'addToMeal': '���ne Ekle',
    },
    'en': {
      'appTitle': 'MealLog',
      'today': 'Today',
      'search': 'Search',
      'settings': 'Settings',
      'breakfast': 'Breakfast',
      'lunch': 'Lunch',
      'dinner': 'Dinner',
      'snack': 'Snack',
      'calories': 'Calories',
      'protein': 'Protein',
      'carbs': 'Carbs',
      'fat': 'Fat',
      'add': 'Add',
      'addFood': 'Add Food',
      'portion': 'Portion',
      'grams': 'Grams',
      'searchHint': 'Search foods (e.g. tomato)',
      'recent': 'Recent',
      'favorites': 'Favorites',
      'manualEntry': 'Manual Food',
      'offlineNotice': 'No internet. Showing cached results.',
      'emptySearch': 'No results found.',
      'total': 'Total',
      'per100g': '100g',
      'verified': 'Verified',
      'save': 'Save',
      'cancel': 'Cancel',
      'editEntry': 'Edit Entry',
      'delete': 'Delete',
      'entryDeleted': 'Entry deleted',
      'undo': 'Undo',
      'notes': 'Notes',
      'macroShort': 'P/C/F',
      'summary': 'Daily Summary',
      'tapToSee': 'Tap to view details',
      'dailyTotal': 'Daily Total',
      'noEntries': 'No entries yet.',
      'tryAgain': 'Try Again',
      'networkFallback': 'No network, showing sample data.',
      'brand': 'Brand',
      'name': 'Name',
      'nameRequired': 'Name is required',
      'kcalPer100g': 'Calories per 100g',
      'proteinPer100g': 'Protein per 100g',
      'carbPer100g': 'Carbs per 100g',
      'fatPer100g': 'Fat per 100g',
      'addToMeal': 'Add to meal',
    },
  };

  String _t(String key) => _localizedValues[locale.languageCode]?[key] ??
      _localizedValues['en']![key]!;

  String get appTitle => _t('appTitle');
  String get today => _t('today');
  String get search => _t('search');
  String get settings => _t('settings');
  String get breakfast => _t('breakfast');
  String get lunch => _t('lunch');
  String get dinner => _t('dinner');
  String get snack => _t('snack');
  String get calories => _t('calories');
  String get protein => _t('protein');
  String get carbs => _t('carbs');
  String get fat => _t('fat');
  String get add => _t('add');
  String get addFood => _t('addFood');
  String get portion => _t('portion');
  String get grams => _t('grams');
  String get searchHint => _t('searchHint');
  String get recent => _t('recent');
  String get favorites => _t('favorites');
  String get manualEntry => _t('manualEntry');
  String get offlineNotice => _t('offlineNotice');
  String get emptySearch => _t('emptySearch');
  String get total => _t('total');
  String get per100g => _t('per100g');
  String get verified => _t('verified');
  String get save => _t('save');
  String get cancel => _t('cancel');
  String get editEntry => _t('editEntry');
  String get delete => _t('delete');
  String get entryDeleted => _t('entryDeleted');
  String get undo => _t('undo');
  String get notes => _t('notes');
  String get macroShort => _t('macroShort');
  String get summary => _t('summary');
  String get tapToSee => _t('tapToSee');
  String get dailyTotal => _t('dailyTotal');
  String get noEntries => _t('noEntries');
  String get tryAgain => _t('tryAgain');
  String get networkFallback => _t('networkFallback');
  String get brand => _t('brand');
  String get name => _t('name');
  String get nameRequired => _t('nameRequired');
  String get kcalPer100g => _t('kcalPer100g');
  String get proteinPer100g => _t('proteinPer100g');
  String get carbPer100g => _t('carbPer100g');
  String get fatPer100g => _t('fatPer100g');
  String get addToMeal => _t('addToMeal');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.supportedLocales.map((e) => e.languageCode).contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
