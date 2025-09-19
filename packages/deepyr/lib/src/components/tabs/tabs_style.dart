import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'tabs.dart';

/// Marker interface for any utility that can be passed to a [Tabs]'s `modifiers` list.
abstract class TabsStyling implements Styling {}

/// Defines specific styling and sizing options for a [Tabs] container component.
/// Implements the [TabsStyling] interface.
class TabsStyle extends ComponentStyle<TabsStyle>
    with Breakpoints<TabsStyle>
    implements TabsStyling {
  // Implements the TabsModifier INTERFACE
  const TabsStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  TabsStyle create(List<PrefixModifier> modifiers) {
    return TabsStyle(cssClass, type: type, modifiers: modifiers);
  }
}
