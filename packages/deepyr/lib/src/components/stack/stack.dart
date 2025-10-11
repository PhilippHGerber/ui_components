import 'package:jaspr/jaspr.dart' show Key, Styles;

import '../../../deepyr.dart';
import '../../base/style_type.dart';
import '../../base/ui_component.dart';
import 'stack_style.dart';

/// A layout component that visually places its children on top of each other.
///
/// The `Stack` component is a simple yet powerful container for creating layered
/// UIs. It renders a `<div>` with the `stack` class. The sizing of the stack
/// container itself should be controlled using general-purpose utilities like
/// `Size` (e.g., `[Size.w32, Size.h32]`).
///
/// All direct children of a `Stack` are layered in the order they appear, with
/// the last child being on top.
///
/// Example Usage:
/// ```dart
/// Stack(
///   style: [Size.w32, Size.h20],
///   [
///     // The first child is at the bottom
///     Container(
///       [text('1')],
///       style: [BgUtil.primary, TextUtil.primaryContent, Layout.grid, Alignment.placeContentCenter, Effects.roundedBox],
///     ),
///     // The second child is in the middle
///     Container(
///       [text('2')],
///       style: [BgUtil.accent, TextUtil.accentContent, Layout.grid, Alignment.placeContentCenter, Effects.roundedBox],
///     ),
///     // The last child is on top
///     Container(
///       [text('3')],
///       style: [BgUtil.secondary, TextUtil.secondaryContent, Layout.grid, Alignment.placeContentCenter, Effects.roundedBox],
///     ),
///   ],
/// )
/// ```
class Stack extends UiComponent {
  /// Creates a Stack component.
  ///
  /// - [children]: The list of components to layer on top of each other.
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [style]: A list of [StackStyling] instances to control the alignment
  ///   of the stacked items (e.g., `Stack.top`) and for applying general
  ///   utilities like `Size`.
  /// - Other parameters are inherited from [UiComponent].
  const Stack(
    super.children, {
    super.tag = 'div',
    List<StackStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.child,
    super.key,
  }) : super(style: style);

  @override
  String get baseClass => 'stack';

  @override
  Stack copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Key? key,
  }) {
    return Stack(
      children,
      tag: tag,
      style: style as List<StackStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      child: child,
      key: key ?? this.key,
    );
  }

  // --- Static Style Modifiers ---

  /// Aligns the children elements to the top. `stack-top`
  static const StackStyle top = StackStyle('stack-top', type: StyleType.layout);

  /// Aligns the children elements to the bottom (default behavior). `stack-bottom`
  static const StackStyle bottom = StackStyle('stack-bottom', type: StyleType.layout);

  /// Aligns the children elements to the start (horizontally). `stack-start`
  static const StackStyle start = StackStyle('stack-start', type: StyleType.layout);

  /// Aligns the children elements to the end (horizontally). `stack-end`
  static const StackStyle end = StackStyle('stack-end', type: StyleType.layout);
}
