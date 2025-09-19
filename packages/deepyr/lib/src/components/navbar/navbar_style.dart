import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'navbar.dart';

/// Marker interface for any utility that can be passed to a [Navbar]'s `modifiers` list.
abstract class NavbarStyling implements Styling {}

/// Defines specific styling or behavioral options for a [Navbar] container component,
/// if any are introduced by DaisyUI beyond its base class.
/// Implements the [NavbarStyling] interface.
class NavbarStyle extends ComponentStyle<NavbarStyle>
    with Breakpoints<NavbarStyle>
    implements NavbarStyling {
  const NavbarStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  NavbarStyle create(List<PrefixModifier> modifiers) {
    return NavbarStyle(cssClass, type: type, modifiers: modifiers);
  }
}
