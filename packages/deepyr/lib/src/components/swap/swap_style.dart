import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'swap.dart';

/// Marker interface for any utility that can be passed to a [Swap]'s `modifiers` list.
abstract class SwapStyling implements Styling {}

/// Defines specific styling, animation, and state options for a [Swap] component.
/// Implements the [SwapStyling] interface.
class SwapStyle extends ComponentStyle<SwapStyle>
    with Breakpoints<SwapStyle>
    implements SwapStyling {
  const SwapStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  SwapStyle create(List<PrefixModifier> modifiers) {
    return SwapStyle(cssClass, type: type, modifiers: modifiers);
  }

  // Static constants will be moved to the Swap class.
}
