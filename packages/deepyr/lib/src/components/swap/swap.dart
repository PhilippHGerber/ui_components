import 'package:jaspr/jaspr.dart';
import 'package:universal_web/web.dart' show HTMLInputElement, document;

import '../../base/stateful_ui_component.dart';
import '../../base/style_type.dart';
import '../../base/ui_component_attributes.dart';
import 'swap_style.dart';

/// A component that toggles between two visual states ("on" and "off") when clicked.
/// It can also represent a third, indeterminate state.
///
/// The `Swap` component wraps two or three elements and switches their visibility
/// based on a checkbox state or a CSS class.
///
/// `Swap` is a **controlled component**. Its state is not managed internally.
/// Instead, you must provide its current state via the [isOn] property and
/// handle state changes with the [onToggle] callback.
///
/// ### Example:
///
/// ```dart
/// Swap(
///   isOn: isDarkMode,
///   onToggle: (value) => setDarkMode(value),
///   onContent: Icon('dark_mode'),
///   offContent: Icon('light_mode'),
///   style: [Swap.rotate],
/// )
/// ```
class Swap extends StatefulUiComponent {
  /// Creates a controlled Swap component.
  ///
  /// - [onContent]: The component to display when `isOn` is true.
  /// - [offContent]: The component to display when `isOn` is false.
  /// - [isOn]: The current state of the swap. `true` shows [onContent], `false` shows [offContent].
  /// - [onToggle]: A callback that fires when the user clicks the component.
  /// - [indeterminate]: If `true`, shows [indeterminateContent] (if provided) or a mixed state.
  /// - [indeterminateContent]: Optional component to display when [indeterminate] is true.
  /// - [style]: A list of [SwapStyling] modifiers (e.g., `Swap.rotate`, `Swap.flip`).
  /// - [tag]: The HTML tag for the root element, defaults to 'label'.
  const Swap({
    required this.onContent,
    required this.offContent,
    this.isOn = false,
    this.onToggle,
    this.indeterminate = false,
    this.indeterminateContent,
    super.tag = 'label',
    List<SwapStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(null, style: style);

  /// The content to display when the swap is in the "on" (checked) state.
  final Component onContent;

  /// The content to display when the swap is in the "off" (unchecked) state.
  final Component offContent;

  /// Optional content to display when the swap is in an indeterminate state.
  final Component? indeterminateContent;

  /// The current state of the swap. `true` corresponds to the "on" state.
  final bool isOn;

  /// If true, the component will be in a visual indeterminate state.
  final bool indeterminate;

  /// A callback that is invoked with the new boolean state when the user
  /// interacts with the component.
  final ValueChanged<bool>? onToggle;

  @override
  String get baseClass => 'swap';

  @override
  State<Swap> createState() => _SwapState();

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    if (!attributes.build().containsKey('role')) {
      attributes.addRole('switch');
    }
  }

  /// Forces the "on" state to be active via CSS class, overriding the checkbox state.
  /// `swap-active`
  static const SwapStyle active = SwapStyle('swap-active', type: StyleType.state);

  /// Applies a rotation animation on toggle. `swap-rotate`
  static const SwapStyle rotate = SwapStyle('swap-rotate', type: StyleType.effect);

  /// Applies a flip animation on toggle. `swap-flip`
  static const SwapStyle flip = SwapStyle('swap-flip', type: StyleType.effect);
}

class _SwapState extends StatefulUiComponentState<Swap> {
  /// Generates a unique ID for the internal checkbox input.
  /// This is necessary to find the element in the DOM for the indeterminate state.
  String get _checkboxId =>
      component.id != null ? '${component.id}_input' : 'swap_input_${component.hashCode}';

  @override
  String get baseClass => component.baseClass;

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    // 1. Call super to run the Widget's configuration (adds role='switch')
    super.configureAttributes(attributes);

    // 2. Add dynamic state
    if (component.indeterminate) {
      attributes.addAria('checked', 'mixed');
    } else {
      attributes.addAria('checked', component.isOn.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _updateIndeterminateState();
  }

  @override
  void didUpdateComponent(Swap oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (oldComponent.indeterminate != component.indeterminate) {
      _updateIndeterminateState();
    }
  }

  /// Updates the JavaScript `indeterminate` property of the input element.
  /// This property cannot be set via HTML attributes.
  void _updateIndeterminateState() {
    if (!kIsWeb) return;

    // Schedule this after the build cycle to ensure the element exists.
    Future.delayed(Duration.zero, () {
      final input = document.getElementById(_checkboxId) as HTMLInputElement?;
      if (input != null) {
        input.indeterminate = component.indeterminate;
      }
    });
  }

  @override
  Component build(BuildContext context) {
    final indeterminateContent = component.indeterminateContent;

    return Component.element(
      tag: component.tag,
      id: component.id,
      classes: combinedClasses,
      styles: component.css,
      attributes: componentAttributes,
      events: eventMap,
      children: [
        // The hidden checkbox controls the state logic
        input(
          id: _checkboxId,
          type: InputType.checkbox,
          // checked attribute controls the visual state via CSS
          checked: component.isOn ? true : null,
          onChange: (dynamic value) {
            // In a controlled component, we toggle based on the current known state.
            component.onToggle?.call(!component.isOn);
          },
        ),

        div(classes: 'swap-on', [component.onContent]),
        div(classes: 'swap-off', [component.offContent]),

        if (indeterminateContent != null)
          div(classes: 'swap-indeterminate', [indeterminateContent]),
      ],
    );
  }
}
