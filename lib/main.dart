import 'package:flutter/material.dart';
import 'package:shoe_product/views/home/home_screen.dart';

import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    final exception = details.exception;
    if (exception is PlatformException) {
      final msg = exception.message ?? '';
      if (exception.code == 'channel-error' ||
          msg.contains('PigeonInternalInstanceManager') ||
          msg.contains('webview_flutter_android') ||
          msg.contains('WebView.')) {
        return; // Ignore
      }
    }
    final errStr = exception.toString();
    if (errStr.contains('PigeonInternalInstanceManager') ||
        errStr.contains('webview_flutter_android') ||
        errStr.contains('WebView.')) {
      return; // Ignore
    }
    FlutterError.presentError(details);
  };

  // Silence asynchronous platform errors from webview pigeon channels
  WidgetsBinding.instance.platformDispatcher.onError = (error, stack) {
    if (error is PlatformException) {
      final msg = error.message ?? '';
      if (error.code == 'channel-error' ||
          msg.contains('PigeonInternalInstanceManager') ||
          msg.contains('webview_flutter_android') ||
          msg.contains('WebView.')) {
        debugPrint(
          'Silenced WebView Pigeon hot-restart platform channel exception.',
        );
        return true; // Silenced
      }
    }
    final errStr = error.toString();
    if (errStr.contains('PigeonInternalInstanceManager') ||
        errStr.contains('webview_flutter_android') ||
        errStr.contains('WebView.')) {
      debugPrint(
        'Silenced WebView Pigeon hot-restart platform channel exception.',
      );
      return true; // Silenced
    }
    return false;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoe App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
