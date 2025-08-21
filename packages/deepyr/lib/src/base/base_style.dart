import 'style_type.dart';
import 'styling.dart';
import 'ui_prefix_modifier.dart';

/// An abstract generic class representing a UI utility class (modifier).
///
/// This class provides a foundation for creating type-safe utility classes
/// that can be combined with [PrefixModifier]s (e.g., for responsive or state-based styling).
/// It implements [Styling] to be usable in heterogeneous lists of modifiers
/// and [Comparable] to allow sorting of utilities of the same specific type `T`.
///
/// Type parameter:
///   `T`: The concrete type of the utility class itself, enabling fluent chaining
///        methods like `on()` and `at()` to return the correct specific type.
abstract class BaseStyle<T extends BaseStyle<T>>
    implements Styling, Comparable<T> {
  /// Constructs a [BaseStyle].
  ///
  /// [cssClass]: The core CSS class string (e.g., "text-center").
  /// [type]: The [StyleType] categorizing this utility.
  /// [modifiers]: An optional list of [PrefixModifier]s already applied.
  const BaseStyle(this.cssClass, {required this.type, this.modifiers});

  @override
  final String cssClass;

  @override
  final StyleType type;

  @override
  final List<PrefixModifier>? modifiers;

  /// Abstract factory method to create a new instance of this utility class (`T`)
  /// with a given list of [PrefixModifier]s.
  ///
  /// This method must be implemented by concrete subclasses to ensure that
  /// methods like `on()` and `at()` can return the correct specific type `T`.
  T create(List<PrefixModifier> modifiers);

  /// Applies a list of [PrefixModifier]s to this utility class.
  ///
  /// Returns a new instance of `T` with the combined prefixes.
  /// If this utility already has prefixes, the new ones are appended.
  T on(List<PrefixModifier> prefixModifiers) {
    // Ensure existing modifiers are preserved and new ones are added.
    // Handle null or empty existing modifiers.
    final existingModifiers = this.modifiers ?? [];
    return create([...existingModifiers, ...prefixModifiers]);
  }

  /// Applies a single responsive breakpoint [PrefixModifier] to this utility class.
  ///
  /// If the provided [breakpoint] is not of type [PrefixModifierType.breakpoint],
  /// `this` instance is returned unchanged. Otherwise, a new instance of `T`
  /// with the breakpoint prefix applied is returned.
  T at(PrefixModifier breakpoint) {
    if (breakpoint.type == PrefixModifierType.breakpoint) {
      final existingModifiers = this.modifiers ?? [];
      return create([...existingModifiers, breakpoint]);
    }
    // It might be more robust to throw an error or log a warning if a non-breakpoint
    // modifier is passed to `at()`, but returning `this` is also an option.
    // For now, let's assume `at` is strictly for breakpoints.
    return this as T;
  }

  /// Returns the string representation of this utility class, including all applied prefixes.
  /// For example, `hover:md:text-lg`.
  @override
  String toString() {
    if (modifiers == null || modifiers!.isEmpty) {
      return cssClass;
    }
    final prefixesString = modifiers!.map((m) => m.prefix).join();
    return '$prefixesString$cssClass';
  }

  /// Compares this utility class to another of the same type `T`.
  ///
  /// Comparison is based on:
  /// 1. [StyleType] (enum index).
  /// 2. [cssClass] (lexicographically).
  /// 3. Applied [PrefixModifier]s (lexicographically by prefix string, then by count).
  @override
  int compareTo(T other) {
    final typeComparison = type.index.compareTo(other.type.index);
    if (typeComparison != 0) return typeComparison;

    final cssComparison = cssClass.compareTo(other.cssClass);
    if (cssComparison != 0) return cssComparison;

    return _compareModifiers(modifiers, other.modifiers);
  }

  // TODO: PERFORMANCE CRITICAL - Optimize modifier comparison logic
  //
  // Current Issues:
  // 1. O(n) complexity for each comparison iteration, becomes O(n²) when sorting lists
  // 2. Multiple null checks and defensive copying create overhead
  // 3. String-based prefix comparison is expensive for large modifier lists
  // 4. No early termination optimization for obviously different lists
  //
  // Optimization Opportunities:
  // - Cache computed comparison keys (hash-based)
  // - Implement fast-path for common cases (empty lists, length differences)
  // - Consider using Comparable<PrefixModifier> directly instead of string comparison
  // - Pre-sort modifiers at creation time to avoid repeated sorting
  //
  // Performance Impact: High for components with many responsive/state modifiers
  // Priority: Medium (optimize after core functionality is stable)
  //
  // Example hot path: Button with 5+ breakpoint modifiers = 25+ comparisons per render
  /// Helper method to compare lists of [PrefixModifier]s.
  int _compareModifiers(
      List<PrefixModifier>? list1, List<PrefixModifier>? list2) {
    final l1 = list1 ?? [];
    final l2 = list2 ?? [];

    if (l1.isEmpty && l2.isEmpty) return 0;
    if (l1.isEmpty) return -1; // Empty list comes before non-empty
    if (l2.isEmpty) return 1; // Non-empty list comes after empty

    for (var i = 0; i < l1.length && i < l2.length; i++) {
      final comparison = l1[i].prefix.compareTo(l2[i].prefix);
      if (comparison != 0) return comparison;
    }
    return l1.length
        .compareTo(l2.length); // Shorter list comes first if prefixes match
  }
}
