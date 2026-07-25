---
name: Presentation Surfaces
description: An itemised bill for one week of work. Cream stock, black ink, one red stamp. Nothing animates.
colors:
  paper: "#F4F1E6"
  paper-2: "#EBE7D8"
  paper-edge: "#DCD7C4"
  ink: "#16140F"
  ink-2: "#4C483C"
  ink-3: "#6E695B"
  rule: "#C6C0AD"
  rule-soft: "#D9D4C3"
  charged-red: "#B3261E"
  credited-green: "#1C6B3F"
  amber: "#8A5A00"
  signal-blue: "#14459B"
typography:
  display:
    fontFamily: "Arial Narrow, Helvetica Neue Condensed, Roboto Condensed, sans-serif"
    fontSize: "clamp(30px, 4.8cqw, 78px)"
    fontWeight: 700
    lineHeight: 1.06
    letterSpacing: "0.05em"
  headline:
    fontFamily: "Arial Narrow, Helvetica Neue Condensed, Roboto Condensed, sans-serif"
    fontSize: "clamp(22px, 3cqw, 48px)"
    fontWeight: 700
    lineHeight: 1.1
    letterSpacing: "0.045em"
  row:
    fontFamily: "Arial Narrow, Helvetica Neue Condensed, Roboto Condensed, sans-serif"
    fontSize: "clamp(13px, 1.35cqw, 24px)"
    fontWeight: 700
    lineHeight: 1.2
    letterSpacing: "0.07em"
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
spacing:
  cell-gap: "2px"
  row-pad: "clamp(8px, 0.9cqw, 15px) clamp(10px, 1.1cqw, 18px)"
  board-inset: "clamp(16px, 2.2cqw, 38px)"
  frame: "1px"
  stub: "clamp(14px, 1.5vw, 26px)"
components:
  headline:
    backgroundColor: "transparent"
    textColor: "{colors.ink}"
    typography: "{typography.display}"
    rounded: "{rounded.none}"
  line-item:
    backgroundColor: "{colors.paper}"
    textColor: "{colors.ink}"
    typography: "{typography.row}"
    rounded: "{rounded.none}"
    padding: "clamp(8px, 0.9cqw, 15px) clamp(10px, 1.1cqw, 18px)"
  stamp-neutral:
    backgroundColor: "transparent"
    textColor: "{colors.ink}"
    rounded: "{rounded.none}"
    padding: "3px 10px"
  stamp-credit:
    backgroundColor: "transparent"
    textColor: "{colors.credited-green}"
    rounded: "{rounded.none}"
    padding: "3px 10px"
  stamp-charge:
    backgroundColor: "transparent"
    textColor: "{colors.charged-red}"
    rounded: "{rounded.none}"
    padding: "3px 10px"
  button:
    backgroundColor: "{colors.paper}"
    textColor: "{colors.ink}"
    rounded: "{rounded.none}"
    padding: "7px 13px"
  button-active:
    backgroundColor: "transparent"
    textColor: "{colors.charged-red}"
    rounded: "{rounded.none}"
    padding: "7px 13px"
---

# Design System: Presentation Surfaces

## Overview

**Creative North Star: "The Ledger"**

The deck is an itemised bill for one week of work. Cream stock, black typewriter ink,
one red stamp. Every slide is a line item on the same document: faint ledger ruling,
dotted leaders running description across to amount, double rules under totals, and a
perforated stub down the left margin where you would tear it off.

The fiction was chosen for three reasons. It is **light**, which in a conference room
where every other AI talk is a glowing dark keynote is the contrarian read — the deck
is recognisable from the hallway. The talk already calls the product *"the receipt, not
the subject,"* so the form is the argument rather than a costume over it. And an invoice
settles the palette without debate: **red is a charge, green is a credit, black is
neutral.** No decorative colour exists, because a bill does not have one.

It also makes the thesis arithmetic. The opening slide is not a claim about savings; it
is four line items that sum to $61.13, and the room can check the subtraction. Every
credit on that bill is an engineering decision, which is the whole talk.

