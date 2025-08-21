import 'base_style.dart';
import 'component_stylings.dart';
import 'style_type.dart';
import 'ui_prefix_modifier.dart';

/// Base class for groups of general utility classes (e.g., `Typography`, `Spacing`, `Effects`).
///
/// These utilities represent common styling patterns applicable across various components.
/// They extend [BaseStyle] to inherit its fluent API for applying [PrefixModifier]s
/// and implement multiple component-specific modifier interfaces.
/// This allows instances of `UtilityGroup` subclasses to be
/// passed to the `modifiers` list of any component that expects its corresponding
/// modifier interface, enabling a flexible and type-safe styling mechanism.
///
/// Type parameter:
///   `T`: The concrete type of the utility group itself (e.g., `Typography` for
///        typography utilities), ensuring methods like `on()` and `at()` return
///        the correct specific type.
abstract class CommonStyle<T extends CommonStyle<T>> extends BaseStyle<T>
    implements AllComponentStylings {
  /// Constructs a [CommonStyle].
  ///
  /// [cssClass]: The core CSS class string (e.g., "text-lg", "mt-4").
  /// [type]: The [StyleType] categorizing this utility (e.g., typography, spacing).
  /// [modifiers]: An optional list of [PrefixModifier]s already applied.
  const CommonStyle(super.cssClass, {required super.type, super.modifiers});

  // The `create(List<PrefixModifier> modifiers)` method must still be
  // implemented by concrete subclasses of UtilityGroup (e.g., Typography, Spacing).
  // Example in a subclass like `Spacing`:
  // @override
  // Spacing create(List<PrefixModifier> modifiers) {
  //   return Spacing(cssClass, modifiers: modifiers);
  // }
}

// Typografie-Gruppe für alle text-bezogenen Stile

// Layout-Gruppe für Positionierung und Anordnung

// Farben und Hintergründe
class Colors extends CommonStyle<Colors> {
  const Colors(super.cssClass, {super.modifiers}) : super(type: StyleType.style);

  static const bgPrimary = Colors('bg-primary');
  static const textPrimary = Colors('text-primary');
  static const borderPrimary = Colors('border-primary');

  @override
  Colors create(List<PrefixModifier> modifiers) {
    // Create a new instance with the original cssClass and new modifiers
    return Colors(cssClass, modifiers: modifiers);
  }
}
