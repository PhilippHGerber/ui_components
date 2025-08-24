// Größen und Dimensionen
import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

/// Utilities for setting the width of an element.
class Size extends CommonStyle<Size> {
  const Size(super.cssClass, {super.modifiers}) : super(type: StyleType.sizing);

  // Container-based widths
  // Examples of responsive container layouts
  // Card(
  //   [/* card content */],
  //   modifiers: [
  //     Size.wxs,                    // w-xs (320px) on mobile
  //     Size.wmd.at(Breakpoint.sm),  // sm:w-md (448px) on small screens
  //     Size.w2xl.at(Breakpoint.lg), // lg:w-2xl (672px) on large screens
  //   ]
  // )
  //
  // These follow Ui's container scale, providing consistent widths for layout containers
  static const Size w3xs = Size('w-3xs'); // 16rem (256px)  - Smallest container width
  static const Size w2xs = Size('w-2xs'); // 18rem (288px)  - Very small container
  static const Size wxs = Size('w-xs'); // 20rem (320px)  - Extra small container
  static const Size wsm = Size('w-sm'); // 24rem (384px)  - Small container
  static const Size wmd = Size('w-md'); // 28rem (448px)  - Medium container
  static const Size wlg = Size('w-lg'); // 32rem (512px)  - Large container
  static const Size wxl = Size('w-xl'); // 36rem (576px)  - Extra large container
  static const Size w2xl = Size('w-2xl'); // 42rem (672px)  - 2x extra large container
  static const Size w3xl = Size('w-3xl'); // 48rem (768px)  - 3x extra large container
  static const Size w4xl = Size('w-4xl'); // 56rem (896px)  - 4x extra large container
  static const Size w5xl = Size('w-5xl'); // 64rem (1024px) - 5x extra large container
  static const Size w6xl = Size('w-6xl'); // 72rem (1152px) - 6x extra large container
  static const Size w7xl = Size('w-7xl'); // 80rem (1280px) - 7x extra large container

  // Base gap utilities - Control spacing in both directions
  static Size w(double value) => Size('w-${_formatValue(value)}');
  static Size h(double value) => Size('h-${_formatValue(value)}');

  // Fixed widths following a 4px (0.25rem) scale
  static const Size w0 = Size('w-0'); // 0px
  static const Size w1 = Size('w-1'); // 4px (0.25rem)
  static const Size w2 = Size('w-2'); // 8px (0.5rem)
  static const Size w3 = Size('w-3'); // 12px (0.75rem)
  static const Size w4 = Size('w-4'); // 16px (1rem)
  static const Size w5 = Size('w-5'); // 20px (1.25rem)
  static const Size w6 = Size('w-6'); // 24px (1.5rem)
  static const Size w8 = Size('w-8'); // 32px (2rem)
  static const Size w10 = Size('w-10'); // 40px (2.5rem)
  static const Size w12 = Size('w-12'); // 48px (3rem)
  static const Size w16 = Size('w-16'); // 64px (4rem)
  static const Size w20 = Size('w-20'); // 80px (5rem)
  static const Size w24 = Size('w-24'); // 96px (6rem)
  static const Size w32 = Size('w-32'); // 128px (8rem)
  static const Size w40 = Size('w-40'); // 160px (10rem)
  static const Size w48 = Size('w-48'); // 192px (12rem)
  static const Size w56 = Size('w-56'); // 224px (14rem)
  static const Size w64 = Size('w-64'); // 256px (16rem)
  static const Size w72 = Size('w-72'); // 288px (18rem)
  static const Size w80 = Size('w-80'); // 320px (20rem)
  static const Size w96 = Size('w-96'); // 384px (24rem)

