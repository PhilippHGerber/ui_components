import 'package:jaspr/jaspr.dart' show Key, Styles;

import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import '../../base/ui_component_attributes.dart';
import 'button_style.dart';

/// Defines the valid HTML `type` attributes for a button element.
enum ButtonHtmlType {
  /// The button submits the form data to the server. This is the default if the
  /// attribute is not specified for buttons associated with a `<form>`,
  /// or if the attribute is an empty or invalid value.
  submit('submit'),

  /// The button resets all the controls to their initial values.
  reset('reset'),

  /// The button has no default behavior and does nothing when pressed by default.
  /// It can have client-side scripts listen to the element's events.
  /// This is the default if the `tag` is `<button>` and no `htmlType` is provided.
  button('button');

  const ButtonHtmlType(this.value);

  final String value;

  @override
  String toString() => value;
}

/// A clickable button component, used for actions in forms, dialogs, and more.
///
/// It can be rendered using different HTML tags (defaulting to `<button>`) and
/// styled with a variety of modifiers for color, size, shape, and state.
class Button extends UiComponent {
  /// Creates a Button component.
  ///
  /// - [children] or [child]: The content of the button (e.g., text, an icon).
  /// - [tag]: The HTML tag to use for the button, defaults to 'button'.
  /// - [htmlType]: The HTML 'type' attribute (e.g., submit, reset, button).
  ///   Relevant if `tag` is 'button'.
  /// - [role]: The ARIA role. Defaults to 'button' if `tag` is not '<button>' or
  ///   if a more specific button-like role (e.g., 'menuitem') is not provided.
  /// - [style]: A list of [ButtonStyling] (the interface) instances.
  /// - Other parameters are inherited from [UiComponent].
  const Button(
    super.children, {
    super.tag = 'button',
    this.htmlType,
    this.role,
    List<ButtonStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.onClick,
    super.child,
    super.key,
  }) : super(style: style);

  /// The HTML 'type' attribute for the button.
  /// If the [tag] is 'button' and [htmlType] is null, it defaults to `ButtonHtmlType.button`.
  final ButtonHtmlType? htmlType;

  /// The ARIA role for the component.
  final String? role;

  @override
  String get baseClass => 'btn';

  @override
  void configureAttributes(UiComponentAttributes attributes) {
    super.configureAttributes(attributes);

    // 1. Set the HTML 'type' attribute
    if (tag == 'button') {
      attributes.add('type', (htmlType ?? ButtonHtmlType.button).value);
    } else if (htmlType != null) {
      // Allow type for other tags if specified, though less common for non-button tags.
      attributes.add('type', htmlType!.value);
    }

    // 2. Set the ARIA 'role' attribute
    if (role != null) {
      attributes.addRole(role!);
    } else if (tag != 'button' && tag != 'input') {
      // Inputs have implicit roles
      // Add role="button" if it's an anchor or div styled as a button
      attributes.addRole('button');
    }

    // 3. Handle disabled state:
    //    - If user provides 'disabled' in attributes, it takes precedence.
    //    - If `ButtonStyleModifier.disabled` is present, set HTML 'disabled' attribute
    //      and ARIA attributes for class-based disabling.
    final isDisabledByAttribute = userProvidedAttributes.containsKey('disabled');
    final isDisabledByStyle = style?.any(
          (styling) => styling is ButtonStyling && styling.cssClass == Button.disabled.cssClass,
        ) ??
        false;

    if (isDisabledByStyle && !isDisabledByAttribute) {
      attributes
        ..add('disabled', '')
        ..add('tabindex', '-1')
        ..addAria('disabled', 'true');
    } else if (isDisabledByAttribute) {
      // If native 'disabled' attribute is set by user, ARIA roles might not be strictly
      // necessary as browsers handle it, but adding them doesn't hurt.
      if (userProvidedAttributes['disabled'] != 'false') {
        // Ensure it's not explicitly false
        attributes.addAria('disabled', 'true');
      }
    }
  }

