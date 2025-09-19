import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'tooltip.dart';

/// A marker interface for any utility that can be passed to a [Tooltip]'s
/// `style` list. This allows for type-safe application of styles for color,
/// placement, and behavior.
abstract class TooltipStyling implements Styling {}

/// Defines specific styling options for a [Tooltip] component.
///
/// This is the concrete implementation class for tooltip-specific modifiers.
/// It implements the [TooltipStyling] interface, making it a valid type for the
/// `style` property of a [Tooltip] component.
class TooltipStyle extends ComponentStyle<TooltipStyle>
    with Breakpoints<TooltipStyle>
    implements TooltipStyling {
  /// Constructs a [TooltipStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "tooltip-primary").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const TooltipStyle(super.cssClass, {required super.type, super.modifiers});

  /// Creates a new instance of [TooltipStyle] with the provided modifiers.
  @override
  TooltipStyle create(List<PrefixModifier> modifiers) {
    return TooltipStyle(cssClass, type: type, modifiers: modifiers);
  }
}
