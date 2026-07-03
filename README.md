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
    publication formats (horizontal bar) — all interactive (hover tooltips,
    react live to filters)
  - A filtered, searchable publications table
  - Light/dark theme (follows system preference, with a manual toggle)

  If the live fetch fails (e.g. CORS, offline, or the sheet becomes
  unpublished), the dashboard falls back to bundled sample data and shows a
  banner explaining why.

## Viewing the dashboard

This is a static site meant to be served with GitHub Pages. See the repo
settings for the live URL once Pages is enabled (Settings → Pages → Source:
Deploy from a branch → this branch → `/` root).

## Column matching

The dashboard doesn't assume exact header names — it matches common
variants (e.g. "Author(s)", "Faculty" → faculty; "Journal/Conference",
"Venue" → venue) case-insensitively. If a column can't be confidently
matched, the dashboard shows a warning banner naming the missing field and
renders "—" for it. To adjust matching, edit `FIELD_ALIASES` near the top
of the `<script>` block in `index.html`.

## Pointing at a different sheet or tab

Update `SHEET_ID` and `GID` near the top of the `<script>` block in
`index.html` (visible in the sheet's URL, or in a fetch error if the CSV
export fails), and `PUB_URL` if the "Publish to web" link changes.
