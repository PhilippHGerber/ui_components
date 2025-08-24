// TODO
import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';
// - gap
// - order

class Layout extends CommonStyle<Layout> {
  const Layout(super.cssClass, {super.modifiers})
      : super(type: StyleType.layout);

  // --- Display ---
  /// `display: block`
  static const Layout block = Layout('block');

  /// `display: inline-block`
  static const Layout inlineBlock = Layout('inline-block');

  /// `display: inline`
  static const Layout inline = Layout('inline');

  /// `display: flex`
  static const Layout flex = Layout('flex');

  /// `display: inline-flex`
  static const Layout inlineFlex = Layout('inline-flex');

  /// `display: table`
  static const Layout table = Layout('table');

  /// `display: inline-table`
  static const Layout inlineTable = Layout('inline-table');

  /// `display: table-caption`
  static const Layout tableCaption = Layout('table-caption');
  // ... add other display types as needed: table-cell, table-column, etc.
  /// `display: grid`
  static const Layout grid = Layout('grid');

  /// `display: inline-grid`
  static const Layout inlineGrid = Layout('inline-grid');

  /// `display: contents`
  static const Layout contents = Layout('contents');

  /// `display: list-item`
  static const Layout listItem = Layout('list-item');

  /// `display: hidden` (same as `hidden` in Tailwind, effectively `display: none`)
  static const Layout hidden = Layout('hidden');

  // --- Flex Direction (from flex.dart, could be consolidated here or kept separate) ---
  // Assuming Flex specific utilities (grow, shrink, basis) remain in flex.dart
  // but basic direction and wrap can be here for general layout.
  static const Layout flexRow = Layout('flex-row');
  static const Layout flexRowReverse = Layout('flex-row-reverse');
  static const Layout flexCol = Layout('flex-col');
  static const Layout flexColReverse = Layout('flex-col-reverse');

  // --- Flex Wrap ---
  static const Layout flexNoWrap = Layout('flex-nowrap');
  static const Layout flexWrap = Layout('flex-wrap');
  static const Layout flexWrapReverse = Layout('flex-wrap-reverse');

  // Base gap utilities - Control spacing in both directions
  static Layout gap(double value) => Layout('gap-${_formatValue(value)}');
  static Layout gapX(double value) => Layout('gap-x-${_formatValue(value)}');
  static Layout gapY(double value) => Layout('gap-y-${_formatValue(value)}');

  // Base gap utilities - Control spacing in both directions
  // These follow the standard 0.25rem (4px) scale pattern
  static const Layout gap0 = Layout('gap-0'); // 0px
  static const Layout gap1 = Layout('gap-1'); // 0.25rem (4px)
  static const Layout gap2 = Layout('gap-2'); // 0.5rem (8px)
  static const Layout gap3 = Layout('gap-3'); // 0.75rem (12px)
  static const Layout gap4 = Layout('gap-4'); // 1rem (16px)
  static const Layout gap5 = Layout('gap-5'); // 1.25rem (20px)
  static const Layout gap6 = Layout('gap-6'); // 1.5rem (24px)
  static const Layout gap8 = Layout('gap-8'); // 2rem (32px)
  static const Layout gap10 = Layout('gap-10'); // 2.5rem (40px)
  static const Layout gap12 = Layout('gap-12'); // 3rem (48px)
  static const Layout gap14 = Layout('gap-14'); // 3.5rem (56px)
  static const Layout gap16 = Layout('gap-16'); // 4rem (64px)
  static const Layout gap20 = Layout('gap-20'); // 5rem (80px)
  static const Layout gap24 = Layout('gap-24'); // 6rem (96px)
  static const Layout gap28 = Layout('gap-28'); // 7rem (112px)
  static const Layout gap32 = Layout('gap-32'); // 8rem (128px)
  static const Layout gap36 = Layout('gap-36'); // 9rem (144px)
  static const Layout gap40 = Layout('gap-40'); // 10rem (160px)
  static const Layout gap44 = Layout('gap-44'); // 11rem (176px)
  static const Layout gap48 = Layout('gap-48'); // 12rem (192px)
  static const Layout gap52 = Layout('gap-52'); // 13rem (208px)
  static const Layout gap56 = Layout('gap-56'); // 14rem (224px)
  static const Layout gap60 = Layout('gap-60'); // 15rem (240px)
  static const Layout gap64 = Layout('gap-64'); // 16rem (256px)
  static const Layout gap72 = Layout('gap-72'); // 18rem (288px)
  static const Layout gap80 = Layout('gap-80'); // 20rem (320px)
  static const Layout gap96 = Layout('gap-96'); // 24rem (384px)

