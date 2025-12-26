import 'package:jaspr/dom.dart' show Styles;
import 'package:jaspr/jaspr.dart' show Key;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'loading_style.dart';

/// A component that shows an animation to indicate that something is loading.
///
/// It renders an empty `<span>` element with the necessary CSS classes for the
/// animation. The color of the loading indicator is controlled by standard text
/// color utilities (e.g., `TextUtil.primary`).
///
/// Example Usage:
/// ```dart
/// Loading(
///   style: [
///     Loading.spinner,
///     Loading.lg,
///     TextUtil.primary, // Color is applied via text utilities
///   ],
/// )
/// ```
class Loading extends UiComponent {
  /// Creates a Loading component.
  ///
  /// - [style]: A list of [LoadingStyling] instances to control the animation
  ///   type (e.g., `Loading.spinner`) and size (e.g., `Loading.lg`).
  ///   Color should be applied using a text utility like `TextUtil.primary`.
  /// - [ariaLabel]: An accessible name for the loading indicator. Defaults to "loading".
  ///   It's recommended to provide a more descriptive label if possible (e.g., "Loading results...").
  /// - [tag]: The HTML tag for the root element, defaults to 'span'.
  /// - Other parameters are inherited from [UiComponent].
  const Loading({
    List<LoadingStyling>? style,
    this.ariaLabel,
    super.tag = 'span',
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null, style: style); // Loading elements have no children.

  /// An accessible label for the loading indicator, announced by screen readers.
  final String? ariaLabel;

  @override
  String get baseClass => 'loading';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    // The 'status' role indicates that the content is a live region
    // providing advisory information about the status of a request.
    if (!userProvidedAttributes.containsKey('role')) {
      attributes.addRole('status');
    }
    // Provide a default accessible name, which can be overridden by the user.
    attributes.addAria('label', ariaLabel ?? 'loading');
  }

  @override
  Loading copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Loading(
      style: style as List<LoadingStyling>?,
      ariaLabel: ariaLabel,
      tag: tag,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  // Animation Styles
  /// Spinner animation. `loading-spinner`
  static const LoadingStyle spinner = LoadingStyle('loading-spinner', type: StyleType.style);

  /// Dots animation. `loading-dots`
  static const LoadingStyle dots = LoadingStyle('loading-dots', type: StyleType.style);

  /// Ring animation. `loading-ring`
  static const LoadingStyle ring = LoadingStyle('loading-ring', type: StyleType.style);

  /// Ball animation. `loading-ball`
  static const LoadingStyle ball = LoadingStyle('loading-ball', type: StyleType.style);

  /// Bars animation. `loading-bars`
  static const LoadingStyle bars = LoadingStyle('loading-bars', type: StyleType.style);

  /// Infinity animation. `loading-infinity`
  static const LoadingStyle infinity = LoadingStyle('loading-infinity', type: StyleType.style);

  // Sizes
  /// Extra-small size. `loading-xs`
  static const LoadingStyle xs = LoadingStyle('loading-xs', type: StyleType.sizing);

  /// Small size. `loading-sm`
  static const LoadingStyle sm = LoadingStyle('loading-sm', type: StyleType.sizing);

  /// Medium size (default). `loading-md`
  static const LoadingStyle md = LoadingStyle('loading-md', type: StyleType.sizing);

  /// Large size. `loading-lg`
  static const LoadingStyle lg = LoadingStyle('loading-lg', type: StyleType.sizing);

  /// Extra-large size. `loading-xl`
  static const LoadingStyle xl = LoadingStyle('loading-xl', type: StyleType.sizing);
}
