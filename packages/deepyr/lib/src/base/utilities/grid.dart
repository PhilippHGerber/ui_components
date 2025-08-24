// TODO
import '../common_style.dart';
import '../style_type.dart';
import '../ui_prefix_modifier.dart';

class Grid extends CommonStyle<Grid> {
  const Grid(super.cssClass, {super.modifiers}) : super(type: StyleType.layout);

  // gridTemplateColumns
  // - grid-cols-<number>
  // - grid-cols-none
  // - grid-cols-subgrid
  // - grid-cols-[<value>]
  // - grid-cols-(<custom-property>)

  // gridColumn
  // - col-span-<number>
  // - col-span-full
  // - col-span-(<custom-property>)
  // - col-span-[<value>]
  // - col-start-<number>
  // - -col-start-<number>
  // - col-start-auto
  // - col-start-(<custom-property>)
  // - col-start-[<value>]
  // - col-end-<number>
  // - -col-end-<number>
  // - col-end-auto
  // - col-end-(<custom-property>)
  // - col-end-[<value>]
  // - col-auto
  // - col-(<custom-property>)
  // - col-[<value>]

  // gridTemplateRows
  // - grid-rows-<number>
  // - grid-rows-none
  // - grid-rows-subgrid
  // - grid-rows-[<value>]
  // - grid-rows-(<custom-property>)

  // gridRow
  // - row-span-<number>
  // - row-span-full
  // - row-span-(<custom-property>)
  // - row-span-[<value>]
  // - row-start-<number>
  // - -row-start-<number>
  // - row-start-auto
  // - row-start-(<custom-property>)
  // - row-start-[<value>]
  // - row-end-<number>
  // - -row-end-<number>
  // - row-end-auto
  // - row-end-(<custom-property>)
  // - row-end-[<value>]
  // - row-auto
  // - row-(<custom-property>)
  // - row-[<value>]

  // gridAutoFlow
  // - grid-flow-row
  // - grid-flow-col
  // - grid-flow-dense
  // - grid-flow-row-dense
  // - grid-flow-col-dense

  // gridAutoColumns
  // - auto-cols-auto
  // - auto-cols-min
  // - auto-cols-max
  // - auto-cols-fr
  // - auto-cols-(<custom-property>)
  // - auto-cols-[<value>]

  // gridAutoRows
  // - auto-rows-auto
  // - auto-rows-min
  // - auto-rows-max
  // - auto-rows-fr
  // - auto-rows-(<custom-property>)
  // - auto-rows-[<value>]

  @override
  Grid create(List<PrefixModifier> modifiers) {
    return Grid(cssClass, modifiers: modifiers);
  }
}
