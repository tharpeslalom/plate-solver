# Tokenomics — proposed storyline (v3)

**Audience:** DFW Innovation Day, mixed/less-technical. **Length:** 10 min, discussion-led.
**Thesis:** AI cost is an architecture problem, not a procurement problem.

**Scope:** the v1 build, from the first ralph-loop task to functional-complete and
debugged. Two phases of the *same project, same person, same specs* — which makes this a
natural A/B rather than a vendor comparison.

| Phase | Window | Commits |
|---|---|---|
| **A — manual** | Jun 9–11 | specs authored, first crates hand-driven |
| **B — ralph loop** | Jun 25 – Jul 1 | `ps-core` → `ps-solve` → `ps-grpc`, end-to-end parity, `8932c62` workspace integration + `8f32748` post-implementation archive |

All figures pulled live from the Postgres usage store behind the Grafana dashboard,
scoped to the `plate-solver` folders. Nothing is a placeholder.

---

## The one number

Same project. Same specs. Same models on the menu.

| | Phase A — manual | Phase B — ralph loop |
|---|---|---|
| Work delivered | 194M tokens | **320M tokens** |
| Ran on a local model | 19% of calls | **85% of calls** |
| **Paid** | **$405** | **$61** |
| **Unit cost** | **$2.09 / Mtok** | **$0.19 / Mtok** |

**65% more work delivered, for 15% of the money. Unit cost fell 11×.**

And within Phase B, against the counterfactual of running the identical workload on the
frontier model:

| | |
|---|---|
| Same 320M tokens, all on Opus | **$574** |
| …and without prompt caching | **$1,696** |
| **Actually paid** | **$61** |

---

## The punchline stat

> **The frontier model was 5.5% of the calls and 99.5% of the bill.**
> 381 of 6,922 calls. $60.80 of $61.13.
> And those calls were *me watching the loop run* — not the loop doing its work.

Every stage of the build itself — write the code, review the code, run the gates, commit
— had **zero marginal cost**. The only metered thing in the room was the human checking
on it.

---

## Slide-by-slide

### 1 · Title *(0:00, 30s)*
> **"We built it for $61."**
> Tokenomics isn't about the price of tokens.

Three tiles: `320M tokens` · `$61 paid` · `89% below list`.

### 2 · What we actually built *(0:30, 60s)*
> **"A photo of the sky in. Where the camera was pointed, out."**

Keep the existing solver screenshot. Plain-language framing: *astronomy software that
works out where a telescope was aimed, in about two milliseconds.* One beat: it's real,
it's benchmarked against an independent reference, it works. Then move on — the product
is the receipt, not the subject.

### 3 · The build loop *(1:30, 120s)* ← **NEW, and the slide that explains everything**
> **"Specs in. Working code out. Nothing in the loop costs money."**

An animated/annotated flow. Proposed layout:

```
   plan.md
  ┌─────────┐        ╔══════════════ THE LOOP ══════════════╗
  │  SPEC   │        ║                                      ║
  │    +    │───────▶║   ①  pick next unblocked task        ║
  │  task   │        ║              │                       ║
  │  list   │        ║              ▼                       ║
  └─────────┘        ║   ②  LOCAL MODEL writes the code     ║
   human, once       ║      qwen3.6-27b · on this Mac       ║
                     ║              │                       ║
                     ║              ▼                       ║
                     ║   ③  JUDGE reviews it                ║
                     ║      glm-5.2 · different lineage     ║
                     ║          │        │                  ║
                     ║    FAIL  │        │  PASS            ║
                     ║    ◀─────┘        ▼                  ║
                     ║   retry ≤3×   ④  COMMIT              ║
                     ║                   │                  ║
                     ╚═══════════════════┼══════════════════╝
                                         │
                                         └──▶ next task, fresh agent
```

Each box carries a **cost tag**, and that's the visual payoff — they're all `$0`:

| Stage | Who does it | Marginal cost |
|---|---|---|
| ① Pick the task | the loop | $0 |
| ② Write the code | local model, on this Mac | $0 — electricity |
| ③ Review the code | judge model, flat-fee subscription | $0 — already paid |
| ④ Gates + commit | compiler, tests, git | $0 — deterministic |
| *(off to the side)* **watching it** | **frontier model** | **$60.80** |

Three things to say over it:
- **Fresh agent per task.** The agent exits when its task is done. Context never
  compounds, so cost stays flat as the project grows instead of climbing.
- **The author never grades its own homework.** The judge is a different model family.
  A cheap independent reviewer catches what you'd otherwise pay frontier prices for.
- **Three strikes.** Fail three reviews and the task parks itself for a human instead of
  burning tokens in a retry spiral.

