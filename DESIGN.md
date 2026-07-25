---
name: Presentation Surfaces
description: A rail-concourse departure board that reports what the build cost.
colors:
  flap-black: "#0D0D0F"
  flap-shadow: "#1B1B1E"
  flap-face: "#141417"
  flap-white: "#F2F2F2"
  flap-dim: "#9A9CA1"
  flap-faint: "#6E7076"
  delay-amber: "#FFB400"
  amber-dim: "#8A6410"
  cancelled-red: "#D32F2F"
  ontime-green: "#4CAF6D"
  steel-frame: "#B6BBC2"
  steel-dark: "#7D838C"
  steel-deep: "#3A3D42"
  signal-blue: "#2E8BFF"
  rule: "#2A2A2E"
typography:
  display:
    fontFamily: "Arial Narrow, Helvetica Neue Condensed, Roboto Condensed, sans-serif"
    fontSize: "clamp(30px, 4.6cqw, 74px)"
    fontWeight: 700
    lineHeight: 1.06
    letterSpacing: "0.06em"
  headline:
    fontFamily: "Arial Narrow, Helvetica Neue Condensed, Roboto Condensed, sans-serif"
    fontSize: "clamp(22px, 2.9cqw, 46px)"
    fontWeight: 700
    lineHeight: 1.1
    letterSpacing: "0.05em"
  row:
    fontFamily: "Arial Narrow, Helvetica Neue Condensed, Roboto Condensed, sans-serif"
    fontSize: "clamp(13px, 1.35cqw, 24px)"
    fontWeight: 700
    lineHeight: 1.2
    letterSpacing: "0.08em"
  body:
    fontFamily: "ui-monospace, SFMono-Regular, SF Mono, Menlo, Consolas, monospace"
    fontSize: "clamp(11px, 0.95cqw, 16px)"
    fontWeight: 400
    lineHeight: 1.6
    letterSpacing: "0.01em"
  label:
    fontFamily: "ui-monospace, SFMono-Regular, SF Mono, Menlo, Consolas, monospace"
    fontSize: "clamp(9px, 0.7cqw, 12px)"
    fontWeight: 700
    lineHeight: 1.4
    letterSpacing: "0.18em"
  data:
    fontFamily: "ui-monospace, SFMono-Regular, SF Mono, Menlo, Consolas, monospace"
    fontSize: "clamp(20px, 2.4cqw, 44px)"
    fontWeight: 700
    lineHeight: 1
    letterSpacing: "0.01em"
    fontFeature: "tabular-nums"
rounded:
  none: "0px"
  hair: "1px"
  cell: "2px"
  chip: "2px"
  housing: "3px"
spacing:
  cell-gap: "2px"
  row-pad: "clamp(8px, 0.9cqw, 15px) clamp(10px, 1.1cqw, 18px)"
  board-inset: "clamp(16px, 2.2cqw, 38px)"
  frame: "clamp(10px, 1.1vw, 18px)"
components:
  flap-cell:
    backgroundColor: "{colors.flap-face}"
    textColor: "{colors.flap-white}"
    typography: "{typography.display}"
    rounded: "{rounded.cell}"
  board-row:
    backgroundColor: "{colors.flap-black}"
    textColor: "{colors.flap-white}"
    typography: "{typography.row}"
    rounded: "{rounded.none}"
    padding: "clamp(8px, 0.9cqw, 15px) clamp(10px, 1.1cqw, 18px)"
  chip-ontime:
    backgroundColor: "transparent"
    textColor: "{colors.flap-white}"
    rounded: "{rounded.chip}"
    padding: "3px 10px"
  chip-delayed:
    backgroundColor: "transparent"
    textColor: "{colors.delay-amber}"
    rounded: "{rounded.chip}"
    padding: "3px 10px"
  chip-cancelled:
    backgroundColor: "transparent"
    textColor: "{colors.cancelled-red}"
    rounded: "{rounded.chip}"
    padding: "3px 10px"
  button:
    backgroundColor: "{colors.flap-black}"
    textColor: "{colors.flap-white}"
    rounded: "{rounded.chip}"
    padding: "7px 13px"
  button-active:
    backgroundColor: "transparent"
    textColor: "{colors.delay-amber}"
    rounded: "{rounded.chip}"
    padding: "7px 13px"
---

# Design System: Presentation Surfaces

## Overview

**Creative North Star: "The Departure Board"**

The deck is a rail-concourse split-flap board mounted in a brushed steel housing. Not a
slide that resembles one — the actual object, with flap cells that carry a split line
through every character, a steel frame with visible bolts, and rows that report status in
the board's own language.

The fiction was chosen because its native context *is* the room the deck is shown in: a
departure board is the one object designed to be read simultaneously by a hall full of
people standing at different distances. Every constraint that matters here — legible from
the back, high contrast under bad light, figures in fixed cells that compare cleanly down
a column — is a constraint the board solved decades ago in hardware.

