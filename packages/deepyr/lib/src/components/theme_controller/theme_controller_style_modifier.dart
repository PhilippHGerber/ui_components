import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'theme_controller.dart';

/// Marker interface for any utility that can be passed to a [ThemeController]'s `modifiers` list.
abstract class ThemeControllerStyling implements Styling {}

/// Defines specific styling options for a [ThemeController] component,
/// such as rendering it as a toggle or a button.
/// Implements the [ThemeControllerStyling] interface.
class ThemeControllerStyle extends ComponentStyle<ThemeControllerStyle>
    with Breakpoints<ThemeControllerStyle>
    implements ThemeControllerStyling {
  const ThemeControllerStyle(super.cssClass,
      {required super.type, super.modifiers});

  @override
  ThemeControllerStyle create(List<PrefixModifier> modifiers) {
    return ThemeControllerStyle(cssClass, type: type, modifiers: modifiers);
  }
}
