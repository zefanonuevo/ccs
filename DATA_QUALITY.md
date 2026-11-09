# Data-quality assessment

Checked against the live sheet (tab `gid=1125842073`) on 2026-11-09. The sheet
was read only. No records were changed, added or removed. Row numbers below are
sheet rows (row 1 is the header).

## Dataset

- 752 records, 27 columns, publication years 2009 to 2027.
- Classification: Scopus 593, Refereed 158, blank 1.
- Type: International Conference 473, International Journal 131, Local Conference 131, Local Journal 12, Book Chapter 4, Unpublished Article 1.

## Validated KPIs (all records, no filters)

| KPI | Value | Check |
| --- | --- | --- |
| Total publications | 752 | Non-empty rows in the tab |
| Scopus indexed ratio | 78.9% | 593 / 752 |
| Q1 share of all records | 11.7% | 88 / 752 |
| Q1 share of ranked records | 26.0% | 88 / 339 |
| Research faculty | 108 | Distinct names, before the spelling fixes below |

Best-quartile split: Q1 88, Q2 61, Q3 116, Q4 74, no quartile 413.
These figures were recomputed independently of the dashboard code using the same definitions.

## Issues to fix in the sheet

1. **Faculty name variants (at least 5 people counted more than once).** Fixing the first three lowers the faculty count by 4 (to 104). The last two came from the duplicate-title check and mean the real count is likely lower still; a full name-by-name review of all 108 names was not done.
   - `Sison, Raymund` and `Sison,, Raymund`
   - `Azcarraga, Judith` and `Azcarraga, judith`
   - `Ruiz, Conrado Jr.`, `Ruiz, Conrado, Jr.` and `Ruiz, Conrado Jr`
   - `Cordel, Macario` and `Cordel, Macario II` (rows 150 and 255)
   - `Samson, Briane` and `Samson, Briane Paul` (rows 440 and 504)
2. **Possible duplicate titles (10 groups).** Same title after ignoring case and punctuation. Some are legitimate (the same work in two venues or years), so these need a human decision:
   - Rows 221 and 222 (Ong, Ethel; 2024; same journal)
   - Rows 113 and 128 (Chu, Shirley; 2025; same series)
   - Rows 325 and 364 (Ching, Michelle Renee; 2023; same conference)
   - Rows 297 and 372 (Ebardo, Ryan; Suarez, Merlin Teodosia; 2023; same journal)
   - Rows 107 and 271, 204 and 268, 263 and 343, 150 and 255, 53 and 250 (same title, different venue or year)
   - Rows 319, 440 and 504 (a CHI symposium title shared by three different authors and years; probably not duplicates)
3. **Future-dated records.** Rows 2 and 3 have Publication Year 2027 while today is in 2026. They may be in-press papers with a 2027 volume year; confirm.
4. **Blank required fields.**
   - Row 425: Classification is blank.
   - Row 748: Faculty is blank.
   - Rows 48 and 748: Dept is blank.
5. **Quartile coverage.** 413 records have no Quartile, Percentile or Category, including 261 Scopus records. If SJR data exists for those, adding it will move the Q1 KPIs.
6. **Unnamed column.** Column T has an empty header and no data in any row. It can be deleted or named.
7. **Repeated DOI, ISBN or ISSN values (22 groups).** The column mixes ISBN and ISSN, so repeats are expected for papers in the same proceedings (for example, 12 consecutive records in rows 84 to 95). They were not treated as duplicates.

## Dashboard notes

- 2026 has 67 records and is still in progress, so the year trend and the 2026 vs 2025 comparison show a partial year.
- The dashboard counts a faculty name exactly as typed, so the spelling variants in item 1 inflate Research faculty and split a person's bar in Publications per Faculty until the sheet is fixed.

## Department and faculty attribution (checked 2026-11-09)

The Department filter relies on the Faculty and Dept cells having the same
number of lines. In the live sheet, 745 of 752 records line up, and all 69
records that span more than one department line up, so the dashboard can
attribute each co-author to the right department for them. These 7 do not,
and they are the remaining sources of wrong department credit:

| Row | Faculty cell | Dept cell | Fix |
| --- | --- | --- | --- |
| 38 | Ebardo, Ryan; Suarez, Merlin Teodosia | ST | Dept should be `IT` then `ST` (one per line, same order as Faculty) |
| 173 | Suarez, Merlin Teodosia; Ebardo, Ryan | ST | Dept should be `ST` then `IT` |
| 537 | Ebardo, Ryan; Suarez, Merlin Teodosia | ST | Dept should be `IT` then `ST` |
| 48 | Ebardo, Ryan | (blank) | Add `IT` |
| 177 | Cempron, Jonathan Paul; Ilao, Joel | CT | Add the second department, or confirm both are CT and repeat it |
| 261 | Pascual, Ronald; Azcarraga, Judith; Ing, John Andrew | CT; CT | Add a third department entry |
| 625 | Department of Transportation: Data Warehousing and Analytics | CT | The Faculty cell holds text that is not a name, and the dashboard counts it as two faculty. Replace it with the real faculty name or names |

Rows 38, 173 and 537 are the ones that still credit Ebardo, Ryan (IT) to ST
when the Department filter is ST. I confirmed the department for Ebardo, Ryan
from the other 60 records that list one: all of them say IT. The departments
for rows 177, 261 and 625 need someone who knows the papers.
