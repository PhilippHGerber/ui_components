import '../../base/component_style.dart';
import '../../base/styling.dart';
import '../../base/ui_prefix_modifier.dart';
import 'indicator.dart';

/// A marker interface for any utility that can be passed to an [Indicator]'s `style` list.
abstract class IndicatorStyling implements Styling {}

/// Defines specific styling options for an [Indicator] container, such as the
/// position of its indicator items.
class IndicatorStyle extends ComponentStyle<IndicatorStyle>
    with Breakpoints<IndicatorStyle>
    implements IndicatorStyling {
  /// Constructs an [IndicatorStyle].
  const IndicatorStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  @override
  IndicatorStyle create(List<PrefixModifier> modifiers) {
    return IndicatorStyle(cssClass, type: type, modifiers: modifiers);
  }
}

/// A marker interface for any utility that can be passed to an [IndicatorItem]'s `style` list.
abstract class IndicatorItemStyling implements Styling {}

/// Defines specific styling options for an [IndicatorItem], primarily its position
/// relative to the parent [Indicator] container.
class IndicatorItemStyle extends ComponentStyle<IndicatorItemStyle>
    with Breakpoints<IndicatorItemStyle>
    implements IndicatorItemStyling {
  /// Constructs an [IndicatorItemStyle].
  const IndicatorItemStyle(
    super.cssClass, {
    required super.type,
    super.modifiers,
  });

  @override
  IndicatorItemStyle create(List<PrefixModifier> modifiers) {
    return IndicatorItemStyle(cssClass, type: type, modifiers: modifiers);
  }
}
