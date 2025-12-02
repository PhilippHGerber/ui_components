import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' show HTMLInputElement, document;

import '../../base/stateful_ui_component.dart';
import '../../base/style_type.dart';
import '../../base/ui_component_attributes.dart';
import 'toggle_style.dart';

/// A checkbox styled to look like a switch button.
/// It renders an `<input type="checkbox">`.
///
/// The `Toggle` is a **controlled component**. Its state is not managed internally.
/// Instead, you must provide its current state via the [isChecked] property and
/// handle state changes with the [onToggle] callback. This ensures that the UI
/// is always a direct reflection of your application's state.
///
/// ### Indeterminate State
/// The [indeterminate] property allows the toggle to be in a "partially checked" state.
/// This is a visual state only and does not affect the value submission.
/// The component automatically handles the necessary JavaScript to apply this state.
///
/// ### Example:
/// ```dart
/// Toggle(
///   isChecked: _notificationsEnabled,
///   onToggle: (newValue) => setState(() => _notificationsEnabled = newValue),
///   style: [Toggle.primary],
/// )
/// ```
class Toggle extends StatefulUiComponent {
  /// Creates a controlled Toggle component.
  ///
  /// - [isChecked]: The current checked state of the toggle.
  /// - [onToggle]: A callback that fires when the user clicks the toggle.
  /// - [indeterminate]: If true, sets the visual indeterminate state via JavaScript.
  /// - [disabled]: If true, the toggle will be non-interactive.
  /// - [style]: A list of [ToggleStyling] instances for styling.
  /// - [tag]: The HTML tag for the root element, defaults to 'input'.
  const Toggle({
    this.isChecked = false,
    this.onToggle,
    this.indeterminate = false,
    this.disabled = false,
    super.tag = 'input',
    List<ToggleStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null, style: style);

  /// The current checked state of the toggle.
  final bool isChecked;

  /// If true, the toggle will be in an indeterminate state (visual only).
  final bool indeterminate;

  /// Callback function invoked when the toggle's state changes.
  final ValueChanged<bool>? onToggle;

  /// If true, the toggle is non-interactive.
  final bool disabled;

  @override
  String get baseClass => 'toggle';

  @override
  State<Toggle> createState() => _ToggleState();

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    attributes.add('type', 'checkbox');

    // NOTE: We DO NOT set 'checked' or 'disabled' attributes here.
    // Those are managed via the `input` component's named parameters to control
    // the DOM properties directly. This avoids conflicts between attributes and properties.

    // Set aria-checked to mixed if indeterminate for accessibility
    if (indeterminate) {
      attributes.addAria('checked', 'mixed');
    }
  }

  // --- Static Style Modifiers ---

  // Colors
  /// Primary color. `toggle-primary`
  static const ToggleStyle primary = ToggleStyle('toggle-primary', type: StyleType.style);

  /// Secondary color. `toggle-secondary`
  static const ToggleStyle secondary = ToggleStyle('toggle-secondary', type: StyleType.style);

  /// Accent color. `toggle-accent`
  static const ToggleStyle accent = ToggleStyle('toggle-accent', type: StyleType.style);

  /// Neutral color. `toggle-neutral`
  static const ToggleStyle neutral = ToggleStyle('toggle-neutral', type: StyleType.style);

  /// Success color. `toggle-success`
  static const ToggleStyle success = ToggleStyle('toggle-success', type: StyleType.style);

  /// Warning color. `toggle-warning`
  static const ToggleStyle warning = ToggleStyle('toggle-warning', type: StyleType.style);

  /// Info color. `toggle-info`
  static const ToggleStyle info = ToggleStyle('toggle-info', type: StyleType.style);

  /// Error color. `toggle-error`
  static const ToggleStyle error = ToggleStyle('toggle-error', type: StyleType.style);

  // Sizes
  /// Extra-small size. `toggle-xs`
  static const ToggleStyle xs = ToggleStyle('toggle-xs', type: StyleType.sizing);

  /// Small size. `toggle-sm`
  static const ToggleStyle sm = ToggleStyle('toggle-sm', type: StyleType.sizing);

  /// Medium size (default). `toggle-md`
  static const ToggleStyle md = ToggleStyle('toggle-md', type: StyleType.sizing);

  /// Large size. `toggle-lg`
  static const ToggleStyle lg = ToggleStyle('toggle-lg', type: StyleType.sizing);

  /// Extra large size. `toggle-xl`
  static const ToggleStyle xl = ToggleStyle('toggle-xl', type: StyleType.sizing);
}

class _ToggleState extends StatefulUiComponentState<Toggle> {
  /// Generates a unique ID if one wasn't provided to find the element for JS interop.
  String get _elementId => component.id ?? 'toggle_${component.hashCode}';

  @override
  String get baseClass => component.baseClass;

  @override
  void initState() {
    super.initState();
    _updateIndeterminateState();
  }

  @override
  void didUpdateComponent(Toggle oldComponent) {
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
      checked: component.isChecked ? true : null,

      // Bind disabled state similarly
      disabled: component.disabled ? true : null,

      // Handle changes via callback
      onChange: (value) {
        // We assume the intent was to toggle the current state.
        component.onToggle?.call(!component.isChecked);
      },
    );
  }
}
