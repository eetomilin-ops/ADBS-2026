# Exercise 3 — Advanced Database Systems (Summer 2026)

**Author:** Evgenii Tomilin 
**Date:** June 2026

---

## Exercise 1: Scalar and Vector Clocks 

### (a) Scalar Clocks

scalar clock uses following algo :\
 a) sender S increase self timer, send current S time as payload \
 b) receiver R set time to max (local R time , received S time) +1 

So the goal is to correctly identify discrete states, looking to the diagram.\
Results as below. 

| Step | Event | Calculation | State After Event |
|---|---|---|---|
| 0 | Initial state | — | a:1 b:4 c:3 |
| 1 | b sends m1 → a | b = 4+1 = 5 | a:1 b:5 c:3 |
| 2 | a receives m1 | a = max(1,5)+1 = 6 | a:6 b:5 c:3 |
| 3 | b sends m2 → a | b = 5+1 = 6 | a:6 b:6 c:3 |
| 4 | a sends m3 → c | a = 6+1 = 7 | a:7 b:6 c:3 |
| 5 | c receives m3 | c = max(3,7)+1 = 8 | a:7 b:6 c:8 |
| 6 | a receives m2 | a = max(7,6)+1 = 8 | a:8 b:6 c:8 |
| 7 | Stable state (empty circles) | — | **a:8 b:6 c:8** |
| 8 | c sends m5 → b | c = 8+1 = 9 | a:8 b:6 c:9 |
| 9 | a sends m4 → b | a = 8+1 = 9 | a:9 b:6 c:9 |
| 10 | b receives m4 | b = max(6,9)+1 = 10 | a:9 b:10 c:9 |
| 11 | b receives m5 | b = max(10,9)+1 = 11 | a:9 b:11 c:9 |
| 12 | Stable state (empty circles) | — | **a:9 b:11 c:9** |

### (b) Vector Clocks
Absolutely the same as (a) instead of scalar the vector is send.\
Logic is pretty the same : 
  - onSend : increase self timer, write to own position in vector, send
  - onReceive : for each component -> max (incoming , self) , increase self component timer 
Assume vector indexes are mapped as [a,b,c] then event stream looks like this

| seq | event | [a state],[b state],[c state] | calculus |
|---|---|---|---|
| 0 | initial | [3,1,2], [2,4,3], [5,2,1] | |
| 1 | b sends m1 to c | [3,1,2], [2,5,3], [5,2,1] | [], [,+1,], [] |
| 2 | c receives m1 | [3,1,2], [2,5,3], [5,5,4] | [], [], [max(5,2), max(2,5), max(1,3)+1] |
| 3 | a sends m2 to c | [4,1,2], [2,5,3], [5,5,4] | [+1,,], [], [] |
| 4 | c receives m2 | [4,1,2], [2,5,3], [5,5,5] | [], [], [max(5,4), max(5,1), max(4,2)+1] |
| 5 | c sends m3 to a | [4,1,2], [2,5,3], [5,5,6] | [], [], [,,+1] |
| 6 | a receives m3 | [6,5,6], [2,5,3], [5,5,6] | [max(4,5)+1, max(1,5), max(2,6)], [], [] |
| 7 | **stable state (fill in boxes)** | **[6,5,6], [2,5,3], [5,5,6]** | |
| 8 | b sends m4 to a | [6,5,6], [2,6,3], [5,5,6] | [], [,+1,], [] |
| 9 | c sends m5 to b | [6,5,6], [2,6,3], [5,5,7] | [], [], [,,+1] |
| 10 | a receives m4 | [7,6,6], [2,6,3], [5,5,7] | [max(6,2)+1, max(5,6), max(6,3)], [], [] |
| 11 | b receives m5 | [7,6,6], [5,7,7], [5,5,7] | [], [max(2,5), max(6,5)+1, max(3,7)], [] |
| 12 | **stable state (fill in boxes)** | **[7,6,6], [5,7,7], [5,5,7]** | |