  // Fractional widths
  static const Size w1_2 = Size('w-1/2'); // 50%
  static const Size w1_3 = Size('w-1/3'); // 33.333333%
  static const Size w2_3 = Size('w-2/3'); // 66.666667%
  static const Size w1_4 = Size('w-1/4'); // 25%
  static const Size w2_4 = Size('w-2/4'); // 50%
  static const Size w3_4 = Size('w-3/4'); // 75%
  static const Size w1_5 = Size('w-1/5'); // 20%
  static const Size w2_5 = Size('w-2/5'); // 40%
  static const Size w3_5 = Size('w-3/5'); // 60%
  static const Size w4_5 = Size('w-4/5'); // 80%
  static const Size w1_6 = Size('w-1/6'); // 16.666667%
  static const Size w2_6 = Size('w-2/6'); // 33.333333%
  static const Size w3_6 = Size('w-3/6'); // 50%
  static const Size w4_6 = Size('w-4/6'); // 66.666667%
  static const Size w5_6 = Size('w-5/6'); // 83.333333%
  static const Size w1_12 = Size('w-1/12'); // 8.333333%
  static const Size w2_12 = Size('w-2/12'); // 16.666667%
  static const Size w3_12 = Size('w-3/12'); // 25%
  static const Size w4_12 = Size('w-4/12'); // 33.333333%
  static const Size w5_12 = Size('w-5/12'); // 41.666667%
  static const Size w6_12 = Size('w-6/12'); // 50%
  static const Size w7_12 = Size('w-7/12'); // 58.333333%
  static const Size w8_12 = Size('w-8/12'); // 66.666667%
  static const Size w9_12 = Size('w-9/12'); // 75%
  static const Size w10_12 = Size('w-10/12'); // 83.333333%
  static const Size w11_12 = Size('w-11/12'); // 91.666667%

  // Special width values
  static const Size wAuto = Size('w-auto'); // auto
  static const Size wFull = Size('w-full'); // 100%
  static const Size wScreen = Size('w-screen'); // 100vw
  static const Size wMin = Size('w-min'); // min-content
  static const Size wMax = Size('w-max'); // max-content
  static const Size wFit = Size('w-fit'); // fit-content

  // Dynamic viewport units
  // These respond to viewport changes including dynamic UI elements like address bars
  static const Size wDvw = Size('w-dvw'); // 100% of the dynamic viewport width
  static const Size wDvh = Size('w-dvh'); // 100% of the dynamic viewport height

  // Large viewport units
  // These use the largest possible viewport size, ignoring dynamic UI elements
  static const Size wLvw = Size('w-lvw'); // 100% of the largest viewport width
  static const Size wLvh = Size('w-lvh'); // 100% of the largest viewport height

  // Small viewport units
  // These use the smallest possible viewport size, accounting for all UI elements
  static const Size wSvw = Size('w-svw'); // 100% of the smallest viewport width
  static const Size wSvh = Size('w-svh'); // 100% of the smallest viewport height

  // Fixed minimum widths following the standard 4px (0.25rem) scale
  // These are useful for ensuring elements maintain a minimal size while still being able to grow
  static const Size minW0 = Size('min-w-0'); // 0px - Useful for overriding defaults
  static const Size minW1 = Size('min-w-1'); // 4px (0.25rem)
  static const Size minW2 = Size('min-w-2'); // 8px (0.5rem)
  static const Size minW3 = Size('min-w-3'); // 12px (0.75rem)
  static const Size minW4 = Size('min-w-4'); // 16px (1rem)
  static const Size minW5 = Size('min-w-5'); // 20px (1.25rem)
  static const Size minW6 = Size('min-w-6'); // 24px (1.5rem)
  static const Size minW8 = Size('min-w-8'); // 32px (2rem)
  static const Size minW10 = Size('min-w-10'); // 40px (2.5rem)
  static const Size minW12 = Size('min-w-12'); // 48px (3rem)
  static const Size minW16 = Size('min-w-16'); // 64px (4rem)
  static const Size minW20 = Size('min-w-20'); // 80px (5rem)
  static const Size minW24 = Size('min-w-24'); // 96px (6rem)
  static const Size minW32 = Size('min-w-32'); // 128px (8rem)
  static const Size minW40 = Size('min-w-40'); // 160px (10rem)
  static const Size minW48 = Size('min-w-48'); // 192px (12rem)
  static const Size minW56 = Size('min-w-56'); // 224px (14rem)
  static const Size minW64 = Size('min-w-64'); // 256px (16rem)
  static const Size minW72 = Size('min-w-72'); // 288px (18rem)
  static const Size minW80 = Size('min-w-80'); // 320px (20rem)
  static const Size minW96 = Size('min-w-96'); // 384px (24rem)

