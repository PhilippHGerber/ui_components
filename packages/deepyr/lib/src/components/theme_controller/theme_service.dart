import 'dart:async';

import 'package:universal_web/web.dart';

// @JS('themeChange')
// external void themeChange();

// @JS('setTheme')
// external void _jsSetTheme(String theme);

/// A singleton service to manage theme switching and persistence for DaisyUI themes.
///
/// This service injects and interacts with the `theme-change` JavaScript library
/// to dynamically change the `data-theme` attribute on the `<html>` element.
/// It also handles saving the current theme to local storage and detecting the
/// user's system theme preference.
///
/// ### Example Usage:
/// ```dart
/// // In your main app initialization:
/// await ThemeService.instance.initialize();
///
/// // To change the theme programmatically:
/// ThemeService.instance.setTheme('dark');
/// ```
class ThemeService {
  ThemeService._();
  static ThemeService? _instance;

  /// Provides access to the singleton instance of the [ThemeService].
  static ThemeService get instance => _instance ??= ThemeService._();

  bool _initialized = false;

  /// Initializes the theme service by injecting the `theme-change` JavaScript library.
  ///
  /// This method must be called once before any theme switching can occur.
  /// It is safe to call multiple times.
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      // Add the theme-change script to the document head.
      final script = document.createElement('script') as HTMLScriptElement;
      script.src = 'https://cdn.jsdelivr.net/npm/theme-change@2.0.2/index.js';
      script.type = 'text/javascript';

      // Wait for the script to load.
      final completer = Completer<void>();
      script.onLoad.listen((_) => completer.complete());
      script.onError.listen(completer.completeError);

      document.head?.appendChild(script);
      await completer.future;

      _initialized = true;
    } catch (e) {
      print('Failed to initialize ThemeService: $e');
      rethrow;
    }
  }

  /// Returns the current theme name from the `data-theme` attribute of the `<html>` element.
  String? getCurrentTheme() {
    return document.documentElement?.getAttribute('data-theme');
  }

  /// The key used for storing the theme in local storage.
  static const _themeKey = 'current_theme';

  /// Loads the saved theme name from the browser's local storage.
  ///
  /// Returns `null` if no theme has been saved.
  String? loadSavedTheme() {
    // Using window.localStorage for persistence
    return window.localStorage[_themeKey];
  }

  /// Saves the provided [theme] name to the browser's local storage.
  void saveTheme(String theme) {
    window.localStorage[_themeKey] = theme;
  }

  /// Checks if the user's system is set to prefer a dark color scheme.
  bool get systemPrefersDark {
    return window.matchMedia('(prefers-color-scheme: dark)').matches;
  }
}
