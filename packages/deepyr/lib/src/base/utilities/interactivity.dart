import '../common_style.dart';
import '../style_type.dart';
import '../styling.dart';
import '../ui_prefix_modifier.dart';

/// A marker interface for any utility that can be passed to a component's `style` list.
abstract class InteractivityStyling implements Styling {}

/// A utility class for applying interactivity styles.
class Interactivity extends CommonStyle<Interactivity> implements InteractivityStyling {
  const Interactivity(super.cssClass, {super.modifiers})
      : super(type: StyleType.interactive);

  @override
  Interactivity create(List<PrefixModifier> modifiers) {
    return Interactivity(cssClass, modifiers: modifiers);
  }

  /// `cursor-pointer`
  static const Interactivity cursorPointer = Interactivity('cursor-pointer');

  /// `pointer-events-none`
  static const Interactivity pointerEventsNone = Interactivity('pointer-events-none');

  /// `pointer-events-auto`
  static const Interactivity pointerEventsAuto = Interactivity('pointer-events-auto');
}