  // Ui container-based minimum widths
  // These follow the container scale and are useful for responsive layouts
  static const Size minW3xs = Size('min-w-3xs'); // 16rem (256px)
  static const Size minW2xs = Size('min-w-2xs'); // 18rem (288px)
  static const Size minWxs = Size('min-w-xs'); // 20rem (320px)
  static const Size minWsm = Size('min-w-sm'); // 24rem (384px)
  static const Size minWmd = Size('min-w-md'); // 28rem (448px)
  static const Size minWlg = Size('min-w-lg'); // 32rem (512px)
  static const Size minWxl = Size('min-w-xl'); // 36rem (576px)
  static const Size minW2xl = Size('min-w-2xl'); // 42rem (672px)
  static const Size minW3xl = Size('min-w-3xl'); // 48rem (768px)
  static const Size minW4xl = Size('min-w-4xl'); // 56rem (896px)
  static const Size minW5xl = Size('min-w-5xl'); // 64rem (1024px)
  static const Size minW6xl = Size('min-w-6xl'); // 72rem (1152px)
  static const Size minW7xl = Size('min-w-7xl'); // 80rem (1280px)

  // Special minimum width values
  // These provide different ways to handle content and viewport-based minimums
  static const Size minWFull = Size('min-w-full'); // 100% of parent width
  static const Size minWMin = Size('min-w-min'); // min-content
  static const Size minWMax = Size('min-w-max'); // max-content
  static const Size minWFit = Size('min-w-fit'); // fit-content

  // Viewport-based minimum widths
  static const Size minWScreen = Size('min-w-screen'); // 100vw
  static const Size minWDvw = Size('min-w-dvw'); // 100dvw
  static const Size minWLvw = Size('min-w-lvw'); // 100lvw
  static const Size minWSvw = Size('min-w-svw'); // 100svw

  // Fixed maximum widths following the standard 4px (0.25rem) scale
  // These provide precise control over maximum element sizes
  static const Size maxW0 = Size('max-w-0'); // 0px - Useful for collapsing elements
  static const Size maxW1 = Size('max-w-1'); // 4px (0.25rem)
  static const Size maxW2 = Size('max-w-2'); // 8px (0.5rem)
  static const Size maxW3 = Size('max-w-3'); // 12px (0.75rem)
  static const Size maxW4 = Size('max-w-4'); // 16px (1rem)
  static const Size maxW5 = Size('max-w-5'); // 20px (1.25rem)
  static const Size maxW6 = Size('max-w-6'); // 24px (1.5rem)
  static const Size maxW8 = Size('max-w-8'); // 32px (2rem)
  static const Size maxW10 = Size('max-w-10'); // 40px (2.5rem)
  static const Size maxW12 = Size('max-w-12'); // 48px (3rem)
  static const Size maxW16 = Size('max-w-16'); // 64px (4rem)
  static const Size maxW20 = Size('max-w-20'); // 80px (5rem)
  static const Size maxW24 = Size('max-w-24'); // 96px (6rem)
  static const Size maxW32 = Size('max-w-32'); // 128px (8rem)
  static const Size maxW40 = Size('max-w-40'); // 160px (10rem)
  static const Size maxW48 = Size('max-w-48'); // 192px (12rem)
  static const Size maxW56 = Size('max-w-56'); // 224px (14rem)
  static const Size maxW64 = Size('max-w-64'); // 256px (16rem)
  static const Size maxW72 = Size('max-w-72'); // 288px (18rem)
  static const Size maxW80 = Size('max-w-80'); // 320px (20rem)
  static const Size maxW96 = Size('max-w-96'); // 384px (24rem)

