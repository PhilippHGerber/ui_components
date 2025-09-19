import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'validator_hint.dart';

/// A marker interface for any utility that can be passed to a [ValidatorHint]'s
/// `style` list.
///
/// This allows for type-safe application of styles. `ValidatorHint` currently
/// has no specific modifiers of its own, so this is used for applying general
/// utilities like `Layout.hidden`.
abstract class ValidatorHintStyling implements Styling {}

/// Defines specific styling options for a [ValidatorHint] component.
///
/// This is the concrete implementation class for validator hint-specific modifiers.
/// It implements the [ValidatorHintStyling] interface. Currently, there are no
/// predefined static modifiers for `ValidatorHint`.
class ValidatorHintStyle extends ComponentStyle<ValidatorHintStyle>
    with Breakpoints<ValidatorHintStyle>
    implements ValidatorHintStyling {
  /// Constructs a [ValidatorHintStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier.
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const ValidatorHintStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  /// Creates a new instance of [ValidatorHintStyle] with the provided modifiers.
  @override
  ValidatorHintStyle create(List<PrefixModifier> modifiers) {
    return ValidatorHintStyle(cssClass, type: type, modifiers: modifiers);
  }
}
