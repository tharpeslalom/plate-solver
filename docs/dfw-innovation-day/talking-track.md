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
| 3 | What a token is | 1:35 | 0:35 |
| 4 | **What drives the bill** | 2:10 | 0:45 |
| 5 | What it does | 2:55 | 0:35 |
| 6 | **The build loop** | 3:30 | **1:10** |
| 7 | What that did to the bill | 4:40 | 0:50 |
| 8 | Route by size | 5:30 | 1:05 |
| 9 | Stop buying the same context twice | 6:35 | 0:55 |
| 10 | Measure it (Grafana) | 7:30 | 0:40 |
| 11 | **Cost per outcome** | 8:10 | 0:40 |
| 12 | Three moves | 8:50 | 0:40 |
| 13 | Discussion | 9:30 | 0:30 |
| — | Appendix A · what the first days cost | backup | — |
| — | Appendix B · sources | backup | — |

**Shape of the talk:** slides 2–4 are the frame — the two levers, what a token actually is,
and the four decisions that drive the bill. Slides 6–9 are the evidence for that frame, and
slide 11 converts it into the metric an executive can govern against. If the room only hears
three slides, they are **2, 4 and 11**.

The clock warns at 8:30. **Cut rule, in order:** if you are behind at slide 7, drop slide 8
to one line ("eighty-five percent local, and the judge alone would have been a hundred and
sixty dollars") and go to caching. Behind at slide 9, skip Grafana and promise it after —
but **do not skip slide 11**; it is the one the CFO in the room came for. Slides 2, 4, 6
and 11 are the ones you must not rush.

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

## 3 · What a token is — *1:35* · **the frame, part one**

*Two slides of vocabulary. Do not skip them — they are what stops someone leaving saying
"that wasn't tokenomics, that was a homelab story." This frame is straight out of the
Slalom FinOps for AI POV; say so, it buys you credibility and costs you nothing.*

> Two slides of vocabulary, because the word gets used loosely and I want us arguing about
> the same thing.
>
> A token has four faces, depending on who is looking at it. *(walk the quadrants)*
> **Cognition** — what the model produces; one unit of thinking. **Compute** — what the
> data center serves; silicon and power somebody had to build. **Price** — what the lab
> charges you. And **value** — what your business actually extracts.
>
> *(land it)* The lab bills you on the third one. You are paid on the fourth. **Tokenomics
> is the distance between them** — and nearly all of that distance is architecture, not
> procurement.

*Thirty-five seconds. Do not linger on cognition and compute; they are there so that price
and value have something to be contrasted against.*

---

## 4 · What drives the bill — *2:10* · **the frame, part two, and the spine of the talk**

*This slide is the table of contents. Every row's right-hand column is a later slide — say
so, and the rest of the deck stops feeling like a tour of your laptop.*

> So what actually moves the bill? Four decisions — and notice that none of them is a
> price. Every one is something a person decided in a design review.
>
> *(walk the rows)* **One, frontier by default** — everything goes to the best model on
> hand, because nobody ever defined what good enough looks like. **Two, growing context** —
> prompts, history, retrieval, tools, all re-read on every single turn. **Three, loops and
> retries** — one request becomes a hundred calls, and the failures bill exactly like the
> successes. **Four, no named owner** — finance sees the bill after the architecture is
> already set in concrete.
>
> *(land it)* Three of those are architecture. The fourth is **why the other three never
> get fixed.**
>
> The right-hand column is the rest of this talk. Routing, caching, a judge with a retry
> cap, and one board somebody actually reads. One week, all four.

**`[IF ASKED]`** Yes, this maps to the FinOps for AI cost-driver chain. I did not invent
it — I ran a week of work against it.

---

## 5 · What it does — *2:55*

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

*Forty-five seconds. If you are still on this slide at 3:30, move. Drop the RMSE and P90
detail unless someone asks — it is the detail that makes this sound like a science talk.*

---

## 6 · The build loop — *3:30* · **the slide that explains the number**

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

## 7 · What that did to the bill — *4:40*

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

## 8 · Route by size — *5:30*

> Lever one, with the receipts. This is where every call in that week actually went.

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

> *(and this is the part that travels)* It was a **config file**, not a rewrite. Claude
> Code asks for a model **by name**; the switchboard — LiteLLM, open source — decides what
> actually answers, and the tool never finds out. Ask for "sonnet", get the local model.
> Same commands, same repo. The local tier here was a laptop already sitting on the desk.
> **There was nothing to procure.**

**`[IF PRESSED]`** At frontier rates the judge alone would have been a hundred and sixty
dollars — taking the build from sixty-one to two hundred and twenty-one.

**`[IF ASKED ABOUT THE HARDWARE]`** A MacBook Pro I already owned, a quantised open-weights
model on the GPU, and a forty-line bash loop in a tmux session. Capital cost: zero. Do not
volunteer the spec sheet — a room that hears "48 GB unified memory" stops listening.

---

## 9 · Stop buying the same context twice — *6:35*

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

## 10 · Measure it — *7:30*

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

## 11 · Cost per outcome — *8:10* · **the slide the CFO came for**

*The one number in this deck an executive can put in a plan. Slow down for it.*

> Last frame, and it is the one to take to a CFO.
>
> Tokens are an **input** metric. Nobody sets a budget in tokens; no executive can govern
> against one. And **a cheaper model is not economical if it needs longer prompts, more
> retries, or worse answers.**
>
> Three questions instead. Did the task actually finish, to a standard you would accept?
> What did the whole interaction cost, retries included? And what accuracy, latency and
> risk are you willing to trade for it?
>
> *(point at the table)* Same project, counted the same way. By hand: twenty-four commits,
> four hundred and five dollars — **sixteen eighty-eight a commit**. On the loop: fifty-two
> commits, sixty-one dollars — **a dollar eighteen**. Fourteen times better, on the metric
> that is actually governable.

**Say the caveat before anyone asks it.** A commit is not a uniform unit of work. But both
columns are counted the same way, and every commit in the loop week passed an independent
judge and the full gate suite before it landed.

---

## 12 · Three moves — *8:50*

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

## 13 · Discussion — *9:30*

*Read the three questions. Then stop talking. Let the room fill the silence.*

If nobody bites, go to the **cache** one — it is the question where people discover they
don't know their own number, and that reliably starts the conversation.

---

## Q&A backup

**"We already have dashboards — isn't that visibility?"**
> A dashboard that shows spend by provider is an invoice with a chart on it. Visibility
> means you can answer *which workflow, which model, which team, and was the answer any
> good.* Mine is scoped per project, per model, per day, and I read it every morning — that
> is the only reason slide 4's fourth row has an answer.

**"Won't this get cheaper on its own? Prices keep falling."**
> Per-token prices have largely flattened at the top tier, and tokenizers have gone the
> other way — the same text can cost meaningfully more tokens on a newer model. And
> historically, when the unit got cheaper, total spend went *up*, because cheap capacity
> gets used. That is Jevons paradox, 1865, coal. You do not get to wait for this one.


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

- [ ] `T` starts the clock. Practise once to the warn at 8:30 — **slides 2, 4, 6 and 11 must land**.
- [ ] Grafana up, with the **`plate-solver-v1`** board open in a tab (not the default
      board). Confirm it reads **$61.13**.
- [ ] `ps-web` running for the slide-5 live solve, or accept the screenshot.
- [ ] Know these cold: **$61 · $574 · $1,122 · 320M · 85% · 5.5% of calls / 99.5% of bill ·
      11× per MTok · $1.18 a commit vs $16.88**.
- [ ] Practise saying the slide-7 and slide-11 caveats *before* anyone asks for it.
- [ ] Print to PDF as the projector-failure backup.
- [ ] Fix the brand palette token block if the real Slalom values are available.