  // Ui container-based maximum widths
  // These provide consistent maximum widths that align with the design system
  static const Size maxW3xs = Size('max-w-3xs'); // 16rem (256px)
  static const Size maxW2xs = Size('max-w-2xs'); // 18rem (288px)
  static const Size maxWxs = Size('max-w-xs'); // 20rem (320px)
  static const Size maxWsm = Size('max-w-sm'); // 24rem (384px)
  static const Size maxWmd = Size('max-w-md'); // 28rem (448px)
  static const Size maxWlg = Size('max-w-lg'); // 32rem (512px)
  static const Size maxWxl = Size('max-w-xl'); // 36rem (576px)
  static const Size maxW2xl = Size('max-w-2xl'); // 42rem (672px)
  static const Size maxW3xl = Size('max-w-3xl'); // 48rem (768px)
  static const Size maxW4xl = Size('max-w-4xl'); // 56rem (896px)
  static const Size maxW5xl = Size('max-w-5xl'); // 64rem (1024px)
  static const Size maxW6xl = Size('max-w-6xl'); // 72rem (1152px)
  static const Size maxW7xl = Size('max-w-7xl'); // 80rem (1280px)

  // Special maximum width values
  // These handle various content and viewport-based maximums
  static const Size maxWFull = Size('max-w-full'); // 100% of parent width
  static const Size maxWMin = Size('max-w-min'); // min-content
  static const Size maxWMax = Size('max-w-max'); // max-content
  static const Size maxWFit = Size('max-w-fit'); // fit-content
  static const Size maxWProse = Size('max-w-prose'); // 65 characters (approx)
  static const Size maxWNone = Size('max-w-none'); // No maximum width

  // Viewport-based maximum widths
  static const Size maxWScreen = Size('max-w-screen'); // 100vw
  static const Size maxWDvw = Size('max-w-dvw'); // 100dvw
  static const Size maxWLvw = Size('max-w-lvw'); // 100lvw
  static const Size maxWSvw = Size('max-w-svw'); // 100svw

  // Additional viewport-specific heights for Ui containers
  static const Size h3xs = Size('h-3xs'); // 16rem (256px)
  static const Size h2xs = Size('h-2xs'); // 18rem (288px)
  static const Size hxs = Size('h-xs'); // 20rem (320px)
  static const Size hsm = Size('h-sm'); // 24rem (384px)
  static const Size hmd = Size('h-md'); // 28rem (448px)
  static const Size hlg = Size('h-lg'); // 32rem (512px)
  static const Size hxl = Size('h-xl'); // 36rem (576px)
  static const Size h2xl = Size('h-2xl'); // 42rem (672px)
  static const Size h3xl = Size('h-3xl'); // 48rem (768px)
  static const Size h4xl = Size('h-4xl'); // 56rem (896px)
  static const Size h5xl = Size('h-5xl'); // 64rem (1024px)
  static const Size h6xl = Size('h-6xl'); // 72rem (1152px)
  static const Size h7xl = Size('h-7xl'); // 80rem (1280px)