**Prior worlds, and why they were cut.** An Instrument Panel (light, blue, flat) was
replaced by a Departure Board (matte black, split-flap cells, brushed steel housing, a
flip cascade per slide). The board's mechanism was well-built and wrong — in a
ten-minute talk about cost, a headline that redraws itself every time you advance
competes with the presenter. Stripping the mechanism left the board too anonymous to
survive as a world. The Ledger replaces it outright; it was chosen over a brutalist type
poster, an engineering blueprint, and a terminal.

**Key Characteristics:**
- Every slide is a page of one document, not a card in a stack
- Figures are line items: qty, description, dotted leader, amount, right-aligned
- Totals rule off with a **double line** — the accounting convention for final
- Red charges, green credits, black neutral. There is no fourth colour and no accent
- Chips are rubber stamps: doubled rule, wide tracking, never filled
- **Nothing animates.** Slides change; their contents do not move
- Flat throughout — no glow, no gradient, no shadow. Paper on a desk

## Colors

Printed. The surface **is** the paper; everything else is ink laid on it. Two inks —
black and red — plus a green reserved for credits, which is the one liberty taken with
the metaphor and earned by how often this deck subtracts.

### Ground
- **Paper** (`#F4F1E6`): The stock. Owns every slide. A warm cream, never white, because
  white on a projector reads as a blown-out gap rather than a surface.
- **Paper 2** (`#EBE7D8`): Attachments and figure mounts — one step down, as if a second
  sheet were laid under the first.
- **Paper Edge** (`#DCD7C4`): The hairline cut edge of the sheet.

### Ink
- **Ink** (`#16140F`): Body of the document. Near-black, warm. 16.3:1 on paper.
- **Ink 2** (`#4C483C`): Secondary — prose, column heads. 8.1:1.
- **Ink 3** (`#6E695B`): Tertiary annotation and line-item subtitles. 4.8:1, which clears
  AA for small text; do not lighten it further.
- **Rule** (`#C6C0AD`) / **Rule Soft** (`#D9D4C3`): Dotted leaders and hairline separators.

### Money
The document's only saturated colours, and they are accounting terms, not decoration.
- **Charged Red** (`#B3261E`): This line costs money. Charges, the metered tier, the
  total due, the PAID stamp. 5.8:1.
- **Credited Green** (`#1C6B3F`): This line is a credit. Savings, $0 tiers, work routed
  off the meter. 5.8:1.
- **Amber** (`#8A5A00`): Held in reserve for a caution that is neither a charge nor a
  credit. 5.2:1. Currently unused in the deck; do not reach for it as a highlight.

### Signal
- **Signal Blue** (`#14459B`): The Slalom thread, and the only non-document colour.
  Brandmark and focus rings. 7.9:1. Darkened from `#2E8BFF` for the light ground. Never
  a status, never a fill.

### Named Rules

**The Accounting Rule.** Red is a charge, green is a credit, black is neutral. A figure
is red because it took money, never because it is important. If a number is neither a
charge nor a credit — a latency, a token count, a percentage of calls — it is black. This
replaces the retired Status-Only Rule and is stricter: the previous world let amber mean
"look here," and this one has no colour for that. Emphasis comes from size and position.

**The No-Glow Rule.** No `box-shadow`, no neon, no `filter: blur`, no gradient text. This
is ink on paper under room light. Depth comes from hairline rules, dotted leaders, and
one-step paper changes, nothing else.

**The One Blue Rule.** Signal Blue appears on the brandmark and focus rings. Two places.
It is the client's thread through the document, not a third ink.

## Typography

**Display / Row Font:** Arial Narrow → Helvetica Neue Condensed → Roboto Condensed
**Data / Label Font:** ui-monospace → SF Mono → Menlo → Consolas

**Character:** A condensed grotesk in caps, tracked wide, is the printed heading on a
form — narrow enough to fit a ruled column, heavy enough to read at distance. It is
paired with monospace for anything numeric, because the document's whole promise is that
a column of figures lines up and the subtraction can be checked. No third family, no
italic, no lowercase in display.

