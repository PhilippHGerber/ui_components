import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'card.dart';

/// Marker interface for any utility that can be passed to a [Card]'s `modifiers` list.
abstract class CardStyling implements Styling {}

/// Defines specific styling options for a [Card] component.
/// Implements the [CardStyling] interface.
class CardStyle extends ComponentStyle<CardStyle>
    with Breakpoints<CardStyle>
    implements CardStyling {
  // Implements the CardModifier INTERFACE
  const CardStyle(super.cssClass, {required super.type, super.modifiers});

  @override
  CardStyle create(List<PrefixModifier> modifiers) {
    return CardStyle(cssClass, type: type, modifiers: modifiers);
  }
}
