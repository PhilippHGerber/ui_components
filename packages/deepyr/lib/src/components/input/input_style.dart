import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'input.dart';

/// A marker interface for any utility that can be passed to an [Input]'s `style` list.
///
/// This allows for type-safe application of styles for colors, sizes, and variants.
abstract class InputStyling implements Styling {}

/// Defines specific styling options for an [Input] component.
///
/// This is the concrete implementation class for input-specific modifiers.
/// It implements the [InputStyling] interface, making it a valid type for the
/// `style` property of an [Input] component.
class InputStyle extends ComponentStyle<InputStyle>
    with Breakpoints<InputStyle>
    implements InputStyling {
  /// Constructs an [InputStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "input-bordered").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const InputStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  /// Creates a new instance of [InputStyle] with the provided modifiers.
  @override
  InputStyle create(List<PrefixModifier> modifiers) {
    return InputStyle(cssClass, type: type, modifiers: modifiers);
  }
}
