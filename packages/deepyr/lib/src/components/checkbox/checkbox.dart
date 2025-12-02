import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' show HTMLInputElement, document;

import '../../base/stateful_ui_component.dart';
import '../../base/style_type.dart';
import '../../base/ui_component_attributes.dart';
import 'checkbox_style.dart';

/// A checkbox component that allows users to select or deselect a value.
/// It renders an `<input type="checkbox">`.
///
/// The `Checkbox` is a **controlled component**. Its state is not managed internally.
/// Instead, you must provide its current state via the [isChecked] property and
/// handle state changes with the [onToggle] callback. This ensures that the UI
/// is always a direct reflection of your application's state.
///
/// ### Indeterminate State
/// The [indeterminate] property allows the checkbox to be in a "partially checked" state.
/// This is a visual state only and does not affect the value submission.
/// The component automatically handles the necessary JavaScript to apply this state.
///
/// ### Example:
/// ```dart
/// Checkbox(
///   isChecked: _agreedToTerms,
///   onToggle: (newValue) => setState(() => _agreedToTerms = newValue),
///   style: [Checkbox.primary],
/// )
/// ```
class Checkbox extends StatefulUiComponent {
  /// Creates a controlled Checkbox component.
  ///
  /// - [isChecked]: The current checked state of the checkbox.
  /// - [onToggle]: A callback that fires when the user clicks the checkbox.
  /// - [indeterminate]: If true, sets the visual indeterminate state via JavaScript.
  /// - [disabled]: If true, the checkbox will be non-interactive.
  /// - [style]: A list of [CheckboxStyling] instances for styling.
  /// - [tag]: The HTML tag for the root element, defaults to 'input'.
  const Checkbox({
    this.isChecked = false,
    this.onToggle,
    this.indeterminate = false,
    this.disabled = false,
    super.tag = 'input',
    List<CheckboxStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null, style: style);

  /// The current checked state of the checkbox.
  final bool isChecked;

  /// If true, the checkbox will be in an indeterminate state (visual only).
  final bool indeterminate;

  /// Callback function invoked when the checkbox's state changes.
  final ValueChanged<bool>? onToggle;

  /// If true, the checkbox is non-interactive.
  final bool disabled;

  @override
  String get baseClass => 'checkbox';

  @override
  State<Checkbox> createState() => _CheckboxState();

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    attributes.add('type', 'checkbox');

    // Set aria-checked to mixed if indeterminate for accessibility
    if (indeterminate) {
      attributes.addAria('checked', 'mixed');
    }
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

class _CheckboxState extends StatefulUiComponentState<Checkbox> {
  /// Generates a unique ID if one wasn't provided to find the element for JS interop.
  String get _elementId => component.id ?? 'checkbox_${component.hashCode}';

  @override
  String get baseClass => component.baseClass;

  @override
  void initState() {
    super.initState();
    _updateIndeterminateState();
  }

  @override
  void didUpdateComponent(Checkbox oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (oldComponent.indeterminate != component.indeterminate) {
      _updateIndeterminateState();
    }
  }

  /// Updates the JavaScript `indeterminate` property.
  void _updateIndeterminateState() {
    if (!kIsWeb) return;

    Future.delayed(Duration.zero, () {
      final input = document.getElementById(_elementId) as HTMLInputElement?;
      if (input != null) {
        input.indeterminate = component.indeterminate;
      }
    });
  }

  @override
  Component build(BuildContext context) {
    return input(
      // Use the ID we generated/retrieved to allow finding the element
      id: _elementId,
      type: InputType.checkbox,
      classes: combinedClasses,
      styles: component.css,
      attributes: componentAttributes,

      // Explicitly bind checked state using the robust true/null pattern.
      // This ensures the DOM property is strictly controlled by our Dart state.
      checked: component.isChecked ? true : null,

      // Bind disabled state similarly
      disabled: component.disabled ? true : null,

      // Handle changes via callback
      onChange: (value) {
        component.onToggle?.call(!component.isChecked);
      },
    );
  }
}
