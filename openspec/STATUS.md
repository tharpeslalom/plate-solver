# Documentation Status — Plate Solver (Rust)

_Originally generated 2026-06-09 for the OpenSpec documentation milestone (M0).
Updated 2026-06-30 after implementation: feat-01–06 are implemented, their tasks checked off, and
the changes archived into `openspec/specs/`. feat-07 (mobile runtime) remains an active, un-started
change. This is a review index for the spec set; it is not itself an OpenSpec artifact._

## What this is

A complete, validated OpenSpec documentation set specifying a from-scratch **Rust**
reimplementation of the tetra3/cedar "lost-in-space" plate solver — star detection → pattern-
database lookup → attitude (RA/Dec/Roll/FOV/distortion) recovery — delivered over **gRPC** and
embeddable on **mobile**. The product "why/what" is in [`PRD.md`](./PRD.md); shared context,
conventions, and the glossary are in [`project.md`](./project.md). Implementation status (test
counts, parity outcomes, deferred items) is tracked in
[`IMPLEMENTATION-STATUS.md`](./IMPLEMENTATION-STATUS.md); a defects/positives audit of the
implemented crates is in [`../CODEBASE-REVIEW.md`](../CODEBASE-REVIEW.md).

## Current state (post-implementation)

The implementation milestone landed feat-01 through feat-06: six crates (`ps-core`, `ps-detect`,
`ps-db`, `ps-dbgen`, `ps-solve`, `ps-grpc`), with the numerical-parity gates held (sv6 RA/Dec
within 10 arcsec, 19/19 matched catalog IDs, cedar-detect interop). Each completed change's
`tasks.md` was checked off and the change archived with `openspec archive`, moving its `spec.md`
into `openspec/specs/<capability>/spec.md` and the change folder into
`openspec/changes/archive/<date>-<change>/`. The post-implementation hardening phase (Phase H)
then resolved the `CODEBASE-REVIEW.md` C1–C6 findings + the feat-06 4.2 gRPC-Web gap (commits
`1a75576`…`e48b5c8`, 2026-06-30); the workspace now runs **200 tests pass / 0 fail / 1 ignored**
(release build clean, rayon flag compiles on and off). C7/C9/C10 (optional cleanup) and
feat-02 7.2 remain open; feat-04 5.3 / C8 is BLOCKED on missing HIP/Tycho catalogs — see
Carried-forward gaps below.

**feat-07 (mobile-runtime)** is genuinely not implemented (deferred — no Xcode/Android NDK in CI)
and remains an active change with 0/12 tasks.

### Archived specs (implemented capabilities)

| Capability | Change (archived) | Crate | Reqs | Tasks |
|---|---|---|---|---|
| `math-core` | feat-01-foundation-math-core | `ps-core` | 19 | 18/18 ✅ |
| `star-detection` | feat-02-star-detection | `ps-detect` | 11 | 17/18 ⚠️ |
| `pattern-database` | feat-03-pattern-database | `ps-db` | 10 | 14/14 ✅ |
| `database-generation` | feat-04-database-generation | `ps-dbgen` | 10 | 15/16 ⚠️ |
| `plate-solver` | feat-05-plate-solver | `ps-solve` | 11 | 19/19 ✅ |
| `grpc-service` | feat-06-grpc-service | `ps-grpc` | 8 | 13/14 ⚠️ |

### Active changes (not yet implemented)

| Capability | Change | Crate | Reqs/Scenarios | Tasks |
|---|---|---|---|---|
| `mobile-runtime` | feat-07-mobile-runtime | `ps-mobile` | 8 / 12 | 0/12 |

Build order: `math-core` → `star-detection` → `pattern-database` → `database-generation` →
`plate-solver` → `grpc-service` → `mobile-runtime`.

## Carried-forward gaps (incomplete tasks in archived changes)

Three tasks were left unchecked at archive time. Phase H (hardening) was opened to close them
plus the `CODEBASE-REVIEW.md` C1–C10 findings. **As of 2026-07-01 the status is:**

- **feat-06 / grpc-service — 4.2 gRPC-Web over HTTP/1** — ✅ **RESOLVED (H7 / `e48b5c8`).**
  `tonic-web` is now a `ps-grpc` dependency and `GrpcWebLayer::new()` is wired in `main.rs`
  alongside `accept_http1(true)`; a gRPC-Web-over-HTTP/1 interop test passes. This carried-forward
  gap is closed.
- **feat-02 / star-detection — 7.2 `summarize_region_of_interest`** — ⏳ **OPEN (Phase H8).** The
  auto-exposure/focus helper was not ported from cedar-detect (it exists only in
  `reference-solutions/`). Non-core, intentionally skipped at implementation; no blocker, just not
  yet started.
