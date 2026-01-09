import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackService {
  Future<void> sendFeedback({required String email}) async {
    final info = await PackageInfo.fromPlatform();
    final deviceInfo = DeviceInfoPlugin();
    final data = await deviceInfo.deviceInfo;
    final body = StringBuffer()
      ..writeln('App: ${info.appName} ${info.version}+${info.buildNumber}')
      ..writeln('Platform: ${data.data['systemName'] ?? data.data['model']}')
      ..writeln('OS: ${data.data['systemVersion'] ?? data.data['version']}')
      ..writeln()
      ..writeln('Feedback:');

    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'WeightVault Feedback',
        'body': body.toString(),
      },
    );
    await launchUrl(uri);
  }
}
