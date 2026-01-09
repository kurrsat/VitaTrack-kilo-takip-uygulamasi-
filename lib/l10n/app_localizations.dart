import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// No description provided for @appName.
  ///
  /// In tr, this message translates to:
  /// **'WeightVault'**
  String get appName;

  /// No description provided for @onboardingTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kilonu trendle yonet'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Dalgalanmayi sakinlestir, hedefe guvenle ilerle.'**
  String get onboardingSubtitle;

  /// No description provided for @continueLabel.
  ///
  /// In tr, this message translates to:
  /// **'Devam'**
  String get continueLabel;

  /// No description provided for @skip.
  ///
  /// In tr, this message translates to:
  /// **'Atla'**
  String get skip;

  /// No description provided for @demoMode.
  ///
  /// In tr, this message translates to:
  /// **'Demo Modu'**
  String get demoMode;

  /// No description provided for @normalMode.
  ///
  /// In tr, this message translates to:
  /// **'Normal Mod'**
  String get normalMode;

  /// No description provided for @login.
  ///
  /// In tr, this message translates to:
  /// **'Giris'**
  String get login;

  /// No description provided for @register.
  ///
  /// In tr, this message translates to:
  /// **'Kayit Ol'**
  String get register;

  /// No description provided for @forgotPassword.
  ///
  /// In tr, this message translates to:
  /// **'Sifremi Unuttum'**
  String get forgotPassword;

  /// No description provided for @dashboard.
  ///
  /// In tr, this message translates to:
  /// **'Panel'**
  String get dashboard;

  /// No description provided for @log.
  ///
  /// In tr, this message translates to:
  /// **'Kayitlar'**
  String get log;

  /// No description provided for @analytics.
  ///
  /// In tr, this message translates to:
  /// **'Analiz'**
  String get analytics;

  /// No description provided for @reportsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Raporlar'**
  String get reportsTitle;

  /// No description provided for @photos.
  ///
  /// In tr, this message translates to:
  /// **'Fotograflar'**
  String get photos;

  /// No description provided for @settings.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get settings;

  /// No description provided for @addButtonLabel.
  ///
  /// In tr, this message translates to:
  /// **'Ekle'**
  String get addButtonLabel;

  /// No description provided for @addWeight.
  ///
  /// In tr, this message translates to:
  /// **'Kilo Ekle'**
  String get addWeight;

  /// No description provided for @addWater.
  ///
  /// In tr, this message translates to:
  /// **'Su Ekle'**
  String get addWater;

  /// No description provided for @addFood.
  ///
  /// In tr, this message translates to:
  /// **'Yemek Ekle'**
  String get addFood;

  /// No description provided for @addPhotoTitle.
  ///
  /// In tr, this message translates to:
  /// **'Fotograf Ekle'**
  String get addPhotoTitle;

  /// No description provided for @addPhotoSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Daha iyi karsilastirma icin ayni isik ve aciyi kullan.'**
  String get addPhotoSubtitle;

  /// No description provided for @logFilterAll.
  ///
  /// In tr, this message translates to:
  /// **'Tumu'**
  String get logFilterAll;

  /// No description provided for @logFilterWeight.
  ///
  /// In tr, this message translates to:
  /// **'Kilo'**
  String get logFilterWeight;

  /// No description provided for @logFilterWater.
  ///
  /// In tr, this message translates to:
  /// **'Su'**
  String get logFilterWater;

  /// No description provided for @logFilterFood.
  ///
  /// In tr, this message translates to:
  /// **'Yemek'**
  String get logFilterFood;

  /// No description provided for @logFilterActivity.
  ///
  /// In tr, this message translates to:
  /// **'Aktivite'**
  String get logFilterActivity;

  /// No description provided for @logFilterPhoto.
  ///
  /// In tr, this message translates to:
  /// **'Foto'**
  String get logFilterPhoto;

  /// No description provided for @yesterdayLabel.
  ///
  /// In tr, this message translates to:
  /// **'Dun'**
  String get yesterdayLabel;

  /// No description provided for @deleteLabel.
  ///
  /// In tr, this message translates to:
  /// **'Sil'**
  String get deleteLabel;

  /// No description provided for @editLabel.
  ///
  /// In tr, this message translates to:
  /// **'Duzenle'**
  String get editLabel;

  /// No description provided for @deleteConfirmTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kaydi sil?'**
  String get deleteConfirmTitle;

  /// No description provided for @deleteConfirmMessage.
  ///
  /// In tr, this message translates to:
  /// **'Bu islem geri alinamaz.'**
  String get deleteConfirmMessage;

  /// No description provided for @recordDetailsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kayit Detayi'**
  String get recordDetailsTitle;

  /// No description provided for @recordSavedMessage.
  ///
  /// In tr, this message translates to:
  /// **'Kayit guncellendi'**
  String get recordSavedMessage;

  /// No description provided for @waterAmountLabel.
  ///
  /// In tr, this message translates to:
  /// **'Su (ml)'**
  String get waterAmountLabel;

  /// No description provided for @photoDetailMessage.
  ///
  /// In tr, this message translates to:
  /// **'Bu fotograf kaydini buradan silebilirsin.'**
  String get photoDetailMessage;

  /// No description provided for @dashboardHeroTitle.
  ///
  /// In tr, this message translates to:
  /// **'Son Olcum'**
  String get dashboardHeroTitle;

  /// No description provided for @lastMeasurementLabel.
  ///
  /// In tr, this message translates to:
  /// **'Son olcum: {value}'**
  String lastMeasurementLabel(Object value);

  /// No description provided for @lastMeasurementUnknown.
  ///
  /// In tr, this message translates to:
  /// **'Son olcum: --'**
  String get lastMeasurementUnknown;

  /// No description provided for @weekDeltaLabel.
  ///
  /// In tr, this message translates to:
  /// **'7 gun degisim: {value}'**
  String weekDeltaLabel(Object value);

  /// No description provided for @weekDeltaUnknown.
  ///
  /// In tr, this message translates to:
  /// **'7 gun degisim: --'**
  String get weekDeltaUnknown;

  /// No description provided for @goalProgressTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hedef'**
  String get goalProgressTitle;

  /// No description provided for @etaNeedsMoreData.
  ///
  /// In tr, this message translates to:
  /// **'Tahmin icin daha fazla olcum gerekli (en az 7 kayit).'**
  String get etaNeedsMoreData;

  /// No description provided for @etaReached.
  ///
  /// In tr, this message translates to:
  /// **'Hedefe ulastin'**
  String get etaReached;

  /// No description provided for @dailySummaryTitle.
  ///
  /// In tr, this message translates to:
  /// **'Gunluk Ozet'**
  String get dailySummaryTitle;

  /// No description provided for @caloriesTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kalori'**
  String get caloriesTitle;

  /// No description provided for @waterTitle.
  ///
  /// In tr, this message translates to:
  /// **'Su'**
  String get waterTitle;

  /// No description provided for @lastEntryTitle.
  ///
  /// In tr, this message translates to:
  /// **'Son Kayit'**
  String get lastEntryTitle;

  /// No description provided for @lastEntrySubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Son ekleme'**
  String get lastEntrySubtitle;

  /// No description provided for @lastEntryUnknown.
  ///
  /// In tr, this message translates to:
  /// **'Henuz kayit yok'**
  String get lastEntryUnknown;

  /// No description provided for @goalUnknown.
  ///
  /// In tr, this message translates to:
  /// **'Hedef: --'**
  String get goalUnknown;

  /// No description provided for @goalInline.
  ///
  /// In tr, this message translates to:
  /// **'Hedef: {value}'**
  String goalInline(Object value);

  /// No description provided for @profileGoalsSectionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Profil ve Hedefler'**
  String get profileGoalsSectionTitle;

  /// No description provided for @profileSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Profil bilgilerini ve hedeflerini guncelle'**
  String get profileSubtitle;

  /// No description provided for @goalTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hedef'**
  String get goalTitle;

  /// No description provided for @unitsSectionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Birimler'**
  String get unitsSectionTitle;

  /// No description provided for @analysisSettingsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Analiz Ayarlari'**
  String get analysisSettingsTitle;

  /// No description provided for @analysisSettingsSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Yumusatma ve gelismis ayarlar'**
  String get analysisSettingsSubtitle;

  /// No description provided for @advancedSettingsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Gelismis'**
  String get advancedSettingsTitle;

  /// No description provided for @unitUnknown.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlanmadi'**
  String get unitUnknown;

  /// No description provided for @range7d.
  ///
  /// In tr, this message translates to:
  /// **'7g'**
  String get range7d;

  /// No description provided for @analyticsViewTitle.
  ///
  /// In tr, this message translates to:
  /// **'Gorunum'**
  String get analyticsViewTitle;

  /// No description provided for @analyticsViewTrend.
  ///
  /// In tr, this message translates to:
  /// **'Trend (Onerilen)'**
  String get analyticsViewTrend;

  /// No description provided for @analyticsViewRaw.
  ///
  /// In tr, this message translates to:
  /// **'Ham'**
  String get analyticsViewRaw;

  /// No description provided for @analyticsSmoothingTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yumusatma'**
  String get analyticsSmoothingTitle;

  /// No description provided for @smoothingLow.
  ///
  /// In tr, this message translates to:
  /// **'Dusuk'**
  String get smoothingLow;

  /// No description provided for @smoothingMedium.
  ///
  /// In tr, this message translates to:
  /// **'Orta'**
  String get smoothingMedium;

  /// No description provided for @smoothingHigh.
  ///
  /// In tr, this message translates to:
  /// **'Yuksek'**
  String get smoothingHigh;

  /// No description provided for @photosEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henuz fotograf yok'**
  String get photosEmptyTitle;

  /// No description provided for @photosEmptyLineOne.
  ///
  /// In tr, this message translates to:
  /// **'Ayni isik, ayni aci, haftada 1 cek.'**
  String get photosEmptyLineOne;

  /// No description provided for @photosEmptyLineTwo.
  ///
  /// In tr, this message translates to:
  /// **'Once/Sonra karsilastirmasi icin fotograf ekle.'**
  String get photosEmptyLineTwo;

  /// No description provided for @startFasting.
  ///
  /// In tr, this message translates to:
  /// **'Oruc Baslat'**
  String get startFasting;

  /// No description provided for @retry.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Dene'**
  String get retry;

  /// No description provided for @errorSomethingWentWrong.
  ///
  /// In tr, this message translates to:
  /// **'Bir seyler ters gitti'**
  String get errorSomethingWentWrong;

  /// No description provided for @unlockApp.
  ///
  /// In tr, this message translates to:
  /// **'WeightVault kilidini ac'**
  String get unlockApp;

  /// No description provided for @initializingApp.
  ///
  /// In tr, this message translates to:
  /// **'WeightVault baslatiliyor'**
  String get initializingApp;

  /// No description provided for @modeSelectTitle.
  ///
  /// In tr, this message translates to:
  /// **'Mod Secimi'**
  String get modeSelectTitle;

  /// No description provided for @modeSelectHeadline.
  ///
  /// In tr, this message translates to:
  /// **'Nasil baslamak istersin?'**
  String get modeSelectHeadline;

  /// No description provided for @demoModeDescription.
  ///
  /// In tr, this message translates to:
  /// **'Offline deneyim, ornek verilerle tam akisi dene.'**
  String get demoModeDescription;

  /// No description provided for @demoModeCta.
  ///
  /// In tr, this message translates to:
  /// **'Demo ile Basla'**
  String get demoModeCta;

  /// No description provided for @normalModeDescription.
  ///
  /// In tr, this message translates to:
  /// **'Firebase ile senkronize, bulut destekli kullan.'**
  String get normalModeDescription;

  /// No description provided for @normalModeCta.
  ///
  /// In tr, this message translates to:
  /// **'Normal Moda Gec'**
  String get normalModeCta;

  /// No description provided for @emailLabel.
  ///
  /// In tr, this message translates to:
  /// **'Eposta'**
  String get emailLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In tr, this message translates to:
  /// **'Sifre'**
  String get passwordLabel;

  /// No description provided for @signingIn.
  ///
  /// In tr, this message translates to:
  /// **'Giris yapiliyor'**
  String get signingIn;

  /// No description provided for @createAccount.
  ///
  /// In tr, this message translates to:
  /// **'Hesap olustur'**
  String get createAccount;

  /// No description provided for @haveAccount.
  ///
  /// In tr, this message translates to:
  /// **'Hesabim var'**
  String get haveAccount;

  /// No description provided for @continueWithGoogle.
  ///
  /// In tr, this message translates to:
  /// **'Google ile devam et'**
  String get continueWithGoogle;

  /// No description provided for @continueWithApple.
  ///
  /// In tr, this message translates to:
  /// **'Apple ile devam et'**
  String get continueWithApple;

  /// No description provided for @authError.
  ///
  /// In tr, this message translates to:
  /// **'Giris hatasi: {error}'**
  String authError(Object error);

  /// No description provided for @passwordResetSent.
  ///
  /// In tr, this message translates to:
  /// **'Sifre sifirlama e-postasi gonderildi.'**
  String get passwordResetSent;

  /// No description provided for @permissionsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Izinler'**
  String get permissionsTitle;

  /// No description provided for @permissionsSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Bildirim ve saglik verisi izinleri ile hatirlatmalari acin.'**
  String get permissionsSubtitle;

  /// No description provided for @notificationsPermissionCta.
  ///
  /// In tr, this message translates to:
  /// **'Bildirim Izni Ver'**
  String get notificationsPermissionCta;

  /// No description provided for @healthPermissionCta.
  ///
  /// In tr, this message translates to:
  /// **'HealthKit / Google Fit'**
  String get healthPermissionCta;

  /// No description provided for @goalSetupTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hedefini kur'**
  String get goalSetupTitle;

  /// No description provided for @nameLabel.
  ///
  /// In tr, this message translates to:
  /// **'Isim'**
  String get nameLabel;

  /// No description provided for @birthYearLabel.
  ///
  /// In tr, this message translates to:
  /// **'Dogum Yili'**
  String get birthYearLabel;

  /// No description provided for @genderLabel.
  ///
  /// In tr, this message translates to:
  /// **'Cinsiyet'**
  String get genderLabel;

  /// No description provided for @genderMale.
  ///
  /// In tr, this message translates to:
  /// **'Erkek'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In tr, this message translates to:
  /// **'Kadin'**
  String get genderFemale;

  /// No description provided for @genderOther.
  ///
  /// In tr, this message translates to:
  /// **'Diger'**
  String get genderOther;

  /// No description provided for @currentWeightLabel.
  ///
  /// In tr, this message translates to:
  /// **'Guncel Kilo (kg)'**
  String get currentWeightLabel;

  /// No description provided for @heightLabel.
  ///
  /// In tr, this message translates to:
  /// **'Boy (cm)'**
  String get heightLabel;

  /// No description provided for @unitsLabel.
  ///
  /// In tr, this message translates to:
  /// **'Birimler'**
  String get unitsLabel;

  /// No description provided for @unitsMetric.
  ///
  /// In tr, this message translates to:
  /// **'Metrik'**
  String get unitsMetric;

  /// No description provided for @unitsImperial.
  ///
  /// In tr, this message translates to:
  /// **'Imperial'**
  String get unitsImperial;

  /// No description provided for @activityLevelLabel.
  ///
  /// In tr, this message translates to:
  /// **'Aktivite Seviyesi'**
  String get activityLevelLabel;

  /// No description provided for @activityLevelLow.
  ///
  /// In tr, this message translates to:
  /// **'Dusuk'**
  String get activityLevelLow;

  /// No description provided for @activityLevelModerate.
  ///
  /// In tr, this message translates to:
  /// **'Orta'**
  String get activityLevelModerate;

  /// No description provided for @activityLevelHigh.
  ///
  /// In tr, this message translates to:
  /// **'Yuksek'**
  String get activityLevelHigh;

  /// No description provided for @activityLevelVeryHigh.
  ///
  /// In tr, this message translates to:
  /// **'Cok Yuksek'**
  String get activityLevelVeryHigh;

  /// No description provided for @goalTypeLabel.
  ///
  /// In tr, this message translates to:
  /// **'Hedef Turu'**
  String get goalTypeLabel;

  /// No description provided for @goalWeightLabel.
  ///
  /// In tr, this message translates to:
  /// **'Hedef Kilo'**
  String get goalWeightLabel;

  /// No description provided for @goalDateLabel.
  ///
  /// In tr, this message translates to:
  /// **'Hedef Tarih'**
  String get goalDateLabel;

  /// No description provided for @goalTypeLose.
  ///
  /// In tr, this message translates to:
  /// **'Kilo ver'**
  String get goalTypeLose;

  /// No description provided for @goalTypeGain.
  ///
  /// In tr, this message translates to:
  /// **'Kilo al'**
  String get goalTypeGain;

  /// No description provided for @goalTypeMaintain.
  ///
  /// In tr, this message translates to:
  /// **'Kilo koru'**
  String get goalTypeMaintain;

  /// No description provided for @dailyCalorieGoalMessage.
  ///
  /// In tr, this message translates to:
  /// **'Gunluk kalori hedefin: {value} kcal'**
  String dailyCalorieGoalMessage(Object value);

  /// No description provided for @weeklyCaloriesTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kaloriler'**
  String get weeklyCaloriesTitle;

  /// No description provided for @weeklyCaloriesChartTitle.
  ///
  /// In tr, this message translates to:
  /// **'Gunluk alim'**
  String get weeklyCaloriesChartTitle;

  /// No description provided for @weeklyCaloriesAverage.
  ///
  /// In tr, this message translates to:
  /// **'Gunluk Ortalama: {value} kcal'**
  String weeklyCaloriesAverage(Object value);

  /// No description provided for @weeklyCaloriesTotal.
  ///
  /// In tr, this message translates to:
  /// **'Toplam: {value} kcal'**
  String weeklyCaloriesTotal(Object value);

  /// No description provided for @weeklyCaloriesTarget.
  ///
  /// In tr, this message translates to:
  /// **'Hedef: {value} kcal'**
  String weeklyCaloriesTarget(Object value);

  /// No description provided for @weeklyCaloriesEmptyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kalori verisi yok'**
  String get weeklyCaloriesEmptyTitle;

  /// No description provided for @weeklyCaloriesEmptyMessage.
  ///
  /// In tr, this message translates to:
  /// **'Son 7 gun icin kalori kaydi yok.'**
  String get weeklyCaloriesEmptyMessage;

  /// No description provided for @emptyWeightTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henuz kilo kaydi yok'**
  String get emptyWeightTitle;

  /// No description provided for @emptyWeightMessage.
  ///
  /// In tr, this message translates to:
  /// **'Trend ve ETA icin ilk olcumu ekle.'**
  String get emptyWeightMessage;

  /// No description provided for @trendTitle.
  ///
  /// In tr, this message translates to:
  /// **'Trend'**
  String get trendTitle;

  /// No description provided for @latestLabel.
  ///
  /// In tr, this message translates to:
  /// **'Son'**
  String get latestLabel;

  /// No description provided for @etaLabel.
  ///
  /// In tr, this message translates to:
  /// **'ETA'**
  String get etaLabel;

  /// No description provided for @etaDays.
  ///
  /// In tr, this message translates to:
  /// **'{days} gun'**
  String etaDays(Object days);

  /// No description provided for @stableLabel.
  ///
  /// In tr, this message translates to:
  /// **'Stabil'**
  String get stableLabel;

  /// No description provided for @goalLabel.
  ///
  /// In tr, this message translates to:
  /// **'Hedef: {weight} kg'**
  String goalLabel(Object weight);

  /// No description provided for @plateauMessage.
  ///
  /// In tr, this message translates to:
  /// **'Plateau tespit edildi. Kalori veya aktiviteyi ayarlamayi dusun.'**
  String get plateauMessage;

  /// No description provided for @quickAddTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hizli Ekle'**
  String get quickAddTitle;

  /// No description provided for @emptyLogTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henuz kayit yok'**
  String get emptyLogTitle;

  /// No description provided for @emptyLogMessage.
  ///
  /// In tr, this message translates to:
  /// **'Ilk kilo kaydini ekle.'**
  String get emptyLogMessage;

  /// No description provided for @entryDeleted.
  ///
  /// In tr, this message translates to:
  /// **'Kayit silindi'**
  String get entryDeleted;

  /// No description provided for @undo.
  ///
  /// In tr, this message translates to:
  /// **'Geri Al'**
  String get undo;

  /// No description provided for @weightSaved.
  ///
  /// In tr, this message translates to:
  /// **'Kilo kaydedildi'**
  String get weightSaved;

  /// No description provided for @weightLabel.
  ///
  /// In tr, this message translates to:
  /// **'Kilo (kg)'**
  String get weightLabel;

  /// No description provided for @noteLabel.
  ///
  /// In tr, this message translates to:
  /// **'Not'**
  String get noteLabel;

  /// No description provided for @conditionLabel.
  ///
  /// In tr, this message translates to:
  /// **'Durum'**
  String get conditionLabel;

  /// No description provided for @moodLabel.
  ///
  /// In tr, this message translates to:
  /// **'Ruh Hali'**
  String get moodLabel;

  /// No description provided for @dateTimeLabel.
  ///
  /// In tr, this message translates to:
  /// **'Tarih ve Saat'**
  String get dateTimeLabel;

  /// No description provided for @cancel.
  ///
  /// In tr, this message translates to:
  /// **'Iptal'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In tr, this message translates to:
  /// **'Kaydet'**
  String get save;

  /// No description provided for @conditionMorningFasted.
  ///
  /// In tr, this message translates to:
  /// **'Sabah ac'**
  String get conditionMorningFasted;

  /// No description provided for @conditionMorningFed.
  ///
  /// In tr, this message translates to:
  /// **'Sabah tok'**
  String get conditionMorningFed;

  /// No description provided for @conditionEveningFasted.
  ///
  /// In tr, this message translates to:
  /// **'Aksam ac'**
  String get conditionEveningFasted;

  /// No description provided for @conditionEveningFed.
  ///
  /// In tr, this message translates to:
  /// **'Aksam tok'**
  String get conditionEveningFed;

  /// No description provided for @moodGreat.
  ///
  /// In tr, this message translates to:
  /// **'Harika'**
  String get moodGreat;

  /// No description provided for @moodOk.
  ///
  /// In tr, this message translates to:
  /// **'Iyi'**
  String get moodOk;

  /// No description provided for @moodLow.
  ///
  /// In tr, this message translates to:
  /// **'Dusuk'**
  String get moodLow;

  /// No description provided for @moodStressed.
  ///
  /// In tr, this message translates to:
  /// **'Stresli'**
  String get moodStressed;

  /// No description provided for @noDataTitle.
  ///
  /// In tr, this message translates to:
  /// **'Veri yok'**
  String get noDataTitle;

  /// No description provided for @noDataAnalyticsMessage.
  ///
  /// In tr, this message translates to:
  /// **'Analiz icin kilo kayitlari ekle.'**
  String get noDataAnalyticsMessage;

  /// No description provided for @range30d.
  ///
  /// In tr, this message translates to:
  /// **'30g'**
  String get range30d;

  /// No description provided for @range6m.
  ///
  /// In tr, this message translates to:
  /// **'6ay'**
  String get range6m;

  /// No description provided for @range90d.
  ///
  /// In tr, this message translates to:
  /// **'90g'**
  String get range90d;

  /// No description provided for @range1y.
  ///
  /// In tr, this message translates to:
  /// **'1yil'**
  String get range1y;

  /// No description provided for @trendMethodLabel.
  ///
  /// In tr, this message translates to:
  /// **'Trend Yontemi'**
  String get trendMethodLabel;

  /// No description provided for @alphaLabel.
  ///
  /// In tr, this message translates to:
  /// **'Alfa: {value}'**
  String alphaLabel(Object value);

  /// No description provided for @betaLabel.
  ///
  /// In tr, this message translates to:
  /// **'Beta: {value}'**
  String betaLabel(Object value);

  /// No description provided for @trendMethodMovingAverage.
  ///
  /// In tr, this message translates to:
  /// **'Hareketli Ortalama'**
  String get trendMethodMovingAverage;

  /// No description provided for @trendMethodExponential.
  ///
  /// In tr, this message translates to:
  /// **'Ussel Duzeltme'**
  String get trendMethodExponential;

  /// No description provided for @trendMethodDoubleExponential.
  ///
  /// In tr, this message translates to:
  /// **'Cift Ussel'**
  String get trendMethodDoubleExponential;

  /// No description provided for @trendMethodCustom.
  ///
  /// In tr, this message translates to:
  /// **'Ozel'**
  String get trendMethodCustom;

  /// No description provided for @waterAdded.
  ///
  /// In tr, this message translates to:
  /// **'{amount} ml eklendi'**
  String waterAdded(Object amount);

  /// No description provided for @waterTrackerTitle.
  ///
  /// In tr, this message translates to:
  /// **'Su Takibi'**
  String get waterTrackerTitle;

  /// No description provided for @todayLabel.
  ///
  /// In tr, this message translates to:
  /// **'Bugun'**
  String get todayLabel;

  /// No description provided for @waterProgress.
  ///
  /// In tr, this message translates to:
  /// **'{current} ml / {goal} ml'**
  String waterProgress(Object current, Object goal);

  /// No description provided for @waterWeekTitle.
  ///
  /// In tr, this message translates to:
  /// **'Son 7 gun'**
  String get waterWeekTitle;

  /// No description provided for @waterStreakLabel.
  ///
  /// In tr, this message translates to:
  /// **'{days} gun seri'**
  String waterStreakLabel(Object days);

  /// No description provided for @waterGoalMetLabel.
  ///
  /// In tr, this message translates to:
  /// **'{count}/{total} gun hedefte'**
  String waterGoalMetLabel(Object count, Object total);

  /// No description provided for @waterAverageLabel.
  ///
  /// In tr, this message translates to:
  /// **'Gunluk ortalama {amount} ml'**
  String waterAverageLabel(Object amount);

  /// No description provided for @addWaterAmount.
  ///
  /// In tr, this message translates to:
  /// **'+{amount} ml'**
  String addWaterAmount(Object amount);

  /// No description provided for @waterAmount.
  ///
  /// In tr, this message translates to:
  /// **'{amount} ml'**
  String waterAmount(Object amount);

  /// No description provided for @fastingTitle.
  ///
  /// In tr, this message translates to:
  /// **'Oruclama'**
  String get fastingTitle;

  /// No description provided for @startFastTitle.
  ///
  /// In tr, this message translates to:
  /// **'Oruca Basla'**
  String get startFastTitle;

  /// No description provided for @goalHoursLabel.
  ///
  /// In tr, this message translates to:
  /// **'Hedef Saat'**
  String get goalHoursLabel;

  /// No description provided for @startLabel.
  ///
  /// In tr, this message translates to:
  /// **'Baslat'**
  String get startLabel;

  /// No description provided for @activeFastTitle.
  ///
  /// In tr, this message translates to:
  /// **'Aktif Oruc'**
  String get activeFastTitle;

  /// No description provided for @elapsedLabel.
  ///
  /// In tr, this message translates to:
  /// **'Gecen: {hours}s {minutes}d'**
  String elapsedLabel(Object hours, Object minutes);

  /// No description provided for @remainingLabel.
  ///
  /// In tr, this message translates to:
  /// **'Kalan: {hours}s {minutes}d'**
  String remainingLabel(Object hours, Object minutes);

  /// No description provided for @stopLabel.
  ///
  /// In tr, this message translates to:
  /// **'Durdur'**
  String get stopLabel;

  /// No description provided for @loadingFasting.
  ///
  /// In tr, this message translates to:
  /// **'Oruc yukleniyor'**
  String get loadingFasting;

  /// No description provided for @errorTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hata'**
  String get errorTitle;

  /// No description provided for @validationRequired.
  ///
  /// In tr, this message translates to:
  /// **'Lutfen bu alani doldurun.'**
  String get validationRequired;

  /// No description provided for @validationInvalidNumber.
  ///
  /// In tr, this message translates to:
  /// **'Gecerli bir sayi girin.'**
  String get validationInvalidNumber;

  /// No description provided for @historyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Gecmis'**
  String get historyTitle;

  /// No description provided for @doneLabel.
  ///
  /// In tr, this message translates to:
  /// **'Tamam'**
  String get doneLabel;

  /// No description provided for @activeLabel.
  ///
  /// In tr, this message translates to:
  /// **'Aktif'**
  String get activeLabel;

  /// No description provided for @loadingHistory.
  ///
  /// In tr, this message translates to:
  /// **'Gecmis yukleniyor'**
  String get loadingHistory;

  /// No description provided for @fastingPlan168.
  ///
  /// In tr, this message translates to:
  /// **'16:8'**
  String get fastingPlan168;

  /// No description provided for @fastingPlan186.
  ///
  /// In tr, this message translates to:
  /// **'18:6'**
  String get fastingPlan186;

  /// No description provided for @fastingPlan204.
  ///
  /// In tr, this message translates to:
  /// **'20:4'**
  String get fastingPlan204;

  /// No description provided for @fastingPlanOmad.
  ///
  /// In tr, this message translates to:
  /// **'OMAD'**
  String get fastingPlanOmad;

  /// No description provided for @fastingPlanCustom.
  ///
  /// In tr, this message translates to:
  /// **'Ozel'**
  String get fastingPlanCustom;

  /// No description provided for @fastingCompleteTitle.
  ///
  /// In tr, this message translates to:
  /// **'Oruc Tamamlandi'**
  String get fastingCompleteTitle;

  /// No description provided for @fastingCompleteBody.
  ///
  /// In tr, this message translates to:
  /// **'Tebrikler! Oruc hedefin tamamlandi.'**
  String get fastingCompleteBody;

  /// No description provided for @activityTitle.
  ///
  /// In tr, this message translates to:
  /// **'Aktivite'**
  String get activityTitle;

  /// No description provided for @stepsToday.
  ///
  /// In tr, this message translates to:
  /// **'Bugun Adim'**
  String get stepsToday;

  /// No description provided for @stepsCount.
  ///
  /// In tr, this message translates to:
  /// **'{steps} adim'**
  String stepsCount(Object steps);

  /// No description provided for @fetchingSteps.
  ///
  /// In tr, this message translates to:
  /// **'Adimlar aliniyor'**
  String get fetchingSteps;

  /// No description provided for @stepsErrorTitle.
  ///
  /// In tr, this message translates to:
  /// **'Adim hatasi'**
  String get stepsErrorTitle;

  /// No description provided for @noActivitiesTitle.
  ///
  /// In tr, this message translates to:
  /// **'Aktivite yok'**
  String get noActivitiesTitle;

  /// No description provided for @noActivitiesMessage.
  ///
  /// In tr, this message translates to:
  /// **'Manuel antrenman ekleyerek takip et.'**
  String get noActivitiesMessage;

  /// No description provided for @workoutsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Antrenmanlar'**
  String get workoutsTitle;

  /// No description provided for @workoutDetails.
  ///
  /// In tr, this message translates to:
  /// **'{minutes} dk | {calories} kcal'**
  String workoutDetails(Object minutes, Object calories);

  /// No description provided for @measurementsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Olcumler'**
  String get measurementsTitle;

  /// No description provided for @noMeasurementsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Olcum yok'**
  String get noMeasurementsTitle;

  /// No description provided for @noMeasurementsMessage.
  ///
  /// In tr, this message translates to:
  /// **'Vucut degisimini takip icin olcum ekle.'**
  String get noMeasurementsMessage;

  /// No description provided for @measurementChartTitle.
  ///
  /// In tr, this message translates to:
  /// **'Olcum Trendi'**
  String get measurementChartTitle;

  /// No description provided for @measurementMetricLabel.
  ///
  /// In tr, this message translates to:
  /// **'Metrik'**
  String get measurementMetricLabel;

  /// No description provided for @measurementLatestValue.
  ///
  /// In tr, this message translates to:
  /// **'Son: {value} {unit}'**
  String measurementLatestValue(Object value, Object unit);

  /// No description provided for @metricWaist.
  ///
  /// In tr, this message translates to:
  /// **'Bel'**
  String get metricWaist;

  /// No description provided for @metricHip.
  ///
  /// In tr, this message translates to:
  /// **'Kalca'**
  String get metricHip;

  /// No description provided for @metricChest.
  ///
  /// In tr, this message translates to:
  /// **'Gogus'**
  String get metricChest;

  /// No description provided for @metricNeck.
  ///
  /// In tr, this message translates to:
  /// **'Boyun'**
  String get metricNeck;

  /// No description provided for @metricArm.
  ///
  /// In tr, this message translates to:
  /// **'Kol'**
  String get metricArm;

  /// No description provided for @metricThigh.
  ///
  /// In tr, this message translates to:
  /// **'Bacak'**
  String get metricThigh;

  /// No description provided for @metricBodyFat.
  ///
  /// In tr, this message translates to:
  /// **'Yag %'**
  String get metricBodyFat;

  /// No description provided for @metricMuscle.
  ///
  /// In tr, this message translates to:
  /// **'Kas %'**
  String get metricMuscle;

  /// No description provided for @metricWaterPct.
  ///
  /// In tr, this message translates to:
  /// **'Su %'**
  String get metricWaterPct;

  /// No description provided for @measurementWaistHip.
  ///
  /// In tr, this message translates to:
  /// **'Bel: {waist} cm | Kalca: {hip} cm'**
  String measurementWaistHip(Object waist, Object hip);

  /// No description provided for @measurementChestNeck.
  ///
  /// In tr, this message translates to:
  /// **'Gogus: {chest} cm | Boyun: {neck} cm'**
  String measurementChestNeck(Object chest, Object neck);

  /// No description provided for @measurementArmThigh.
  ///
  /// In tr, this message translates to:
  /// **'Kol: {arm} cm | Bacak: {thigh} cm'**
  String measurementArmThigh(Object arm, Object thigh);

  /// No description provided for @quickAddWeightLoading.
  ///
  /// In tr, this message translates to:
  /// **'Hizli kilo ekle aciliyor'**
  String get quickAddWeightLoading;

  /// No description provided for @quickAddWaterLoading.
  ///
  /// In tr, this message translates to:
  /// **'Su ekleniyor'**
  String get quickAddWaterLoading;

  /// No description provided for @nutritionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Beslenme'**
  String get nutritionTitle;

  /// No description provided for @noFoodLoggedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yemek kaydi yok'**
  String get noFoodLoggedTitle;

  /// No description provided for @noFoodLoggedMessage.
  ///
  /// In tr, this message translates to:
  /// **'Gunluk toplamlar icin ogun ekle.'**
  String get noFoodLoggedMessage;

  /// No description provided for @todayTotalsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bugun Toplam'**
  String get todayTotalsTitle;

  /// No description provided for @caloriesValue.
  ///
  /// In tr, this message translates to:
  /// **'Kalori: {value} kcal'**
  String caloriesValue(Object value);

  /// No description provided for @proteinValue.
  ///
  /// In tr, this message translates to:
  /// **'Protein: {value} g'**
  String proteinValue(Object value);

  /// No description provided for @carbValue.
  ///
  /// In tr, this message translates to:
  /// **'Karb: {value} g'**
  String carbValue(Object value);

  /// No description provided for @fatValue.
  ///
  /// In tr, this message translates to:
  /// **'Yag: {value} g'**
  String fatValue(Object value);

  /// No description provided for @foodItemCalories.
  ///
  /// In tr, this message translates to:
  /// **'{name} - {cal} kcal'**
  String foodItemCalories(Object name, Object cal);

  /// No description provided for @addFoodTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yemek Ekle'**
  String get addFoodTitle;

  /// No description provided for @barcodeLabel.
  ///
  /// In tr, this message translates to:
  /// **'Barkod'**
  String get barcodeLabel;

  /// No description provided for @lookupLabel.
  ///
  /// In tr, this message translates to:
  /// **'Ara'**
  String get lookupLabel;

  /// No description provided for @mealTypeLabel.
  ///
  /// In tr, this message translates to:
  /// **'Ogun Turu'**
  String get mealTypeLabel;

  /// No description provided for @gramsLabel.
  ///
  /// In tr, this message translates to:
  /// **'Gram'**
  String get gramsLabel;

  /// No description provided for @caloriesLabel.
  ///
  /// In tr, this message translates to:
  /// **'Kalori (kcal)'**
  String get caloriesLabel;

  /// No description provided for @proteinLabel.
  ///
  /// In tr, this message translates to:
  /// **'Protein (g)'**
  String get proteinLabel;

  /// No description provided for @carbLabel.
  ///
  /// In tr, this message translates to:
  /// **'Karb (g)'**
  String get carbLabel;

  /// No description provided for @fatLabel.
  ///
  /// In tr, this message translates to:
  /// **'Yag (g)'**
  String get fatLabel;

  /// No description provided for @foodSaved.
  ///
  /// In tr, this message translates to:
  /// **'Yemek kaydedildi'**
  String get foodSaved;

  /// No description provided for @foodDefaultName.
  ///
  /// In tr, this message translates to:
  /// **'Yemek'**
  String get foodDefaultName;

  /// No description provided for @mealBreakfast.
  ///
  /// In tr, this message translates to:
  /// **'Kahvalti'**
  String get mealBreakfast;

  /// No description provided for @mealLunch.
  ///
  /// In tr, this message translates to:
  /// **'Ogle'**
  String get mealLunch;

  /// No description provided for @mealDinner.
  ///
  /// In tr, this message translates to:
  /// **'Aksam'**
  String get mealDinner;

  /// No description provided for @mealSnack.
  ///
  /// In tr, this message translates to:
  /// **'Ara Ogun'**
  String get mealSnack;

  /// No description provided for @customFoodTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ozel Yemek'**
  String get customFoodTitle;

  /// No description provided for @customFoodSaved.
  ///
  /// In tr, this message translates to:
  /// **'Ozel yemek kaydedildi'**
  String get customFoodSaved;

  /// No description provided for @nameTrLabel.
  ///
  /// In tr, this message translates to:
  /// **'Isim (TR)'**
  String get nameTrLabel;

  /// No description provided for @nameEnLabel.
  ///
  /// In tr, this message translates to:
  /// **'Isim (EN)'**
  String get nameEnLabel;

  /// No description provided for @barcodeOptionalLabel.
  ///
  /// In tr, this message translates to:
  /// **'Barkod (opsiyonel)'**
  String get barcodeOptionalLabel;

  /// No description provided for @customFoodDefaultTr.
  ///
  /// In tr, this message translates to:
  /// **'Ozel yemek (TR)'**
  String get customFoodDefaultTr;

  /// No description provided for @customFoodDefaultEn.
  ///
  /// In tr, this message translates to:
  /// **'Ozel yemek (EN)'**
  String get customFoodDefaultEn;

  /// No description provided for @addActivityTitle.
  ///
  /// In tr, this message translates to:
  /// **'Aktivite Ekle'**
  String get addActivityTitle;

  /// No description provided for @activitySaved.
  ///
  /// In tr, this message translates to:
  /// **'Aktivite kaydedildi'**
  String get activitySaved;

  /// No description provided for @activityTypeLabel.
  ///
  /// In tr, this message translates to:
  /// **'Aktivite Turu'**
  String get activityTypeLabel;

  /// No description provided for @activityDurationLabel.
  ///
  /// In tr, this message translates to:
  /// **'Sure (dk)'**
  String get activityDurationLabel;

  /// No description provided for @activityDefaultType.
  ///
  /// In tr, this message translates to:
  /// **'Antrenman'**
  String get activityDefaultType;

  /// No description provided for @addMeasurementsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Olcum Ekle'**
  String get addMeasurementsTitle;

  /// No description provided for @measurementsSaved.
  ///
  /// In tr, this message translates to:
  /// **'Olcumler kaydedildi'**
  String get measurementsSaved;

  /// No description provided for @waistLabel.
  ///
  /// In tr, this message translates to:
  /// **'Bel (cm)'**
  String get waistLabel;

  /// No description provided for @hipLabel.
  ///
  /// In tr, this message translates to:
  /// **'Kalca (cm)'**
  String get hipLabel;

  /// No description provided for @chestLabel.
  ///
  /// In tr, this message translates to:
  /// **'Gogus (cm)'**
  String get chestLabel;

  /// No description provided for @neckLabel.
  ///
  /// In tr, this message translates to:
  /// **'Boyun (cm)'**
  String get neckLabel;

  /// No description provided for @armLabel.
  ///
  /// In tr, this message translates to:
  /// **'Kol (cm)'**
  String get armLabel;

  /// No description provided for @thighLabel.
  ///
  /// In tr, this message translates to:
  /// **'Bacak (cm)'**
  String get thighLabel;

  /// No description provided for @progressPhotosTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ilerleme Fotograflari'**
  String get progressPhotosTitle;

  /// No description provided for @noPhotosTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henuz fotograf yok'**
  String get noPhotosTitle;

  /// No description provided for @noPhotosMessage.
  ///
  /// In tr, this message translates to:
  /// **'Ilerlemeyi karsilastirmak icin fotograf ekle.'**
  String get noPhotosMessage;

  /// No description provided for @photoTypeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Fotograf turu sec'**
  String get photoTypeTitle;

  /// No description provided for @photoTypeFront.
  ///
  /// In tr, this message translates to:
  /// **'On'**
  String get photoTypeFront;

  /// No description provided for @photoTypeSide.
  ///
  /// In tr, this message translates to:
  /// **'Yan'**
  String get photoTypeSide;

  /// No description provided for @photoTypeBack.
  ///
  /// In tr, this message translates to:
  /// **'Arka'**
  String get photoTypeBack;

  /// No description provided for @photoCompareTitle.
  ///
  /// In tr, this message translates to:
  /// **'Fotograf Karsilastir'**
  String get photoCompareTitle;

  /// No description provided for @weeklyInsightsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Haftalik Icgoruler'**
  String get weeklyInsightsTitle;

  /// No description provided for @weeklyReportTitle.
  ///
  /// In tr, this message translates to:
  /// **'Haftalik Rapor'**
  String get weeklyReportTitle;

  /// No description provided for @weeklySummaryTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ozet'**
  String get weeklySummaryTitle;

  /// No description provided for @weeklyWeightChangeLabel.
  ///
  /// In tr, this message translates to:
  /// **'Kilo degisimi'**
  String get weeklyWeightChangeLabel;

  /// No description provided for @weeklyTrendSpeedLabel.
  ///
  /// In tr, this message translates to:
  /// **'Trend hizi'**
  String get weeklyTrendSpeedLabel;

  /// No description provided for @weeklyWaterAdherenceLabel.
  ///
  /// In tr, this message translates to:
  /// **'Su uyumu'**
  String get weeklyWaterAdherenceLabel;

  /// No description provided for @weeklyFastingCountLabel.
  ///
  /// In tr, this message translates to:
  /// **'Oruc seanslari'**
  String get weeklyFastingCountLabel;

  /// No description provided for @weeklyWaterAdherenceValue.
  ///
  /// In tr, this message translates to:
  /// **'{count}/{total} gun'**
  String weeklyWaterAdherenceValue(Object count, Object total);

  /// No description provided for @weeklyFastingCountValue.
  ///
  /// In tr, this message translates to:
  /// **'{count} seans'**
  String weeklyFastingCountValue(Object count);

  /// No description provided for @weeklyGeneratedLabel.
  ///
  /// In tr, this message translates to:
  /// **'Olusturuldu {time}'**
  String weeklyGeneratedLabel(Object time);

  /// No description provided for @weeklyReportShareText.
  ///
  /// In tr, this message translates to:
  /// **'WeightVault Haftalik Rapor'**
  String get weeklyReportShareText;

  /// No description provided for @noInsightsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Henuz icgoru yok'**
  String get noInsightsTitle;

  /// No description provided for @noInsightsMessage.
  ///
  /// In tr, this message translates to:
  /// **'Icgoruler icin kilo kaydi ekle.'**
  String get noInsightsMessage;

  /// No description provided for @noRecentDataTitle.
  ///
  /// In tr, this message translates to:
  /// **'Son veri yok'**
  String get noRecentDataTitle;

  /// No description provided for @noRecentDataMessage.
  ///
  /// In tr, this message translates to:
  /// **'Bu hafta kilo girisi yap.'**
  String get noRecentDataMessage;

  /// No description provided for @adaptiveTargetTitle.
  ///
  /// In tr, this message translates to:
  /// **'Uyarlanabilir Hedef'**
  String get adaptiveTargetTitle;

  /// No description provided for @bmrValue.
  ///
  /// In tr, this message translates to:
  /// **'BMR: {value} kcal'**
  String bmrValue(Object value);

  /// No description provided for @tdeeValue.
  ///
  /// In tr, this message translates to:
  /// **'TDEE: {value} kcal'**
  String tdeeValue(Object value);

  /// No description provided for @suggestedValue.
  ///
  /// In tr, this message translates to:
  /// **'Oneri: {value} kcal'**
  String suggestedValue(Object value);

  /// No description provided for @weeklyChangeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Haftalik Degisim'**
  String get weeklyChangeTitle;

  /// No description provided for @weightChangeValue.
  ///
  /// In tr, this message translates to:
  /// **'{value} kg'**
  String weightChangeValue(Object value);

  /// No description provided for @trendSpeedTitle.
  ///
  /// In tr, this message translates to:
  /// **'Trend Hizi'**
  String get trendSpeedTitle;

  /// No description provided for @trendSpeedValue.
  ///
  /// In tr, this message translates to:
  /// **'{value} kg/hafta'**
  String trendSpeedValue(Object value);

  /// No description provided for @consistencyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Tutarlilik'**
  String get consistencyTitle;

  /// No description provided for @consistencyMessage.
  ///
  /// In tr, this message translates to:
  /// **'Bu hafta {count} kilo girisi yapildi.'**
  String consistencyMessage(Object count);

  /// No description provided for @dailyCalorieTargetTitle.
  ///
  /// In tr, this message translates to:
  /// **'Gunluk Kalori Hedefi'**
  String get dailyCalorieTargetTitle;

  /// No description provided for @editDailyCalorieGoal.
  ///
  /// In tr, this message translates to:
  /// **'Kalori Hedefini Duzenle'**
  String get editDailyCalorieGoal;

  /// No description provided for @calorieGoalMissingInfo.
  ///
  /// In tr, this message translates to:
  /// **'Kalori hedefi icin dogum yili ve cinsiyet gerekli.'**
  String get calorieGoalMissingInfo;

  /// No description provided for @calorieGoalSaved.
  ///
  /// In tr, this message translates to:
  /// **'Kalori hedefi kaydedildi.'**
  String get calorieGoalSaved;

  /// No description provided for @calorieOffsetTitle.
  ///
  /// In tr, this message translates to:
  /// **'Gunluk Kalori Farki'**
  String get calorieOffsetTitle;

  /// No description provided for @calorieOffsetSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'BMR + aktivite + fark'**
  String get calorieOffsetSubtitle;

  /// No description provided for @calorieOffsetValue.
  ///
  /// In tr, this message translates to:
  /// **'{value} kcal'**
  String calorieOffsetValue(Object value);

  /// No description provided for @calorieOffsetEditTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kalori Farkini Duzenle'**
  String get calorieOffsetEditTitle;

  /// No description provided for @calorieOffsetHint.
  ///
  /// In tr, this message translates to:
  /// **'Ornek: 500 arti, -500 eksi'**
  String get calorieOffsetHint;

  /// No description provided for @calorieOffsetInvalid.
  ///
  /// In tr, this message translates to:
  /// **'Gecerli bir kcal degeri girin.'**
  String get calorieOffsetInvalid;

  /// No description provided for @calorieOffsetSaved.
  ///
  /// In tr, this message translates to:
  /// **'Kalori farki kaydedildi.'**
  String get calorieOffsetSaved;

  /// No description provided for @exportImportTitle.
  ///
  /// In tr, this message translates to:
  /// **'Disari / Icari Aktar'**
  String get exportImportTitle;

  /// No description provided for @workingLabel.
  ///
  /// In tr, this message translates to:
  /// **'Isleniyor...'**
  String get workingLabel;

  /// No description provided for @exportTitle.
  ///
  /// In tr, this message translates to:
  /// **'Disari Aktar'**
  String get exportTitle;

  /// No description provided for @exportJson.
  ///
  /// In tr, this message translates to:
  /// **'JSON Disari Aktar'**
  String get exportJson;

  /// No description provided for @exportCsv.
  ///
  /// In tr, this message translates to:
  /// **'CSV Disari Aktar'**
  String get exportCsv;

  /// No description provided for @exportJsonShare.
  ///
  /// In tr, this message translates to:
  /// **'WeightVault JSON Disari Aktar'**
  String get exportJsonShare;

  /// No description provided for @exportCsvShare.
  ///
  /// In tr, this message translates to:
  /// **'WeightVault CSV Disari Aktar'**
  String get exportCsvShare;

  /// No description provided for @importTitle.
  ///
  /// In tr, this message translates to:
  /// **'Icari Aktar'**
  String get importTitle;

  /// No description provided for @importJson.
  ///
  /// In tr, this message translates to:
  /// **'JSON Icari Aktar'**
  String get importJson;

  /// No description provided for @csvImportWizard.
  ///
  /// In tr, this message translates to:
  /// **'CSV Icari Aktar Sihirbazi'**
  String get csvImportWizard;

  /// No description provided for @importJsonTitle.
  ///
  /// In tr, this message translates to:
  /// **'JSON Icari Aktar'**
  String get importJsonTitle;

  /// No description provided for @importingLabel.
  ///
  /// In tr, this message translates to:
  /// **'Icari aktariliyor...'**
  String get importingLabel;

  /// No description provided for @selectJsonFile.
  ///
  /// In tr, this message translates to:
  /// **'JSON Dosyasi Sec'**
  String get selectJsonFile;

  /// No description provided for @importComplete.
  ///
  /// In tr, this message translates to:
  /// **'Icari aktarim tamamlandi.'**
  String get importComplete;

  /// No description provided for @csvImportWizardTitle.
  ///
  /// In tr, this message translates to:
  /// **'CSV Icari Aktar Sihirbazi'**
  String get csvImportWizardTitle;

  /// No description provided for @selectCsvFile.
  ///
  /// In tr, this message translates to:
  /// **'CSV Dosyasi Sec'**
  String get selectCsvFile;

  /// No description provided for @dateColumnLabel.
  ///
  /// In tr, this message translates to:
  /// **'Tarih Kolonu'**
  String get dateColumnLabel;

  /// No description provided for @weightColumnLabel.
  ///
  /// In tr, this message translates to:
  /// **'Kilo Kolonu'**
  String get weightColumnLabel;

  /// No description provided for @importLabel.
  ///
  /// In tr, this message translates to:
  /// **'Icari Aktar'**
  String get importLabel;

  /// No description provided for @importedEntries.
  ///
  /// In tr, this message translates to:
  /// **'Iceri aktarildi: {count} kayit.'**
  String importedEntries(Object count);

  /// No description provided for @goPremiumTitle.
  ///
  /// In tr, this message translates to:
  /// **'Premiuma Gec'**
  String get goPremiumTitle;

  /// No description provided for @loadingPaywall.
  ///
  /// In tr, this message translates to:
  /// **'Paywall yukleniyor'**
  String get loadingPaywall;

  /// No description provided for @noOfferingsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Paket yok'**
  String get noOfferingsTitle;

  /// No description provided for @noOfferingsMessage.
  ///
  /// In tr, this message translates to:
  /// **'RevenueCat paketleri henuz ayarlanmadi.'**
  String get noOfferingsMessage;

  /// No description provided for @premiumBenefitsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Premium Avantajlar'**
  String get premiumBenefitsTitle;

  /// No description provided for @premiumBenefitsMessage.
  ///
  /// In tr, this message translates to:
  /// **'Sinirsiz fotograf, widget, barkod tarama, icgoru.'**
  String get premiumBenefitsMessage;

  /// No description provided for @subscribeLabel.
  ///
  /// In tr, this message translates to:
  /// **'Abone ol {price}'**
  String subscribeLabel(Object price);

  /// No description provided for @purchaseSuccessful.
  ///
  /// In tr, this message translates to:
  /// **'Satin alma basarili.'**
  String get purchaseSuccessful;

  /// No description provided for @restorePurchases.
  ///
  /// In tr, this message translates to:
  /// **'Satin Almalari Geri Yukle'**
  String get restorePurchases;

  /// No description provided for @manageSubscription.
  ///
  /// In tr, this message translates to:
  /// **'Aboneligi Yonet'**
  String get manageSubscription;

  /// No description provided for @manageSubscriptionMessage.
  ///
  /// In tr, this message translates to:
  /// **'Aboneligi magazadan yonetin.'**
  String get manageSubscriptionMessage;

  /// No description provided for @unableToOpenSubscriptions.
  ///
  /// In tr, this message translates to:
  /// **'Abonelik ayarlari acilamadi.'**
  String get unableToOpenSubscriptions;

  /// No description provided for @profileTitle.
  ///
  /// In tr, this message translates to:
  /// **'Profil'**
  String get profileTitle;

  /// No description provided for @editProfile.
  ///
  /// In tr, this message translates to:
  /// **'Profil Duzenle'**
  String get editProfile;

  /// No description provided for @loadingProfile.
  ///
  /// In tr, this message translates to:
  /// **'Profil yukleniyor'**
  String get loadingProfile;

  /// No description provided for @profileErrorTitle.
  ///
  /// In tr, this message translates to:
  /// **'Profil hatasi'**
  String get profileErrorTitle;

  /// No description provided for @goalsSectionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hedefler'**
  String get goalsSectionTitle;

  /// No description provided for @adaptiveGoalsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Uyarlanabilir Hedefler'**
  String get adaptiveGoalsTitle;

  /// No description provided for @supportSectionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Destek'**
  String get supportSectionTitle;

  /// No description provided for @sendFeedback.
  ///
  /// In tr, this message translates to:
  /// **'Geri Bildirim Gonder'**
  String get sendFeedback;

  /// No description provided for @exportDebugBundle.
  ///
  /// In tr, this message translates to:
  /// **'Debug Paketini Disari Aktar'**
  String get exportDebugBundle;

  /// No description provided for @debugBundleShareText.
  ///
  /// In tr, this message translates to:
  /// **'WeightVault Debug Paketi'**
  String get debugBundleShareText;

  /// No description provided for @securitySectionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Guvenlik'**
  String get securitySectionTitle;

  /// No description provided for @biometricAppLock.
  ///
  /// In tr, this message translates to:
  /// **'Biyometrik Kilit'**
  String get biometricAppLock;

  /// No description provided for @privacyScreenBlur.
  ///
  /// In tr, this message translates to:
  /// **'Gizlilik Bulanikligi'**
  String get privacyScreenBlur;

  /// No description provided for @localDbEncryption.
  ///
  /// In tr, this message translates to:
  /// **'Yerel DB Sifreleme'**
  String get localDbEncryption;

  /// No description provided for @restartToApplyEncryption.
  ///
  /// In tr, this message translates to:
  /// **'Sifreleme degisiklikleri icin uygulamayi yeniden baslatin.'**
  String get restartToApplyEncryption;

  /// No description provided for @notificationsSectionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Bildirimler'**
  String get notificationsSectionTitle;

  /// No description provided for @quietHoursStart.
  ///
  /// In tr, this message translates to:
  /// **'Sessiz Saat Baslangic'**
  String get quietHoursStart;

  /// No description provided for @quietHoursEnd.
  ///
  /// In tr, this message translates to:
  /// **'Sessiz Saat Bitis'**
  String get quietHoursEnd;

  /// No description provided for @reminderOff.
  ///
  /// In tr, this message translates to:
  /// **'Kapali'**
  String get reminderOff;

  /// No description provided for @weightReminderTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kilo Hatirlatici'**
  String get weightReminderTitle;

  /// No description provided for @weightReminderBody.
  ///
  /// In tr, this message translates to:
  /// **'Bugun kilonu gir.'**
  String get weightReminderBody;

  /// No description provided for @waterReminderTitle.
  ///
  /// In tr, this message translates to:
  /// **'Su Hatirlatici'**
  String get waterReminderTitle;

  /// No description provided for @waterReminderBody.
  ///
  /// In tr, this message translates to:
  /// **'Su icme zamani.'**
  String get waterReminderBody;

  /// No description provided for @mealReminderTitle.
  ///
  /// In tr, this message translates to:
  /// **'Ogun Hatirlatici'**
  String get mealReminderTitle;

  /// No description provided for @mealReminderBody.
  ///
  /// In tr, this message translates to:
  /// **'Ogununu kaydet.'**
  String get mealReminderBody;

  /// No description provided for @reminderMovedMessage.
  ///
  /// In tr, this message translates to:
  /// **'Sessiz saatler nedeniyle hatirlatici {time} icin tasindi.'**
  String reminderMovedMessage(Object time);

  /// No description provided for @disableLabel.
  ///
  /// In tr, this message translates to:
  /// **'Kapat'**
  String get disableLabel;

  /// No description provided for @dataSectionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Veri'**
  String get dataSectionTitle;

  /// No description provided for @insightsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Icgoruler'**
  String get insightsTitle;

  /// No description provided for @premiumSectionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Premium'**
  String get premiumSectionTitle;

  /// No description provided for @paywallSubscriptionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Paywall ve Abonelik'**
  String get paywallSubscriptionTitle;

  /// No description provided for @legalSectionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Yasal'**
  String get legalSectionTitle;

  /// No description provided for @demoToolsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Demo Araclari'**
  String get demoToolsTitle;

  /// No description provided for @resetDemoData.
  ///
  /// In tr, this message translates to:
  /// **'Demo Verisini Sifirla'**
  String get resetDemoData;

  /// No description provided for @demoDataReset.
  ///
  /// In tr, this message translates to:
  /// **'Demo verisi sifirlandi.'**
  String get demoDataReset;

  /// No description provided for @accountSectionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hesap'**
  String get accountSectionTitle;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hesabi Sil'**
  String get deleteAccountTitle;

  /// No description provided for @signOut.
  ///
  /// In tr, this message translates to:
  /// **'Cikis Yap'**
  String get signOut;

  /// No description provided for @appVersionTitle.
  ///
  /// In tr, this message translates to:
  /// **'Uygulama Surumu'**
  String get appVersionTitle;

  /// No description provided for @noProfileTitle.
  ///
  /// In tr, this message translates to:
  /// **'Profil yok'**
  String get noProfileTitle;

  /// No description provided for @noProfileMessage.
  ///
  /// In tr, this message translates to:
  /// **'Onboarding tamamla.'**
  String get noProfileMessage;

  /// No description provided for @profileSaved.
  ///
  /// In tr, this message translates to:
  /// **'Profil kaydedildi.'**
  String get profileSaved;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In tr, this message translates to:
  /// **'Bu islem kalicidir ve tum verileri siler.'**
  String get deleteAccountWarning;

  /// No description provided for @confirmDeleteLabel.
  ///
  /// In tr, this message translates to:
  /// **'{word} yazarak onayla'**
  String confirmDeleteLabel(Object word);

  /// No description provided for @deletingLabel.
  ///
  /// In tr, this message translates to:
  /// **'Siliniyor...'**
  String get deletingLabel;

  /// No description provided for @deleteAccountCta.
  ///
  /// In tr, this message translates to:
  /// **'Hesabi Sil'**
  String get deleteAccountCta;

  /// No description provided for @privacyPolicyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Gizlilik Politikasi'**
  String get privacyPolicyTitle;

  /// No description provided for @privacyPolicyBody.
  ///
  /// In tr, this message translates to:
  /// **'WeightVault verilerini yerelde saklar ve etkinse bulut hesabinla senkronize eder. Istegin zaman disari aktarabilir veya silebilirsin. Bu uygulama tibbi tavsiye vermez.'**
  String get privacyPolicyBody;

  /// No description provided for @termsOfServiceTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kullanim Sartlari'**
  String get termsOfServiceTitle;

  /// No description provided for @termsOfServiceBody.
  ///
  /// In tr, this message translates to:
  /// **'WeightVault\'u kullanarak uygulamanin sadece bilgilendirme amacli oldugunu kabul edersin. Tibbi kararlar icin profesyonel saglik danismani ile gorus.'**
  String get termsOfServiceBody;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
