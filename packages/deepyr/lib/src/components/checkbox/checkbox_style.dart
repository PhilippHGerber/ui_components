import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'checkbox.dart';

/// A marker interface for any utility that can be passed to a [Checkbox]'s `style` list.
///
/// This allows for type-safe application of styles for colors and sizes.
abstract class CheckboxStyling implements Styling {}

/// Defines specific styling options for a [Checkbox] component.
///
/// This is the concrete implementation class for checkbox-specific modifiers.
/// It implements the [CheckboxStyling] interface, making it a valid type for the
/// `style` property of a [Checkbox] component.
class CheckboxStyle extends ComponentStyle<CheckboxStyle>
    with Breakpoints<CheckboxStyle>
    implements CheckboxStyling {
  /// Constructs a [CheckboxStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "checkbox-primary").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const CheckboxStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  /// Creates a new instance of [CheckboxStyle] with the provided modifiers.
  @override
  CheckboxStyle create(List<PrefixModifier> modifiers) {
    return CheckboxStyle(cssClass, type: type, modifiers: modifiers);
  }
}