  // Horizontal gap utilities - Control spacing between columns
  // These follow the same scale but only affect horizontal spacing
  static const Layout gapX0 = Layout('gap-x-0');
  static const Layout gapX1 = Layout('gap-x-1');
  static const Layout gapX2 = Layout('gap-x-2');
  static const Layout gapX3 = Layout('gap-x-3');
  static const Layout gapX4 = Layout('gap-x-4');
  static const Layout gapX5 = Layout('gap-x-5');
  static const Layout gapX6 = Layout('gap-x-6');
  static const Layout gapX8 = Layout('gap-x-8');
  static const Layout gapX10 = Layout('gap-x-10');
  static const Layout gapX12 = Layout('gap-x-12');
  static const Layout gapX14 = Layout('gap-x-14');
  static const Layout gapX16 = Layout('gap-x-16');
  static const Layout gapX20 = Layout('gap-x-20');
  static const Layout gapX24 = Layout('gap-x-24');
  static const Layout gapX28 = Layout('gap-x-28');
  static const Layout gapX32 = Layout('gap-x-32');
  static const Layout gapX36 = Layout('gap-x-36');
  static const Layout gapX40 = Layout('gap-x-40');
  static const Layout gapX44 = Layout('gap-x-44');
  static const Layout gapX48 = Layout('gap-x-48');
  static const Layout gapX52 = Layout('gap-x-52');
  static const Layout gapX56 = Layout('gap-x-56');
  static const Layout gapX60 = Layout('gap-x-60');
  static const Layout gapX64 = Layout('gap-x-64');
  static const Layout gapX72 = Layout('gap-x-72');
  static const Layout gapX80 = Layout('gap-x-80');
  static const Layout gapX96 = Layout('gap-x-96');

  // Vertical gap utilities - Control spacing between rows
  // These follow the same scale but only affect vertical spacing
  static const Layout gapY0 = Layout('gap-y-0');
  static const Layout gapY1 = Layout('gap-y-1');
  static const Layout gapY2 = Layout('gap-y-2');
  static const Layout gapY3 = Layout('gap-y-3');
  static const Layout gapY4 = Layout('gap-y-4');
  static const Layout gapY5 = Layout('gap-y-5');
  static const Layout gapY6 = Layout('gap-y-6');
  static const Layout gapY8 = Layout('gap-y-8');
  static const Layout gapY10 = Layout('gap-y-10');
  static const Layout gapY12 = Layout('gap-y-12');
  static const Layout gapY14 = Layout('gap-y-14');
  static const Layout gapY16 = Layout('gap-y-16');
  static const Layout gapY20 = Layout('gap-y-20');
  static const Layout gapY24 = Layout('gap-y-24');
  static const Layout gapY28 = Layout('gap-y-28');
  static const Layout gapY32 = Layout('gap-y-32');
  static const Layout gapY36 = Layout('gap-y-36');
  static const Layout gapY40 = Layout('gap-y-40');
  static const Layout gapY44 = Layout('gap-y-44');
  static const Layout gapY48 = Layout('gap-y-48');
  static const Layout gapY52 = Layout('gap-y-52');
  static const Layout gapY56 = Layout('gap-y-56');
  static const Layout gapY60 = Layout('gap-y-60');
  static const Layout gapY64 = Layout('gap-y-64');
  static const Layout gapY72 = Layout('gap-y-72');
  static const Layout gapY80 = Layout('gap-y-80');
  static const Layout gapY96 = Layout('gap-y-96');

  // Order utilities for controlling the visual order of flex/grid items
  // Special order values that provide semantic meaning
  // --- Order ---
  // Order utilities for controlling the visual order of flex/grid items
  static const Layout orderFirst = Layout('order-first');
  static const Layout orderLast = Layout('order-last');
  static const Layout orderNone = Layout('order-none');
  static Layout order(int value) => Layout('order-$value');
  static Layout orderNeg(int value) => Layout('-order-$value');
  // ... (add more specific order values if desired, e.g., order1, order2) ...

  // Positive order values for standard ordering
  static const Layout order1 = Layout('order-1');
  static const Layout order2 = Layout('order-2');
  static const Layout order3 = Layout('order-3');
  static const Layout order4 = Layout('order-4');
  static const Layout order5 = Layout('order-5');
  static const Layout order6 = Layout('order-6');
  static const Layout order7 = Layout('order-7');
  static const Layout order8 = Layout('order-8');
  static const Layout order9 = Layout('order-9');
  static const Layout order10 = Layout('order-10');
  static const Layout order11 = Layout('order-11');
  static const Layout order12 = Layout('order-12');

  // Negative order values for placing items before others
  static const Layout orderNeg1 = Layout('-order-1');
  static const Layout orderNeg2 = Layout('-order-2');
  static const Layout orderNeg3 = Layout('-order-3');
  static const Layout orderNeg4 = Layout('-order-4');
  static const Layout orderNeg5 = Layout('-order-5');
  static const Layout orderNeg6 = Layout('-order-6');
  static const Layout orderNeg7 = Layout('-order-7');
  static const Layout orderNeg8 = Layout('-order-8');
  static const Layout orderNeg9 = Layout('-order-9');
  static const Layout orderNeg10 = Layout('-order-10');
  static const Layout orderNeg11 = Layout('-order-11');
  static const Layout orderNeg12 = Layout('-order-12');

  static String _formatValue(double value) {
    if (value == value.truncate()) {
      return value.truncate().toString();
    }
    return value.toString();
  }

  @override
  Layout create(List<PrefixModifier> modifiers) {
    return Layout(cssClass, modifiers: modifiers);
  }
}
