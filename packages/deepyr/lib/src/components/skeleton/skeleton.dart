import 'package:jaspr/jaspr.dart' show Key, Styles;

import '../../base/ui_component.dart';
import '../../base/ui_events.dart';
import 'skeleton_style.dart';

/// A component that displays a placeholder preview of your content before it loads.
///
/// The `Skeleton` component renders an HTML `<div>` (by default) with the `skeleton`
/// base class, which creates a shimmering animation effect. Its dimensions and shape
/// are controlled by applying general-purpose utility classes from the `deepyr`
/// library, such as `Size` and `Effects`.
///
/// It does not have any component-specific style modifiers; all styling is
/// applied via the `style` property using general utilities.
///
/// Example Usage:
/// ```dart
/// // A simple rectangular skeleton placeholder
/// Skeleton(
///   style: [Size.w(32), Size.h(32)],
/// ),
///
/// // A circular skeleton placeholder
/// Skeleton(
///   style: [Size.w(16), Size.h(16), Effects.roundedFull],
/// ),
///
/// // Composing multiple skeletons to create a UI placeholder
/// Container(
///   style: [Layout.flex, Layout.flexCol, Layout.gap(4)],
///   [
///     Skeleton(style: [Size.h(4), Size.w(28)]),
///     Skeleton(style: [Size.h(4), Size.wFull]),
///     Skeleton(style: [Size.h(4), Size.wFull]),
///   ],
/// )
/// ```
class Skeleton extends UiComponent {
  /// Creates a Skeleton component.
  ///
  /// - [tag]: The HTML tag for the root element, defaults to 'div'.
  /// - [style]: A list of [SkeletonStyling] instances. This is where you apply
  ///   general utilities like `Size.w()`, `Size.h()`, and `Effects.roundedFull`
  ///   to define the shape and dimensions of the skeleton placeholder.
  /// - Other parameters are inherited from [UiComponent].
  const Skeleton({
    super.tag = 'div',
    List<SkeletonStyling>? style,
    super.id,
    super.classes,
    super.css,
    super.attributes,
    super.eventHandlers,
    super.key,
  }) : super(
         null, // Skeletons typically have no children.
         style: style,
       );

  @override
  String get baseClass => 'skeleton';

  @override
  Skeleton copyWith({
    String? id,
    String? classes,
    Styles? css,
    Map<String, String>? attributes,
    Map<String, List<UiEventHandler>>? eventHandlers,
    Key? key,
  }) {
    return Skeleton(
      tag: tag,
      style: style as List<SkeletonStyling>?,
      id: id ?? this.id,
      classes: mergeClasses(this.classes, classes),
      css: css ?? this.css,
      attributes: attributes ?? userProvidedAttributes,
      eventHandlers: eventHandlers ?? this.eventHandlers,
      key: key ?? this.key,
    );
  }
}
