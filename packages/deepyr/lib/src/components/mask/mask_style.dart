import '../../base/component_style.dart';
import '../../base/style_type.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'mask.dart';

/// A marker interface for any utility that can be passed to a [Mask]'s `style` list.
///
/// This allows for type-safe application of styles. Both component-specific styles
/// (like [MaskStyle]) and applicable general utilities can implement this interface.
abstract class MaskStyling implements Styling {}

/// Defines the shape and behavior for a [Mask] component.
///
/// This is the concrete implementation class for mask-specific modifiers.
/// It implements the [MaskStyling] interface, making it a valid type for the
/// `style` property of a [Mask] component.
class MaskStyle extends ComponentStyle<MaskStyle>
    with Breakpoints<MaskStyle>
    implements MaskStyling {
  /// Constructs a [MaskStyle].
  ///
  /// - [cssClass]: The core CSS class string for this modifier (e.g., "mask-heart").
  /// - [type]: The [StyleType] categorizing this modifier.
  /// - [modifiers]: An optional list of [PrefixModifier]s for responsive styling.
  const MaskStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  MaskStyle create(List<PrefixModifier> modifiers) {
    return MaskStyle(cssClass, type: type, modifiers: modifiers);
  }
}