### 4 · What that did to the bill *(3:30, 90s)* ← **the money slide**
The A/B table from above, as two bars plus a unit-cost callout:

- Phase A — manual: **$405** for 194M tokens
- Phase B — ralph loop: **$61** for 320M tokens
- **$2.09/Mtok → $0.19/Mtok**

*"Same project. Same week's worth of specs. The second phase did more work for a
sixth of the money, and the difference is entirely where the work ran."*

### 5 · Lever 1 — route by size *(5:00, 90s)*
> **85% of calls never left the building.**

A **switchboard** (LiteLLM) sits between the coding tool and the models. The tool asks
for a model by name; the switchboard decides what actually serves it — and it quietly
serves most requests from a model running on the laptop.

| Where the work went | Calls | What it cost |
|---|---|---|
| Local model, on this Mac | 5,880 | electricity |
| Judge, flat-fee cloud | 654 | already paid |
| Frontier (Opus) | 381 | **$60.80** |

Say out loud: *the coding tool believes it is calling a commercial model. Nothing
upstream had to change. That is a config file, not a rewrite.*

### 6 · Lever 2 — stop buying the same context twice *(6:30, 60s)*
> **Caching was worth more than everything else combined: $1,122.**

Plain English: an agent re-reads the same background — the spec, the code, the
conversation so far — on *every single turn*. Charged fresh, that's most of a bill.
Cached, the same tokens cost **a tenth**.

Without caching, this build would have been **$1,696** instead of $574 even before any
routing. Least glamorous lever, biggest number.

### 7 · You can't manage what you can't see *(7:30, 60s)*
Live Grafana (screenshot inlined as backup). Point at two things only:
- **Cost per day by model** — spend concentrates in a handful of expensive calls.
- **Realized savings** — the counterfactual tracked continuously, not reconstructed
  after the fact for a slide.

*"Tokens is an input metric. Cost per unit of delivered work is a business metric. Only
one of them belongs on an executive's dashboard."*

### 8 · Three things to take back *(8:30, 60s)*
1. **Route by size, not by habit.** Most tasks don't need the frontier model. A router
   is cheaper than a better model.
2. **Cache aggressively.** Biggest single lever, pure engineering, no vendor call.
3. **Bound the context.** Ending the process is a cost control. Long-lived agents get
   expensive because context compounds.

Closing: *"We didn't get cheaper by finding cheaper tokens. We got cheaper by changing
where the work runs, and how often we pay for the same context."*

### 9 · Discussion *(9:30, 30s)*
- Where are you paying frontier prices for work a small model could do?
- Do you know your cache hit rate? It's usually the biggest lever and nobody measures it.
- Do you know your cost per delivered thing — or just your monthly bill?

---

## Appendix (backup, not presented)

- **A — Two failures worth more than the successes.** Keep it. The runaway-context burn
  (72 min, 1,410 commands, zero output) is now directly on-thesis: it's what happens
  *without* the loop's context bounding.
- **B — Where every number came from.** Each figure mapped to its SQL query against
  `usage_events`, so any claim can be re-run live in the room.

---

## Two corrections to what you remembered

1. **The judge ran on glm-5.2, not Sonnet.** In the whole ralph window there are exactly
   **2** `claude-sonnet-4-6-real` calls. The judge was routed to real Sonnet on Jun 10
   (`f207947`), but by the time the loop was running in earnest it had moved to glm-5.2
   via the `--judge-model` flag (`0af42c4`) — 654 calls. This actually *strengthens* the
   story: the judge was flat-fee, so independent review cost nothing marginal. Had it
   run on Opus it would have been ~$160, more than doubling the build.
2. **Your Opus recollection is exactly right.** 381 Opus calls, $60.80 — 99.5% of the
   total bill, and it was monitoring, not building.

## Honest caveats (say these if asked)

1. **"Flat-fee" isn't free.** The judge's subscription was already being paid for.
   Counting it as zero *marginal* cost is the right basis for a routing decision, not
   for total cost of ownership.
2. **The $574 counterfactual assumes identical token volume on Opus.** A smaller local
   model sometimes needs more turns, so the true saving is somewhat lower. Directional,
   and I'll present it that way.
3. **The local model isn't free either** — hardware and electricity, and it only became
   trustworthy because of the review architecture around it.
4. **Phase A isn't purely "manual."** It included spec authoring and heavy Opus use for
   architecture, which is genuinely different work — not just slower coding. The unit-cost
   comparison is fair; a like-for-like task comparison would be tighter.
5. **One data gap, now known:** the usage DB has no price row for Opus 5, so 392 calls
   elsewhere in the project count as $0. It does not affect the Phase A/B figures above
   (no Opus 5 in either window).