It also settles the status palette without argument. Amber means attention, red means
this one costs you, white means nominal. The deck's spend figures are already that
vocabulary; the board just makes it literal. And because a split-flap board is **matte,
painted, mechanical**, the surface cannot drift into the glowing dark-keynote look that
every AI-generated "dark deck" lands on. There is no glow in this world.

**Key Characteristics:**
- Every slide is a board in a steel frame; the frame is structure, not decoration
- Display type is condensed grotesk caps in flap cells, each split by a hinge line
- Comparisons are rows with fixed columns and a status chip, never cards
- Amber / red / white is a status language, never a decorative palette
- One orchestrated flip cascade per slide; silence in between
- Matte throughout — no glow, no gradient text, no glass

## Colors

Drenched. The surface **is** flap black; light exists only as painted type, amber lamps,
and the steel of the housing.

### Primary
- **Flap Black** (`#0D0D0F`): The board ground. Owns the whole surface.
- **Flap Face** (`#141417`): Individual flap cells, one step above the ground so the cell
  grid is visible without a border.
- **Flap Shadow** (`#1B1B1E`): The hinge line and cell gaps; reads as the gap between
  two physical flaps.
- **Flap White** (`#F2F2F2`): Painted character faces. Slightly off-white — paint on
  plastic, never pure #FFF.

### Status
The board's native vocabulary. These are the only saturated colors, and they always mean
state.
- **Delay Amber** (`#FFB400`): Attention. Active controls, the retry path, the figure the
  room should look at. 9.9:1 on flap black.
- **Cancelled Red** (`#D32F2F`): This one costs money. Metered spend, failures. 4.9:1.
- **On-Time Green** (`#4CAF6D`): Nominal, zero-cost, passing. 7.4:1.

### Steel
The housing, never the content.
- **Steel Frame** (`#B6BBC2`) / **Steel Dark** (`#7D838C`) / **Steel Deep** (`#3A3D42`):
  A three-stop brushed gradient. Bolt heads are radial gradients between the light and
  dark stops.

### Neutral
- **Flap Dim** (`#9A9CA1`): Secondary row text and column headers. 7.0:1.
- **Flap Faint** (`#6E7076`): Tertiary annotation only. 3.6:1 — large text or non-essential.
- **Rule** (`#2A2A2E`): Hairline row separators.

### Signal
- **Signal Blue** (`#2E8BFF`): The Slalom thread, and the only non-board color. Brandmark,
  live rail segment, focus rings. Brightened from the incumbent `#0C62FB` because the
  original is unreadable on flap black. Never a status, never a fill.

### Named Rules

**The Status-Only Rule.** Amber, red, and green mean state. A figure is amber because the
room should look at it, never because amber looks good.

**The No-Glow Rule.** No `box-shadow` spread as light, no neon, no `filter: blur` halo, no
gradient text. The board is painted plastic and brushed steel under hall lighting. Depth
comes from the flap grid, the hinge line, and the steel frame.

**The One Blue Rule.** Signal Blue appears on the brandmark, the live rail segment, and
focus rings. Three places. It is the client's thread through the object, not a fourth
status.

## Typography

**Display / Row Font:** Arial Narrow → Helvetica Neue Condensed → Roboto Condensed
**Data / Label Font:** ui-monospace → SF Mono → Menlo → Consolas

**Character:** A condensed grotesk in caps, tracked wide, is what a flap can physically
carry — narrow enough to fit a cell, heavy enough to read at distance. It is paired with
monospace for anything numeric, because the board's whole promise is that a column of
figures lines up. No third family, no italic, no lowercase in display.

### Hierarchy
- **Display** (700, `clamp(30px, 4.6cqw, 74px)`, caps, ls 0.06em): The board's primary message.
  Rendered in flap cells. Opening and closing slides.
- **Headline** (700, `clamp(22px, 2.9cqw, 46px)`, caps, ls 0.05em): The claim per slide,
  also in flap cells.
- **Row** (700, `clamp(13px, 1.35cqw, 24px)`, caps, ls 0.08em): Destination-column text in
  board rows.
- **Body** (mono, 400, `clamp(11px, 0.95cqw, 16px)`, lh 1.6, max 68ch): Argument text and
  caveats. Mono at body size is legible here because the ground is dark and the measure
  is short.
- **Label** (mono, 700, `clamp(9px, 0.7cqw, 12px)`, ls 0.18em, caps): Column headers and
  the slide's single kicker.
- **Data** (mono, 700, `clamp(20px, 2.4cqw, 44px)`, tabular): Every figure.

### Named Rules

**The Caps-In-Cells Rule.** Display and headline type is uppercase and lives in flap
cells. A flap can only show one character; lowercase descenders would break the illusion
and the cell grid.

**The Container-Query Rule.** Carried over and still binding: type scales in `cqw` against
the board's own inline size, never `vw`. The projector's aspect ratio is unknown.

**The Tabular Rule.** Carried over: comparable figures are mono with `tabular-nums`. On a
board, a column that does not line up is a broken board.

## Layout

Every slide is a **board inside a steel frame**. The frame is a real border of
`clamp(10px, 1.1vw, 18px)` carrying a three-stop brushed gradient and four bolt heads at
the corners. Inside it, the board ground is inset by `clamp(16px, 2.2cqw, 38px)`.

