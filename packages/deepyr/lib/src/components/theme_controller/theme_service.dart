import 'dart:async';

import 'package:universal_web/web.dart';

/// A singleton service to manage theme switching and persistence for DaisyUI themes.
class ThemeService {
  // Private constructor
  ThemeService._();

  /// Provides access to the singleton instance.
  /// Dart static variables are lazily initialized by default.
  static final ThemeService instance = ThemeService._();

  static const _themeKey = 'current_theme';
  bool _initialized = false;

  /// Initializes the theme service.
  ///
  /// In a real app using `theme-change`, this might inject the script.
  /// For deepyr's controlled components, we can also manage state manually here.
  Future<void> initialize() async {
    if (_initialized) return;
    // Logic to load saved theme and apply it immediately on start
    final saved = loadSavedTheme();
    if (saved != null) {
      setTheme(saved);
    }
    _initialized = true;
  }

  /// Returns the current theme name from the `data-theme` attribute of the `<html>` element.
  String? getCurrentTheme() {
    return document.documentElement?.getAttribute('data-theme');
  }

  /// Loads the saved theme name from local storage.
  String? loadSavedTheme() {
    return window.localStorage.getItem(_themeKey);
  }

  /// Saves the theme to local storage.
  void saveTheme(String theme) {
    window.localStorage.setItem(_themeKey, theme);
  }

  /// Sets the theme on the document root and saves it.
  void setTheme(String theme) {
    document.documentElement?.setAttribute('data-theme', theme);
    saveTheme(theme);
  }

  /// Checks if the user's system is set to prefer a dark color scheme.
  bool get systemPrefersDark {
    return window.matchMedia('(prefers-color-scheme: dark)').matches;
  }
}
