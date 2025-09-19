import 'package:jaspr/jaspr.dart'
    show BuildContext, Component, EventCallback, Key, Styles, ValueChanged, kIsWeb;
import 'package:universal_web/web.dart' show Event, HTMLInputElement;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
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
/// Example of state management in a `StatefulComponent`:
/// ```dart
/// enum Flavor { vanilla, chocolate, strawberry }
///
/// class MyFormState extends State<MyForm> {
///   Flavor _selectedFlavor = Flavor.vanilla;
///
///   @override
///   Component build(BuildContext context) {
///     for (final flavor in Flavor.values) {
///       return Radio<Flavor>(
///         value: flavor,
///         groupValue: _selectedFlavor,
///         name: 'flavor-group',
///         onSelect: (newValue) {
///           setState(() => _selectedFlavor = newValue);
///         },
///       );
///     }
///   }
/// }
/// ```
class Radio<T> extends UiComponent {
  /// Creates a Radio button component.
  ///
  /// - [value]: The unique value of type `T` that this radio button represents.
  /// - [groupValue]: The currently selected value of type `T` for the entire radio group.
  ///   The radio button is considered 'checked' if `value == groupValue`.
  /// - [name]: The HTML `name` attribute, which must be the same for all radio
  ///   buttons in a group to ensure they are mutually exclusive.
  /// - [onSelect]: A callback that fires when the user selects this radio button.
  ///   It receives the `value` of this component.
  /// - [disabled]: If true, the radio button will be non-interactive.
  /// - [style]: A list of [RadioStyling] instances for styling.
  /// - Other parameters are inherited from [UiComponent].
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
  }) : super(null, style: style); // Radio elements have no children.

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
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    attributes
      ..add('type', 'radio')
      ..add('name', name)
      // The HTML value attribute is always a string.
      ..add('value', value.toString());
    if (isChecked) {
      attributes.add('checked', '');
    }
    if (disabled) {
      attributes.add('disabled', '');
    }
  }

  @override
  Radio<T> copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    // This copyWith implementation is complex due to generics and required fields.
    // It is provided for completeness of the UiComponent contract but may need
    // adjustments based on specific use cases for copying Radio components.
    return Radio<T>(
      value: value,
      groupValue: groupValue,
      name: name,
      onSelect: onSelect,
      disabled: disabled,
      tag: tag,
      style: style as List<RadioStyling>?,
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

    // The 'change' event fires when a radio button is selected.
    eventMap['change'] = (dynamic event) {
      // Guard for web-only execution.
      if (kIsWeb) {
        // Use explicit casting for type safety and to avoid analyzer warnings.
        final target = (event as Event).target! as HTMLInputElement;
        // Only trigger the callback if this radio button just became checked.
        if (target.checked) {
          onSelect?.call(value);
        }
      }
    };

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
