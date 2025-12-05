import 'package:jaspr/jaspr.dart';

import '../../base/stateful_ui_component.dart';
import '../../base/style_type.dart';
import '../../base/ui_component_attributes.dart';
import 'radio_style.dart';

/// A radio button component that allows users to select one option from a group.
/// It renders an `<input type="radio">`.
///
/// The `Radio` component is a **controlled component** and is generic over the type `T`
/// of its value for type safety.
///
/// Its state is managed by a parent component, which holds the currently selected
/// value for the entire group (`groupValue`). The `Radio` determines if it is
/// checked by comparing its own `value` to the `groupValue`. When clicked, it
/// notifies the parent of the selection via the `onSelect` callback.
///
/// ### Example:
/// ```dart
/// enum Flavor { vanilla, chocolate }
///
/// Radio<Flavor>(
///   value: Flavor.vanilla,
///   groupValue: _selectedFlavor,
///   name: 'flavors',
///   onSelect: (val) => setState(() => _selectedFlavor = val),
///   style: [Radio.primary],
/// )
/// ```
class Radio<T> extends StatefulUiComponent {
  /// Creates a controlled Radio button component.
  ///
  /// - [value]: The unique value of type `T` that this radio button represents.
  /// - [groupValue]: The currently selected value of type `T` for the entire radio group.
  ///   The radio button is considered 'checked' if `value == groupValue`.
  /// - [name]: The HTML `name` attribute, which must be the same for all radio
  ///   buttons in a group to ensure they are mutually exclusive.
  /// - [onSelect]: A callback that fires when the user selects this radio button.
  ///   It receives the [value] of this component.
  /// - [disabled]: If true, the radio button will be non-interactive.
  /// - [style]: A list of [RadioStyling] instances for styling.
  /// - [tag]: The HTML tag for the root element, defaults to 'input'.
  const Radio({
    required this.value,
    required this.groupValue,
    required this.name,
    this.onSelect,
    this.disabled = false,
    super.tag = 'input',
    List<RadioStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null, style: style);

  /// The unique value this radio button represents within its group.
  final T value;

  /// The currently selected value for the entire radio group.
  final T groupValue;

  /// The name for the radio button group.
  final String name;

  /// Callback function invoked when this radio button is selected.
  final ValueChanged<T>? onSelect;

  /// If true, the radio button is non-interactive.
  final bool disabled;

  /// Internally computed checked state.
  bool get isChecked => value == groupValue;

  @override
  String get baseClass => 'radio';

  @override
  State<Radio<T>> createState() => _RadioState<T>();

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    attributes
      ..add('type', 'radio')
      ..add('name', name)
      // The HTML value attribute is always a string.
      ..add('value', value.toString());

    // NOTE: We DO NOT set 'checked' or 'disabled' attributes here.
    // Those are managed via the `input` component's named parameters in the state
    // to control the DOM properties directly.
  }

  // --- Static Style Modifiers ---

  // Colors
  /// Applies the primary theme color. `radio-primary`
  static const RadioStyle primary = RadioStyle('radio-primary', type: StyleType.style);

  /// Applies the secondary theme color. `radio-secondary`
  static const RadioStyle secondary = RadioStyle('radio-secondary', type: StyleType.style);

  /// Applies the accent theme color. `radio-accent`
  static const RadioStyle accent = RadioStyle('radio-accent', type: StyleType.style);

  /// Applies the neutral theme color. `radio-neutral`
  static const RadioStyle neutral = RadioStyle('radio-neutral', type: StyleType.style);

  /// Applies the success theme color, typically green. `radio-success`
  static const RadioStyle success = RadioStyle('radio-success', type: StyleType.style);

  /// Applies the warning theme color, typically yellow or orange. `radio-warning`
  static const RadioStyle warning = RadioStyle('radio-warning', type: StyleType.style);

  /// Applies the info theme color, typically light blue. `radio-info`
  static const RadioStyle info = RadioStyle('radio-info', type: StyleType.style);

  /// Applies the error theme color, typically red. `radio-error`
  static const RadioStyle error = RadioStyle('radio-error', type: StyleType.style);

  // Sizes
  /// Renders an extra-small radio button. `radio-xs`
  static const RadioStyle xs = RadioStyle('radio-xs', type: StyleType.sizing);

  /// Renders a small radio button. `radio-sm`
  static const RadioStyle sm = RadioStyle('radio-sm', type: StyleType.sizing);

  /// Renders a medium-sized radio button (default size). `radio-md`
  static const RadioStyle md = RadioStyle('radio-md', type: StyleType.sizing);

  /// Renders a large radio button. `radio-lg`
  static const RadioStyle lg = RadioStyle('radio-lg', type: StyleType.sizing);

  /// Renders an extra-large radio button. `radio-xl`
  static const RadioStyle xl = RadioStyle('radio-xl', type: StyleType.sizing);
}

class _RadioState<T> extends StatefulUiComponentState<Radio<T>> {
  @override
  String get baseClass => component.baseClass;

  @override
  Component build(BuildContext context) {
    return input(
      id: component.id,
      type: InputType.radio,
      classes: combinedClasses,
      styles: component.css,
      attributes: componentAttributes,

      // Explicitly bind checked state using the true/null pattern.
      // This ensures the DOM property is strictly controlled by our Dart state.
      checked: component.isChecked ? true : null,

      // Bind disabled state similarly
      disabled: component.disabled ? true : null,

      // Handle changes via callback
      onChange: (dynamic val) {
        // HTML Radio inputs only trigger 'change' when they are selected.
        // We simply notify the parent of the new value.
        component.onSelect?.call(component.value);
      },
    );
  }
}
