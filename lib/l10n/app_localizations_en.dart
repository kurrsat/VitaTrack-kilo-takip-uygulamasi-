import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'WeightVault';

  @override
  String get onboardingTitle => 'Track with confidence';

  @override
  String get onboardingSubtitle => 'Smooth the noise and stay focused on the trend.';

  @override
  String get continueLabel => 'Continue';

  @override
  String get skip => 'Skip';

  @override
  String get demoMode => 'Demo Mode';

  @override
  String get normalMode => 'Normal Mode';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get forgotPassword => 'Forgot Password';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get log => 'Log';

  @override
  String get analytics => 'Analytics';

  @override
  String get reportsTitle => 'Reports';

  @override
  String get photos => 'Photos';

  @override
  String get settings => 'Settings';

  @override
  String get addButtonLabel => 'Add';

  @override
  String get addWeight => 'Add Weight';

  @override
  String get addWater => 'Add Water';

  @override
  String get addFood => 'Add Food';

  @override
  String get addPhotoTitle => 'Add Photo';

  @override
  String get addPhotoSubtitle => 'Use the same lighting and angle for better comparisons.';

  @override
  String get logFilterAll => 'All';

  @override
  String get logFilterWeight => 'Weight';

  @override
  String get logFilterWater => 'Water';

  @override
  String get logFilterFood => 'Food';

  @override
  String get logFilterActivity => 'Activity';

  @override
  String get logFilterPhoto => 'Photo';

  @override
  String get yesterdayLabel => 'Yesterday';

  @override
  String get deleteLabel => 'Delete';

  @override
  String get editLabel => 'Edit';

  @override
  String get deleteConfirmTitle => 'Delete entry?';

  @override
  String get deleteConfirmMessage => 'This action cannot be undone.';

  @override
  String get recordDetailsTitle => 'Record Details';

  @override
  String get recordSavedMessage => 'Record updated';

  @override
  String get waterAmountLabel => 'Water (ml)';

  @override
  String get photoDetailMessage => 'You can delete this photo entry from here.';

  @override
  String get dashboardHeroTitle => 'Latest';

  @override
  String lastMeasurementLabel(Object value) {
    return 'Last measurement: $value';
  }

  @override
  String get lastMeasurementUnknown => 'Last measurement: --';

  @override
  String weekDeltaLabel(Object value) {
    return '7-day change: $value';
  }

  @override
  String get weekDeltaUnknown => '7-day change: --';

  @override
  String get goalProgressTitle => 'Goal';

  @override
  String get etaNeedsMoreData => 'More measurements are needed for ETA (min 7 entries).';

  @override
  String get etaReached => 'Goal reached';

  @override
  String get dailySummaryTitle => 'Daily Summary';

  @override
  String get caloriesTitle => 'Calories';

  @override
  String get waterTitle => 'Water';

  @override
  String get lastEntryTitle => 'Last Entry';

  @override
  String get lastEntrySubtitle => 'Latest activity';

  @override
  String get lastEntryUnknown => 'No entries yet';

  @override
  String get goalUnknown => 'Goal: --';

  @override
  String goalInline(Object value) {
    return 'Goal: $value';
  }

  @override
  String get profileGoalsSectionTitle => 'Profile & Goals';

  @override
  String get profileSubtitle => 'Update your details and goals';

  @override
  String get goalTitle => 'Goal';

  @override
  String get unitsSectionTitle => 'Units';

  @override
  String get analysisSettingsTitle => 'Analysis Settings';

  @override
  String get analysisSettingsSubtitle => 'Smoothing and advanced controls';

  @override
  String get advancedSettingsTitle => 'Advanced';

  @override
  String get unitUnknown => 'Not set';

  @override
  String get range7d => '7d';

  @override
  String get analyticsViewTitle => 'View';

  @override
  String get analyticsViewTrend => 'Trend (Recommended)';

  @override
  String get analyticsViewRaw => 'Raw';

  @override
  String get analyticsSmoothingTitle => 'Smoothing';

  @override
  String get smoothingLow => 'Low';

  @override
  String get smoothingMedium => 'Medium';

  @override
  String get smoothingHigh => 'High';

  @override
  String get photosEmptyTitle => 'No photos yet';

  @override
  String get photosEmptyLineOne => 'Same light, same angle, once a week.';

  @override
  String get photosEmptyLineTwo => 'Add photos to compare progress.';

  @override
  String get startFasting => 'Start Fasting';

  @override
  String get retry => 'Retry';

  @override
  String get errorSomethingWentWrong => 'Something went wrong';

  @override
  String get unlockApp => 'Unlock WeightVault';

  @override
  String get initializingApp => 'Initializing WeightVault';

  @override
  String get modeSelectTitle => 'Mode Select';

  @override
  String get modeSelectHeadline => 'How would you like to start?';

  @override
  String get demoModeDescription => 'Offline experience with sample data.';

  @override
  String get demoModeCta => 'Start with Demo';

  @override
  String get normalModeDescription => 'Cloud sync powered by Firebase.';

  @override
  String get normalModeCta => 'Continue with Normal Mode';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get signingIn => 'Signing in';

  @override
  String get createAccount => 'Create account';

  @override
  String get haveAccount => 'I have an account';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String authError(Object error) {
    return 'Auth error: $error';
  }

  @override
  String get passwordResetSent => 'Password reset email sent.';

  @override
  String get permissionsTitle => 'Permissions';

  @override
  String get permissionsSubtitle => 'Enable notifications and health permissions for reminders.';

  @override
  String get notificationsPermissionCta => 'Allow Notifications';

  @override
  String get healthPermissionCta => 'HealthKit / Google Fit';

  @override
  String get goalSetupTitle => 'Set your goal';

  @override
  String get nameLabel => 'Name';

  @override
  String get birthYearLabel => 'Birth Year';

  @override
  String get genderLabel => 'Gender';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get genderOther => 'Other';

  @override
  String get currentWeightLabel => 'Current Weight (kg)';

  @override
  String get heightLabel => 'Height (cm)';

  @override
  String get unitsLabel => 'Units';

  @override
  String get unitsMetric => 'Metric';

  @override
  String get unitsImperial => 'Imperial';

  @override
  String get activityLevelLabel => 'Activity Level';

  @override
  String get activityLevelLow => 'Low';

  @override
  String get activityLevelModerate => 'Moderate';

  @override
  String get activityLevelHigh => 'High';

  @override
  String get activityLevelVeryHigh => 'Very High';

  @override
  String get goalTypeLabel => 'Goal Type';

  @override
  String get goalWeightLabel => 'Goal Weight';

  @override
  String get goalDateLabel => 'Goal Date';

  @override
  String get goalTypeLose => 'Lose';

  @override
  String get goalTypeGain => 'Gain';

  @override
  String get goalTypeMaintain => 'Maintain';

  @override
  String dailyCalorieGoalMessage(Object value) {
    return 'Your daily calorie goal: $value kcal';
  }

  @override
  String get weeklyCaloriesTitle => 'Calories';

  @override
  String get weeklyCaloriesChartTitle => 'Daily intake';

  @override
  String weeklyCaloriesAverage(Object value) {
    return 'Daily average: $value kcal';
  }

  @override
  String weeklyCaloriesTotal(Object value) {
    return 'Total: $value kcal';
  }

  @override
  String weeklyCaloriesTarget(Object value) {
    return 'Target: $value kcal';
  }

  @override
  String get weeklyCaloriesEmptyTitle => 'No calorie data';

  @override
  String get weeklyCaloriesEmptyMessage => 'No calorie entries in the last 7 days.';

  @override
  String get emptyWeightTitle => 'No weight entries yet';

  @override
  String get emptyWeightMessage => 'Add your first weigh-in to see trends and ETA.';

  @override
  String get trendTitle => 'Trend';

  @override
  String get latestLabel => 'Latest';

  @override
  String get etaLabel => 'ETA';

  @override
  String etaDays(Object days) {
    return '$days days';
  }

  @override
  String get stableLabel => 'Stable';

  @override
  String goalLabel(Object weight) {
    return 'Goal: $weight kg';
  }

  @override
  String get plateauMessage => 'Plateau detected. Consider adjusting calories or activity to restart progress.';

  @override
  String get quickAddTitle => 'Quick Add';

  @override
  String get emptyLogTitle => 'No logs yet';

  @override
  String get emptyLogMessage => 'Add your first weight entry.';

  @override
  String get entryDeleted => 'Entry deleted';

  @override
  String get undo => 'Undo';

  @override
  String get weightSaved => 'Weight saved';

  @override
  String get weightLabel => 'Weight (kg)';

  @override
  String get noteLabel => 'Note';

  @override
  String get conditionLabel => 'Condition';

  @override
  String get moodLabel => 'Mood';

  @override
  String get dateTimeLabel => 'Date & Time';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get conditionMorningFasted => 'Morning fasted';

  @override
  String get conditionMorningFed => 'Morning fed';

  @override
  String get conditionEveningFasted => 'Evening fasted';

  @override
  String get conditionEveningFed => 'Evening fed';

  @override
  String get moodGreat => 'Great';

  @override
  String get moodOk => 'Ok';

  @override
  String get moodLow => 'Low';

  @override
  String get moodStressed => 'Stressed';

  @override
  String get noDataTitle => 'No data';

  @override
  String get noDataAnalyticsMessage => 'Add weight entries to see analytics.';

  @override
  String get range30d => '30d';

  @override
  String get range6m => '6mo';

  @override
  String get range90d => '90d';

  @override
  String get range1y => '1y';

  @override
  String get trendMethodLabel => 'Trend Method';

  @override
  String alphaLabel(Object value) {
    return 'Alpha: $value';
  }

  @override
  String betaLabel(Object value) {
    return 'Beta: $value';
  }

  @override
  String get trendMethodMovingAverage => 'Moving Average';

  @override
  String get trendMethodExponential => 'Exponential';

  @override
  String get trendMethodDoubleExponential => 'Double Exponential';

  @override
  String get trendMethodCustom => 'Custom';

  @override
  String waterAdded(Object amount) {
    return 'Added $amount ml';
  }

  @override
  String get waterTrackerTitle => 'Water Tracker';

  @override
  String get todayLabel => 'Today';

  @override
  String waterProgress(Object current, Object goal) {
    return '$current ml / $goal ml';
  }

  @override
  String get waterWeekTitle => 'Last 7 days';

  @override
  String waterStreakLabel(Object days) {
    return '$days day streak';
  }

  @override
  String waterGoalMetLabel(Object count, Object total) {
    return '$count/$total days on goal';
  }

  @override
  String waterAverageLabel(Object amount) {
    return 'Avg $amount ml/day';
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
  String get fastingTitle => 'Fasting';

  @override
  String get startFastTitle => 'Start a Fast';

  @override
  String get goalHoursLabel => 'Goal Hours';

  @override
  String get startLabel => 'Start';

  @override
  String get activeFastTitle => 'Active Fast';

  @override
  String elapsedLabel(Object hours, Object minutes) {
    return 'Elapsed: ${hours}h ${minutes}m';
  }

  @override
  String remainingLabel(Object hours, Object minutes) {
    return 'Remaining: ${hours}h ${minutes}m';
  }

  @override
  String get stopLabel => 'Stop';

  @override
  String get loadingFasting => 'Loading fasting';

  @override
  String get errorTitle => 'Error';

  @override
  String get validationRequired => 'Please fill out this field.';

  @override
  String get validationInvalidNumber => 'Enter a valid number.';

  @override
  String get historyTitle => 'History';

  @override
  String get doneLabel => 'Done';

  @override
  String get activeLabel => 'Active';

  @override
  String get loadingHistory => 'Loading history';

  @override
  String get fastingPlan168 => '16:8';

  @override
  String get fastingPlan186 => '18:6';

  @override
  String get fastingPlan204 => '20:4';

  @override
  String get fastingPlanOmad => 'OMAD';

  @override
  String get fastingPlanCustom => 'Custom';

  @override
  String get fastingCompleteTitle => 'Fasting Complete';

  @override
  String get fastingCompleteBody => 'Great job! Your fasting window is done.';

  @override
  String get activityTitle => 'Activity';

  @override
  String get stepsToday => 'Steps Today';

  @override
  String stepsCount(Object steps) {
    return '$steps steps';
  }

  @override
  String get fetchingSteps => 'Fetching steps';

  @override
  String get stepsErrorTitle => 'Steps error';

  @override
  String get noActivitiesTitle => 'No activities';

  @override
  String get noActivitiesMessage => 'Add manual workouts to track energy burn.';

  @override
  String get workoutsTitle => 'Workouts';

  @override
  String workoutDetails(Object minutes, Object calories) {
    return '$minutes min | $calories kcal';
  }

  @override
  String get measurementsTitle => 'Measurements';

  @override
  String get noMeasurementsTitle => 'No measurements';

  @override
  String get noMeasurementsMessage => 'Add measurements to track body changes.';

  @override
  String get measurementChartTitle => 'Measurement Trend';

  @override
  String get measurementMetricLabel => 'Metric';

  @override
  String measurementLatestValue(Object value, Object unit) {
    return 'Latest: $value $unit';
  }

  @override
  String get metricWaist => 'Waist';

  @override
  String get metricHip => 'Hip';

  @override
  String get metricChest => 'Chest';

  @override
  String get metricNeck => 'Neck';

  @override
  String get metricArm => 'Arm';

  @override
  String get metricThigh => 'Thigh';

  @override
  String get metricBodyFat => 'Body Fat %';

  @override
  String get metricMuscle => 'Muscle %';

  @override
  String get metricWaterPct => 'Water %';

  @override
  String measurementWaistHip(Object waist, Object hip) {
    return 'Waist: $waist cm | Hip: $hip cm';
  }

  @override
  String measurementChestNeck(Object chest, Object neck) {
    return 'Chest: $chest cm | Neck: $neck cm';
  }

  @override
  String measurementArmThigh(Object arm, Object thigh) {
    return 'Arm: $arm cm | Thigh: $thigh cm';
  }

  @override
  String get quickAddWeightLoading => 'Opening quick add';

  @override
  String get quickAddWaterLoading => 'Adding water';

  @override
  String get nutritionTitle => 'Nutrition';

  @override
  String get noFoodLoggedTitle => 'No food logged';

  @override
  String get noFoodLoggedMessage => 'Add meals to see daily totals.';

  @override
  String get todayTotalsTitle => 'Today Totals';

  @override
  String caloriesValue(Object value) {
    return 'Calories: $value kcal';
  }

  @override
  String proteinValue(Object value) {
    return 'Protein: $value g';
  }

  @override
  String carbValue(Object value) {
    return 'Carb: $value g';
  }

  @override
  String fatValue(Object value) {
    return 'Fat: $value g';
  }

  @override
  String foodItemCalories(Object name, Object cal) {
    return '$name - $cal kcal';
  }

  @override
  String get addFoodTitle => 'Add Food';

  @override
  String get barcodeLabel => 'Barcode';

  @override
  String get lookupLabel => 'Lookup';

  @override
  String get mealTypeLabel => 'Meal Type';

  @override
  String get gramsLabel => 'Grams';

  @override
  String get caloriesLabel => 'Calories (kcal)';

  @override
  String get proteinLabel => 'Protein (g)';

  @override
  String get carbLabel => 'Carb (g)';

  @override
  String get fatLabel => 'Fat (g)';

  @override
  String get foodSaved => 'Food saved';

  @override
  String get foodDefaultName => 'Food';

  @override
  String get mealBreakfast => 'Breakfast';

  @override
  String get mealLunch => 'Lunch';

  @override
  String get mealDinner => 'Dinner';

  @override
  String get mealSnack => 'Snack';

  @override
  String get customFoodTitle => 'Custom Food';

  @override
  String get customFoodSaved => 'Custom food saved';

  @override
  String get nameTrLabel => 'Name (TR)';

  @override
  String get nameEnLabel => 'Name (EN)';

  @override
  String get barcodeOptionalLabel => 'Barcode (optional)';

  @override
  String get customFoodDefaultTr => 'Custom food (TR)';

  @override
  String get customFoodDefaultEn => 'Custom food (EN)';

  @override
  String get addActivityTitle => 'Add Activity';

  @override
  String get activitySaved => 'Activity saved';

  @override
  String get activityTypeLabel => 'Activity Type';

  @override
  String get activityDurationLabel => 'Duration (min)';

  @override
  String get activityDefaultType => 'Workout';

  @override
  String get addMeasurementsTitle => 'Add Measurements';

  @override
  String get measurementsSaved => 'Measurements saved';

  @override
  String get waistLabel => 'Waist (cm)';

  @override
  String get hipLabel => 'Hip (cm)';

  @override
  String get chestLabel => 'Chest (cm)';

  @override
  String get neckLabel => 'Neck (cm)';

  @override
  String get armLabel => 'Arm (cm)';

  @override
  String get thighLabel => 'Thigh (cm)';

  @override
  String get progressPhotosTitle => 'Progress Photos';

  @override
  String get noPhotosTitle => 'No photos yet';

  @override
  String get noPhotosMessage => 'Add photos to compare your progress.';

  @override
  String get photoTypeTitle => 'Select photo type';

  @override
  String get photoTypeFront => 'Front';

  @override
  String get photoTypeSide => 'Side';

  @override
  String get photoTypeBack => 'Back';

  @override
  String get photoCompareTitle => 'Compare Photos';

  @override
  String get weeklyInsightsTitle => 'Weekly Insights';

  @override
  String get weeklyReportTitle => 'Weekly Report';

  @override
  String get weeklySummaryTitle => 'Summary';

  @override
  String get weeklyWeightChangeLabel => 'Weight change';

  @override
  String get weeklyTrendSpeedLabel => 'Trend speed';

  @override
  String get weeklyWaterAdherenceLabel => 'Water adherence';

  @override
  String get weeklyFastingCountLabel => 'Fasting sessions';

  @override
  String weeklyWaterAdherenceValue(Object count, Object total) {
    return '$count/$total days';
  }

  @override
  String weeklyFastingCountValue(Object count) {
    return '$count sessions';
  }

  @override
  String weeklyGeneratedLabel(Object time) {
    return 'Generated $time';
  }

  @override
  String get weeklyReportShareText => 'WeightVault Weekly Report';

  @override
  String get noInsightsTitle => 'No insights yet';

  @override
  String get noInsightsMessage => 'Add weight entries to unlock insights.';

  @override
  String get noRecentDataTitle => 'No recent data';

  @override
  String get noRecentDataMessage => 'Log weight this week to see insights.';

  @override
  String get adaptiveTargetTitle => 'Adaptive Target';

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
    return 'Suggested: $value kcal';
  }

  @override
  String get weeklyChangeTitle => 'Weekly Change';

  @override
  String weightChangeValue(Object value) {
    return '$value kg';
  }

  @override
  String get trendSpeedTitle => 'Trend Speed';

  @override
  String trendSpeedValue(Object value) {
    return '$value kg/week';
  }

  @override
  String get consistencyTitle => 'Consistency';

  @override
  String consistencyMessage(Object count) {
    return 'Logged $count weigh-ins this week.';
  }

  @override
  String get dailyCalorieTargetTitle => 'Daily Calorie Target';

  @override
  String get editDailyCalorieGoal => 'Edit Calorie Goal';

  @override
  String get calorieGoalMissingInfo => 'Birth year and gender are required to calculate the calorie goal.';

  @override
  String get calorieGoalSaved => 'Calorie goal saved.';

  @override
  String get calorieOffsetTitle => 'Daily Calorie Offset';

  @override
  String get calorieOffsetSubtitle => 'BMR + activity + offset';

  @override
  String calorieOffsetValue(Object value) {
    return '$value kcal';
  }

  @override
  String get calorieOffsetEditTitle => 'Edit Calorie Offset';

  @override
  String get calorieOffsetHint => 'Example: 500 for surplus, -500 for deficit';

  @override
  String get calorieOffsetInvalid => 'Enter a valid kcal value.';

  @override
  String get calorieOffsetSaved => 'Calorie offset saved.';

  @override
  String get exportImportTitle => 'Export / Import';

  @override
  String get workingLabel => 'Working...';

  @override
  String get exportTitle => 'Export';

  @override
  String get exportJson => 'Export JSON';

  @override
  String get exportCsv => 'Export CSV';

  @override
  String get exportJsonShare => 'WeightVault JSON Export';

  @override
  String get exportCsvShare => 'WeightVault CSV Export';

  @override
  String get importTitle => 'Import';

  @override
  String get importJson => 'Import JSON';

  @override
  String get csvImportWizard => 'CSV Import Wizard';

  @override
  String get importJsonTitle => 'Import JSON';

  @override
  String get importingLabel => 'Importing...';

  @override
  String get selectJsonFile => 'Select JSON File';

  @override
  String get importComplete => 'Import complete.';

  @override
  String get csvImportWizardTitle => 'CSV Import Wizard';

  @override
  String get selectCsvFile => 'Select CSV File';

  @override
  String get dateColumnLabel => 'Date Column';

  @override
  String get weightColumnLabel => 'Weight Column';

  @override
  String get importLabel => 'Import';

  @override
  String importedEntries(Object count) {
    return 'Imported $count entries.';
  }

  @override
  String get goPremiumTitle => 'Go Premium';

  @override
  String get loadingPaywall => 'Loading paywall';

  @override
  String get noOfferingsTitle => 'No offerings';

  @override
  String get noOfferingsMessage => 'RevenueCat offerings not configured yet.';

  @override
  String get premiumBenefitsTitle => 'Premium Benefits';

  @override
  String get premiumBenefitsMessage => 'Unlimited photos, widgets, barcode scanner, insights.';

  @override
  String subscribeLabel(Object price) {
    return 'Subscribe $price';
  }

  @override
  String get purchaseSuccessful => 'Purchase successful.';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get manageSubscription => 'Manage Subscription';

  @override
  String get manageSubscriptionMessage => 'Manage subscriptions from your store account.';

  @override
  String get unableToOpenSubscriptions => 'Unable to open subscription settings.';

  @override
  String get profileTitle => 'Profile';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get loadingProfile => 'Loading profile';

  @override
  String get profileErrorTitle => 'Profile error';

  @override
  String get goalsSectionTitle => 'Goals';

  @override
  String get adaptiveGoalsTitle => 'Adaptive Goals';

  @override
  String get supportSectionTitle => 'Support';

  @override
  String get sendFeedback => 'Send Feedback';

  @override
  String get exportDebugBundle => 'Export Debug Bundle';

  @override
  String get debugBundleShareText => 'WeightVault Debug Bundle';

  @override
  String get securitySectionTitle => 'Security';

  @override
  String get biometricAppLock => 'Biometric App Lock';

  @override
  String get privacyScreenBlur => 'Privacy Screen Blur';

  @override
  String get localDbEncryption => 'Local DB Encryption';

  @override
  String get restartToApplyEncryption => 'Restart app to apply encryption changes.';

  @override
  String get notificationsSectionTitle => 'Notifications';

  @override
  String get quietHoursStart => 'Quiet Hours Start';

  @override
  String get quietHoursEnd => 'Quiet Hours End';

  @override
  String get reminderOff => 'Off';

  @override
  String get weightReminderTitle => 'Weight Reminder';

  @override
  String get weightReminderBody => 'Log your weight today.';

  @override
  String get waterReminderTitle => 'Water Reminder';

  @override
  String get waterReminderBody => 'Time to hydrate.';

  @override
  String get mealReminderTitle => 'Meal Reminder';

  @override
  String get mealReminderBody => 'Log your meal.';

  @override
  String reminderMovedMessage(Object time) {
    return 'Reminder moved to $time due to quiet hours.';
  }

  @override
  String get disableLabel => 'Disable';

  @override
  String get dataSectionTitle => 'Data';

  @override
  String get insightsTitle => 'Insights';

  @override
  String get premiumSectionTitle => 'Premium';

  @override
  String get paywallSubscriptionTitle => 'Paywall & Subscription';

  @override
  String get legalSectionTitle => 'Legal';

  @override
  String get demoToolsTitle => 'Demo Tools';

  @override
  String get resetDemoData => 'Reset Demo Data';

  @override
  String get demoDataReset => 'Demo data reset.';

  @override
  String get accountSectionTitle => 'Account';

  @override
  String get deleteAccountTitle => 'Delete Account';

  @override
  String get signOut => 'Sign Out';

  @override
  String get appVersionTitle => 'App Version';

  @override
  String get noProfileTitle => 'No profile';

  @override
  String get noProfileMessage => 'Complete onboarding first.';

  @override
  String get profileSaved => 'Profile saved.';

  @override
  String get deleteAccountWarning => 'This action is permanent and deletes all data.';

  @override
  String confirmDeleteLabel(Object word) {
    return 'Type $word to confirm';
  }

  @override
  String get deletingLabel => 'Deleting...';

  @override
  String get deleteAccountCta => 'Delete Account';

  @override
  String get privacyPolicyTitle => 'Privacy Policy';

  @override
  String get privacyPolicyBody => 'WeightVault stores your data locally and syncs to your cloud account when enabled. You can export or delete your data anytime. This app does not provide medical advice.';

  @override
  String get termsOfServiceTitle => 'Terms of Service';

  @override
  String get termsOfServiceBody => 'By using WeightVault, you agree that the app is for informational purposes only. Always consult a healthcare professional for medical decisions.';
}
