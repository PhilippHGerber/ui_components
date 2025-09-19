// packages/deepyr/lib/src/base/utilities/layout.dart

import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

/// A comprehensive utility class for applying layout styles.
///
/// This includes utilities for display, positioning, z-index, overflow,
/// visibility, flexbox/grid spacing (gap), ordering, and other
/// fundamental CSS layout properties.
class Layout extends CommonStyle<Layout> {
  const Layout(super.cssClass, {super.modifiers}) : super(type: StyleType.layout);

  // --- Z-Index ---
  /// Creates a z-index utility. `z-{value}`
  factory Layout.z(int value) => Layout('z-$value');

  // --- Positioning ---
  /// Creates an inset utility. `inset-{value}`
  factory Layout.inset(num value) => Layout('inset-${_formatValue(value)}');

  /// Creates a horizontal inset utility. `inset-x-{value}`
  factory Layout.insetX(num value) => Layout('inset-x-${_formatValue(value)}');

  /// Creates a vertical inset utility. `inset-y-{value}`
  factory Layout.insetY(num value) => Layout('inset-y-${_formatValue(value)}');

  /// Creates a top position utility. `top-{value}`
  factory Layout.top(num value) => Layout('top-${_formatValue(value)}');

  /// Creates a bottom position utility. `bottom-{value}`
  factory Layout.bottom(num value) => Layout('bottom-${_formatValue(value)}');

  /// Creates a left position utility. `left-{value}`
  factory Layout.left(num value) => Layout('left-${_formatValue(value)}');

  /// Creates a right position utility. `right-{value}`
  factory Layout.right(num value) => Layout('right-${_formatValue(value)}');

  // --- Gap, Order, and Spacing ---
  /// Creates a gap utility for both axes. `gap-{value}`
  factory Layout.gap(num value) => Layout('gap-${_formatValue(value)}');

  /// Creates a horizontal gap utility. `gap-x-{value}`
  factory Layout.gapX(num value) => Layout('gap-x-${_formatValue(value)}');

  /// Creates a vertical gap utility. `gap-y-{value}`
  factory Layout.gapY(num value) => Layout('gap-y-${_formatValue(value)}');

  /// Creates a positive order utility. `order-{value}`
  factory Layout.order(int value) => Layout('order-$value');

  /// Creates a negative order utility. `-order-{value}`
  factory Layout.orderNeg(int value) => Layout('-order-$value');

  /// Helper to format a value, removing .0 for whole numbers.
  static String _formatValue(num value) {
    if (value == value.truncate()) {
      return value.truncate().toString();
    }
    return value.toString();
  }

  @override
  Layout create(List<PrefixModifier> modifiers) {
    return Layout(cssClass, modifiers: modifiers);
  }

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

  /// `display: grid`
  static const Layout grid = Layout('grid');

  /// `display: inline-grid`
  static const Layout inlineGrid = Layout('inline-grid');

  /// `display: contents`
  static const Layout contents = Layout('contents');

  /// `display: list-item`
  static const Layout listItem = Layout('list-item');

  /// `display: hidden` (effectively `display: none`)
  static const Layout hidden = Layout('hidden');

  /// `display: flow-root`
  static const Layout flowRoot = Layout('flow-root');

  /// `z-index: auto`
  static const Layout zAuto = Layout('z-auto');

  /// `z-index: 0`
  static const Layout z0 = Layout('z-0');

  /// `z-index: 10`
  static const Layout z10 = Layout('z-10');

  /// `z-index: 20`
  static const Layout z20 = Layout('z-20');

  /// `z-index: 30`
  static const Layout z30 = Layout('z-30');

  /// `z-index: 40`
  static const Layout z40 = Layout('z-40');

  /// `z-index: 50`
  static const Layout z50 = Layout('z-50');

  /// `inset: 0`
  static const Layout inset0 = Layout('inset-0');

  /// `inset: auto`
  static const Layout insetAuto = Layout('inset-auto');

  /// `top: 0`
  static const Layout top0 = Layout('top-0');

  /// `bottom: 0`
  static const Layout bottom0 = Layout('bottom-0');

  /// `left: 0`
  static const Layout left0 = Layout('left-0');

  /// `right: 0`
  static const Layout right0 = Layout('right-0');

  /// `inset: 100%`
  static const Layout insetFull = Layout('inset-full');

  // --- Overflow ---
  /// `overflow: auto`
  static const Layout overflowAuto = Layout('overflow-auto');

  /// `overflow: hidden`
  static const Layout overflowHidden = Layout('overflow-hidden');

