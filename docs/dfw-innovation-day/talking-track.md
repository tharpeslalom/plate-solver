# Tokenomics — talking track

**DFW Innovation Day · Bryan Tharpe & Kiran · 10 minutes · discussion-led**

Deck: [`tokenomics-deck.html`](./tokenomics-deck.html) — press `S` for these notes per
slide, `T` to start the talk clock.

**Thesis in one line:** AI cost is an architecture problem, not a procurement problem.

**Scope:** the v1 plate-solver build only, 2026-06-25 → 2026-07-01. Nothing from the v2
rebuild appears anywhere in this talk.

---

## Timing

| # | Slide | Mark | Budget |
|---|---|---|---|
| 1 | We built it for $61 | 0:00 | 0:25 |
| 2 | **Two levers** | 0:25 | **1:10** |
| 3 | What it does | 1:35 | 0:55 |
| 4 | The rig | 2:30 | 1:05 |
| 5 | **The build loop** | 3:35 | **1:15** |
| 6 | What that did to the bill | 4:50 | 1:10 |
| 7 | Route by size | 6:00 | 0:55 |
| 8 | Stop buying the same context twice | 6:55 | 0:55 |
| 9 | Measure it (Grafana) | 7:50 | 0:50 |
| 10 | Three moves | 8:40 | 0:50 |
| 11 | Discussion | 9:30 | 0:30 |
| — | Appendix A · what the first days cost | backup | — |
| — | Appendix B · sources | backup | — |

**Shape of the talk:** slide 2 states both levers up front; slides 5–8 are the evidence.
If the room only hears one slide, it should be slide 2.

