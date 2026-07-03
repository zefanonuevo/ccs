# ccs

A minimal static dashboard that embeds a Google Sheet published to the web.

## What's here

- `index.html` — the dashboard page. It embeds the published sheet in an
  iframe and links out to the full spreadsheet view.

## Viewing the dashboard

This is a static site meant to be served with GitHub Pages. See the repo
settings for the live URL once Pages is enabled (Settings → Pages → Source:
Deploy from a branch → this branch → `/` root).

## Updating the source sheet

The dashboard always reflects the live published sheet — no rebuild is
needed when the spreadsheet data changes. To point it at a different sheet,
update the `src` and link `href` values in `index.html` with a new
Publish to web URL from Google Sheets (File → Share → Publish to web).
