import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

/// A utility class for controlling flexbox item behavior, including grow, shrink, and basis.
class Flex extends CommonStyle<Flex> {
  const Flex(super.cssClass, {super.modifiers}) : super(type: StyleType.layout);

  // Standard flex values that control how flex items grow and shrink
  /// `flex: 1 1 0%` - Allows flex item to grow and shrink.
  static const Flex flex1 = Flex('flex-1');

  /// `flex: 2 2 0%` - Grows/shrinks twice as much as flex-1.
  static const Flex flex2 = Flex('flex-2');

  /// `flex: 3 3 0%` - Grows/shrinks three times as much as flex-1.
  static const Flex flex3 = Flex('flex-3');

  /// `flex: 4 4 0%` - Grows/shrinks four times as much as flex-1.
  static const Flex flex4 = Flex('flex-4');

  /// `flex: 5 5 0%` - Grows/shrinks five times as much as flex-1.
  static const Flex flex5 = Flex('flex-5');

  /// `flex: 6 6 0%` - Grows/shrinks six times as much as flex-1.
  static const Flex flex6 = Flex('flex-6');

  // Fractional flex values for more precise control
  /// `flex: 0.5 0.5 0%`
  static const Flex flexHalf = Flex('flex-1/2');

  /// `flex: 0.33333 0.33333 0%`
  static const Flex flexThird = Flex('flex-1/3');

  /// `flex: 0.25 0.25 0%`
  static const Flex flexQuarter = Flex('flex-1/4');

  // Predefined flex behavior keywords
  /// `flex: 1 1 auto` - Grow and shrink, taking initial size into account.
  static const Flex flexAuto = Flex('flex-auto');

  /// `flex: 0 1 auto` - Only shrink if needed.
  static const Flex flexInitial = Flex('flex-initial');

  /// `flex: none` - Prevent growing or shrinking.
  static const Flex flexNone = Flex('flex-none');

  // Numeric flex-basis values following the 4px (0.25rem) scale
  /// `flex-basis: 0px` - Useful for collapsing initial size.
  static const Flex basis0 = Flex('basis-0');

  /// `flex-basis: 0.25rem` (4px)
  static const Flex basis1 = Flex('basis-1');

  /// `flex-basis: 0.5rem` (8px)
  static const Flex basis2 = Flex('basis-2');

  /// `flex-basis: 0.75rem` (12px)
  static const Flex basis3 = Flex('basis-3');

  /// `flex-basis: 1rem` (16px)
  static const Flex basis4 = Flex('basis-4');

  /// `flex-basis: 1.25rem` (20px)
  static const Flex basis5 = Flex('basis-5');

  /// `flex-basis: 1.5rem` (24px)
  static const Flex basis6 = Flex('basis-6');

  /// `flex-basis: 2rem` (32px)
  static const Flex basis8 = Flex('basis-8');

  /// `flex-basis: 2.5rem` (40px)
  static const Flex basis10 = Flex('basis-10');

  /// `flex-basis: 3rem` (48px)
  static const Flex basis12 = Flex('basis-12');

  /// `flex-basis: 4rem` (64px)
  static const Flex basis16 = Flex('basis-16');

  /// `flex-basis: 5rem` (80px)
  static const Flex basis20 = Flex('basis-20');

  /// `flex-basis: 6rem` (96px)
  static const Flex basis24 = Flex('basis-24');

  /// `flex-basis: 8rem` (128px)
  static const Flex basis32 = Flex('basis-32');

  /// `flex-basis: 10rem` (160px)
  static const Flex basis40 = Flex('basis-40');

  /// `flex-basis: 12rem` (192px)
  static const Flex basis48 = Flex('basis-48');

  /// `flex-basis: 14rem` (224px)
  static const Flex basis56 = Flex('basis-56');

  /// `flex-basis: 16rem` (256px)
  static const Flex basis64 = Flex('basis-64');

  /// `flex-basis: 18rem` (288px)
  static const Flex basis72 = Flex('basis-72');

  /// `flex-basis: 20rem` (320px)
  static const Flex basis80 = Flex('basis-80');

  /// `flex-basis: 24rem` (384px)
  static const Flex basis96 = Flex('basis-96');

  // Fractional flex-basis values for responsive layouts
  /// `flex-basis: 50%`
  static const Flex basis1_2 = Flex('basis-1/2');

  /// `flex-basis: 33.333333%`
  static const Flex basis1_3 = Flex('basis-1/3');

  /// `flex-basis: 66.666667%`
  static const Flex basis2_3 = Flex('basis-2/3');

  /// `flex-basis: 25%`
  static const Flex basis1_4 = Flex('basis-1/4');

  /// `flex-basis: 50%`
  static const Flex basis2_4 = Flex('basis-2/4');

  /// `flex-basis: 75%`
  static const Flex basis3_4 = Flex('basis-3/4');

  /// `flex-basis: 20%`
  static const Flex basis1_5 = Flex('basis-1/5');

  /// `flex-basis: 40%`
  static const Flex basis2_5 = Flex('basis-2/5');

  /// `flex-basis: 60%`
  static const Flex basis3_5 = Flex('basis-3/5');

  /// `flex-basis: 80%`
  static const Flex basis4_5 = Flex('basis-4/5');

  /// `flex-basis: 16.666667%`
  static const Flex basis1_6 = Flex('basis-1/6');

  /// `flex-basis: 33.333333%`
  static const Flex basis2_6 = Flex('basis-2/6');

  /// `flex-basis: 50%`
  static const Flex basis3_6 = Flex('basis-3/6');

  /// `flex-basis: 66.666667%`
  static const Flex basis4_6 = Flex('basis-4/6');

