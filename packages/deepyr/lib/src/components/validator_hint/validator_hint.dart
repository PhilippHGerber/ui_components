import 'package:jaspr/jaspr.dart' show Key, Styles;

import '../../base/ui_component.dart';
import 'validator_hint_style.dart';

/// A component that displays a validation message for a form field.
///
/// It renders as a `<p>` element with the `validator-hint` base class.
/// According to DaisyUI's CSS, this hint will be invisible by default when
/// placed after an element with the `validator` class, and will become visible
/// automatically when that element becomes invalid (e.g., via the `:invalid`
/// pseudo-class).
class ValidatorHint extends UiComponent {
  /// Creates a ValidatorHint component.
  ///
  /// - [children] or [child]: The validation message to display.
  /// - [tag]: The HTML tag for the root element, defaults to 'p' for semantic
  ///   appropriateness as a descriptive message.
  /// - [style]: A list of [ValidatorHintStyling] instances. For example, use
  ///   `[Layout.hidden]` to prevent the hint from occupying space when invisible.
  /// - Other parameters are inherited from [UiComponent].
  const ValidatorHint(
    super.children, {
    super.tag = 'p',
    List<ValidatorHintStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.child,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'validator-hint';

  @override
  ValidatorHint copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return ValidatorHint(
      children,
      tag: tag,
      style: style as List<ValidatorHintStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      child: child,
      key: key ?? this.key,
    );
  }
}
