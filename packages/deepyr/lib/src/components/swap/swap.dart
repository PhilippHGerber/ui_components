import 'package:jaspr/jaspr.dart' hide css;
import 'package:universal_web/web.dart';

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import 'swap_style.dart';

// Example for helpers, assuming Icon component exists
// import '../icon.dart'; // If Icon is a separate component in your library

/// A component that toggles between two visual states ("on" and "off")
/// when an internal checkbox is toggled. It can also represent an indeterminate state.
///
/// The `styles` list accepts [SwapStyling] (the interface) instances,
/// which includes specific swap animations (like [Swap.rotate]) and general utilities.
class Swap extends UiComponent {
  /// Creates a Swap component.
  ///
  /// - [onContent]: The [Component] to display when the swap is in the "on" (checked) state.
  /// - [offContent]: The [Component] to display when the swap is in the "off" (unchecked) state.
  /// - [tag]: The HTML tag for the root element, defaults to 'label' to associate with the internal checkbox.
  /// - [indeterminateContent]: Optional [Component] to display when the swap is in an indeterminate state.
  /// - [checked]: If true, the swap is initially in the "on" state.
  /// - [indeterminate]: If true, the swap is initially in the indeterminate state.
  ///   Note: An indeterminate checkbox is visually distinct but its value when submitted in a form is usually `false`.
  /// - [style]: A list of [SwapStyling] (the interface) instances.
  /// - [onToggle]: Callback function that is invoked when the swap state changes (checked/unchecked).
  ///   Receives the new checked state as a boolean.
  /// - Other parameters are inherited from [UiComponent].
  const Swap({
    required this.onContent,
    required this.offContent,
    super.tag = 'label',
    this.indeterminateContent,
    this.checked = false,
    this.indeterminate = false,
    List<SwapStyling>? style,
    this.onToggle,
    super.id, // ID for the label, can be used with 'for' if checkbox ID is known/set
    super.classes,
    super.css,
    super.attributes,
    super.onClick, // onClick on the label itself
    super.key,
  }) : super(
         null, // Children are managed internally in the build method
         style: style,
       );

  /// The content to display when the swap is in the "on" (checked) state.
  final Component onContent;

  /// The content to display when the "off" (unchecked) state.
  final Component offContent;

  /// Optional content to display when the swap is in an indeterminate state.
  final Component? indeterminateContent;

  /// Initial checked state.
  final bool checked;

  /// Initial indeterminate state.
  final bool indeterminate;

  /// Callback when the toggle state changes. `void Function(bool isChecked)`
  final ValueChanged<bool>? onToggle;

  @override
  String get baseClass => 'swap'; // DaisyUI base class

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);
    // The <label> tag for 'swap' doesn't typically require specific ARIA roles
    // beyond what its association with the checkbox provides.
    // If the checkbox ID were known and stable, `attributes.add('for', checkboxId)` could be set here.
    // However, managing the checkbox ID centrally can be tricky if `id` prop is for the label.

    // Check for active state modifier to potentially set aria-pressed or similar,
    // though 'swap-active' mainly controls visibility of on/off content via CSS.
    // final List<SwapStyleModifier> styleModifiers =
    //     this.modifiers?.whereType<SwapStyleModifier>().toList() ?? [];
    // if (styleModifiers.contains(Swap.active)) {
    //    // This state is usually controlled by the internal checkbox's :checked state
    // }
  }

  @override
  Swap copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Swap(
      onContent: onContent,
      offContent: offContent,
      tag: tag,
      indeterminateContent: indeterminateContent,
      checked: checked,
      indeterminate: indeterminate,
      style: style as List<SwapStyling>?,
      onToggle: onToggle,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      onClick: onClick,
      key: key ?? this.key,
    );
  }

  @override
  Component build(BuildContext context) {
    // Generate a unique ID for the checkbox if no main ID is provided for the label
    // to ensure the label's 'for' attribute (if used) could point to it.
    // However, direct nesting of the input within the label often makes 'for' unnecessary.
    final checkboxId = id != null ? '${id}_checkbox' : 'swap_checkbox_${key.hashCode}';

    final swapChildren = <Component>[
      // Hidden checkbox for controlling state.
      // The `onChange` handler for this input will trigger `onToggle`.
      input(
        type: InputType.checkbox,
        id: checkboxId, // ID for potential 'for' attribute on label
        attributes: <String, String>{
          if (checked && !indeterminate)
            'checked': '', // 'checked' attribute makes it visually checked
          // 'indeterminate' is a JS property, not an HTML attribute for initial state.
          // It needs to be set via JS after the element is in the DOM.
          // For a purely declarative Jaspr component, simulating indeterminate
          // visually might require CSS if JS manipulation is avoided here.
          // DaisyUI's `swap-indeterminate` class handles the visual state when `indeterminate` prop is true.
        },
        events: onToggle != null
            ? <String, EventCallback>{
                'change': (dynamic rawEvent) {
                  if (kIsWeb) {
                    final target = (rawEvent as Event).target! as HTMLInputElement;
                    onToggle!(target.checked);
                  }
                },
              }
            : null,
      ),

      // "On" state content
      div(classes: 'swap-on', <Component>[onContent]),

      // "Off" state content
      div(classes: 'swap-off', <Component>[offContent]),
    ];

    // Optional indeterminate state content. DaisyUI uses a sibling `swap-indeterminate`
    // and controls its visibility along with swap-on/off based on checkbox state
    // and potentially the presence of `swap-active` on the main `swap` element.
    // The `indeterminate` JS property on the checkbox is what truly makes it indeterminate.
    if (indeterminate && indeterminateContent != null) {
      swapChildren.add(div(classes: 'swap-indeterminate', <Component>[indeterminateContent!]));
    }

    return Component.element(
      tag: tag, // Should be 'label' for accessibility with the checkbox
      id: id,
      // If tag is 'label', 'for' attribute can be added to link to checkbox
      // attributes: tag == 'label' ? {'for': checkboxId, ...componentAttributes} : componentAttributes,
      // For simplicity, direct nesting of input in label usually works.
      // The `componentAttributes` getter will be called.
      attributes: componentAttributes,
      classes:
          combinedClasses, // Includes 'swap' and potentially 'swap-active' if `indeterminate` is true for styling
      styles: css,
      events: this.events, // For onClick on the label itself
      children: swapChildren,
    );
  }

  // --- Static Swap Modifiers (Type: SwapModifier interface, Instantiating: SwapStyleModifier) ---

  /// Applies if the swap is in the "on" state.
  /// Often controlled by the internal checkbox's `:checked` pseudo-class,
  /// but `swap-active` can be used to force the "on" state penampilan.
  /// If `indeterminate` is true, `swap-active` might also be needed for `swap-indeterminate` visibility.
  static const SwapStyle active = SwapStyle('swap-active', type: StyleType.state);

  // Animation effect modifiers
  /// Applies a rotation animation on toggle. `swap-rotate`
  static const SwapStyle rotate = SwapStyle(
    'swap-rotate',
    type: StyleType.effect,
  ); // Was .additional
  /// Applies a flip animation on toggle. `swap-flip`
  static const SwapStyle flip = SwapStyle(
    'swap-flip',
    type: StyleType.effect,
  ); // Was .additional
}
