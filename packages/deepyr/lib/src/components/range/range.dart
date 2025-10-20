import 'package:jaspr/jaspr.dart'
    show BuildContext, Component, EventCallback, Key, Styles, ValueChanged, kIsWeb;
import 'package:universal_web/web.dart' show Event, HTMLInputElement;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'range_style.dart';

/// A range slider component used to select a value by sliding a handle.
/// It renders an `<input type="range">`.
///
/// The `Range` is a **controlled component**. Its state is not managed internally.
/// You must provide its current `value` and handle state changes with the
/// [onValueChanged] callback. This callback provides the new value as a `double`,
/// abstracting away the string parsing from the DOM event.
///
/// Example of state management in a `StatefulComponent`:
/// ```dart
/// class VolumeControl extends StatefulComponent {
///   @override
///   State<VolumeControl> createState() => _VolumeControlState();
/// }
///
/// class _VolumeControlState extends State<VolumeControl> {
///   double _volume = 40.0;
///
///   @override
///   Component build(BuildContext context) {
///     return Range(
///       value: _volume,
///       onValueChanged: (newValue) {
///         setState(() => _volume = newValue);
///       },
///       min: 0,
///       max: 100,
///       step: 10,
///       style: [Range.primary],
///     );
///     return p([text('Volume: \${_volume.toInt()}%')]);
///   }
/// }
/// ```
class Range extends UiComponent {
  /// Creates a Range slider component.
  ///
  /// - [value]: The current numerical value of the slider.
  /// - [onValueChanged]: A callback that fires when the slider's value changes
  ///   (e.g., while dragging). It receives the new value as a `double`.
  /// - [min]: The minimum value of the range. Defaults to `0`.
  /// - [max]: The maximum value of the range. Defaults to `100`.
  /// - [step]: The stepping interval. If null, the slider moves smoothly.
  /// - [disabled]: If true, the range slider will be non-interactive.
  /// - [style]: A list of [RangeStyling] instances for styling.
  /// - Other parameters are inherited from [UiComponent].
  const Range({
    this.value = 0,
    this.onValueChanged,
    this.min = 0,
    this.max = 100,
    this.step,
    this.disabled = false,
    super.tag = 'input',
    List<RangeStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null, style: style); // Range elements have no children.

  /// The current value of the slider.
  final double value;

  /// Callback function invoked when the slider's value changes.
  final ValueChanged<double>? onValueChanged;

  /// The minimum value of the slider.
  final double min;

  /// The maximum value of the slider.
  final double max;

  /// The granularity that the value must adhere to.
  final double? step;

  /// If true, the slider is non-interactive.
  final bool disabled;

  @override
  String get baseClass => 'range';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    attributes
      ..add('type', 'range')
      ..add('value', value.toString())
      ..add('min', min.toString())
      ..add('max', max.toString());
    if (step != null) {
      attributes.add('step', step!.toString());
    }
    if (disabled) {
      attributes.add('disabled', '');
    }
  }

  @override
  Range copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Range(
      value: value,
      onValueChanged: onValueChanged,
      min: min,
      max: max,
      step: step,
      disabled: disabled,
      tag: tag,
      style: style as List<RangeStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  @override
  Component build(BuildContext context) {
    final eventMap = Map<String, EventCallback>.from(events);

    if (onValueChanged != null) {
      // The 'input' event fires continuously as the user drags the slider.
      eventMap['input'] = (dynamic rawEvent) {
        if (kIsWeb) {
          final target = (rawEvent as Event).target! as HTMLInputElement;
          // The value from a range input is always a string, so we parse it.
          final newValue = double.tryParse(target.value);
          if (newValue != null) {
            onValueChanged!(newValue);
          }
        }
      };
    }

    return Component.element(
      tag: tag,
      id: id,
      classes: combinedClasses,
      styles: css,
      attributes: componentAttributes,
      events: eventMap,
    );
  }

  // --- Static Style Modifiers ---

  // Colors
  /// Neutral color. `range-neutral`
  static const RangeStyle neutral = RangeStyle('range-neutral', type: StyleType.style);

  /// Primary color. `range-primary`
  static const RangeStyle primary = RangeStyle('range-primary', type: StyleType.style);

  /// Secondary color. `range-secondary`
  static const RangeStyle secondary = RangeStyle('range-secondary', type: StyleType.style);

  /// Accent color. `range-accent`
  static const RangeStyle accent = RangeStyle('range-accent', type: StyleType.style);

  /// Success color. `range-success`
  static const RangeStyle success = RangeStyle('range-success', type: StyleType.style);

  /// Warning color. `range-warning`
  static const RangeStyle warning = RangeStyle('range-warning', type: StyleType.style);

  /// Info color. `range-info`
  static const RangeStyle info = RangeStyle('range-info', type: StyleType.style);

  /// Error color. `range-error`
  static const RangeStyle error = RangeStyle('range-error', type: StyleType.style);

  // Sizes
  /// Extra-small size. `range-xs`
  static const RangeStyle xs = RangeStyle('range-xs', type: StyleType.sizing);

  /// Small size. `range-sm`
  static const RangeStyle sm = RangeStyle('range-sm', type: StyleType.sizing);

  /// Medium size (default). `range-md`
  static const RangeStyle md = RangeStyle('range-md', type: StyleType.sizing);

  /// Large size. `range-lg`
  static const RangeStyle lg = RangeStyle('range-lg', type: StyleType.sizing);

  /// Extra-large size. `range-xl`
  static const RangeStyle xl = RangeStyle('range-xl', type: StyleType.sizing);
}
