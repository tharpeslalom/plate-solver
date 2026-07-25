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
| 1 | We built it for $61 | 0:00 | 0:30 |
| 2 | What it does | 0:30 | 1:00 |
| 3 | **The build loop** | 1:30 | **2:00** |
| 4 | What that did to the bill | 3:30 | 1:30 |
| 5 | Route by size | 5:00 | 1:30 |
| 6 | Stop buying the same context twice | 6:30 | 1:00 |
| 7 | Measure it (Grafana) | 7:30 | 1:00 |
| 8 | Three moves | 8:30 | 1:00 |
| 9 | Discussion | 9:30 | 0:30 |
| — | Appendix A · what the first days cost | backup | — |
| — | Appendix B · sources | backup | — |

The clock warns at 8:30. **If you are behind at slide 5, cut slide 6 to one sentence**
("caching was worth eleven hundred dollars, ask me after") and go straight to Grafana.
Slide 3 is the one slide you must not rush.

---

## 1 · We built it for $61 — *0:00*

> We are **not** going to talk about the price of tokens. Everyone has seen the
> price-per-million table, and it is the least interesting number in this conversation.
>
> Here is the number that is interesting. One week of building a real piece of software.
> Three hundred and twenty million tokens of AI work. We paid **sixty-one dollars**. The
> same work run the obvious way was five hundred and seventy-four.
>
> Nobody gave us a discount. We changed the architecture. Ten minutes, then let's argue
> about it.

*Don't explain the levers yet. Let the number sit.*

---

## 2 · What it does — *0:30*

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

## 3 · The build loop — *1:30* · **the slide that explains the number**

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

## 4 · What that did to the bill — *3:30*

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

## 5 · Route by size — *5:00*

> Two levers got us there. Here is the first, and it is the one people find surprising.
>
> There is a **switchboard** between the coding tool and the models. The tool asks for a
> model by name. The switchboard decides what actually answers.
>
> The coding tool believes it is calling a commercial cloud model. **Most of those calls
> are being served by a model running on the laptop in front of you**, and it has no idea.
> That is a config file. Nothing upstream changed.

*Walk the three lanes.*

> Five thousand eight hundred calls local — that is electricity. Six hundred and fifty-four
> to the judge on a flat-fee subscription, already paid for; at frontier rates that review
> alone would have been a hundred and sixty dollars, more than doubling the build. And
> three hundred and eighty-one frontier calls, sixty dollars — which was me watching.

---

## 6 · Stop buying the same context twice — *6:30*

> Second lever, and it is the biggest number in the deck. It is also the most boring, which
> is why almost nobody does it.
>
> An agent re-reads the same background on *every single turn* — the spec, the code, the
> conversation so far. If you are charged fresh for that every time, it is most of your
> bill. Cached, the identical tokens cost **a tenth**.
>
> On this one week, caching was worth **eleven hundred and twenty-two dollars**. Without
> it, this build would have been sixteen hundred and ninety-six dollars before any routing
> at all.
>
> No vendor call. No model change. No negotiation. Pure engineering.

*This is the slide to compress if you are behind.*

---

## 7 · Measure it — *7:30*

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

## 8 · Three moves — *8:30*

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

## 9 · Discussion — *9:30*

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

- [ ] `T` starts the clock. Practise once to the warn at 8:30 — **slide 3 must land**.
- [ ] Grafana up, with the **`plate-solver-v1`** board open in a tab (not the default
      board). Confirm it reads **$61.13**.
- [ ] `ps-web` running for the slide-2 live solve, or accept the screenshot.
- [ ] Know these six cold: **$61 · $574 · 320M · 85% · 5.5% of calls / 99.5% of bill · 11×**.
- [ ] Practise saying the slide-4 caveat *before* anyone asks for it.
- [ ] Print to PDF as the projector-failure backup.
- [ ] Fix the brand palette token block if the real Slalom values are available.
