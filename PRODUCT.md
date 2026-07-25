# Product

## Register

brand

## Users

Rooms of mixed technical depth. The anchor case is DFW Innovation Day: consultants,
practice leads, and engineering leaders sitting through a ten-minute slot, some of whom
write code and some of whom own a budget. They are not reading; they are watching from
across a room, often under bad projection, with a phone in reach.

The job they're trying to get done is deciding whether the thing on screen changes how
they'd run their own work. Success is not comprehension — it's that they leave believing
AI cost is an architectural problem, and go check a number they'd never checked before
(most often their own cache hit rate).

Secondary context: these decks get re-opened later, alone, as a document. They have to
survive being read without a presenter.

## Product Purpose

Presentation surfaces — conference decks, talk collateral, demo framing — that argue a
technical position from measured evidence.

These exist to change a mind in ten minutes. The argument is always the same shape: an
expected framing is wrong, here is a real system, here is what it actually cost, here is
the architectural decision that moved the number, go measure your own. The deck is the
deliverable; there is no other artifact the audience takes away.

Success looks like a room that argues back. A talk that produces silence has failed even
if every slide was correct.

## Brand Personality

**Evidence-first, plain, contrarian.**

Opens by rejecting the obvious framing rather than building up to it. Leads with the
metered number, not the setup. Uses plain words for technical things — "switchboard," not
"routing layer"; "stop buying the same context twice," not "prompt cache optimization."

Confident because it shows receipts, never because it asserts. Volunteers its own
weaknesses before the room finds them, which is where the credibility actually comes
from. Dry rather than energetic; the numbers do the shouting.

Visually Slalom-adjacent — reads as family without being a pixel-exact brand
application. Brand identity is carried by restraint and typography, not by decoration.

## Anti-references

- **Generic consulting deck.** Template chrome, bullet grids, three-column icon rows, a
  framework diagram on every slide. The visual grammar the room has already sat through
  five hundred times, and stopped seeing.
- **SaaS pitch deck.** Hero metric plus gradient accent plus logo wall plus "trusted by."
  Startup-fundraise grammar; reads as selling, which poisons an evidence argument.
- **AI-generated slop.** Gradient text, identical card grids, tiny uppercase tracked
  eyebrows above every section, 01/02/03 numbered scaffolding used as page furniture. A
  deck arguing about AI economics cannot itself look AI-generated.
- **Dense academic slides.** Wall-of-text bullets, unstyled charts, type that dies past
  the third row.

## Design Principles

1. **Show the receipt.** Every number on screen traces to something re-runnable — a
   query, a commit SHA, a live dashboard. Provenance is a design element, not an
   appendix afterthought. If a figure can't be sourced, it doesn't ship; a visibly empty
   slot beats a plausible invention.

2. **Volunteer the caveat.** Name the weakest part of the argument on the slide that
   makes the claim, not in Q&A. Stated limits are what make the rest believable. This is
   a layout requirement: caveats need real space, not footnote treatment.

3. **The number is the hero, the chrome is silent.** One claim per slide, carried by a
   figure large enough to read from the back. Everything else recedes. If a slide has two
   ideas, it's two slides or it's one idea.

4. **Built to be argued with.** The deck's job is to provoke disagreement, not to
   transfer information. Prefer the framing that invites a challenge over the one that
   forecloses it. End on questions, not a summary.

5. **Survives the room it's shown in.** Bad projector, back row, no presenter, printed as
   a PDF backup. Legibility under degraded conditions is a first-order constraint that
   outranks visual ambition.

## Accessibility & Inclusion

**Projector-first legibility plus WCAG AA.**

- Body text ≥4.5:1, large text ≥3:1, verified rather than assumed. Tinted near-whites
  with muted gray text are the specific failure to avoid.
- Categorical series colors must be distinguishable under color-vision deficiency, not
  only in normal vision. The current deck validates its two-series pair at CVD ΔE 31.6 /
  normal ΔE 40.6; new series colors are held to the same check.
- Never encode meaning in hue alone — pair color with label, position, or shape.
- Every animation needs a `prefers-reduced-motion: reduce` alternative. Reveals must
  enhance already-visible content; never gate content on a transition that won't fire in
  a headless or backgrounded render.
- Type sized for the back of a room, not for a laptop at arm's length.
- A print stylesheet is a hard requirement: one slide per page, chrome suppressed. The
  PDF is the projector-failure fallback.
