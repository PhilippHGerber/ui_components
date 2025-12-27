// dart format off
// ignore_for_file: type=lint

// GENERATED FILE, DO NOT MODIFY
// Generated with jaspr_builder

import 'package:jaspr/server.dart';
import 'package:deepyr/src/components/icon/icon.dart' as _icon;
import 'package:deepyr/src/components/label/label.dart' as _label;
import 'package:example/example.dart' as _example;

/// Default [ServerOptions] for use with your Jaspr project.
///
/// Use this to initialize Jaspr **before** calling [runApp].
///
/// Example:
/// ```dart
/// import 'main.server.options.dart';
///
/// void main() {
///   Jaspr.initializeApp(
///     options: defaultServerOptions,
///   );
///
///   runApp(...);
/// }
/// ```
ServerOptions get defaultServerOptions => ServerOptions(
  clientId: 'main.client.dart.js',
  clients: {
    _example.DeepyrShowcase: ClientTarget<_example.DeepyrShowcase>('example'),
  },
  styles: () => [..._icon.Icon.styles, ..._label.Label.styles],
);
