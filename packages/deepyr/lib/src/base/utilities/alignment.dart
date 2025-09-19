import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

/// A utility class for applying alignment styles to flexbox and grid layouts.
///
/// This includes utilities for justifying and aligning content and items along both
/// the main and cross axes.
class Alignment extends CommonStyle<Alignment> {
  const Alignment(super.cssClass, {super.modifiers}) : super(type: StyleType.layout);

  // --- Justify Content ---
  // Controls how flex and grid items are positioned along the container's main axis.

  /// `justify-content: flex-start`
  static const Alignment justifyStart = Alignment('justify-start');

  /// `justify-content: flex-end`
  static const Alignment justifyEnd = Alignment('justify-end');

  /// `justify-content: center`
  static const Alignment justifyCenter = Alignment('justify-center');

  /// `justify-content: space-between`
  static const Alignment justifyBetween = Alignment('justify-between');

  /// `justify-content: space-around`
  static const Alignment justifyAround = Alignment('justify-around');

  /// `justify-content: space-evenly`
  static const Alignment justifyEvenly = Alignment('justify-evenly');

  /// `justify-content: stretch`
  static const Alignment justifyStretch = Alignment('justify-stretch');

  // --- Justify Items ---
  // Controls how grid items are aligned along their inline (main) axis.

  /// `justify-items: start`
  static const Alignment justifyItemsStart = Alignment('justify-items-start');

  /// `justify-items: end`
  static const Alignment justifyItemsEnd = Alignment('justify-items-end');

  /// `justify-items: center`
  static const Alignment justifyItemsCenter = Alignment('justify-items-center');

  /// `justify-items: stretch`
  static const Alignment justifyItemsStretch = Alignment('justify-items-stretch');

  // --- Justify Self ---
  // Controls how an individual grid item is aligned along its inline (main) axis.

  /// `justify-self: auto`
  static const Alignment justifySelfAuto = Alignment('justify-self-auto');

  /// `justify-self: start`
  static const Alignment justifySelfStart = Alignment('justify-self-start');

  /// `justify-self: end`
  static const Alignment justifySelfEnd = Alignment('justify-self-end');

  /// `justify-self: center`
  static const Alignment justifySelfCenter = Alignment('justify-self-center');

  /// `justify-self: stretch`
  static const Alignment justifySelfStretch = Alignment('justify-self-stretch');

  // --- Align Content ---
  // Controls how lines are packed in a multi-line flex or grid container.

  /// `align-content: center`
  static const Alignment contentCenter = Alignment('content-center');

  /// `align-content: flex-start`
  static const Alignment contentStart = Alignment('content-start');

  /// `align-content: flex-end`
  static const Alignment contentEnd = Alignment('content-end');

  /// `align-content: space-between`
  static const Alignment contentBetween = Alignment('content-between');

  /// `align-content: space-around`
  static const Alignment contentAround = Alignment('content-around');

  /// `align-content: space-evenly`
  static const Alignment contentEvenly = Alignment('content-evenly');

  /// `align-content: baseline`
  static const Alignment contentBaseline = Alignment('content-baseline');

  /// `align-content: stretch`
  static const Alignment contentStretch = Alignment('content-stretch');

  // --- Align Items ---
  // Controls how flex and grid items are positioned along the container's cross axis.

  /// `align-items: flex-start`
  static const Alignment itemsStart = Alignment('items-start');

  /// `align-items: flex-end`
  static const Alignment itemsEnd = Alignment('items-end');

  /// `align-items: center`
  static const Alignment itemsCenter = Alignment('items-center');

  /// `align-items: baseline`
  static const Alignment itemsBaseline = Alignment('items-baseline');

  /// `align-items: stretch`
  static const Alignment itemsStretch = Alignment('items-stretch');

  // --- Align Self ---
  // Controls how an individual flex or grid item is aligned along its cross axis.

  /// `align-self: auto`
  static const Alignment alignSelfAuto = Alignment('self-auto');

  /// `align-self: flex-start`
  static const Alignment alignSelfStart = Alignment('self-start');

  /// `align-self: flex-end`
  static const Alignment alignSelfEnd = Alignment('self-end');

  /// `align-self: center`
  static const Alignment alignSelfCenter = Alignment('self-center');

  /// `align-self: stretch`
  static const Alignment alignSelfStretch = Alignment('self-stretch');

  /// `align-self: baseline`
  static const Alignment alignSelfBaseline = Alignment('self-baseline');

  // --- Place Content ---
  // A shorthand for setting both `align-content` and `justify-content`.

  /// `place-content: center`
  static const Alignment placeContentCenter = Alignment('place-content-center');

  /// `place-content: start`
  static const Alignment placeContentStart = Alignment('place-content-start');

  /// `place-content: end`
  static const Alignment placeContentEnd = Alignment('place-content-end');

  /// `place-content: space-between`
  static const Alignment placeContentBetween = Alignment('place-content-between');

  /// `place-content: space-around`
  static const Alignment placeContentAround = Alignment('place-content-around');

  /// `place-content: space-evenly`
  static const Alignment placeContentEvenly = Alignment('place-content-evenly');

  /// `place-content: baseline`
  static const Alignment placeContentBaseline = Alignment('place-content-baseline');

  /// `place-content: stretch`
  static const Alignment placeContentStretch = Alignment('place-content-stretch');

  // --- Place Items ---
  // A shorthand for setting both `align-items` and `justify-items`.

  /// `place-items: start`
  static const Alignment placeItemsStart = Alignment('place-items-start');

  /// `place-items: end`
  static const Alignment placeItemsEnd = Alignment('place-items-end');

  /// `place-items: center`
  static const Alignment placeItemsCenter = Alignment('place-items-center');

  /// `place-items: baseline`
  static const Alignment placeItemsBaseline = Alignment('place-items-baseline');

  /// `place-items: stretch`
  static const Alignment placeItemsStretch = Alignment('place-items-stretch');

  // --- Place Self ---
  // A shorthand for setting both `align-self` and `justify-self` for an individual item.

  /// `place-self: auto`
  static const Alignment placeSelfAuto = Alignment('place-self-auto');

  /// `place-self: start`
  static const Alignment placeSelfStart = Alignment('place-self-start');

  /// `place-self: end`
  static const Alignment placeSelfEnd = Alignment('place-self-end');

  /// `place-self: center`
  static const Alignment placeSelfCenter = Alignment('place-self-center');

  /// `place-self: stretch`
  static const Alignment placeSelfStretch = Alignment('place-self-stretch');

  @override
  Alignment create(List<PrefixModifier> modifiers) {
    return Alignment(cssClass, modifiers: modifiers);
  }
}
