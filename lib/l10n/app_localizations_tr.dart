import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'WeightVault';

  @override
  String get onboardingTitle => 'Kilonu trendle yonet';

  @override
  String get onboardingSubtitle => 'Dalgalanmayi sakinlestir, hedefe guvenle ilerle.';

  @override
  String get continueLabel => 'Devam';

  @override
  String get skip => 'Atla';

  @override
  String get demoMode => 'Demo Modu';

  @override
  String get normalMode => 'Normal Mod';

  @override
  String get login => 'Giris';

  @override
  String get register => 'Kayit Ol';

  @override
  String get forgotPassword => 'Sifremi Unuttum';

  @override
  String get dashboard => 'Panel';

  @override
  String get log => 'Kayitlar';

  @override
  String get analytics => 'Analiz';

  @override
  String get reportsTitle => 'Raporlar';

  @override
  String get photos => 'Fotograflar';

  @override
  String get settings => 'Ayarlar';

  @override
  String get addButtonLabel => 'Ekle';

  @override
  String get addWeight => 'Kilo Ekle';

  @override
  String get addWater => 'Su Ekle';

  @override
  String get addFood => 'Yemek Ekle';

  @override
  String get addPhotoTitle => 'Fotograf Ekle';

  @override
  String get addPhotoSubtitle => 'Daha iyi karsilastirma icin ayni isik ve aciyi kullan.';

  @override
  String get logFilterAll => 'Tumu';

  @override
  String get logFilterWeight => 'Kilo';

  @override
  String get logFilterWater => 'Su';

  @override
  String get logFilterFood => 'Yemek';

  @override
  String get logFilterActivity => 'Aktivite';

  @override
  String get logFilterPhoto => 'Foto';

  @override
  String get yesterdayLabel => 'Dun';

  @override
  String get deleteLabel => 'Sil';

  @override
  String get editLabel => 'Duzenle';

  @override
  String get deleteConfirmTitle => 'Kaydi sil?';

  @override
  String get deleteConfirmMessage => 'Bu islem geri alinamaz.';

  @override
  String get recordDetailsTitle => 'Kayit Detayi';

  @override
  String get recordSavedMessage => 'Kayit guncellendi';

  @override
  String get waterAmountLabel => 'Su (ml)';

  @override
  String get photoDetailMessage => 'Bu fotograf kaydini buradan silebilirsin.';

  @override
  String get dashboardHeroTitle => 'Son Olcum';

  @override
  String lastMeasurementLabel(Object value) {
    return 'Son olcum: $value';
  }

  @override
  String get lastMeasurementUnknown => 'Son olcum: --';

  @override
  String weekDeltaLabel(Object value) {
    return '7 gun degisim: $value';
  }

  @override
  String get weekDeltaUnknown => '7 gun degisim: --';

  @override
  String get goalProgressTitle => 'Hedef';

  @override
  String get etaNeedsMoreData => 'Tahmin icin daha fazla olcum gerekli (en az 7 kayit).';

  @override
  String get etaReached => 'Hedefe ulastin';

  @override
  String get dailySummaryTitle => 'Gunluk Ozet';

  @override
  String get caloriesTitle => 'Kalori';

  @override
  String get waterTitle => 'Su';

  @override
  String get lastEntryTitle => 'Son Kayit';

  @override
  String get lastEntrySubtitle => 'Son ekleme';

  @override
  String get lastEntryUnknown => 'Henuz kayit yok';

  @override
  String get goalUnknown => 'Hedef: --';

  @override
  String goalInline(Object value) {
    return 'Hedef: $value';
  }

  @override
  String get profileGoalsSectionTitle => 'Profil ve Hedefler';

  @override
  String get profileSubtitle => 'Profil bilgilerini ve hedeflerini guncelle';

  @override
  String get goalTitle => 'Hedef';

  @override
  String get unitsSectionTitle => 'Birimler';

  @override
  String get analysisSettingsTitle => 'Analiz Ayarlari';

  @override
  String get analysisSettingsSubtitle => 'Yumusatma ve gelismis ayarlar';

  @override
  String get advancedSettingsTitle => 'Gelismis';

  @override
  String get unitUnknown => 'Ayarlanmadi';

  @override
  String get range7d => '7g';

  @override
  String get analyticsViewTitle => 'Gorunum';

  @override
  String get analyticsViewTrend => 'Trend (Onerilen)';

  @override
  String get analyticsViewRaw => 'Ham';

  @override
  String get analyticsSmoothingTitle => 'Yumusatma';

  @override
  String get smoothingLow => 'Dusuk';

  @override
  String get smoothingMedium => 'Orta';

  @override
  String get smoothingHigh => 'Yuksek';

  @override
  String get photosEmptyTitle => 'Henuz fotograf yok';

  @override
  String get photosEmptyLineOne => 'Ayni isik, ayni aci, haftada 1 cek.';

  @override
  String get photosEmptyLineTwo => 'Once/Sonra karsilastirmasi icin fotograf ekle.';

  @override
  String get startFasting => 'Oruc Baslat';

  @override
  String get retry => 'Tekrar Dene';

  @override
  String get errorSomethingWentWrong => 'Bir seyler ters gitti';

  @override
  String get unlockApp => 'WeightVault kilidini ac';

  @override
  String get initializingApp => 'WeightVault baslatiliyor';

  @override
  String get modeSelectTitle => 'Mod Secimi';

  @override
  String get modeSelectHeadline => 'Nasil baslamak istersin?';

  @override
  String get demoModeDescription => 'Offline deneyim, ornek verilerle tam akisi dene.';

  @override
  String get demoModeCta => 'Demo ile Basla';

  @override
  String get normalModeDescription => 'Firebase ile senkronize, bulut destekli kullan.';

  @override
  String get normalModeCta => 'Normal Moda Gec';

  @override
  String get emailLabel => 'Eposta';

  @override
  String get passwordLabel => 'Sifre';

  @override
  String get signingIn => 'Giris yapiliyor';

  @override
  String get createAccount => 'Hesap olustur';

  @override
  String get haveAccount => 'Hesabim var';

  @override
  String get continueWithGoogle => 'Google ile devam et';

  @override
  String get continueWithApple => 'Apple ile devam et';

  @override
  String authError(Object error) {
    return 'Giris hatasi: $error';
  }

  @override
  String get passwordResetSent => 'Sifre sifirlama e-postasi gonderildi.';

  @override
  String get permissionsTitle => 'Izinler';

  @override
  String get permissionsSubtitle => 'Bildirim ve saglik verisi izinleri ile hatirlatmalari acin.';

  @override
  String get notificationsPermissionCta => 'Bildirim Izni Ver';

  @override
  String get healthPermissionCta => 'HealthKit / Google Fit';

  @override
  String get goalSetupTitle => 'Hedefini kur';

  @override
  String get nameLabel => 'Isim';

  @override
  String get birthYearLabel => 'Dogum Yili';

  @override
  String get genderLabel => 'Cinsiyet';

  @override
  String get genderMale => 'Erkek';

  @override
  String get genderFemale => 'Kadin';

  @override
  String get genderOther => 'Diger';

  @override
  String get currentWeightLabel => 'Guncel Kilo (kg)';

  @override
  String get heightLabel => 'Boy (cm)';

  @override
  String get unitsLabel => 'Birimler';

  @override
  String get unitsMetric => 'Metrik';

  @override
  String get unitsImperial => 'Imperial';

  @override
  String get activityLevelLabel => 'Aktivite Seviyesi';

  @override
  String get activityLevelLow => 'Dusuk';

  @override
  String get activityLevelModerate => 'Orta';

  @override
  String get activityLevelHigh => 'Yuksek';

  @override
  String get activityLevelVeryHigh => 'Cok Yuksek';

  @override
  String get goalTypeLabel => 'Hedef Turu';

  @override
  String get goalWeightLabel => 'Hedef Kilo';

  @override
  String get goalDateLabel => 'Hedef Tarih';

  @override
  String get goalTypeLose => 'Kilo ver';

  @override
  String get goalTypeGain => 'Kilo al';

  @override
  String get goalTypeMaintain => 'Kilo koru';

  @override
  String dailyCalorieGoalMessage(Object value) {
    return 'Gunluk kalori hedefin: $value kcal';
  }

  @override
  String get weeklyCaloriesTitle => 'Kaloriler';

  @override
  String get weeklyCaloriesChartTitle => 'Gunluk alim';

  @override
  String weeklyCaloriesAverage(Object value) {
    return 'Gunluk Ortalama: $value kcal';
  }

  @override
  String weeklyCaloriesTotal(Object value) {
    return 'Toplam: $value kcal';
  }

  @override
  String weeklyCaloriesTarget(Object value) {
    return 'Hedef: $value kcal';
  }

  @override
  String get weeklyCaloriesEmptyTitle => 'Kalori verisi yok';

  @override
  String get weeklyCaloriesEmptyMessage => 'Son 7 gun icin kalori kaydi yok.';

  @override
  String get emptyWeightTitle => 'Henuz kilo kaydi yok';

  @override
  String get emptyWeightMessage => 'Trend ve ETA icin ilk olcumu ekle.';

  @override
  String get trendTitle => 'Trend';

  @override
  String get latestLabel => 'Son';

  @override
  String get etaLabel => 'ETA';

  @override
  String etaDays(Object days) {
    return '$days gun';
  }

  @override
  String get stableLabel => 'Stabil';

  @override
  String goalLabel(Object weight) {
    return 'Hedef: $weight kg';
  }

  @override
  String get plateauMessage => 'Plateau tespit edildi. Kalori veya aktiviteyi ayarlamayi dusun.';

  @override
  String get quickAddTitle => 'Hizli Ekle';

  @override
  String get emptyLogTitle => 'Henuz kayit yok';

  @override
  String get emptyLogMessage => 'Ilk kilo kaydini ekle.';

  @override
  String get entryDeleted => 'Kayit silindi';

  @override
  String get undo => 'Geri Al';

  @override
  String get weightSaved => 'Kilo kaydedildi';

  @override
  String get weightLabel => 'Kilo (kg)';

  @override
  String get noteLabel => 'Not';

  @override
  String get conditionLabel => 'Durum';

  @override
  String get moodLabel => 'Ruh Hali';

  @override
  String get dateTimeLabel => 'Tarih ve Saat';

  @override
  String get cancel => 'Iptal';

  @override
  String get save => 'Kaydet';

  @override
  String get conditionMorningFasted => 'Sabah ac';

  @override
  String get conditionMorningFed => 'Sabah tok';

  @override
  String get conditionEveningFasted => 'Aksam ac';

  @override
  String get conditionEveningFed => 'Aksam tok';

  @override
  String get moodGreat => 'Harika';

  @override
  String get moodOk => 'Iyi';

  @override
  String get moodLow => 'Dusuk';

  @override
  String get moodStressed => 'Stresli';

  @override
  String get noDataTitle => 'Veri yok';

  @override
  String get noDataAnalyticsMessage => 'Analiz icin kilo kayitlari ekle.';

  @override
  String get range30d => '30g';

  @override
  String get range6m => '6ay';

  @override
  String get range90d => '90g';

  @override
  String get range1y => '1yil';

  @override
  String get trendMethodLabel => 'Trend Yontemi';

  @override
  String alphaLabel(Object value) {
    return 'Alfa: $value';
  }

  @override
  String betaLabel(Object value) {
    return 'Beta: $value';
  }

  @override
  String get trendMethodMovingAverage => 'Hareketli Ortalama';

  @override
  String get trendMethodExponential => 'Ussel Duzeltme';

  @override
  String get trendMethodDoubleExponential => 'Cift Ussel';

  @override
  String get trendMethodCustom => 'Ozel';

  @override
  String waterAdded(Object amount) {
    return '$amount ml eklendi';
  }

  @override
  String get waterTrackerTitle => 'Su Takibi';

  @override
  String get todayLabel => 'Bugun';

  @override
  String waterProgress(Object current, Object goal) {
    return '$current ml / $goal ml';
  }

  @override
  String get waterWeekTitle => 'Son 7 gun';

  @override
  String waterStreakLabel(Object days) {
    return '$days gun seri';
  }

  @override
  String waterGoalMetLabel(Object count, Object total) {
    return '$count/$total gun hedefte';
  }

  @override
  String waterAverageLabel(Object amount) {
    return 'Gunluk ortalama $amount ml';
  }

  @override
  String addWaterAmount(Object amount) {
    return '+$amount ml';
  }

  @override
  String waterAmount(Object amount) {
    return '$amount ml';
  }

  @override
  String get fastingTitle => 'Oruclama';

  @override
  String get startFastTitle => 'Oruca Basla';

  @override
  String get goalHoursLabel => 'Hedef Saat';

  @override
  String get startLabel => 'Baslat';

  @override
  String get activeFastTitle => 'Aktif Oruc';

  @override
  String elapsedLabel(Object hours, Object minutes) {
    return 'Gecen: ${hours}s ${minutes}d';
  }

  @override
  String remainingLabel(Object hours, Object minutes) {
    return 'Kalan: ${hours}s ${minutes}d';
  }

  @override
  String get stopLabel => 'Durdur';

  @override
  String get loadingFasting => 'Oruc yukleniyor';

  @override
  String get errorTitle => 'Hata';

  @override
  String get validationRequired => 'Lutfen bu alani doldurun.';

  @override
  String get validationInvalidNumber => 'Gecerli bir sayi girin.';

  @override
  String get historyTitle => 'Gecmis';

  @override
  String get doneLabel => 'Tamam';

  @override
  String get activeLabel => 'Aktif';

  @override
  String get loadingHistory => 'Gecmis yukleniyor';

  @override
  String get fastingPlan168 => '16:8';

  @override
  String get fastingPlan186 => '18:6';

  @override
  String get fastingPlan204 => '20:4';

  @override
  String get fastingPlanOmad => 'OMAD';

  @override
  String get fastingPlanCustom => 'Ozel';

  @override
  String get fastingCompleteTitle => 'Oruc Tamamlandi';

  @override
  String get fastingCompleteBody => 'Tebrikler! Oruc hedefin tamamlandi.';

  @override
  String get activityTitle => 'Aktivite';

  @override
  String get stepsToday => 'Bugun Adim';

  @override
  String stepsCount(Object steps) {
    return '$steps adim';
  }

  @override
  String get fetchingSteps => 'Adimlar aliniyor';

  @override
  String get stepsErrorTitle => 'Adim hatasi';

  @override
  String get noActivitiesTitle => 'Aktivite yok';

  @override
  String get noActivitiesMessage => 'Manuel antrenman ekleyerek takip et.';

  @override
  String get workoutsTitle => 'Antrenmanlar';

  @override
  String workoutDetails(Object minutes, Object calories) {
    return '$minutes dk | $calories kcal';
  }

  @override
  String get measurementsTitle => 'Olcumler';

  @override
  String get noMeasurementsTitle => 'Olcum yok';

  @override
  String get noMeasurementsMessage => 'Vucut degisimini takip icin olcum ekle.';

  @override
  String get measurementChartTitle => 'Olcum Trendi';

  @override
  String get measurementMetricLabel => 'Metrik';

  @override
  String measurementLatestValue(Object value, Object unit) {
    return 'Son: $value $unit';
  }

  @override
  String get metricWaist => 'Bel';

  @override
  String get metricHip => 'Kalca';

  @override
  String get metricChest => 'Gogus';

  @override
  String get metricNeck => 'Boyun';

  @override
  String get metricArm => 'Kol';

  @override
  String get metricThigh => 'Bacak';

  @override
  String get metricBodyFat => 'Yag %';

  @override
  String get metricMuscle => 'Kas %';

  @override
  String get metricWaterPct => 'Su %';

  @override
  String measurementWaistHip(Object waist, Object hip) {
    return 'Bel: $waist cm | Kalca: $hip cm';
  }

  @override
  String measurementChestNeck(Object chest, Object neck) {
    return 'Gogus: $chest cm | Boyun: $neck cm';
  }

  @override
  String measurementArmThigh(Object arm, Object thigh) {
    return 'Kol: $arm cm | Bacak: $thigh cm';
  }

  @override
  String get quickAddWeightLoading => 'Hizli kilo ekle aciliyor';

  @override
  String get quickAddWaterLoading => 'Su ekleniyor';

  @override
  String get nutritionTitle => 'Beslenme';

  @override
  String get noFoodLoggedTitle => 'Yemek kaydi yok';

  @override
  String get noFoodLoggedMessage => 'Gunluk toplamlar icin ogun ekle.';

  @override
  String get todayTotalsTitle => 'Bugun Toplam';

  @override
  String caloriesValue(Object value) {
    return 'Kalori: $value kcal';
  }

  @override
  String proteinValue(Object value) {
    return 'Protein: $value g';
  }

  @override
  String carbValue(Object value) {
    return 'Karb: $value g';
  }

  @override
  String fatValue(Object value) {
    return 'Yag: $value g';
  }

  @override
  String foodItemCalories(Object name, Object cal) {
    return '$name - $cal kcal';
  }

  @override
  String get addFoodTitle => 'Yemek Ekle';

  @override
  String get barcodeLabel => 'Barkod';

  @override
  String get lookupLabel => 'Ara';

  @override
  String get mealTypeLabel => 'Ogun Turu';

  @override
  String get gramsLabel => 'Gram';

  @override
  String get caloriesLabel => 'Kalori (kcal)';

  @override
  String get proteinLabel => 'Protein (g)';

  @override
  String get carbLabel => 'Karb (g)';

  @override
  String get fatLabel => 'Yag (g)';

  @override
  String get foodSaved => 'Yemek kaydedildi';

  @override
  String get foodDefaultName => 'Yemek';

  @override
  String get mealBreakfast => 'Kahvalti';

  @override
  String get mealLunch => 'Ogle';

  @override
  String get mealDinner => 'Aksam';

  @override
  String get mealSnack => 'Ara Ogun';

  @override
  String get customFoodTitle => 'Ozel Yemek';

  @override
  String get customFoodSaved => 'Ozel yemek kaydedildi';

  @override
  String get nameTrLabel => 'Isim (TR)';

  @override
  String get nameEnLabel => 'Isim (EN)';

  @override
  String get barcodeOptionalLabel => 'Barkod (opsiyonel)';

  @override
  String get customFoodDefaultTr => 'Ozel yemek (TR)';

  @override
  String get customFoodDefaultEn => 'Ozel yemek (EN)';

  @override
  String get addActivityTitle => 'Aktivite Ekle';

  @override
  String get activitySaved => 'Aktivite kaydedildi';

  @override
  String get activityTypeLabel => 'Aktivite Turu';

  @override
  String get activityDurationLabel => 'Sure (dk)';

  @override
  String get activityDefaultType => 'Antrenman';

  @override
  String get addMeasurementsTitle => 'Olcum Ekle';

  @override
  String get measurementsSaved => 'Olcumler kaydedildi';

  @override
  String get waistLabel => 'Bel (cm)';

  @override
  String get hipLabel => 'Kalca (cm)';

  @override
  String get chestLabel => 'Gogus (cm)';

  @override
  String get neckLabel => 'Boyun (cm)';

  @override
  String get armLabel => 'Kol (cm)';

  @override
  String get thighLabel => 'Bacak (cm)';

  @override
  String get progressPhotosTitle => 'Ilerleme Fotograflari';

  @override
  String get noPhotosTitle => 'Henuz fotograf yok';

  @override
  String get noPhotosMessage => 'Ilerlemeyi karsilastirmak icin fotograf ekle.';

  @override
  String get photoTypeTitle => 'Fotograf turu sec';

  @override
  String get photoTypeFront => 'On';

  @override
  String get photoTypeSide => 'Yan';

  @override
  String get photoTypeBack => 'Arka';

  @override
  String get photoCompareTitle => 'Fotograf Karsilastir';

  @override
  String get weeklyInsightsTitle => 'Haftalik Icgoruler';

  @override
  String get weeklyReportTitle => 'Haftalik Rapor';

  @override
  String get weeklySummaryTitle => 'Ozet';

  @override
  String get weeklyWeightChangeLabel => 'Kilo degisimi';

  @override
  String get weeklyTrendSpeedLabel => 'Trend hizi';

  @override
  String get weeklyWaterAdherenceLabel => 'Su uyumu';

  @override
  String get weeklyFastingCountLabel => 'Oruc seanslari';

  @override
  String weeklyWaterAdherenceValue(Object count, Object total) {
    return '$count/$total gun';
  }

  @override
  String weeklyFastingCountValue(Object count) {
    return '$count seans';
  }

  @override
  String weeklyGeneratedLabel(Object time) {
    return 'Olusturuldu $time';
  }

  @override
  String get weeklyReportShareText => 'WeightVault Haftalik Rapor';

  @override
  String get noInsightsTitle => 'Henuz icgoru yok';

  @override
  String get noInsightsMessage => 'Icgoruler icin kilo kaydi ekle.';

  @override
  String get noRecentDataTitle => 'Son veri yok';

  @override
  String get noRecentDataMessage => 'Bu hafta kilo girisi yap.';

  @override
  String get adaptiveTargetTitle => 'Uyarlanabilir Hedef';

  @override
  String bmrValue(Object value) {
    return 'BMR: $value kcal';
  }

  @override
  String tdeeValue(Object value) {
    return 'TDEE: $value kcal';
  }

  @override
  String suggestedValue(Object value) {
    return 'Oneri: $value kcal';
  }

  @override
  String get weeklyChangeTitle => 'Haftalik Degisim';

  @override
  String weightChangeValue(Object value) {
    return '$value kg';
  }

  @override
  String get trendSpeedTitle => 'Trend Hizi';

  @override
  String trendSpeedValue(Object value) {
    return '$value kg/hafta';
  }

  @override
  String get consistencyTitle => 'Tutarlilik';

  @override
  String consistencyMessage(Object count) {
    return 'Bu hafta $count kilo girisi yapildi.';
  }

  @override
  String get dailyCalorieTargetTitle => 'Gunluk Kalori Hedefi';

  @override
  String get editDailyCalorieGoal => 'Kalori Hedefini Duzenle';

  @override
  String get calorieGoalMissingInfo => 'Kalori hedefi icin dogum yili ve cinsiyet gerekli.';

  @override
  String get calorieGoalSaved => 'Kalori hedefi kaydedildi.';

  @override
  String get calorieOffsetTitle => 'Gunluk Kalori Farki';

  @override
  String get calorieOffsetSubtitle => 'BMR + aktivite + fark';

  @override
  String calorieOffsetValue(Object value) {
    return '$value kcal';
  }

  @override
  String get calorieOffsetEditTitle => 'Kalori Farkini Duzenle';

  @override
  String get calorieOffsetHint => 'Ornek: 500 arti, -500 eksi';

  @override
  String get calorieOffsetInvalid => 'Gecerli bir kcal degeri girin.';

  @override
  String get calorieOffsetSaved => 'Kalori farki kaydedildi.';

  @override
  String get exportImportTitle => 'Disari / Icari Aktar';

  @override
  String get workingLabel => 'Isleniyor...';

  @override
  String get exportTitle => 'Disari Aktar';

  @override
  String get exportJson => 'JSON Disari Aktar';

  @override
  String get exportCsv => 'CSV Disari Aktar';

  @override
  String get exportJsonShare => 'WeightVault JSON Disari Aktar';

  @override
  String get exportCsvShare => 'WeightVault CSV Disari Aktar';

  @override
  String get importTitle => 'Icari Aktar';

  @override
  String get importJson => 'JSON Icari Aktar';

  @override
  String get csvImportWizard => 'CSV Icari Aktar Sihirbazi';

  @override
  String get importJsonTitle => 'JSON Icari Aktar';

  @override
  String get importingLabel => 'Icari aktariliyor...';

  @override
  String get selectJsonFile => 'JSON Dosyasi Sec';

  @override
  String get importComplete => 'Icari aktarim tamamlandi.';

  @override
  String get csvImportWizardTitle => 'CSV Icari Aktar Sihirbazi';

  @override
  String get selectCsvFile => 'CSV Dosyasi Sec';

  @override
  String get dateColumnLabel => 'Tarih Kolonu';

  @override
  String get weightColumnLabel => 'Kilo Kolonu';

  @override
  String get importLabel => 'Icari Aktar';

  @override
  String importedEntries(Object count) {
    return 'Iceri aktarildi: $count kayit.';
  }

  @override
  String get goPremiumTitle => 'Premiuma Gec';

  @override
  String get loadingPaywall => 'Paywall yukleniyor';

  @override
  String get noOfferingsTitle => 'Paket yok';

  @override
  String get noOfferingsMessage => 'RevenueCat paketleri henuz ayarlanmadi.';

  @override
  String get premiumBenefitsTitle => 'Premium Avantajlar';

  @override
  String get premiumBenefitsMessage => 'Sinirsiz fotograf, widget, barkod tarama, icgoru.';

  @override
  String subscribeLabel(Object price) {
    return 'Abone ol $price';
  }

  @override
  String get purchaseSuccessful => 'Satin alma basarili.';

  @override
  String get restorePurchases => 'Satin Almalari Geri Yukle';

  @override
  String get manageSubscription => 'Aboneligi Yonet';

  @override
  String get manageSubscriptionMessage => 'Aboneligi magazadan yonetin.';

  @override
  String get unableToOpenSubscriptions => 'Abonelik ayarlari acilamadi.';

  @override
  String get profileTitle => 'Profil';

  @override
  String get editProfile => 'Profil Duzenle';

  @override
  String get loadingProfile => 'Profil yukleniyor';

  @override
  String get profileErrorTitle => 'Profil hatasi';

  @override
  String get goalsSectionTitle => 'Hedefler';

  @override
  String get adaptiveGoalsTitle => 'Uyarlanabilir Hedefler';

  @override
  String get supportSectionTitle => 'Destek';

  @override
  String get sendFeedback => 'Geri Bildirim Gonder';

  @override
  String get exportDebugBundle => 'Debug Paketini Disari Aktar';

  @override
  String get debugBundleShareText => 'WeightVault Debug Paketi';

  @override
  String get securitySectionTitle => 'Guvenlik';

  @override
  String get biometricAppLock => 'Biyometrik Kilit';

  @override
  String get privacyScreenBlur => 'Gizlilik Bulanikligi';

  @override
  String get localDbEncryption => 'Yerel DB Sifreleme';

  @override
  String get restartToApplyEncryption => 'Sifreleme degisiklikleri icin uygulamayi yeniden baslatin.';

  @override
  String get notificationsSectionTitle => 'Bildirimler';

  @override
  String get quietHoursStart => 'Sessiz Saat Baslangic';

  @override
  String get quietHoursEnd => 'Sessiz Saat Bitis';

  @override
  String get reminderOff => 'Kapali';

  @override
  String get weightReminderTitle => 'Kilo Hatirlatici';

  @override
  String get weightReminderBody => 'Bugun kilonu gir.';

  @override
  String get waterReminderTitle => 'Su Hatirlatici';

  @override
  String get waterReminderBody => 'Su icme zamani.';

  @override
  String get mealReminderTitle => 'Ogun Hatirlatici';

  @override
  String get mealReminderBody => 'Ogununu kaydet.';

  @override
  String reminderMovedMessage(Object time) {
    return 'Sessiz saatler nedeniyle hatirlatici $time icin tasindi.';
  }

  @override
  String get disableLabel => 'Kapat';

  @override
  String get dataSectionTitle => 'Veri';

  @override
  String get insightsTitle => 'Icgoruler';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get paywallSubscriptionTitle => 'Paywall ve Abonelik';

  @override
  String get legalSectionTitle => 'Yasal';

  @override
  String get demoToolsTitle => 'Demo Araclari';

  @override
  String get resetDemoData => 'Demo Verisini Sifirla';

  @override
  String get demoDataReset => 'Demo verisi sifirlandi.';

  @override
  String get accountSectionTitle => 'Hesap';

  @override
  String get deleteAccountTitle => 'Hesabi Sil';

  @override
  String get signOut => 'Cikis Yap';

  @override
  String get appVersionTitle => 'Uygulama Surumu';

  @override
  String get noProfileTitle => 'Profil yok';

  @override
  String get noProfileMessage => 'Onboarding tamamla.';

  @override
  String get profileSaved => 'Profil kaydedildi.';

  @override
  String get deleteAccountWarning => 'Bu islem kalicidir ve tum verileri siler.';

  @override
  String confirmDeleteLabel(Object word) {
    return '$word yazarak onayla';
  }

  @override
  String get deletingLabel => 'Siliniyor...';

  @override
  String get deleteAccountCta => 'Hesabi Sil';

  @override
  String get privacyPolicyTitle => 'Gizlilik Politikasi';

  @override
  String get privacyPolicyBody => 'WeightVault verilerini yerelde saklar ve etkinse bulut hesabinla senkronize eder. Istegin zaman disari aktarabilir veya silebilirsin. Bu uygulama tibbi tavsiye vermez.';

  @override
  String get termsOfServiceTitle => 'Kullanim Sartlari';

  @override
  String get termsOfServiceBody => 'WeightVault\'u kullanarak uygulamanin sadece bilgilendirme amacli oldugunu kabul edersin. Tibbi kararlar icin profesyonel saglik danismani ile gorus.';
}
