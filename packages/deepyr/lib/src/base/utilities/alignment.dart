import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

class Alignment extends CommonStyle<Alignment> {
  const Alignment(super.cssClass, {super.modifiers})
      : super(type: StyleType.layout);

  // Justify content - Controls how flex and grid items are positioned
  // along container's main axis
  static const Alignment justifyStart =
      Alignment('justify-start'); // flex-start
  static const Alignment justifyEnd = Alignment('justify-end'); // flex-end
  static const Alignment justifyCenter = Alignment('justify-center'); // center
  static const Alignment justifyBetween =
      Alignment('justify-between'); // space-between
  static const Alignment justifyAround =
      Alignment('justify-around'); // space-around
  static const Alignment justifyEvenly =
      Alignment('justify-evenly'); // space-evenly
  static const Alignment justifyStretch =
      Alignment('justify-stretch'); // stretch
  static const Alignment justifyBaseline =
      Alignment('justify-baseline'); // baseline
  static const Alignment justifyNormal = Alignment('justify-normal'); // normal

  // Utilities for controlling how grid items are aligned along their inline axis.
  static const Alignment justifyItemsStart =
      Alignment('justify-items-start'); // start
  static const Alignment justifyItemsEnd =
      Alignment('justify-items-end'); // end
  static const Alignment justifyItemsCenter =
      Alignment('justify-items-center'); // center
  static const Alignment justifyItemsStretch =
      Alignment('justify-items-stretch'); // stretch
  static const Alignment justifyItemsNormal =
      Alignment('justify-items-normal'); // normal

  // Controls how an individual flex or grid item is justified
  // along its inline axis relative to its container
  static const Alignment justifySelfAuto =
      Alignment('justify-self-auto'); // auto
  static const Alignment justifySelfStart =
      Alignment('justify-self-start'); // start
  static const Alignment justifySelfEnd = Alignment('justify-self-end'); // end
  static const Alignment justifySelfCenter =
      Alignment('justify-self-center'); // center
  static const Alignment justifySelfStretch =
      Alignment('justify-self-stretch'); // stretch

  // Controls alignment of wrapped lines in flex containers
  // and alignment of grid tracks in grid containers
  static const Alignment contentNormal = Alignment('content-normal'); // normal
  static const Alignment contentCenter = Alignment('content-center'); // center
  static const Alignment contentStart =
      Alignment('content-start'); // flex-start
  static const Alignment contentEnd = Alignment('content-end'); // flex-end
  static const Alignment contentBetween =
      Alignment('content-between'); // space-between
  static const Alignment contentAround =
      Alignment('content-around'); // space-around
  static const Alignment contentEvenly =
      Alignment('content-evenly'); // space-evenly
  static const Alignment contentBaseline =
      Alignment('content-baseline'); // baseline
  static const Alignment contentStretch =
      Alignment('content-stretch'); // stretch

  // Controls how flex and grid items are positioned
  // along a container's cross axis
  static const Alignment itemsStart = Alignment('items-start'); // flex-start
  static const Alignment itemsEnd = Alignment('items-end'); // flex-end
  static const Alignment itemsCenter = Alignment('items-center'); // center
  static const Alignment itemsBaseline =
      Alignment('items-baseline'); // baseline
  static const Alignment itemsStretch = Alignment('items-stretch'); // stretch

  // Controls how an individual flex or grid item is aligned
  // along its cross axis relative to its container
  static const Alignment alignSelfAuto = Alignment('self-auto'); // auto
  static const Alignment alignSelfStart = Alignment('self-start'); // flex-start
  static const Alignment alignSelfEnd = Alignment('self-end'); // flex-end
  static const Alignment alignSelfCenter = Alignment('self-center'); // center
  static const Alignment alignSelfStretch =
      Alignment('self-stretch'); // stretch
  static const Alignment alignSelfBaseline =
      Alignment('self-baseline'); // baseline

  // Controls alignment of grid and flexbox content in both directions simultaneously
  // Shorthand for align-content and justify-content
  static const Alignment placeContentCenter =
      Alignment('place-content-center'); // center
  static const Alignment placeContentStart =
      Alignment('place-content-start'); // start
  static const Alignment placeContentEnd =
      Alignment('place-content-end'); // end
  static const Alignment placeContentBetween =
      Alignment('place-content-between'); // space-between
  static const Alignment placeContentAround =
      Alignment('place-content-around'); // space-around
  static const Alignment placeContentEvenly =
      Alignment('place-content-evenly'); // space-evenly
  static const Alignment placeContentBaseline =
      Alignment('place-content-baseline'); // baseline
  static const Alignment placeContentStretch =
      Alignment('place-content-stretch'); // stretch

  // Controls how items are placed on both axes at once,
  // shorthand for align-items and justify-items
  static const Alignment placeItemsStart =
      Alignment('place-items-start'); // start
  static const Alignment placeItemsEnd = Alignment('place-items-end'); // end
  static const Alignment placeItemsCenter =
      Alignment('place-items-center'); // center
  static const Alignment placeItemsBaseline =
      Alignment('place-items-baseline'); // baseline
  static const Alignment placeItemsStretch =
      Alignment('place-items-stretch'); // stretch

  // Controls how an individual flex or grid item is justified and aligned
  // Shorthand for align-self and justify-self properties
  static const Alignment placeSelfAuto = Alignment('place-self-auto'); // auto
  static const Alignment placeSelfStart =
      Alignment('place-self-start'); // start
  static const Alignment placeSelfEnd = Alignment('place-self-end'); // end
  static const Alignment placeSelfCenter =
      Alignment('place-self-center'); // center
  static const Alignment placeSelfStretch =
      Alignment('place-self-stretch'); // stretch

  @override
  Alignment create(List<PrefixModifier> modifiers) {
    return Alignment(cssClass, modifiers: modifiers);
  }
}
