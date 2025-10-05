import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'list.dart' show ListCol, ListRow, Listing;

// --- Marker Interfaces for Type Safety ---

/// A marker interface for any utility that can be passed to a [Listing]'s `style` list.
abstract class ListingStyling implements Styling {}

/// A marker interface for any utility that can be passed to a [ListRow]'s `style` list.
abstract class ListRowStyling implements Styling {}

/// A marker interface for any utility that can be passed to a [ListCol]'s `style` list.
abstract class ListColStyling implements Styling {}

// --- Concrete Style Classes (Only for components with unique modifiers) ---

/// Defines specific styling options for a [Listing] container, like adding borders between items.
class ListingStyle extends ComponentStyle<ListingStyle>
    with Breakpoints<ListingStyle>
    implements ListingStyling {
  const ListingStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  ListingStyle create(List<PrefixModifier> modifiers) {
    return ListingStyle(cssClass, type: type, modifiers: modifiers);
  }
}

/// Defines specific layout options for a [ListCol] component, controlling its flex and grid behavior.
class ListColStyle extends ComponentStyle<ListColStyle>
    with Breakpoints<ListColStyle>
    implements ListColStyling {
  const ListColStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  ListColStyle create(List<PrefixModifier> modifiers) {
    return ListColStyle(cssClass, type: type, modifiers: modifiers);
  }
}
