import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'countdown.dart';

/// A marker interface for any utility that can be passed to a [Countdown]'s
/// `style` list.
///
/// `Countdown` has no specific modifiers of its own; this interface is used
/// to allow general utilities (like `FontUtil`, `TextUtil`, etc.) to be applied to it.
abstract class CountdownStyling implements Styling {}

/// Defines specific styling options for a [Countdown] component.
///
/// This is the concrete implementation class for countdown-specific modifiers.
/// It implements the [CountdownStyling] interface. Currently, there are no
/// predefined static modifiers for `Countdown`.
class CountdownStyle extends ComponentStyle<CountdownStyle>
    with Breakpoints<CountdownStyle>
    implements CountdownStyling {
  /// Constructs a [CountdownStyle].
  const CountdownStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  CountdownStyle create(List<PrefixModifier> modifiers) {
    return CountdownStyle(cssClass, type: type, modifiers: modifiers);
  }
}
