import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'drawer.dart';

/// Marker interface for any utility that can be passed to a [Drawer]'s `modifiers` list.
abstract class DrawerStyling implements Styling {}

/// Defines specific styling, sizing, and behavioral options for a [Drawer] container component.
/// Implements the [DrawerStyling] interface.
class DrawerStyle extends ComponentStyle<DrawerStyle>
    with Breakpoints<DrawerStyle>
    implements DrawerStyling {
  const DrawerStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  DrawerStyle create(List<PrefixModifier> modifiers) {
    return DrawerStyle(cssClass, type: type, modifiers: modifiers);
  }
}