  /// `overflow: visible`
  static const Layout overflowVisible = Layout('overflow-visible');

  /// `overflow: scroll`
  static const Layout overflowScroll = Layout('overflow-scroll');

  /// `overflow-x: auto`
  static const Layout overflowXAuto = Layout('overflow-x-auto');

  /// `overflow-y: auto`
  static const Layout overflowYAuto = Layout('overflow-y-auto');

  /// `overflow-x: hidden`
  static const Layout overflowXHidden = Layout('overflow-x-hidden');

  /// `overflow-y: hidden`
  static const Layout overflowYHidden = Layout('overflow-y-hidden');

  /// `overflow-x: visible`
  static const Layout overflowXVisible = Layout('overflow-x-visible');

  /// `overflow-y: visible`
  static const Layout overflowYVisible = Layout('overflow-y-visible');

  /// `overflow-x: scroll`
  static const Layout overflowXScroll = Layout('overflow-x-scroll');

  /// `overflow-y: scroll`
  static const Layout overflowYScroll = Layout('overflow-y-scroll');

  // --- Visibility ---
  /// `visibility: visible`
  static const Layout visible = Layout('visible');

  /// `visibility: hidden` (element still takes up space)
  static const Layout invisible = Layout('invisible');

  // --- Object Fit & Position ---
  /// `object-fit: contain`
  static const Layout objectContain = Layout('object-contain');

  /// `object-fit: cover`
  static const Layout objectCover = Layout('object-cover');

  /// `object-fit: fill`
  static const Layout objectFill = Layout('object-fill');

  /// `object-fit: none`
  static const Layout objectNone = Layout('object-none');

  /// `object-fit: scale-down`
  static const Layout objectScaleDown = Layout('object-scale-down');

  /// `object-position: bottom`
  static const Layout objectBottom = Layout('object-bottom');

  /// `object-position: center`
  static const Layout objectCenter = Layout('object-center');

  /// `object-position: left`
  static const Layout objectLeft = Layout('object-left');

  /// `object-position: left bottom`
  static const Layout objectLeftBottom = Layout('object-left-bottom');

  /// `object-position: left top`
  static const Layout objectLeftTop = Layout('object-left-top');

  /// `object-position: right`
  static const Layout objectRight = Layout('object-right');

  /// `object-position: right bottom`
  static const Layout objectRightBottom = Layout('object-right-bottom');

  /// `object-position: right top`
  static const Layout objectRightTop = Layout('object-right-top');

  /// `object-position: top`
  static const Layout objectTop = Layout('object-top');

  // --- Flexbox & Grid Container ---
  /// `flex-direction: row`
  static const Layout flexRow = Layout('flex-row');

  /// `flex-direction: row-reverse`
  static const Layout flexRowReverse = Layout('flex-row-reverse');

  /// `flex-direction: column`
  static const Layout flexCol = Layout('flex-col');

  /// `flex-direction: column-reverse`
  static const Layout flexColReverse = Layout('flex-col-reverse');

  /// `flex-wrap: nowrap`
  static const Layout flexNoWrap = Layout('flex-nowrap');

  /// `flex-wrap: wrap`
  static const Layout flexWrap = Layout('flex-wrap');

  /// `flex-wrap: wrap-reverse`
  static const Layout flexWrapReverse = Layout('flex-wrap-reverse');

  /// `grid-auto-flow: row`
  static const Layout gridFlowRow = Layout('grid-flow-row');

  /// `grid-auto-flow: column`
  static const Layout gridFlowCol = Layout('grid-flow-col');

  /// `grid-auto-flow: row dense`
  static const Layout gridFlowRowDense = Layout('grid-flow-row-dense');

  /// `grid-auto-flow: column dense`
  static const Layout gridFlowColDense = Layout('grid-flow-col-dense');

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

  // Horizontal gap utilities
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
  /// `order: -9999`
  static const Layout orderFirst = Layout('order-first');
  static const Layout orderLast = Layout('order-last');
  static const Layout orderNone = Layout('order-none');
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

  /// `float: none`
  static const Layout floatNone = Layout('float-none');

  /// `clear: left`
  static const Layout clearLeft = Layout('clear-left');

  /// `clear: right`
  static const Layout clearRight = Layout('clear-right');

  /// `clear: both`
  static const Layout clearBoth = Layout('clear-both');

  /// `clear: none`
  static const Layout clearNone = Layout('clear-none');

  // --- Box Sizing ---
  /// `box-sizing: border-box`
  static const Layout boxBorder = Layout('box-border');

  /// `box-sizing: content-box`
  static const Layout boxContent = Layout('box-content');
}
