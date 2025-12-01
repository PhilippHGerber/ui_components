import 'package:jaspr/jaspr.dart'
    show BuildContext, Component, EventCallback, Key, Styles, ValueChanged, kIsWeb;
import 'package:universal_web/web.dart' show Event, HTMLInputElement;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'checkbox_style.dart';

/// A checkbox component that allows users to select or deselect a value.
/// It renders an `<input type="checkbox">`.
///
/// The `Checkbox` is a **controlled component**. Its state is not managed internally.
/// Instead, you must provide its current state via the [isChecked] property and
/// handle state changes with the [onToggle] callback. This ensures that the UI
/// is always a direct reflection of your application's state.
///
/// Example of state management in a `StatefulComponent`:
/// ```dart
/// class MyForm extends StatefulComponent {
///   bool _agreedToTerms = false;
///
///   @override
///   State<MyForm> createState() => _MyFormState();
/// }
///
/// class _MyFormState extends State<MyForm> {
///   @override
///   Component build(BuildContext context) {
///     return Checkbox(
///       isChecked: _agreedToTerms,
///       onToggle: (newValue) {
///         setState(() => _agreedToTerms = newValue);
///       },
///     );
///   }
/// }
/// ```
class Checkbox extends UiComponent {
  /// Creates a Checkbox component.
  ///
  /// - [isChecked]: The current checked state of the checkbox.
  /// - [onToggle]: A callback that fires when the user clicks the checkbox. It
  ///   receives the new potential boolean state. You should use this callback
  ///   to update your application's state.
  /// - [disabled]: If true, the checkbox will be non-interactive.
  /// - [style]: A list of [CheckboxStyling] instances for styling.
  /// - Other parameters are inherited from [UiComponent].
  const Checkbox({
    this.isChecked = false,
    this.onToggle,
    this.disabled = false,
    super.tag = 'input',
    List<CheckboxStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null, style: style); // Checkbox elements have no children.

  /// The current checked state of the checkbox.
  final bool isChecked;

  /// Callback function invoked when the checkbox's state changes.
  final ValueChanged<bool>? onToggle;

  /// If true, the checkbox is non-interactive.
  final bool disabled;

  @override
  String get baseClass => 'checkbox';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    attributes.add('type', 'checkbox');
    if (isChecked) {
      attributes.add('checked', '');
    }
    if (disabled) {
      attributes.add('disabled', '');
    }
  }

  @override
  Checkbox copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Checkbox(
      isChecked: isChecked,
      onToggle: onToggle,
      disabled: disabled,
      tag: tag,
      style: style as List<CheckboxStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }

  /// Overrides the default build method to provide a type-safe `onToggle` callback.
  ///
  /// The base `UiComponent`'s `onChange` event is designed for string values from text inputs.
  /// This override creates a specific event handler for the checkbox's boolean `checked` property,
  /// ensuring it only runs on the client and uses safe type casting.
  @override
  Component build(BuildContext context) {
    // Start with the standard events from the base class.
    final eventMap = Map<String, EventCallback>.from(this.eventMap);

    if (onToggle != null) {
      eventMap['change'] = (dynamic event) {
        // Guard for web-only execution to prevent errors during SSR.
        if (kIsWeb) {
          // Use explicit casting (`as`) which is the idiomatic way to handle
          // known event types from JS interop, avoiding analyzer warnings.
          final target = (event as Event).target! as HTMLInputElement;
          onToggle!(target.checked);
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
      // A checkbox has no children.
    );
  }

  // --- Static Style Modifiers ---

  // Colors
  /// Primary color. `checkbox-primary`
  static const CheckboxStyle primary = CheckboxStyle('checkbox-primary', type: StyleType.style);

  /// Secondary color. `checkbox-secondary`
  static const CheckboxStyle secondary = CheckboxStyle('checkbox-secondary', type: StyleType.style);

  /// Accent color. `checkbox-accent`
  static const CheckboxStyle accent = CheckboxStyle('checkbox-accent', type: StyleType.style);

  /// Neutral color. `checkbox-neutral`
  static const CheckboxStyle neutral = CheckboxStyle('checkbox-neutral', type: StyleType.style);

  /// Success color. `checkbox-success`
  static const CheckboxStyle success = CheckboxStyle('checkbox-success', type: StyleType.style);

  /// Warning color. `checkbox-warning`
  static const CheckboxStyle warning = CheckboxStyle('checkbox-warning', type: StyleType.style);

  /// Info color. `checkbox-info`
  static const CheckboxStyle info = CheckboxStyle('checkbox-info', type: StyleType.style);

  /// Error color. `checkbox-error`
  static const CheckboxStyle error = CheckboxStyle('checkbox-error', type: StyleType.style);

  // Sizes
  /// Extra-small size. `checkbox-xs`
  static const CheckboxStyle xs = CheckboxStyle('checkbox-xs', type: StyleType.sizing);

  /// Small size. `checkbox-sm`
  static const CheckboxStyle sm = CheckboxStyle('checkbox-sm', type: StyleType.sizing);

  /// Medium size (default). `checkbox-md`
  static const CheckboxStyle md = CheckboxStyle('checkbox-md', type: StyleType.sizing);

  /// Large size. `checkbox-lg`
  static const CheckboxStyle lg = CheckboxStyle('checkbox-lg', type: StyleType.sizing);

  /// Extra-large size. `checkbox-xl`
  static const CheckboxStyle xl = CheckboxStyle('checkbox-xl', type: StyleType.sizing);
}
