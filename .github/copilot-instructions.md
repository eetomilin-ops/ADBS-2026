# Project Guidelines
# Context 
 This is study project implementing tasks described in \Task2
  \materials contains all necessary data to infer and fulfill tasks 
  ..\sampleCode contains templates .ipynb for tasks 4 and 5 , subfolders typical tasks implementation  
 ..\src - code is placed here , the whole project is a set of .ipynb files. shared for task 1-3 , and isolated for 4 and 5. 

Tasks 4,5 will be run on LDB cluster

# implementation requirement
Target platform is the LBD public Hadoop cluster accessed through a JupyterLab shell.
Verified target Python version is 3.12.3.
Verified target mrjob version is 0.7.4.
Verified target Hadoop and HDFS client version is 3.3.6.
Use Python 3.12 compatible code for implementation and local validation.
Assume the target shell environment is Linux with bash available.
Captured cluster vars can be inferred in LDBvars.txt .
Dataset metadata can be taken from https://meta.stackexchange.com/questions/2677/database-schema-documentation-for-the-public-data-dump-and-sede/2678#2678

Dataset CSV resides on cluster , see shell output
e12533692@jupyter-e12533692:~$ ls dataLAB/data/adbs_shared/Ex_2/stackexchange/
comments.csv  posts.csv  users.csv

Local samples are in ./materials/data, they were captured using sampler.sh

Filecheck.txt is an output of filecheck.sh that lists file properties on cluster.

# Code Style Ruleset

## Goal
Produce code that resembles typical human-written software rather than AI-generated output. Avoid patterns that signal templated, overly generic, or instructional code.
---
## DOs

### 1. Write Purposeful, Non-Obvious Comments
Comment **why**, not **what**. Focus on intent, trade-offs, constraints, or edge cases.
Good sample
```
# Avoid division by zero when baseline data is incomplete
if base == 0: return None
```

### 2. Use Inconsistent (Natural) Comment Density
Comment only where needed. Leave some obvious lines uncommented.

### 3. Reflect Real-World Constraints
Add domain-specific handling instead of generic fallbacks. Encode assumptions explicitly.

Good sample
```
# Expect values in percentage format (0–100)
if value > 100: raise ValueError("Unexpected scale")
```

### 4. Vary Function and Variable Naming
Mix concise and descriptive names.Avoid overly systematic naming patterns.

Good sample
parseYear()
clean_val()
normalizeBaseline()

5. Allow Minor Imperfections
Small asymmetries in structure are acceptable.Humans rarely write perfectly uniform code.

6. Use Context-Specific Error Handling
Tailor logic to expected data issues. Avoid generic “catch-all” patterns.
Avoid guards where possible. Fail fast. Aim for speed.

7. Write Selective Docstrings
Avoid general docstrings, use only for non-trivial functions. Include edge cases or assumptions if relevant.
Use common comments for outher cases. 

Good sample
def normalize(series):
    """Normalize relative to first valid entry; assumes sorted input."""

8. Mix Coding Styles Slightly
Minor variation in formatting or structure is acceptable. Avoid rigid, repeated templates.
---

## DON'Ts
1. Do Not Explain Obvious Code . Avoid comments that restate the code.
Bad sample
```
# Create a list of columns
cols = list(df.columns)
```

### 2. Do Not Use Template-Like Docstrings Everywhere
Avoid uniform phrasing across all functions. Do not describe trivial behavior.
Bad sample 
```
"""Convert input to float or return None."""
```
### 3. Avoid Canonical AI Pipelines
Repetitive patterns like: strip → convert → coerce → fallback . Generic “safe” conversions without context .
Bad sample 
```
pd.to_numeric(str(x).strip(), errors="coerce")
```
### 4. Avoid Overly Defensive Generic Logic
Do not handle every possible case identically. Avoid “universal” fallback outputs like None or NaN without reasoning. Fail fast. Aim for speed and readability.

### 5. Do Not Narrate Code Usage
Avoid describing where or how code is used externally.
Bad sample
```
# This function is applied during CSV loading
```

### 6. Avoid Excessive Uniformity
Do not keep identical structure across all functions.
Avoid repeated patterns in: docstrings, comments, naming

### 7. Avoid Over-Clean Mathematical Formulations (weak)
Real code often includes intermediate variables or checks. Avoid overly “perfect” one-liners for complex logic. Avoid extra variables where possible.
Bad
return ((s / base) * 100).round(2)

### 8. Do Not Over-Document Simple Helpers
Small utility functions typically have minimal or no documentation.

### 9. Optimize for readability .
Do not make uber one liners. Expression length is 60-100 symbols max. Do not add extra CRLF, make code compact. 

## Checklist
Before finalizing code, verify:
 - Comments explain intent, not syntax
 - Some parts are intentionally uncommented
 - Naming is not overly systematic
 - Error handling reflects real constraints
 - No repeated “AI-style” pipelines
 - Docstrings are sparse and non-uniform
 - Code is slightly irregular but still clear
## Comment Formatting Rules (Exercise 4)

### Placement
- Comments always inline on same line as code, never on separate line above
- No docstrings, only #

### Function Signatures
- Inline comment on purpose after def name
- Inline comment on each arg after the arg name
- Closing paren on own line

### Conditionals
- Every if/elif carries inline comment stating reason and purpose for the branch

### Library Calls
- Non-obvious stdlib calls get inline comment on what they do in context

### Line Length
- Code + comment not to exceed 125 chars per line
