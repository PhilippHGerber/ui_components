import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'tabs.dart';

/// Marker interface for any utility that can be passed to an individual [Tab]'s `modifiers` list.
abstract class TabStyling implements Styling {}

/// Defines specific styling and state options for an individual [Tab] component.
/// Implements the [TabStyling] interface.
class TabStyle extends ComponentStyle<TabStyle>
    with Breakpoints<TabStyle>
    implements TabStyling {
  // Implements the TabModifier INTERFACE
  const TabStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  TabStyle create(List<PrefixModifier> modifiers) {
    return TabStyle(cssClass, type: type, modifiers: modifiers);
  }
}