  // Fixed heights following the standard 4px (0.25rem) scale
  // These provide precise control for smaller UI elements
  static const Size h0 = Size('h-0'); // 0px - Useful for collapsing elements
  static const Size h1 = Size('h-1'); // 4px (0.25rem)
  static const Size h2 = Size('h-2'); // 8px (0.5rem)
  static const Size h3 = Size('h-3'); // 12px (0.75rem)
  static const Size h4 = Size('h-4'); // 16px (1rem) - Common line height
  static const Size h5 = Size('h-5'); // 20px (1.25rem)
  static const Size h6 = Size('h-6'); // 24px (1.5rem)
  static const Size h8 = Size('h-8'); // 32px (2rem)
  static const Size h10 = Size('h-10'); // 40px (2.5rem)
  static const Size h12 = Size('h-12'); // 48px (3rem)
  static const Size h16 = Size('h-16'); // 64px (4rem)
  static const Size h20 = Size('h-20'); // 80px (5rem)
  static const Size h24 = Size('h-24'); // 96px (6rem)
  static const Size h32 = Size('h-32'); // 128px (8rem)
  static const Size h40 = Size('h-40'); // 160px (10rem)
  static const Size h48 = Size('h-48'); // 192px (12rem)
  static const Size h56 = Size('h-56'); // 224px (14rem)
  static const Size h64 = Size('h-64'); // 256px (16rem)
  static const Size h72 = Size('h-72'); // 288px (18rem)
  static const Size h80 = Size('h-80'); // 320px (20rem)
  static const Size h96 = Size('h-96'); // 384px (24rem)

  // Fractional heights
  // These are particularly useful for responsive layouts and vertical splits
  static const Size h1_2 = Size('h-1/2'); // 50%
  static const Size h1_3 = Size('h-1/3'); // 33.333333%
  static const Size h2_3 = Size('h-2/3'); // 66.666667%
  static const Size h1_4 = Size('h-1/4'); // 25%
  static const Size h2_4 = Size('h-2/4'); // 50%
  static const Size h3_4 = Size('h-3/4'); // 75%
  static const Size h1_5 = Size('h-1/5'); // 20%
  static const Size h2_5 = Size('h-2/5'); // 40%
  static const Size h3_5 = Size('h-3/5'); // 60%
  static const Size h4_5 = Size('h-4/5'); // 80%
  static const Size h1_6 = Size('h-1/6'); // 16.666667%
  static const Size h2_6 = Size('h-2/6'); // 33.333333%
  static const Size h3_6 = Size('h-3/6'); // 50%
  static const Size h4_6 = Size('h-4/6'); // 66.666667%
  static const Size h5_6 = Size('h-5/6'); // 83.333333%

  // Special height values
  // These provide different ways to handle viewport and content-based heights
  static const Size hAuto = Size('h-auto'); // Let the browser determine height
  static const Size hFull = Size('h-full'); // 100% of parent's height
  static const Size hScreen = Size('h-screen'); // 100vh - Full viewport height
  static const Size hMin = Size('h-min'); // Fit content, minimum height
  static const Size hMax = Size('h-max'); // Fit content, maximum height
  static const Size hFit = Size('h-fit'); // Fit content

  // Modern viewport height units
  // These provide better control over viewport heights, especially on mobile
  static const Size hDvh = Size('h-dvh'); // Dynamic viewport height
  static const Size hLvh = Size('h-lvh'); // Largest viewport height
  static const Size hSvh = Size('h-svh'); // Smallest viewport height
  static const Size hDvw = Size('h-dvw'); // Dynamic viewport width as height
  static const Size hLvw = Size('h-lvw'); // Largest viewport width as height
  static const Size hSvw = Size('h-svw'); // Smallest viewport width as height

