import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'tabs.dart';

/// Marker interface for utilities passed to [Tabs].
abstract class TabsStyling implements Styling {}

/// Defines styling options for [Tabs].
class TabsStyle extends ComponentStyle<TabsStyle>
    with Breakpoints<TabsStyle>
    implements TabsStyling {
  const TabsStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  TabsStyle create(List<PrefixModifier> modifiers) {
    return TabsStyle(cssClass, type: type, modifiers: modifiers);
  }
}
