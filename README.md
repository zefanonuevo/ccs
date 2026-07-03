# ccs

An interactive faculty-publications dashboard backed by a Google Sheet
published to the web.

## What's here

- `index.html` — the dashboard. On load it fetches the published sheet as
  CSV (via Google's `gviz/tq` export endpoint), parses it client-side, and
  renders:
  - Stat tiles: total publications, Scopus indexed ratio, Q1 share, unique
    research faculty
  - Filters: free-text search plus Publication Year, Classification, Type,
    Department, and Highest Quartile
  - Charts: publications per year (bar), category indexation (donut),
    publication type (horizontal bar), publications per faculty
    (top 10, horizontal bar), highest SJR quartile distribution (pie,
    fixed Q1-green → Q4-red → Unranked-gray coloring), and top research
    categories split by quartile (stacked bar) — all interactive (hover
    tooltips, react live to filters)
  - A filtered, searchable publications table — click any row to open a
    detail spec sheet (full title, complete author list, faculty,
    department, full citation details, and a per-subject-area SJR
    quartile/percentile breakdown)
  - Light/dark theme (follows system preference by default; the toggle in
    the header overrides it and persists the choice)

  If the live fetch fails (e.g. CORS, offline, or the sheet becomes
  unpublished), the dashboard falls back to bundled sample data and shows a
  banner explaining why.

## Viewing the dashboard

This is a static site served with GitHub Pages:
https://zefanonuevo.github.io/ccs/

(Settings → Pages → Source: Deploy from a branch → this branch → `/` root.)

## Column matching

The dashboard doesn't assume exact header names — it matches common
variants (e.g. "Author(s)", "Faculty" → faculty; "Journal/Conference",
"Venue" → venue) case-insensitively. If a column can't be confidently
matched, the dashboard shows a warning banner naming the missing field and
renders "—" for it. To adjust matching, edit `FIELD_ALIASES` near the top
of the `<script>` block in `index.html`.

### SJR quartile/percentile breakdown

The source sheet stores a publication's per-subject-area breakdown as three
parallel columns — `Category`, `Quartile`, `Percentile` — each cell holding
one newline-separated line per subject area, aligned by line position (e.g.
line 3 of each column together describe one subject area). `getCategoryBreakdown()`
zips these back into `{category, quartile, percentile}` rows; `bestQuartile()`
derives the publication's overall "highest quartile" (used by the Q1 stat
tile, the quartile filter, and the quartile pie chart) as the best value
across that breakdown, not just whichever line comes first. A publication
with only a single quartile/percentile value for multiple categories has
that value reused across all of them. Sheets that instead pack
`"Category, Q#, Top Nth"` lines into one combined column are supported as a
fallback (`parseBreakdownRows`).

### Publication Type

Some sheets have two different "type" columns — an unrelated one (e.g.
author/student level: Faculty/Grad/Undergrad/SHS) alongside the actual
venue-type column ("Publication Type": International Conference, Journal,
etc.). `FIELD_ALIASES.type` checks `publicationtype`/`typeofpublication`/
`venuetype` before the bare `type`, so the more specific column wins the
exact-match check first instead of whichever "Type"-named column happens
to exist.

### Department

The Department filter is fixed to the three CCS departments (`DEPARTMENT_OPTIONS`
near `splitDepartments` in `index.html`: `CT`, `IT`, `ST`) rather than
whatever values happen to appear in the sheet. A publication co-authored by
faculty from more than one department can list several (e.g. `"CT; IT"`),
separated by `;`, `,`, `/`, "and", or "&"; it then matches — and appears
under — every one of those departments when filtering.

## Pointing at a different sheet or tab

Update `SHEET_ID` and `GID` near the top of the `<script>` block in
`index.html` (visible in the sheet's URL, or in a fetch error if the CSV
export fails).
