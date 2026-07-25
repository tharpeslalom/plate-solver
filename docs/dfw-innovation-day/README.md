# DFW Innovation Day — Tokenomics session

A 10-minute, discussion-led session on AI cost optimization, anchored on the **v1 build of
this repository** as the worked example.

| File | What it is |
|------|------------|
| [`tokenomics-deck.html`](./tokenomics-deck.html) | The deck. Single self-contained file — open it in any browser, no build, no network. |
| [`storyline.md`](./storyline.md) | The narrative outline, the numbers, and the honest caveats. Read this first. |
| [`talking-track.md`](./talking-track.md) | The script, timing marks, Q&A backup, and rehearsal checklist. |

## Running the deck

Open `tokenomics-deck.html` in a browser. Everything is inlined; it works offline.

| Key | Action |
|-----|--------|
| `←` `→` `Space` | Navigate |
| `S` | Speaker notes (per slide) |
| `T` / `R` | Start-pause / reset the 10-minute talk clock |
| `G` | Overview grid |
| `1`–`15` | Jump to slide (type both digits) |
| `?` | All shortcuts |

## Printing

```bash
./print.sh            # → tokenomics-deck.pdf, 15 pages, one slide per page
```

`tokenomics-deck.pdf` is committed, so you only need this after editing the deck.

**Printing it on paper.** The pages are 1600×900 px (16:9), so in the print dialog pick
**landscape**, scale **Fit to page**, and turn **background graphics ON** — without it you
lose the red/green, and in this deck those are accounting terms, not decoration. The stock
prints white; only the ink is coloured, so it is not toner-hungry apart from the slide-5
screenshot of the dark app UI.

**Don't use Cmd-P on the HTML directly** unless you have to. Chrome resolves print media
queries against the default paper width before `@page` applies, and the deck's own
`@page { size: 1600px 900px }` is what keeps the layout identical to the screen. `print.sh`
pins that; the browser dialog may not.

**Handouts.** For a leave-behind, `talking-track.md` is the better document — it has the
timing table, the full script, the cut rule, and the eight Q&A answers.

## The argument

AI cost is an architecture problem, not a procurement problem. Same project, same specs,
same models available — the bill fell 11× per unit of work because of *where the work ran*
and *how often the same context was paid for*.

| | Manual · Jun 9–11 | Ralph loop · Jun 25 – Jul 1 |
|---|---|---|
| Tokens delivered | 194 M | **320 M** |
| Ran on a local model | 19% of calls | **85% of calls** |
| Paid | **$405** | **$61** |
| Unit cost | $2.09 / MTok | **$0.19 / MTok** |
| Cost per commit | $16.88 | **$1.18** |

Cost per commit is the row to lead with for an executive audience: tokens are an input
metric and nobody sets a budget in them. Commits are not a uniform unit of work, but both
columns are counted the same way and every commit in the loop week passed an independent
judge and the full gate suite.

The frontier model was **5.5% of the calls and 99.5% of the bill** — and those calls were
human monitoring, not the loop doing its work. Every stage of the build itself (write,
review, gate, commit) had zero marginal cost.

## Framing

Slides 3, 4 and 11 borrow their frame from the **Slalom FinOps for AI · Tokenomics POV**
(Jason Prell): the four faces of a token, the cost-driver chain, and cost per successful
outcome. The source `.pptx` is marked DRAFT / INTERNAL ONLY and is **gitignored** — it is
not in this repo. The deck credits the POV on slides 3 and 4.

## Scope

**v1 only**, per the brief: the first build, from the first ralph-loop task to
functional-complete. Nothing from the v2 spec-only rebuild appears in the deck.

- **Window:** 2026-06-25 → 2026-07-01
- **Lineage:** `bryantharpe/plate-solver`; tag `v1-original` = `185128e` (absent on
  `tharpeslalom`, whose `main` is frozen at `104de07`, Jun 30 — the same boundary)
- **Not counted:** work after Jul 1 moved to a home DGX under a different orchestrator and
  is not in the usage database.

## Data source

Every figure is live from the Postgres usage store behind the Grafana dashboard in
`~/mac-llm-env` (`usage_events` × `model_prices`), scoped to the `plate-solver` folders.
Appendix B (slide 15) maps each claim to its query or commit. There are **no placeholder figures** in
this version.

To re-run the headline numbers:

```sh
docker exec macllm-postgres psql -U macllm -d usage -c "
  SELECT count(*), round(SUM(input_tokens+output_tokens+cache_creation_tokens+cache_read_tokens)/1e6,1) AS mtok
  FROM usage_events
  WHERE folder LIKE '/Users/bryant/code/plate-solver%'
    AND ts::date BETWEEN '2026-06-25' AND '2026-07-01';"
```

Grafana, pre-filtered to this build: <http://localhost:3001/d/plate-solver-v1>
(provisioned from `~/mac-llm-env/monitoring/grafana/dashboards/plate-solver-v1.json`;
anonymous read-only viewing is on). The machine-wide board is at `/d/macllm-llm-cost`.

## Before presenting

1. **Brand palette.** `slalom.com` was unreachable from the build environment, so the
   colors are brand-adjacent rather than sampled. Every color derives from the token block
   at the top of the HTML — correcting it is a single-block edit.
2. **Use the pre-filtered Grafana board** — <http://localhost:3001/d/plate-solver-v1>.
   It opens scoped to `plate-solver`, windowed to Jun 25 – Jul 1 UTC, baseline Opus 4.8,
   and reads **$61.13**. The default board is machine-wide and will contradict the deck.
3. **Optional:** the usage database has no price row for `claude-opus-5`, so those calls
   count as $0 elsewhere in the project. It does not affect any figure in this deck (no
   Opus 5 in the v1 window), but the live board under-reports until it's added.
