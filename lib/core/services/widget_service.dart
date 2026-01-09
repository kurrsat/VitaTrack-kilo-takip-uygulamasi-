import 'package:home_widget/home_widget.dart';
import 'package:weightvault/core/constants/app_constants.dart';
class WidgetService {
  Future<void> updateTodaySummary({required double trend, required int etaDays}) async {
    await HomeWidget.saveWidgetData('trend', trend.toStringAsFixed(1));
    await HomeWidget.saveWidgetData('etaDays', etaDays.toString());
    await HomeWidget.updateWidget(
      name: AppConstants.todaySummaryWidgetKind,
      iOSName: AppConstants.todaySummaryWidgetKind,
      androidName: 'com.example.kilotakibi.TodaySummaryWidgetProvider',
    );
  }

  Future<void> updateFastingTimer({required String remaining}) async {
    await HomeWidget.saveWidgetData('fastingRemaining', remaining);
    await HomeWidget.updateWidget(
      name: AppConstants.fastingWidgetKind,
      iOSName: AppConstants.fastingWidgetKind,
      androidName: 'com.example.kilotakibi.FastingWidgetProvider',
    );
  }
}
