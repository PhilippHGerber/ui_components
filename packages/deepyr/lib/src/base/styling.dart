import 'style_type.dart';
import 'ui_component.dart';
import 'ui_prefix_modifier.dart';

/// A base interface for all UI utility classes (modifiers).
///
/// This class defines the common contract for utility classes, allowing them to be
/// used polymorphically, for example, in a list of modifiers for a [UiComponent].
/// It ensures that every utility class can provide its CSS class string, its type,
/// and any applied prefix modifiers.
abstract interface class Styling {
  /// The core CSS class name of this utility (e.g., "btn-primary", "text-lg").
  /// This does not include any [PrefixModifier]s.
  String get cssClass;

  /// The category or type of this utility class (e.g., sizing, layout, style).
  StyleType get type;

  /// An optional list of [PrefixModifier]s (like 'hover:', 'md:') applied to this utility.
  /// Returns `null` or an empty list if no prefixes are applied.
  List<PrefixModifier>? get modifiers;

  /// Returns the string representation of this utility class, including any
  /// applied [PrefixModifier]s.
  /// For example, if `cssClass` is "text-blue-500" and `modifiers` contains
  /// a `hover` prefix, this might return "hover:text-blue-500".
  @override
  String toString();
}