The clock warns at 8:30. **Cut rule, in order:** if you are behind at slide 6, drop
slide 7 to one line ("eighty-five percent local, and the judge alone would have been a
hundred and sixty dollars") and go to caching. Behind at slide 8, skip Grafana and
promise it after. Slides 2 and 5 are the two you must not rush.

---

## 1 · We built it for $61 — *0:00*

> We are **not** going to talk about the price of tokens. Everyone has seen the
> price-per-million table, and it is the least interesting number in this conversation.
>
> Here is the number that is interesting. One week of building a real piece of software.
> Run the obvious way, it was five hundred and seventy-four dollars. We paid **sixty-one**.
>
> Nobody gave us a discount. We changed the architecture. Ten minutes, then let's argue
> about it.

*Three cells, left to right: what it should have cost, what we paid, the difference. Let
the middle one sit before you move.*

---

## 2 · Two levers — *0:25* · **the whole talk, up front**

*This is the slide the room should leave with. Everything after it is evidence.*

> Before the story, the two ideas.
>
> **One: the right model for the job.** Writing a function against a written spec is not
> the same task as deciding whether that function is correct. We price them the same
> anyway — everything goes to the best model we have, out of habit, not analysis. Sort the
> work first. Judgment to the frontier model, volume to a small model on hardware you
> already own. *(point)* Eighty-five percent of the calls in this build never left the
> laptop.
>
> **Two: pay once for the same context.** An agent re-reads its entire world on every
> single turn — the spec, the code, the conversation so far. Priced fresh each time, that
> repetition *is* your invoice. Cached, the identical tokens cost a tenth. *(point)*
> Eleven hundred and twenty-two dollars, one week.
>
> Neither of those is a discount, a vendor call, or a negotiation.

*If the clock is already tight, this is still the slide you protect. Cut later, not here.*

---

## 3 · What it does — *1:35*

**`[LIVE?]`** If the app is up: drop the image in, FOV 11, hit Solve. Otherwise the
screenshot is real output and nobody will know.

> Quickly, because this is not the subject. This is a plate solver. You hand it a
> photograph of the night sky — no GPS, no timestamp, nothing — and it tells you where the
> camera was pointed. It is how a satellite finds itself when it is lost in space.
>
> *(point)* Forty-seven catalog stars matched, in **1.8 milliseconds**.
>
> The only reason this slide exists: the bill I am about to show you bought **working,
> benchmarked software** — not a demo. The product is the receipt, not the subject.

*Sixty seconds. If you are still on this slide at 1:45, move.*

---

## 4 · The rig — *2:30*

*People assume there is a cluster behind this. Thirty seconds to kill that assumption.*

> Worth a moment on what this actually ran on.
>
> *(walk the left column)* A MacBook Pro I already owned. A quantised open-weights model
> on the GPU. LiteLLM — open source — as the switchboard. Claude Code doing the work. And
> a **forty-line bash loop** keeping it going in a tmux session while I made dinner.
>
> *(right side — this is the trick)* Claude Code asks for a model **by name**. The
> switchboard decides what actually answers, and the tool never finds out. Ask for
> "sonnet", get the local model. Ask for "haiku", get the local model. The one model I
> chose to keep on the meter is the only thing that bills.
>
> That is a **config file**, not a rewrite. Same commands, same tool, same repo.
>
> *(point at the red row)* Which means the build itself was **free**. Claude Code was fired
> on the sonnet alias, so it resolved to the local model — every row above the red one cost
> nothing to run. The meter only ever ran when **I** opened a session to check on it. Sixty
> dollars and eighty cents of me looking over its shoulder.

**`[IF ASKED]`** Capital cost: zero. That is the point — there was nothing to procure.

---

## 5 · The build loop — *3:35* · **the slide that explains the number**

*Slow down here. Everything else is a consequence of this diagram.*

> On the left: a **plan file**. A human wrote it once — the spec, the task list, what done
> means. It is the only thing that persists, which is why the whole thing survives a
> restart.

*Walk the four boxes.*

> Then the loop. Pick the next unblocked task. A **local model, running on this Mac**,
> writes the code. A **judge — a different model family entirely** — reviews it. If it
> fails, back to step two, up to three times, then it parks itself for a human rather than
> burning tokens in a retry spiral. If it passes: gates run, and it commits.

*Now point at the cost tags, one at a time.*

> Zero. Zero. Zero. Zero. **Every stage of actually building the software had no marginal
> cost.**

*Point at the red box.*

> And that is the entire bill. Sixty dollars and eighty cents — **me, on a frontier model,
> watching it run.** Five and a half percent of the calls. Ninety-nine and a half percent
> of the spend.

Two design notes worth saying out loud:

> **Fresh agent per task.** The agent exits when its task is done, so context never
> compounds and cost stays flat as the project grows.
>
> **The author never grades its own homework.** That is a correctness decision first — but
> a cheap independent reviewer also catches what you would otherwise pay frontier prices
> to catch.

---

## 6 · What that did to the bill — *4:50*

> Same project. Same specs. Same models available to me.
>
> *(left bars, orange)* The first week I drove it myself. A hundred and ninety-four
> million tokens, four hundred and five dollars.
>
> *(right bars, blue)* The week on the loop. Three hundred and twenty million tokens —
> **sixty-five percent more work** — for **sixty-one dollars**.
>
> The pair I actually care about is the third one. Cost per million tokens went from two
> dollars nine to nineteen cents. **Eleven times cheaper per unit of work.**

**Volunteer the caveat — don't wait to be caught:**

> Be straight about this: the manual week included writing specs and architecture.
> Genuinely different work, not just slower typing. So take the unit-cost trend as the
> claim, not a task-for-task comparison. The cleaner number is the counterfactual — the
> identical three hundred and twenty million tokens, all on the frontier model, was five
> hundred and seventy-four dollars.

---

## 7 · Route by size — *6:00*

> Lever one, with the receipts. You have already seen the switchboard — this is where
> every call in that week actually went.

*Walk the three rows.*

> Five thousand eight hundred and eighty calls served locally — that is electricity. Six
> hundred and fifty-four to the judge, on a flat-fee subscription I had already paid for.
> And three hundred and eighty-one frontier calls: sixty dollars and eighty cents.
>
> *(point at the two right-hand columns)* **Volume and spend point in opposite
> directions.** The tier doing nearly all the work bills nothing. The tier doing five and
> a half percent of the calls is basically the whole invoice.
>
> So the interesting question is never "which model is best." It is **which of these three
> rows does this particular task belong in** — and you can usually answer that before you
> dispatch it.

**`[IF PRESSED]`** At frontier rates the judge alone would have been a hundred and sixty
dollars — taking the build from sixty-one to two hundred and twenty-one.

---

## 8 · Stop buying the same context twice — *6:55*

> Lever two, and the largest number in this deck — larger than every routing decision
> combined.

*Read the three cells top to bottom as one sentence.*

> Run the obvious way, this build was **sixteen hundred and ninety-six dollars**. Turning
> on caching alone took **eleven hundred and twenty-two** off it. Routing then took most
> of the rest, down to sixty-one.
>
> Which is the uncomfortable part: **the biggest lever required no model change at all.**
> It is a header, a stable prompt prefix, and someone bothering to check the hit rate.
> Pure engineering — and nobody gets promoted for it.

*This is the slide to compress if you are behind.*

---

## 9 · Measure it — *7:50*

**`[LIVE]`** Alt-tab to Grafana. **Open the pre-filtered board, not the default one:**

```
http://localhost:3001/d/plate-solver-v1
```

It opens scoped to `plate-solver`, windowed to Jun 25 – Jul 1 UTC, baseline Opus 4.8 —
frontier spend reads **$61.13**, matching the deck. The default board is machine-wide and
will contradict you.

> None of what I just told you was reconstructed for this talk. It is instrumented, and I
> can re-run every number in the room.
>
> *(two panels only)* **The distribution** — volume sits on the cheap tier, but spend
> concentrates in a handful of expensive calls. You cannot find those without this board.
> **And realized savings** — the counterfactual, tracked continuously.
>
> The framing I would leave you with: tokens is an **input** metric. Cost per unit of
> delivered work is a **business** metric. Only one of those belongs on an executive's
> dashboard.

---

## 10 · Three moves — *8:40*

> **Route by size, not by habit.** Most tasks don't need the frontier model, and the ones
> that do are identifiable before you dispatch them. A router is cheaper than a better
> model.
>
> **Cache aggressively.** Biggest lever, least glamorous. Go ask your team what their cache
> hit rate is — most cannot answer, and that is the finding.
>
> **Bound the context.** Long-lived agents get expensive because context compounds. Ending
> the process is a cost control.
>
> We did not get cheaper by finding cheaper tokens. We got cheaper by changing where the
> work runs, and how often we pay for the same context.

---

## 11 · Discussion — *9:30*

*Read the three questions. Then stop talking. Let the room fill the silence.*

If nobody bites, go to the **cache** one — it is the question where people discover they
don't know their own number, and that reliably starts the conversation.

---

## Q&A backup

**"Isn't the local model just worse?"**
> For most tasks, no — and that is the point of sizing the work before you dispatch it. But
> I would not have trusted it without the review architecture around it. The local model
> writes; a different model family reviews; deterministic gates run before either of them
> gets a vote. The routing decision and the verification decision are the same decision.

**"Your 'free' tiers aren't free."**
> Correct, and I should be precise. The judge's subscription was already being paid for, so
> I count it as zero *marginal* cost — the right basis for a routing decision and the wrong
> basis for total cost of ownership. The local model is hardware and electricity. Add your
> hardware amortisation if you want the fully-loaded number; the routing conclusion does
> not change.

**"The counterfactual is doing a lot of work."**
> It is, and it is directional. It assumes the same token volume would have run on the
> frontier model. In practice a smaller model sometimes needs more turns, so the true
> saving is somewhat lower. What is *not* estimated is the sixty-one dollars — that is
> metered, and it is on the board behind me.

**"How do you trust code no human wrote?"**
> You don't trust the author. You make its output falsifiable by something it cannot
> influence. Here that is a parity test against an independent Python reference the code
> under test did not produce. Agreement with it is external validation, not
> self-certification.

**"Did the loop actually catch anything?"**
> Yes — appendix A. On June 28 the judge failed a task on step ordering and the loop opened
> its own follow-up rather than merging it or stalling. That review cost nothing marginal.
> Catching it at frontier prices would not have.

**"What went wrong?"**
> The first three days. Four hundred and five dollars, and June 10 alone was three hundred
> and thirteen — one day, more than five times the entire loop week, with only nineteen
> percent running locally. That day bought the architecture. All three fixes are in the v1
> git history: move the judge off the frontier tier and trim the orchestrator's context;
> add a deferred judge queue so review batches instead of blocking a paid seat; add a flag
> to route review to a cheaper account entirely. Note the first cost fix was a *context*
> fix.

**"Does this scale past one developer?"**
> The mechanism does — it is a router and a plan file, not a personality. What I cannot
> claim from this data is team-scale behaviour: this is one person, one repo, one week. The
> levers are general; my evidence is narrow.

**"Why not just use the cheap model for everything?"**
> Because the expensive tier earns its place where judgment decides the outcome. The
> discipline is treating it as a budget rather than a default. On this build that budget
> went almost entirely to human oversight — which, in hindsight, is the line item I would
> attack next.

**"What would you do differently?"**
> Cache from day one instead of day three, and get myself out of the monitoring loop
> sooner. Ninety-nine and a half percent of the bill was a human watching a machine work.
> That is the next thing to automate, not the code generation.

---

## Rehearsal checklist

- [ ] `T` starts the clock. Practise once to the warn at 8:30 — **slides 2 and 5 must land**.
- [ ] Grafana up, with the **`plate-solver-v1`** board open in a tab (not the default
      board). Confirm it reads **$61.13**.
- [ ] `ps-web` running for the slide-3 live solve, or accept the screenshot.
- [ ] Know these seven cold: **$61 · $574 · $1,122 · 320M · 85% · 5.5% of calls / 99.5% of
      bill · 11×**.
- [ ] Practise saying the slide-6 caveat *before* anyone asks for it.
- [ ] Print to PDF as the projector-failure backup.
- [ ] Fix the brand palette token block if the real Slalom values are available.