The internal grammar is **rows before columns**. Any comparison of two or more things is a
row set with shared columns and a right-aligned status column — the departure-table form —
rather than side-by-side panels. Prose sits in a single column at ≤68ch against the board
ground with no container around it; a box around body text is a card, and this world does
not have cards.

Column headers are tracked mono caps in Flap Dim above a hairline rule. Rows separate with
`1px` Rule, never with gaps or shadows.

Below 900px the fixed aspect ratio is released, column sets collapse to two columns
(identity + value), and the status chip moves under the row label.

**The Rows-Not-Cards Rule.** If content is a comparison, it is a table of rows. Cards are
not part of this world; a bordered box floating on the board is an object the object
doesn't have.

## Elevation & Depth

Flat and matte, and now for a reason the world supplies rather than one imposed on it:
a split-flap board has no lit surfaces. Depth is physical, not luminous —

1. the **flap grid** (cells one step lighter than the ground),
2. the **hinge line** (a 1px Flap Shadow rule across each cell's midpoint),
3. the **steel frame** and its bolts.

**The No-Shadow Rule.** Unchanged and now stronger: no `box-shadow` anywhere. The frame
is the only depth cue the object has.

## Shapes

Square. `border-radius` is `0` on every structural element; flap cells and chips take
`2px` only, which is the corner radius of a physical flap. Two other steps exist and are
the complete set: `1px` on the small bar cells, and `3px` on the outer steel housing —
the only rounded thing in the system, because the frame is milled metal, not a flap. The `50%` step markers from the
previous world are gone — the board numbers rows, it does not draw circles.

The −11° skew of the previous identity is **retired**. It belonged to the old world and has
no counterpart on a mechanical board; the diagonal has been replaced by the hinge line as
the system's recurring mark.

## Components

Character: **mechanical and reportorial.** Every element is something the physical object
would actually have. Nothing is invented to hold content.

### Flap Cell
- Each display/headline character sits in its own cell: Flap Face ground, `2px` radius,
  a `1px` Flap Shadow hinge across the vertical midpoint, `2px` gaps
- Spaces render as an empty cell, preserving the grid
- Cells are generated at runtime from text content, so copy stays editable and selectable

### Board Row
- Grid with fixed columns; `1px` Rule separator; `clamp(8px,0.9cqw,15px)` block padding
- Left columns are Row type in Flap White, secondary columns Flap Dim, status right-aligned
- No background fill at rest; the row is legible because the board is dark

### Status Chip
- `1px` border in its status color, transparent fill, `2px` radius, tracked mono caps
- `ON TIME` white · `DELAYED` amber · `CANCELLED` red
- The chip is the only bordered element in the content area

### Button (presenter chrome)
- Flap Black ground, `1px` Steel Deep border, tracked mono caps in Flap White, `2px` radius
- **Hover:** border to Steel Dark
- **Active** (`aria-pressed="true"`): border and text to Delay Amber, ground unchanged
- Focus-visible: `2px` Signal Blue outline, `2px` offset

### Bar Row
- The comparison chart, restated as board rows: label column, then a bar drawn as a run of
  flap cells rather than a solid fill, then the value in Data type
- The "before" series is Flap Dim cells; the "after" series is Delay Amber cells
- Cell-count encoding is the point — a bar you can *count* beats a bar you must measure

### Split-Flap Headline (signature)
The one authored motion in the system. On slide entry, each cell cycles glyphs and settles
left-to-right with a per-cell stagger, the way a real board updates. Runs **once** per
slide, ~40ms per cell, capped at ~700ms total. Under
`prefers-reduced-motion: reduce` the text is simply present, no cycling.

## Do's and Don'ts

### Do:
- **Do** render display and headline copy in flap cells, uppercase.
- **Do** express any comparison as rows with shared columns and a status chip.
- **Do** keep the steel frame on every slide; it is what makes the surface an object.
- **Do** use amber to point the room at the figure that matters, once per slide.
- **Do** scale type in `cqw` against the board, and set every figure in tabular mono.
- **Do** keep the cascade to one orchestrated run per slide, with a reduced-motion path
  that shows the text immediately.
- **Do** keep the print stylesheet working: the board prints as flat black-on-white with
  the frame suppressed, one slide per page. `#FFF`, `#000`, and `#333` appear **only**
  inside the `@media print` block; the palette above governs screen and is never mixed
  with them.

### Don't:
- **Don't** add glow, neon, gradient text, or blur. The object is matte.
- **Don't** add a `box-shadow`. The frame and the flap grid are the only depth.
- **Don't** put body text in a bordered box. This world has rows, not cards.
- **Don't** use a status color decoratively, or introduce a fourth.
- **Don't** set display type in lowercase or outside flap cells.
- **Don't** animate more than the one cascade per slide; ambient clatter destroys it.
- **Don't** reintroduce the −11° skew; it belongs to the retired world.
- **Don't** use Signal Blue for anything but the brandmark, live rail, and focus ring.