## Exercise 2: Denormalization (2 pts)

### Data Model Design

*Describe your JSON document model. Explain:*
- *How you denormalized the relational tables (room, booking, occupancy, guest)*
- *Why your design makes "guests by year" queries fast*
- *How you handle frequent booking updates efficiently*
- *Trade-offs you made*

### JSON Files

*The JSON files are included separately in the submission ZIP. Describe their structure briefly:*

```
guest_documents.json    — (describe)
booking_documents.json  — (describe)
...
```

---

## Exercise 3: Graph Databases — Neo4j (4 pts)

### Setup

*Describe how you ran Neo4j (docker-compose) and loaded the dataset.*

### 1. Basic Queries

#### (i) Distinct languages spoken by award recipients

```cypher
-- your query here
```

*Explanation and screenshot:*

![Query 1(i) output](screenshots/3_1_i.png)

#### (ii) Distinct countries with universities where persons studied

```cypher
-- your query here
```

![Query 1(ii) output](screenshots/3_1_ii.png)

#### (iii) Countries with count of persons who studied there

```cypher
-- your query here
```

![Query 1(iii) output](screenshots/3_1_iii.png)

#### (iv) Countries with count of multilingual (≥2 languages) persons who studied there

```cypher
-- your query here
```

![Query 1(iv) output](screenshots/3_1_iv.png)

### 2. Top-K Queries

#### (i) Top 10 universities by employees

```cypher
-- your query here
```

![Query 2(i) output](screenshots/3_2_i.png)

#### (ii) Top 10 regions by number of persons born there

```cypher
-- your query here
```

![Query 2(ii) output](screenshots/3_2_ii.png)

#### (iii) Top 3 countries by persons employed at local universities who won both Turing Award and ACM Fellow

```cypher
-- your query here
```

![Query 2(iii) output](screenshots/3_2_iii.png)

### 3. Subgraph Matching

*Find one subgraph matching the pattern: Person → RECEIVED_AWARD → Award (×2), Person → STUDIED_AT → University (shared), Person → BORN_IN → Place (shared).*

```cypher
-- your query here
```

![Query 3 output](screenshots/3_3.png)

*Explain what the found subgraph represents.*

### 4. Adding Name and DateOfBirth as Graph Nodes

#### Query to create Name and DateOfBirth nodes via MERGE

```cypher
-- your query here
```

*Explanation of how MERGE prevents duplicates.*

#### Query to show persons connected to the  most common last names

```cypher
-- your query here
```

![Query 4 output](screenshots/3_4.png)

### 5. Shortest Paths on Extended Graph

#### Creating the additional relationship between universities

```cypher
-- your query here (intermediate step: create edges between universities)
```

#### Finding shortest paths from TU Wien to all German universities

```cypher
-- your query using shortestPath
```

![Query 5 output](screenshots/3_5.png)

*Explain the results.*

---

## Exercise 4: Column Stores — Late Materialization (2 pts)

*Fill in the intermediate results for each step of the query plan.*

**Query:** `SELECT sum(R.a) FROM R, S WHERE R.b = S.a AND 5 <= R.a AND R.a <= 20`

### Step 1: `inter1 = select(Ra, 5, 20)`

| pos |
|---|
| |
| |
| |
| |

### Step 2: `inter2 = reconstruct(Rb, inter1)`

| pos | Rb |
|---|---|
| | |
| | |
| | |

### Step 3: `join_input_S = reverse(Sa)`

| Sa (key) | pos |
|---|---|
| | |
| | |
| | |

### Step 4: `join_res = join(inter2, join_input_S)`

| pos_R | pos_S |
|---|---|
| | |
| | |

### Step 5: `inter3 = voidTail(join_res)`

| pos |
|---|
| |
| |

### Step 6: `inter4 = reconstruct(Ra, inter3)`

| pos | Ra |
|---|---|
| | |
| | |

### Step 7: `result = sum(inter4)`

| result |
|---|
| |

---

*End of report.*