  @override
  Button copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Button(
      children, // or this.child
      tag: tag,
      htmlType: htmlType,
      role: role,
      style: style as List<ButtonStyling>?,
      onClick: onClick,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      key: key ?? this.key,
      child: child,
    );
  }
  // --- Static Button Modifiers ---

  /// Neutral button style. `btn-neutral`
  static const ButtonStyle neutral = ButtonStyle(
    'btn-neutral',
    type: StyleType.style,
  );

  /// Primary button style. `btn-primary`
  static const ButtonStyle primary = ButtonStyle(
    'btn-primary',
    type: StyleType.style,
  );

  /// Secondary button style. `btn-secondary`
  static const ButtonStyle secondary = ButtonStyle(
    'btn-secondary',
    type: StyleType.style,
  );

  /// Accent button style. `btn-accent`
  static const ButtonStyle accent = ButtonStyle(
    'btn-accent',
    type: StyleType.style,
  );

  /// Info button style. `btn-info`
  static const ButtonStyle info = ButtonStyle(
    'btn-info',
    type: StyleType.style,
  );

  /// Success button style. `btn-success`
  static const ButtonStyle success = ButtonStyle(
    'btn-success',
    type: StyleType.style,
  );

  /// Warning button style. `btn-warning`
  static const ButtonStyle warning = ButtonStyle(
    'btn-warning',
    type: StyleType.style,
  );

  /// Error button style. `btn-error`
  static const ButtonStyle error = ButtonStyle(
    'btn-error',
    type: StyleType.style,
  );

  // Styles
  /// Outline button style. `btn-outline`
  static const ButtonStyle outline = ButtonStyle(
    'btn-outline',
    type: StyleType.style,
  ); // Was .border

  /// Dash button style. `btn-dash` (New in DaisyUI 5)
  static const ButtonStyle dash = ButtonStyle(
    'btn-dash',
    type: StyleType.style,
  );

  /// Soft button style. `btn-soft` (New in DaisyUI 5)
  static const ButtonStyle soft = ButtonStyle(
    'btn-soft',
    type: StyleType.style,
  );

  /// Ghost button style (transparent background). `btn-ghost`
  static const ButtonStyle ghost = ButtonStyle(
    'btn-ghost',
    type: StyleType.style,
  );

  /// Link button style (looks like a hyperlink). `btn-link`
  static const ButtonStyle link = ButtonStyle(
    'btn-link',
    type: StyleType.style,
  );

  // Behavior modifiers
  /// Active button state (appears pressed). `btn-active`
  static const ButtonStyle active = ButtonStyle(
    'btn-active',
    type: StyleType.state,
  );

  /// Disabled button state (styles the button as disabled). `btn-disabled`
  /// The HTML 'disabled' attribute and ARIA attributes will also be managed by `configureAttributes`.
  static const ButtonStyle disabled = ButtonStyle(
    'btn-disabled',
    type: StyleType.state,
  );

  // Size modifiers
  /// Extra small button size. `btn-xs`
  static const ButtonStyle xs = ButtonStyle(
    'btn-xs',
    type: StyleType.sizing,
  );

  /// Small button size. `btn-sm`
  static const ButtonStyle sm = ButtonStyle(
    'btn-sm',
    type: StyleType.sizing,
  );

  /// Medium button size (default). `btn-md`
  static const ButtonStyle md = ButtonStyle(
    'btn-md',
    type: StyleType.sizing,
  );

  /// Large button size. `btn-lg`
  static const ButtonStyle lg = ButtonStyle(
    'btn-lg',
    type: StyleType.sizing,
  );

  /// Extra large button size. `btn-xl` (New in DaisyUI 5)
  static const ButtonStyle xl = ButtonStyle(
    'btn-xl',
    type: StyleType.sizing,
  );

  // General modifiers
  /// Wide button style (takes more horizontal space). `btn-wide`
  static const ButtonStyle wide = ButtonStyle(
    'btn-wide',
    type: StyleType.additional,
  );

  /// Block level button style (takes full width of its parent). `btn-block`
  static const ButtonStyle block = ButtonStyle(
    'btn-block',
    type: StyleType.additional,
  );

  /// Square button shape. `btn-square`
  static const ButtonStyle square = ButtonStyle(
    'btn-square',
    type: StyleType.form,
  );

  /// Circle button shape. `btn-circle`
  static const ButtonStyle circle = ButtonStyle(
    'btn-circle',
    type: StyleType.form,
  );
}
