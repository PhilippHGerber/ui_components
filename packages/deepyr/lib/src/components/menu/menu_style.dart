import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'menu.dart';

/// Marker interface for any utility that can be passed to a [Menu]'s `modifiers` list.
abstract class MenuStyling implements Styling {}

/// Defines specific styling, sizing, and layout options for a [Menu] container component.
/// Implements the [MenuStyling] interface.
class MenuStyle extends ComponentStyle<MenuStyle>
    with Breakpoints<MenuStyle>
    implements MenuStyling {
  const MenuStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  MenuStyle create(List<PrefixModifier> modifiers) {
    return MenuStyle(cssClass, type: type, modifiers: modifiers);
  }
}