  // Fixed minimum heights using the standard spacing scale
  // These ensure elements maintain at least a certain height while allowing for expansion
  static const Size minH0 = Size('min-h-0'); // 0px - Removes any minimum height
  static const Size minH1 = Size('min-h-1'); // 4px (0.25rem)
  static const Size minH2 = Size('min-h-2'); // 8px (0.5rem)
  static const Size minH3 = Size('min-h-3'); // 12px (0.75rem)
  static const Size minH4 = Size('min-h-4'); // 16px (1rem)
  static const Size minH5 = Size('min-h-5'); // 20px (1.25rem)
  static const Size minH6 = Size('min-h-6'); // 24px (1.5rem)
  static const Size minH8 = Size('min-h-8'); // 32px (2rem)
  static const Size minH10 = Size('min-h-10'); // 40px (2.5rem)
  static const Size minH12 = Size('min-h-12'); // 48px (3rem)
  static const Size minH16 = Size('min-h-16'); // 64px (4rem)
  static const Size minH20 = Size('min-h-20'); // 80px (5rem)
  static const Size minH24 = Size('min-h-24'); // 96px (6rem)
  static const Size minH32 = Size('min-h-32'); // 128px (8rem)
  static const Size minH40 = Size('min-h-40'); // 160px (10rem)
  static const Size minH48 = Size('min-h-48'); // 192px (12rem)
  static const Size minH56 = Size('min-h-56'); // 224px (14rem)
  static const Size minH64 = Size('min-h-64'); // 256px (16rem)
  static const Size minH72 = Size('min-h-72'); // 288px (18rem)
  static const Size minH80 = Size('min-h-80'); // 320px (20rem)
  static const Size minH96 = Size('min-h-96'); // 384px (24rem)

  // Ui container-based minimum heights
  // These match the container scale for consistent vertical spacing
  static const Size minH3xs = Size('min-h-3xs'); // 16rem (256px)
  static const Size minH2xs = Size('min-h-2xs'); // 18rem (288px)
  static const Size minHxs = Size('min-h-xs'); // 20rem (320px)
  static const Size minHsm = Size('min-h-sm'); // 24rem (384px)
  static const Size minHmd = Size('min-h-md'); // 28rem (448px)
  static const Size minHlg = Size('min-h-lg'); // 32rem (512px)
  static const Size minHxl = Size('min-h-xl'); // 36rem (576px)
  static const Size minH2xl = Size('min-h-2xl'); // 42rem (672px)
  static const Size minH3xl = Size('min-h-3xl'); // 48rem (768px)
  static const Size minH4xl = Size('min-h-4xl'); // 56rem (896px)
  static const Size minH5xl = Size('min-h-5xl'); // 64rem (1024px)
  static const Size minH6xl = Size('min-h-6xl'); // 72rem (1152px)
  static const Size minH7xl = Size('min-h-7xl'); // 80rem (1280px)

  // Special minimum height values
  // These handle various content and viewport-based minimums
  static const Size minHFull = Size('min-h-full'); // 100% of parent height
  static const Size minHScreen = Size('min-h-screen'); // 100vh - Traditional viewport height
  static const Size minHMin = Size('min-h-min'); // min-content
  static const Size minHMax = Size('min-h-max'); // max-content
  static const Size minHFit = Size('min-h-fit'); // fit-content

  // Modern viewport-based minimum heights
  // These provide better control over viewport heights on mobile devices
  static const Size minHDvh = Size('min-h-dvh'); // Dynamic viewport height
  static const Size minHLvh = Size('min-h-lvh'); // Largest viewport height
  static const Size minHSvh = Size('min-h-svh'); // Smallest viewport height

  // Viewport width as minimum height
  // Useful for maintaining aspect ratios
  static const Size minHDvw = Size('min-h-dvw'); // Dynamic viewport width
  static const Size minHLvw = Size('min-h-lvw'); // Largest viewport width
  static const Size minHSvw = Size('min-h-svw'); // Smallest viewport width

