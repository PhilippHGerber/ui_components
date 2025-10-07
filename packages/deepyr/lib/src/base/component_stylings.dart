import '../../deepyr.dart';

/// A central "interface aggregator" mixin that is fundamental to the type-safe
/// styling system of the Deepyr library.
///
/// ### The Problem This Solves
///
/// The Deepyr styling system has two categories of [Styling] objects:
///
/// 1.  **Component-Specific Styles**: Modifiers that are unique to a single
///     component (e.g., `Button.primary`, which is a `ButtonStyling`). The type
///     system correctly prevents these from being used on the wrong component.
///
/// 2.  **General-Purpose Utilities**: Modifiers that should be applicable to *any*
///     component (e.g., `Spacing.p(4)`, `Effects.shadowLg`, `BgUtil.primary`).
///
/// The challenge is to allow general-purpose utilities to be used in any
/// component's `style` list, which expects a specific type. For example, `Button`
/// expects a `List<ButtonStyling>`, while `Card` expects a `List<CardStyling>`.
///
/// ### The Solution: Universal Interface Implementation
///
/// This mixin solves the problem by implementing every single component-specific
/// styling interface (like `ButtonStyling`, `CardStyling`, etc.).
///
/// The base class for all general-purpose utilities, `CommonStyle`, then implements
/// this single `AllComponentStylings` mixin. By doing so, every utility class
/// like `Spacing`, `Effects`, and `Layout` automatically satisfies the type
/// requirements for *every* component's `style` property.
///
/// ```dart
/// // An instance of a general utility like Spacing...
/// final padding = Spacing.p(4);
///
/// // ...is now valid for both a Button and a Card, because Spacing
/// // implements AllComponentStylings.
/// Button([text('Click')], style: [Button.primary, padding]); // Compiles successfully
/// Card([text('Content')], style: [Card.border, padding]);    // Compiles successfully
///
/// // However, component-specific styles remain protected.
/// // This still results in a compile-time error, as intended.
/// Card([text('Content')], style: [Button.primary]);
/// ```
///
/// ### A Deliberate Design Choice
///
/// At first glance, a large, empty mixin that implements dozens of interfaces
/// might seem unusual. However, it is a deliberate and pragmatic design pattern
/// chosen for its significant architectural benefits:
///
/// - **Maximum Maintainability**: When a new component, `NewComponent`, is added
///   to the library, its `NewComponentStyling` interface only needs to be added
///   to this single mixin. Without this aggregator, every single general utility
///   class (`Spacing`, `Effects`, etc.) would need to be manually updated to
///   implement `NewComponentStyling`, which would be highly error-prone and
///   unscalable.
///
/// - **Preservation of Type Safety**: This pattern only "loosens" the type
///   constraints for general utilities, which is the desired behavior. It does not
///   compromise the strict type safety of component-specific modifiers.
///
/// - **Developer Experience**: It enables a clean and intuitive API where developers
///   can freely and safely mix general layout and style utilities with
///   component-specific modifiers in any `style` list.
///
/// In summary, `AllComponentStylings` is the cornerstone of the library's flexible
/// and scalable styling architecture. It is a targeted solution that makes the
/// entire system work seamlessly.
mixin AllComponentStylings
    implements
        AccordionStyling,
        AlertStyling,
        AvatarStyling,
        BadgeStyling,
        ButtonStyling,
        BreadcrumbsStyling,
        CardStyling,
        CheckboxStyling,
        CollapseStyling,
        CountdownStyling,
        DiffStyling,
        DividerStyling,
        DrawerStyling,
        DropdownStyling,
        DropdownContentStyling,
        FieldsetStyling,
        FileInputStyling,
        FooterStyling,
        FormLabelStyling,
        HeroStyling,
        IconStyling,
        IndicatorStyling,
        IndicatorItemStyling,
        InputStyling,
        JoinStyling,
        KbdStyling,
        LabelStyling,
        LegendStyling,
        LinkStyling,
        ListingStyling,
        ListRowStyling,
        ListColStyling,
        LoadingStyling,
        MaskStyling,
        MenuStyling,
        MenuItemStyling,
        ModalStyling,
        NavbarStyling,
        ProgressStyling,
        RadialProgressStyling,
        RadioStyling,
        RangeStyling,
        SelectStyling,
        SkeletonStyling,
        StatsStyling,
        StatStyling,
        StatFigureStyling,
        StatTitleStyling,
        StatValueStyling,
        StatDescStyling,
        StatActionsStyling,
        StatusStyling,
        SwapStyling,
        TableStyling,
        TabsStyling,
        TabStyling,
        TextareaStyling,
        TimelineStyling,
        TimelineContentStyling,
        ThemeControllerStyling,
        ToggleStyling,
        TooltipStyling,
        ValidatorHintStyling {
  // Empty mixin - only Interface
}
