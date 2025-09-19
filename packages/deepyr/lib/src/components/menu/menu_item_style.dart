import '../../../deepyr.dart' show MenuItem, MenuTitle;
import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'menu.dart' show MenuItem, MenuTitle;

/// Marker interface for any utility that can be passed to a menu item's
/// (like [MenuItem], [MenuTitle]) `modifiers` list.
abstract class MenuItemStyling implements Styling {}

/// Defines specific styling and state options for menu items (`<li>` tags).
/// Implements the [MenuItemStyling] interface.
class MenuItemStyle extends ComponentStyle<MenuItemStyle>
    with Breakpoints<MenuItemStyle>
    implements MenuItemStyling {
  const MenuItemStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  @override
  MenuItemStyle create(List<PrefixModifier> modifiers) {
    return MenuItemStyle(cssClass, type: type, modifiers: modifiers);
  }
}