  // Fixed maximum heights using the standard spacing scale
  // These utilities help constrain elements to specific maximum heights
  // while still allowing them to be smaller if their content requires less space
  static const Size maxH0 = Size('max-h-0'); // 0px - Completely collapses the element
  static const Size maxH1 = Size('max-h-1'); // 4px (0.25rem)
  static const Size maxH2 = Size('max-h-2'); // 8px (0.5rem)
  static const Size maxH3 = Size('max-h-3'); // 12px (0.75rem)
  static const Size maxH4 = Size('max-h-4'); // 16px (1rem)
  static const Size maxH5 = Size('max-h-5'); // 20px (1.25rem)
  static const Size maxH6 = Size('max-h-6'); // 24px (1.5rem)
  static const Size maxH8 = Size('max-h-8'); // 32px (2rem)
  static const Size maxH10 = Size('max-h-10'); // 40px (2.5rem)
  static const Size maxH12 = Size('max-h-12'); // 48px (3rem)
  static const Size maxH16 = Size('max-h-16'); // 64px (4rem)
  static const Size maxH20 = Size('max-h-20'); // 80px (5rem)
  static const Size maxH24 = Size('max-h-24'); // 96px (6rem)
  static const Size maxH32 = Size('max-h-32'); // 128px (8rem)
  static const Size maxH40 = Size('max-h-40'); // 160px (10rem)
  static const Size maxH48 = Size('max-h-48'); // 192px (12rem)
  static const Size maxH56 = Size('max-h-56'); // 224px (14rem)
  static const Size maxH64 = Size('max-h-64'); // 256px (16rem)
  static const Size maxH72 = Size('max-h-72'); // 288px (18rem)
  static const Size maxH80 = Size('max-h-80'); // 320px (20rem)
  static const Size maxH96 = Size('max-h-96'); // 384px (24rem)

  // Ui container-based maximum heights
  // These match the container scale for consistent vertical constraints
  // across your application's components
  static const Size maxH3xs = Size('max-h-3xs'); // 16rem (256px)
  static const Size maxH2xs = Size('max-h-2xs'); // 18rem (288px)
  static const Size maxHxs = Size('max-h-xs'); // 20rem (320px)
  static const Size maxHsm = Size('max-h-sm'); // 24rem (384px)
  static const Size maxHmd = Size('max-h-md'); // 28rem (448px)
  static const Size maxHlg = Size('max-h-lg'); // 32rem (512px)
  static const Size maxHxl = Size('max-h-xl'); // 36rem (576px)
  static const Size maxH2xl = Size('max-h-2xl'); // 42rem (672px)
  static const Size maxH3xl = Size('max-h-3xl'); // 48rem (768px)
  static const Size maxH4xl = Size('max-h-4xl'); // 56rem (896px)
  static const Size maxH5xl = Size('max-h-5xl'); // 64rem (1024px)
  static const Size maxH6xl = Size('max-h-6xl'); // 72rem (1152px)
  static const Size maxH7xl = Size('max-h-7xl'); // 80rem (1280px)

  // Special maximum height values
  // These provide different ways to handle content and viewport-based maximums,
  // giving you flexibility in how your elements respond to their content
  static const Size maxHFull = Size('max-h-full'); // 100% of parent height
  static const Size maxHScreen = Size('max-h-screen'); // 100vh - Traditional viewport height
  static const Size maxHMin = Size('max-h-min'); // min-content
  static const Size maxHMax = Size('max-h-max'); // max-content
  static const Size maxHFit = Size('max-h-fit'); // fit-content
  static const Size maxHNone = Size('max-h-none'); // No maximum height constraint

  // Modern viewport-based maximum heights
  // These new viewport units provide better control over sizing,
  // especially on mobile devices where browser UI can affect the viewport
  static const Size maxHDvh = Size('max-h-dvh'); // Dynamic viewport height
  static const Size maxHLvh = Size('max-h-lvh'); // Largest viewport height
  static const Size maxHSvh = Size('max-h-svh'); // Smallest viewport height

  // Viewport width as maximum height
  // These can be useful for maintaining aspect ratios
  // or creating height constraints based on viewport width
  static const Size maxHDvw = Size('max-h-dvw'); // Dynamic viewport width
  static const Size maxHLvw = Size('max-h-lvw'); // Largest viewport width
  static const Size maxHSvw = Size('max-h-svw'); // Smallest viewport width

  static String _formatValue(double value) {
    if (value == value.truncate()) {
      return value.truncate().toString();
    }
    return value.toString();
  }

  @override
  Size create(List<PrefixModifier> modifiers) {
    return Size(cssClass, modifiers: modifiers);
  }
}