### Hierarchy
- **Display** (700, `clamp(30px, 4.8cqw, 78px)`, caps, ls 0.05em): The document's primary
  claim. Opening and closing slides.
- **Headline** (700, `clamp(22px, 3cqw, 48px)`, caps, ls 0.045em, max 26ch): The claim per
  page.
- **Row** (700, `clamp(13px, 1.35cqw, 24px)`, caps, ls 0.07em): Description-column text in
  line items.
- **Body** (mono, 400, `clamp(11px, 0.95cqw, 16px)`, lh 1.6, max 68ch): Argument text and
  caveats. Mono at body size is legible here because the measure is short and the
  contrast against paper is 8:1.
- **Label** (mono, 700, `clamp(9px, 0.7cqw, 12px)`, ls 0.18em, caps): Column headers and
  the page's single kicker, which runs a dotted leader out to the margin like a form field.
- **Data** (mono, 700, `clamp(20px, 2.4cqw, 44px)`, tabular): Every figure, always
  right-aligned in its column.

### Named Rules

**The Caps Rule.** Display and headline type is uppercase, tracked wide, set plainly on
the paper. It reads as the printed heading on a form, and it is what makes a headline
legible from the back of the room.

**The Container-Query Rule.** Carried over and still binding: type scales in `cqw` against
the board's own inline size, never `vw`. The projector's aspect ratio is unknown.

**The Tabular Rule.** Carried over: comparable figures are mono with `tabular-nums`. On a
board, a column that does not line up is a broken board.

## Layout

Every slide is a **page of one document**. The sheet has a 1px cut edge and a perforated
stub down the left margin — a dotted vertical rule at `clamp(14px, 1.5vw, 26px)` — so the
surface reads as paper you could tear rather than a slide that happens to be beige. The
page is inset by `clamp(16px, 2.2cqw, 38px)`, and carries a ledger ruling at 2% ink every
36px: visible as texture at reading distance, invisible as stripes from the back.

The internal grammar is **line items before columns**. Any comparison is a row set with
shared columns and a right-aligned amount — the invoice form — rather than side-by-side
panels. Prose sits in a single column at ≤68ch directly on the paper; a box around body
text is a card, and this world does not have cards.

Column headers are tracked mono caps in Ink 2 above a **solid** rule. Line items separate
with `1px dotted` Rule. Totals rule off with `3px double` Ink, above and below.

Below 900px the fixed aspect ratio is released, column sets collapse to two columns
(identity + value), and the status chip moves under the row label.

**The Rows-Not-Cards Rule.** If content is a comparison, it is a table of rows. Cards are
not part of this world; a bordered box floating on the board is an object the object
doesn't have.

## Elevation & Depth

Flat, for a reason the world supplies rather than one imposed on it: a printed bill has
no lit surfaces and no floating panels. Depth is physical, not luminous —

1. the **paper step** (attachments on Paper 2, one shade under the sheet),
2. the **rules** (dotted for line items, solid for headers, double for totals),
3. the **perforated stub** down the left margin.

**The No-Shadow Rule.** No `box-shadow` anywhere. Zero occurrences is the invariant, and
it is easier to hold here than in the dark world — paper does not cast light.

## Shapes

Square. `border-radius` is `0` on every element without exception, including chips and
buttons. This is stricter than the previous world, which allowed `2px` on its cells and
`3px` on the housing: a printed form has no rounded corners, so the whole rounded scale
collapses to `none`.

The **one rotation** in the system is the PAID stamp at `-5.5deg`. It is permitted
because a stamp is applied by hand after the document is printed — it is the only element
that is not part of the typeset page. Do not rotate anything else.

The −11° skew of the original identity remains **retired**.

## Components

Character: **printed and transactional.** Every element is something an invoice would
actually have. Nothing is invented to hold content.

### Headline
- Condensed grotesk caps, weight 700, `0.045em` tracking, `1.05` line height, on the paper
  with no container
- `h1` `clamp(30px, 4.8cqw, 78px)` · `h2` `clamp(22px, 3cqw, 48px)`, capped at `26ch`
- Plain text in the DOM: selectable, searchable, printable, and not built by script

