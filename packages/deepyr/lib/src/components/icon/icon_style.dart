import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'icon.dart';

/// Marker interface for any utility that can be passed to an [Icon]'s `modifiers` list.
abstract class IconStyling implements Styling {}

/// Defines specific styling options for an [Icon] component,
/// such as fill state or font weight, often specific to the icon font being used.
/// Implements the [IconStyling] interface.
class IconStyle extends ComponentStyle<IconStyle>
    with Breakpoints<IconStyle>
    implements IconStyling {
  // Implements the IconModifier INTERFACE
  const IconStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  IconStyle create(List<PrefixModifier> modifiers) {
    return IconStyle(cssClass, type: type, modifiers: modifiers);
  }
}
