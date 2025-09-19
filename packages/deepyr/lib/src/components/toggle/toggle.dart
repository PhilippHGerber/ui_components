import 'package:jaspr/jaspr.dart'
    show BuildContext, Component, EventCallback, Key, Styles, ValueChanged, kIsWeb;
import 'package:universal_web/web.dart' show Event, HTMLInputElement;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import '../../base/ui_events.dart';
import 'toggle_style.dart';

/// A checkbox styled to look like a switch button.
///
/// The `Toggle` is a **controlled component**. Its state is not managed internally.
/// Instead, you must provide its current state via the [isChecked] property and
/// handle state changes with the [onToggle] callback. This ensures that the UI
/// is always a direct reflection of your application's state.
///
/// Example of state management in a `StatefulComponent`:
/// ```dart
/// class MySettings extends StatefulComponent {
///   bool _notificationsEnabled = true;
///
///   @override
///   State<MySettings> createState() => _MySettingsState();
/// }
///
/// class _MySettingsState extends State<MySettings> {
///   @override
///   Component build(BuildContext context) {
///     return Toggle(
///       isChecked: _notificationsEnabled,
///       onToggle: (newValue) {
///         setState(() => _notificationsEnabled = newValue);
///       },
///       style: [Toggle.primary],
///     );
///   }
/// }
/// ```
class Toggle extends UiComponent {
  /// Creates a Toggle component.
  ///
  /// - [isChecked]: The current checked state of the toggle.
  /// - [onToggle]: A callback that fires when the user clicks the toggle. It
  ///   receives the new potential boolean state. You should use this callback
  ///   to update your application's state.
  /// - [disabled]: If true, the toggle will be non-interactive.
  /// - [indeterminate]: If true, the toggle will be in an indeterminate state.
  ///   **Note:** This property must be managed via JavaScript after the component has
  ///   rendered. See the documentation for an example.
  /// - [style]: A list of [ToggleStyling] instances for styling.
  /// - Other parameters are inherited from [UiComponent].
  const Toggle({
    this.isChecked = false,
    this.onToggle,
    this.disabled = false,
    this.indeterminate = false,
    super.tag = 'input',
    List<ToggleStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null, style: style); // Toggle elements have no children.

  /// The current checked state of the toggle.
  final bool isChecked;

  /// Callback function invoked when the toggle's state changes.
  final ValueChanged<bool>? onToggle;

  /// If true, the toggle is non-interactive.
  final bool disabled;

  /// If true, the toggle will be in an indeterminate state.
  /// This is a visual state that is not submitted with the form value and must
  /// be set via JavaScript after the element has rendered.
  final bool indeterminate;

  @override
  String get baseClass => 'toggle';

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
  Toggle copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Toggle(
      isChecked: isChecked,
      onToggle: onToggle,
      disabled: disabled,
      indeterminate: indeterminate,
      tag: tag,
      style: style as List<ToggleStyling>?,
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
    // Start with the standard events from the base class.
    final eventMap = Map<String, EventCallback>.from(events);

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
      // A toggle has no children.
    );
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
