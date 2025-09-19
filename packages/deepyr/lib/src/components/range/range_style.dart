import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'range.dart';

/// A marker interface for any utility that can be passed to a [Range]'s `style` list.
///
/// This allows for type-safe application of styles for colors and sizes.
abstract class RangeStyling implements Styling {}

/// Defines specific styling options for a [Range] component.
///
/// This is the concrete implementation class for range-specific modifiers.
/// It implements the [RangeStyling] interface, making it a valid type for the
/// `style` property of a [Range] component.
class RangeStyle extends ComponentStyle<RangeStyle>
    with Breakpoints<RangeStyle>
    implements RangeStyling {
  /// Constructs a [RangeStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "range-primary").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const RangeStyle(super.cssClass, {required super.type, super.modifiers});

  /// Creates a new instance of [RangeStyle] with the provided modifiers.
  @override
  RangeStyle create(List<PrefixModifier> modifiers) {
    return RangeStyle(cssClass, type: type, modifiers: modifiers);
  }
}
