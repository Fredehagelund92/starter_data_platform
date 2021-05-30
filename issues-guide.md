# Writing bug reports in analytics
From time to time, some of our work will impact existing reports such that they use show different numbers to what is expected. When this happens, we definitely want to know about it! Unfortunately, a lot of the time, we will get alerted that something is "wrong" or "broken" without enough details for us to diagnose the issue effectively. To help us fix things as quickly as possible, it's really important to communicate the bug clearly. Often, as the bug reporter, spending some extra effort when reporting the bug will save lots of effort in making the fix!

If you've noticed a bug, we recommend opening up an issue on your dbt repo. We use the same structure in reporting analytics bugs that software engineers do when reporting software bugs.

## Steps to reproduce:
List the steps that took you on your journey to discovering this bug! Include hyperlinks so we can go on the same journey.

List the steps that are required to discover the bug that you are encountering. Feel free to include hyperlinks.

Example:
```
## Steps to reproduce:
1. Go to [this HR dashboard](www.link_to_ga.com).
2. Look at [this redash report](www.link_to_report.com).
3. Check the number of employees.
```

## Expected Result:
Explain what you expected to see when you went on your journey of bug-discovery. If you have historical data (e.g. a screenshot of the same report from last week), here is a great place to include it!
Example:
```
## Expected resuts:
* The pageview numbers for yesterday _should_ be somewhat similar.
```

## Current Result
Explain the problem and what makes you think that this could be a bug. Please include screenshots.

```
## Current Result:
* Redash is showing that we have 100 employees.
[Screenshot of Redash]
* In HR system we only have 50:
[Screenshot of HR system]
```

## Possible Solution
Tell us if you have any idea of why this might have happened.

```
A migration of the HR system happened yesterday. This could be the reason for the inconsistency between the DWH and source.
```