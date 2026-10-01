# 4-Bit Shift Registers (Verilog HDL)

## 1. Objective

To design and implement four types of 4-bit registers using Verilog HDL: SISO, SIPO, PISO, and PIPO, and understand their data transfer operations.

## 2. Introduction

A **shift register** is a sequential circuit used to store and transfer binary data. It consists of flip-flops connected in series and operates using a common clock.

Shift registers are classified based on how data enters and leaves the circuit.

| Type | Full Form                | Data Input | Data Output |
| ---- | ------------------------ | ---------- | ----------- |
| SISO | Serial-In Serial-Out     | Serial     | Serial      |
| SIPO | Serial-In Parallel-Out   | Serial     | Parallel    |
| PISO | Parallel-In Serial-Out   | Parallel   | Serial      |
| PIPO | Parallel-In Parallel-Out | Parallel   | Parallel    |

## 3. Block Diagrams

### A. SISO (Serial-In Serial-Out)

```text
       SI
        |
        v
    +-------+    +-------+    +-------+    +-------+
    | D-FF  |--->| D-FF  |--->| D-FF  |--->| D-FF  |
    |  Q3   |    |  Q2   |    |  Q1   |    |  Q0   |
    +-------+    +-------+    +-------+    +-------+
                                              |
                                              v
                                              SO
```

Data enters and leaves one bit at a time.

### B. SIPO (Serial-In Parallel-Out)

```text
       SI
        |
        v
    +-------+    +-------+    +-------+    +-------+
    | D-FF  |--->| D-FF  |--->| D-FF  |--->| D-FF  |
    |  Q3   |    |  Q2   |    |  Q1   |    |  Q0   |
    +-------+    +-------+    +-------+    +-------+
        |            |            |            |
       Q3           Q2           Q1           Q0
```

Data enters serially and is available simultaneously at the four outputs.

### C. PISO (Parallel-In Serial-Out)

```text
 D[3:0] ───────┐
               v
         +-------------+
 LOAD -->|             |
 CLK --->|  PISO       |----> SO
         |  REGISTER   |
         +-------------+
```

Data is loaded simultaneously and shifted out one bit at a time.

### D. PIPO (Parallel-In Parallel-Out)

```text
       D[3:0]
          |
          v
    +-------------+
    |             |
CLK>|  PIPO       |----> Q[3:0]
    |  REGISTER   |
    +-------------+
```

All four bits are loaded and read simultaneously.

All four designs use a rising-edge-triggered clock.


## 5. Working Principle

### A. SISO

The input data enters one bit at a time and moves through the four flip-flops on successive rising clock edges. The oldest bit eventually reaches Q[0] and appears at SO.

### B. SIPO

The input data enters serially and shifts through the register. After four clock edges, four input bits are stored and available simultaneously at Q[3:0].

### C. PISO

When LOAD is HIGH, the four input bits are loaded simultaneously. When LOAD is LOW, the register shifts one bit toward Q[0] on each rising clock edge. The bit at Q[0] is available at SO.

### D. PIPO

At each rising clock edge, all four input bits are stored simultaneously. The output holds the stored data until the next rising edge.

## 6. Example of Data Transfer

Assume the input data is `1011` and the initial register state is `0000`.

### A. SISO and SIPO

Serial input sequence: `1, 0, 1, 1`

| Clock Edge | SI | Register Q[3:0] |
| ---------- | -: | --------------: |
| Initial    |  - |            0000 |
| 1          |  1 |            1000 |
| 2          |  0 |            0100 |
| 3          |  1 |            1010 |
| 4          |  1 |            1101 |

After four clock edges:

* **SISO:** The first bit entered has reached the serial output after four shifts.
* **SIPO:** All four bits are available simultaneously as `1101`.

The register shifts toward Q[0], so the first bit entered reaches SO first.

### B. PISO

Parallel input: `D = 1011`

| Clock Edge | LOAD | Register Q[3:0] | SO |
| ---------- | ---: | --------------: | -: |
| 1          |    1 |            1011 |  1 |
| 2          |    0 |            0110 |  0 |
| 3          |    0 |            1100 |  0 |
| 4          |    0 |            1000 |  0 |
| 5          |    0 |            0000 |  0 |

The first output bit is available immediately after loading. Subsequent bits are shifted to SO on later clock edges.

**Note:** The PISO design shifts toward Q[0] and inserts zeros at Q[3]. Its output sequence for the loaded word `1011` is `1, 0, 1, 1`.

### C. PIPO

Parallel input: `D = 1011`

| Clock Edge | D[3:0] | Q[3:0] |
| ---------- | ------ | ------ |
| 1          | 1011   | 1011   |
| 2          | 0101   | 0101   |
| 3          | 1100   | 1100   |

All four bits are transferred simultaneously at each rising edge.

## 7. Timing Diagrams

The following diagrams illustrate the basic data transfer behavior. The initial register state is assumed to be `0000`.

### A. SISO

```text
CLK  ____|‾|____|‾|____|‾|____|‾|____

SI   ____1______0______1______1______

Q3   ____1______0______1______1______

Q2   ____0______1______0______1______

Q1   ____0______0______1______0______

Q0   ____0______0______0______1______

SO   ____0______0______0______1______
```

### B. SIPO

```text
CLK  ____|‾|____|‾|____|‾|____|‾|____

SI   ____1______0______1______1______

Q3   ____1______0______1______1______

Q2   ____0______1______0______1______

Q1   ____0______0______1______0______

Q0   ____0______0______0______1______
```

### C. PISO

```text
CLK   ____|‾|____|‾|____|‾|____|‾|____|‾|____

LOAD  ‾‾‾‾‾‾‾‾‾‾|____________________________

D     1011

Q     1011     0110     1100     1000     0000

SO      1        0        0        0        0
```

### D. PIPO

```text
CLK  ____|‾|____|‾|____|‾|____

D    1011   0101   1100

Q    1011   0101   1100
```

*Note: These are conceptual timing diagrams. In simulation, input signals should be set up before the active clock edge. The PISO output shown is the value of Q[0] after each clock edge.*

## 8. Comparison

| Feature        | SISO                 | SIPO                          | PISO                          | PIPO                  |
| -------------- | -------------------- | ----------------------------- | ----------------------------- | --------------------- |
| Input method   | Serial               | Serial                        | Parallel                      | Parallel              |
| Output method  | Serial               | Parallel                      | Serial                        | Parallel              |
| Data shifting  | Yes                  | Yes                           | Yes                           | No                    |
| Control signal | None                 | None                          | LOAD                          | None                  |
| Main purpose   | Serial data transfer | Serial-to-parallel conversion | Parallel-to-serial conversion | Parallel data storage |

## 9. Applications

* **SISO:** Serial data transmission and delay circuits.
* **SIPO:** Serial-to-parallel conversion in communication systems.
* **PISO:** Parallel-to-serial conversion for data transmission.
* **PIPO:** Temporary data storage and data buffering in digital systems.

## Key Takeaways

* SISO and SIPO accept data serially.
* PISO and PIPO accept data in parallel.
* SISO and PISO produce serial outputs.
* SIPO and PIPO produce parallel outputs.
* Shift registers use clocked flip-flops to store and transfer data.
* The PISO design uses LOAD to select between parallel loading and shifting.
* PIPO is a parallel register without a shifting operation.