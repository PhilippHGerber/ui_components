import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'select.dart';

/// A marker interface for any utility that can be passed to a [Select]'s `style` list.
///
/// This allows for type-safe application of styles for colors, sizes, and variants.
abstract class SelectStyling implements Styling {}

/// Defines specific styling options for a [Select] component.
///
/// This is the concrete implementation class for select-specific modifiers.
/// It implements the [SelectStyling] interface, making it a valid type for the
/// `style` property of a [Select] component.
class SelectStyle extends ComponentStyle<SelectStyle>
    with Breakpoints<SelectStyle>
    implements SelectStyling {
  /// Constructs a [SelectStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "select-bordered").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const SelectStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  /// Creates a new instance of [SelectStyle] with the provided modifiers.
  @override
  SelectStyle create(List<PrefixModifier> modifiers) {
    return SelectStyle(cssClass, type: type, modifiers: modifiers);
  }
}
