import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'radial_progress.dart';

/// A marker interface for any utility that can be passed to a [RadialProgress]'s
/// `style` list.
///
/// `RadialProgress` has no specific modifiers; this interface is used to allow
/// general utilities (like `TextUtil` for color) to be applied to it.
abstract class RadialProgressStyling implements Styling {}

/// Defines specific styling options for a [RadialProgress] component.
///
/// This is the concrete implementation class for component-specific modifiers.
/// It implements the [RadialProgressStyling] interface. Currently, there are no
/// predefined static modifiers for `RadialProgress`.
class RadialProgressStyle extends ComponentStyle<RadialProgressStyle>
    with Breakpoints<RadialProgressStyle>
    implements RadialProgressStyling {
  /// Constructs a [RadialProgressStyle].
  const RadialProgressStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  RadialProgressStyle create(List<PrefixModifier> modifiers) {
    return RadialProgressStyle(cssClass, type: type, modifiers: modifiers);
  }
}