  /// `flex-basis: 83.333333%`
  static const Flex basis5_6 = Flex('basis-5/6');

  // Ui container-based flex-basis sizes
  // These provide consistent sizing that aligns with the design system
  /// `flex-basis: 16rem` (256px)
  static const Flex basis3xs = Flex('basis-3xs');

  /// `flex-basis: 18rem` (288px)
  static const Flex basis2xs = Flex('basis-2xs');

  /// `flex-basis: 20rem` (320px)
  static const Flex basisXs = Flex('basis-xs');

  /// `flex-basis: 24rem` (384px)
  static const Flex basisSm = Flex('basis-sm');

  /// `flex-basis: 28rem` (448px)
  static const Flex basisMd = Flex('basis-md');

  /// `flex-basis: 32rem` (512px)
  static const Flex basisLg = Flex('basis-lg');

  /// `flex-basis: 36rem` (576px)
  static const Flex basisXl = Flex('basis-xl');

  /// `flex-basis: 42rem` (672px)
  static const Flex basis2xl = Flex('basis-2xl');

  /// `flex-basis: 48rem` (768px)
  static const Flex basis3xl = Flex('basis-3xl');

  /// `flex-basis: 56rem` (896px)
  static const Flex basis4xl = Flex('basis-4xl');

  /// `flex-basis: 64rem` (1024px)
  static const Flex basis5xl = Flex('basis-5xl');

  /// `flex-basis: 72rem` (1152px)
  static const Flex basis6xl = Flex('basis-6xl');

  /// `flex-basis: 80rem` (1280px)
  static const Flex basis7xl = Flex('basis-7xl');

  // Special values for common use cases
  /// `flex-basis: auto` - Use item's content size.
  static const Flex basisAuto = Flex('basis-auto');

  /// `flex-basis: 100%` - 100% of container.
  static const Flex basisFull = Flex('basis-full');

  // Flex Direction Utilities
  // These control the main axis of the flex container, determining
  // how flex items are placed within the container

  /// `flex-direction: row` - Items flow left to right (default browser behavior).
  static const Flex flexRow = Flex('flex-row');

  /// `flex-direction: row-reverse` - Items flow right to left, reversing their order.
  static const Flex flexRowReverse = Flex('flex-row-reverse');

  /// `flex-direction: column` - Items flow top to bottom, creating a vertical layout.
  static const Flex flexCol = Flex('flex-col');

  /// `flex-direction: column-reverse` - Items flow bottom to top, reversing their vertical order.
  static const Flex flexColReverse = Flex('flex-col-reverse');

  // Flex Wrap Utilities
  // These determine whether and how flex items wrap when they
  // exceed the container's dimensions

  /// `flex-wrap: nowrap` - Items remain on a single line, potentially overflowing.
  static const Flex flexNowrap = Flex('flex-nowrap');

  /// `flex-wrap: wrap` - Items wrap onto multiple lines when needed, from top to bottom.
  static const Flex flexWrap = Flex('flex-wrap');

  /// `flex-wrap: wrap-reverse` - Items wrap onto multiple lines when needed, from bottom to top.
  static const Flex flexWrapReverse = Flex('flex-wrap-reverse');

  // Flex Grow Utilities
  // These control how flex items expand to fill available space

  /// `flex-grow: 1` - Enables growing with a factor of 1.
  static const Flex grow = Flex('grow');

  // Numeric grow factors provide more precise control over growth ratios
  // Each number represents how much more the item should grow compared
  // to other items. For example, grow2 will grow twice as fast as grow1
  /// `flex-grow: 0` - Prevents growing.
  static const Flex grow0 = Flex('grow-0');

  /// `flex-grow: 1` - Standard growth rate.
  static const Flex grow1 = Flex('grow-1');

  /// `flex-grow: 2` - Grows twice as fast.
  static const Flex grow2 = Flex('grow-2');

  /// `flex-grow: 3` - Grows three times as fast.
  static const Flex grow3 = Flex('grow-3');

  /// `flex-grow: 4` - Grows four times as fast.
  static const Flex grow4 = Flex('grow-4');

  /// `flex-grow: 5` - Grows five times as fast.
  static const Flex grow5 = Flex('grow-5');

  /// `flex-grow: 6` - Grows six times as fast.
  static const Flex grow6 = Flex('grow-6');

  // Flex Shrink Utilities
  // These control how flex items reduce their size when the container
  // becomes too small to fit all items at their natural size.

  /// `flex-shrink: 1` - Enables shrinking with a factor of 1.
  static const Flex shrink = Flex('shrink');

  // Numeric shrink factors provide fine-grained control over how
  // quickly items shrink relative to each other. An item with
  // shrink-2 will give up space twice as fast as one with shrink-1
  /// `flex-shrink: 0` - Prevents shrinking entirely.
  static const Flex shrink0 = Flex('shrink-0');

  /// `flex-shrink: 1` - Standard shrink rate.
  static const Flex shrink1 = Flex('shrink-1');

  /// `flex-shrink: 2` - Shrinks twice as fast.
  static const Flex shrink2 = Flex('shrink-2');

  /// `flex-shrink: 3` - Shrinks three times as fast.
  static const Flex shrink3 = Flex('shrink-3');

  /// `flex-shrink: 4` - Shrinks four times as fast.
  static const Flex shrink4 = Flex('shrink-4');

  /// `flex-shrink: 5` - Shrinks five times as fast.
  static const Flex shrink5 = Flex('shrink-5');

  /// `flex-shrink: 6` - Shrinks six times as fast.
  static const Flex shrink6 = Flex('shrink-6');

  @override
  Flex create(List<PrefixModifier> modifiers) {
    return Flex(cssClass, modifiers: modifiers);
  }
}