- **feat-04 / database-generation — 5.3 pattern-count parity vs `default_database.npz`** — 🛑
  **BLOCKED (Phase H9).** The Hipparcos/Tycho source catalogs are not in-repo, so `ps-dbgen` has
  never been verified to reproduce the reference pattern count (1,010,981). The shipped
  `default_database.npz` is the Python-built artifact and loads/works; only the offline
  *regeneration-from-catalogs* path is unverified. Standing gate (green): structural validity +
  byte-identical determinism + round-trip through `ps-db`. To unblock: user downloads
  `hip_main.dat`/`tyc2.dat` to a known path. See [`IMPLEMENTATION-STATUS.md`](./IMPLEMENTATION-STATUS.md).

These are separate from the code-quality/robustness findings in
[`../CODEBASE-REVIEW.md`](../CODEBASE-REVIEW.md) (C1–C10), defects in *implemented* code against
these specs' own acceptance scenarios. **As of 2026-07-01, C1–C6 are RESOLVED** (commits
`1a75576` C1 lazy combinations, `7cfa34a` C2 client detect params, `24e1190` C5 panics→Result,
`06a09fb` C3 mmap alignment, `635bc98` C4 width/height casts, `dfb4d08` C6 RPC deadline + rayon
flag); **C7, C9, C10 remain OPEN** (optional Phase H10 cleanup tail); **C8 is the same BLOCK as
feat-04 5.3 above** (Phase H9). The mobile-readiness and boundary-robustness scenarios that C1–C6
targeted now hold; those that C7–C10 target remain.

## Definition of done (documentation milestone, met 2026-06-09)

- `openspec/` contains `project.md`, `PRD.md`, `STATUS.md`, and **7 changes** (now 1 active + 6
  archived).
- Every change/spec passes `openspec validate <name> --strict` (exit 0). Archived changes show
  4/4 artifacts; the six archived specs are strict-valid.
- Totals: **77 requirements / 122 scenarios** across the 7 capabilities.

## Scope decisions (from review)

- **cedar throughout** — detection (cedar-detect), DB generation (lattice fields), and the solver
  all follow the cedar variant, which strictly supersedes the original tetra3.
- **Reference-only / non-goals:** tetra3's simpler detector (doc 03) and per-anchor DB
  enumeration (doc 05 §5.1); partial-sky databases; tracking mode; fisheye lens models;
  >8-bit detection.
- **gRPC = full `PlateSolver`** service (`ExtractCentroids`, `SolveFromCentroids`,
  `SolveFromImage`, `GetInfo`), reusing cedar-detect's `Image`/`ImageCoord` message shapes.
- **Parity is a tested contract** — scenarios assert numerical parity vs the Python reference
  within stated tolerances (RA/Dec arcsec, centroids ±0.1 px, identical matched catalog IDs).

## How to review

```sh
openspec list                    # 1 active change (feat-07)
openspec list --specs            # 6 archived specs
openspec show feat-07-mobile-runtime        # the remaining active change
openspec validate math-core --strict        # validate an archived spec
openspec status --change feat-07-mobile-runtime
openspec view                                 # interactive dashboard
```

Read order for a reviewer: [`PRD.md`](./PRD.md) → [`project.md`](./project.md) →
[`IMPLEMENTATION-STATUS.md`](./IMPLEMENTATION-STATUS.md) → the archived specs in dependency order
above → [`../CODEBASE-REVIEW.md`](../CODEBASE-REVIEW.md) for the defect list.

## Next steps

1. ~~Resolve the three carried-forward gaps above~~ — feat-06 4.2 (gRPC-Web) **done**; feat-02 7.2
   (ROI helper) and feat-04 5.3 (count parity, BLOCKED on missing HIP/Tycho catalogs) remain.
2. ~~Address the `CODEBASE-REVIEW.md` C1–C10 findings in severity order~~ — **C1–C6 done**
   (commits `1a75576`…`dfb4d08`); C7/C9/C10 (optional cleanup tail, Phase H10) remain; C8 is the
   feat-04 5.3 block above.
3. Optional Phase H10 cleanup: dedup the `ps-db` loader/mmap readers (C7), convert `ps-dbgen`
   `hash_insert` `unwrap`/`panic` to `Result` (C9), remove the dead `gate.rs` branch and replace the
   16-arg `apply_legacy_fallbacks` with a config struct (C10).
4. Implement feat-07 (mobile runtime) when iOS/Android tooling is available, then archive it the
   same way.