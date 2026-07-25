\# Supabase



This directory contains the canonical backend implementation for DXT.



\## Structure



\- canonical/ — Current approved SQL object definitions.

\- migrations/ — Versioned database migrations.

\- snapshots/ — Point-in-time production snapshots taken before significant changes.

\- registry/ — Canonical object registry, reconciliation reports, and backend governance artifacts.



\## Governance



The live Supabase database is the production runtime.



The Git repository is the canonical engineering source for:

\- SQL definitions

\- Architecture

\- Governance

\- Documentation



Every backend change follows this workflow:



1\. Audit the live object.

2\. Modify the live object.

3\. Validate the production behavior.

4\. Update the canonical SQL in this repository.

5\. Commit the change.