### Line Item (row)
- Grid with fixed columns; `1px dotted` Rule separator; `clamp(8px,0.9cqw,15px)` padding
- Qty left, description and its subtitle centre, amount right in tabular mono
- Subtitles are Ink 3 and always sit under the description, never inline with it
- No background fill; the row is legible because the paper is light

### Total Line
- A line item with `3px double` Ink above it and no rule below
- Description reads `TOTAL DUE`; amount is Charged Red at `big` scale
- Only one per page. A document with two totals has not decided what it is claiming

### Stamp Chip
- `1px` border plus a `1px` outline at `2px` offset — a doubled rule, the impression of a
  rubber stamp — transparent fill, tracked mono caps, `0` radius
- Green for credits and `$0`, red for charges, black for neutral facts
- The chip is the only bordered element in the content area

### PAID Stamp (signature)
- Doubled `3px` red rule, `0.22em` tracking, rotated `-5.5deg`, transparent fill
- Appears **once in the deck**, beside the total on the opening slide. It is the mark the
  whole world is built around; using it twice spends it

### Button (presenter chrome)
- Paper ground, `1px` Rule border, tracked mono caps in Ink, `0` radius
- **Hover:** border to Ink 2
- **Active** (`aria-pressed="true"`): border and text to Charged Red, ground unchanged
- Focus-visible: `2px` Signal Blue outline, `2px` offset

### Bar Row
- The comparison chart as line items: label, then a bar drawn as a run of 18 discrete
  cells rather than a solid fill, then the value in tabular mono
- Unfilled cells are hairline Rule outlines; the "before" series fills Ink 2; the "after"
  series fills Credited Green, because on this deck the after series is always the credit
- Cell-count encoding is the point — a bar you can *count* beats a bar you must measure

### Named Rules

**The Still Board Rule.** Nothing on a slide animates. Slides replace each other; their
contents are simply there. An earlier build had a split-flap cascade — each character
cycling glyphs and settling with a per-cell stagger on slide entry. It was well-built,
reduced-motion-safe, and wrong: in a ten-minute talk about cost, a mechanism that redraws
the headline every time the presenter advances competes with the presenter. It was cut
deliberately, not lost. **Do not reintroduce it**, and do not add a replacement — no
fades, no counters ticking up, no reveals. The only motion in this deck is the person
talking. (The name predates the Ledger and is kept so the history stays traceable.)

**The One Stamp Rule.** The PAID stamp and the `-5.5deg` rotation it carries appear once
in the deck. Everything else on the page is typeset square.

## Do's and Don'ts

### Do:
- **Do** render display and headline copy in condensed caps, plainly on the paper.
- **Do** express any comparison as line items with shared columns and a right-aligned amount.
- **Do** rule off totals with a double line, and only ever one total per page.
- **Do** colour by accounting meaning: red charges, green credits, black everything else.
- **Do** scale type in `cqw` against the page, and set every figure in tabular mono.
- **Do** keep the print stylesheet working: the deck prints as flat black-on-white with
  the sheet edge and ledger ruling suppressed, one slide per page. `#FFF`, `#000`, and
  `#333` appear **only** inside the `@media print` block; the palette above governs
  screen and is never mixed with them.

### Don't:
- **Don't** add glow, neon, gradient text, or blur. This is ink on paper.
- **Don't** add a `box-shadow`. Rules are the only depth.
- **Don't** put body text in a bordered box. This world has line items, not cards.
- **Don't** colour a figure for emphasis. Red and green are accounting terms here; if a
  number needs attention, make it bigger or move it, do not tint it.
- **Don't** set display type in lowercase.
- **Don't** animate anything. See The Still Board Rule — the cascade was cut on purpose.
- **Don't** rotate anything except the one PAID stamp, and don't reintroduce the −11° skew.
- **Don't** use Signal Blue for anything but the brandmark and focus ring.
- **Don't** let the paper go pure white; `#F4F1E6` is the ground and white reads as a hole
  in the projection.
