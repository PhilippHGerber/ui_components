import 'dart:async';

import 'package:universal_web/web.dart';

// @JS('themeChange')
// external void themeChange();

// @JS('setTheme')
// external void _jsSetTheme(String theme);

/// Service zum Verwalten des UI Themes
/// Theme programmatisch ändern
/// ThemeService.instance.setTheme('dark');
class ThemeService {
  ThemeService._();
  static ThemeService? _instance;
  static ThemeService get instance => _instance ??= ThemeService._();

  bool _initialized = false;

  /// Initialisiert den Theme Service
  /// Lädt das theme-change Script und initialisiert es
  Future<void> initialize() async {
    if (_initialized) return;

    try {
      // Füge theme-change Script hinzu
      final script = document.createElement('script') as HTMLScriptElement;
      script.src = 'https://cdn.jsdelivr.net/npm/theme-change@2.0.2/index.js';
      script.type = 'text/javascript';

      // Warte bis Script geladen ist
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

  /// Gibt das aktuelle Theme zurück
  String? getCurrentTheme() {
    return document.documentElement?.getAttribute('data-theme');
  }

  /// Add Theme Persistence:
  static const _themeKey = 'current_theme';

  String? loadSavedTheme() {
    // Using window.localStorage for persistence
    return window.localStorage[_themeKey];
  }

  void saveTheme(String theme) {
    window.localStorage[_themeKey] = theme;
  }

  ///Add System Theme Detection
  bool get systemPrefersDark {
    return window.matchMedia('(prefers-color-scheme: dark)').matches;
  }
}
