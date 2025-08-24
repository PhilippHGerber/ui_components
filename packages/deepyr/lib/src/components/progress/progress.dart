import 'package:jaspr/jaspr.dart' show Key, Styles;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import 'progress_style.dart';

/// A component to show the progress of a task or the passing of time.
///
/// It renders a semantic `<progress>` HTML element. The component can be either
/// determinate or indeterminate.
///
/// - **Determinate:** Provide a `value` and `max`.
/// - **Indeterminate:** Omit the `value` (or pass `null`). The browser will
///   render a waiting/indeterminate animation.
///
/// Example Usage:
/// ```dart
/// // Determinate progress bar at 40%
/// Progress(
///   value: 40,
///   max: 100,
///   style: [Progress.primary, Sizing.w(56)],
/// )
///
/// // Indeterminate progress bar
/// Progress(
///   style: [Sizing.w(56)],
/// )
/// ```
class Progress extends UiComponent {
  /// Creates a Progress component.
  ///
  /// - [value]: The current progress value. If `null`, the progress bar is
  ///   indeterminate.
  /// - [max]: The maximum value of the progress bar. Defaults to `100`.
  /// - [style]: A list of [ProgressStyling] instances to control the color.
  ///   Size should be applied using a general utility like `Sizing.w(56)`.
  /// - [tag]: The HTML tag for the root element, defaults to 'progress'.
  /// - Other parameters are inherited from [UiComponent].
  const Progress({
    this.value,
    this.max = 100,
    super.tag = 'progress',
    List<ProgressStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.key,
  }) : super(null, style: style); // Progress elements have no children.

  /// The current value of the progress bar. If null, the bar is indeterminate.
  final double? value;

  /// The maximum value, representing completion.
  final double max;

  @override
  String get baseClass => 'progress';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    // The native <progress> element has implicit accessibility roles.
    // We only need to provide the value and max attributes.
    if (value != null) {
      attributes.add('value', value!.toString());
    }
    attributes.add('max', max.toString());
  }

  @override
  Progress copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Progress(
      value: value,
      max: max,
      tag: tag,
      style: style as List<ProgressStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  // Colors
  /// Neutral color. `progress-neutral`
  static const ProgressStyle neutral = ProgressStyle('progress-neutral', type: StyleType.style);

  /// Primary color. `progress-primary`
  static const ProgressStyle primary = ProgressStyle('progress-primary', type: StyleType.style);

  /// Secondary color. `progress-secondary`
  static const ProgressStyle secondary = ProgressStyle('progress-secondary', type: StyleType.style);

  /// Accent color. `progress-accent`
  static const ProgressStyle accent = ProgressStyle('progress-accent', type: StyleType.style);

  /// Info color. `progress-info`
  static const ProgressStyle info = ProgressStyle('progress-info', type: StyleType.style);

  /// Success color. `progress-success`
  static const ProgressStyle success = ProgressStyle('progress-success', type: StyleType.style);

  /// Warning color. `progress-warning`
  static const ProgressStyle warning = ProgressStyle('progress-warning', type: StyleType.style);

  /// Error color. `progress-error`
  static const ProgressStyle error = ProgressStyle('progress-error', type: StyleType.style);
}
