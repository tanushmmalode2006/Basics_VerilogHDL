# 4-Bit Serial-In Shift Register (Verilog HDL)

## 1. Objective

To design a 4-bit shift register using Verilog HDL that accepts serial data and shifts the stored bits by one position on every rising edge of the clock.

## 2. Introduction

A **shift register** is a sequential circuit used to store and shift binary data. This design consists of four flip-flops connected in series.

It has:

* **SI (Serial Input):** Receives data one bit at a time.
* **CLK (Clock):** Controls the shifting operation.
* **Q[3:0]:** Stores the 4-bit data.

This is a **Serial-In, Parallel-Out (SIPO)** shift register because it accepts data serially and provides the stored data in parallel.

## 3. Block Diagram

```text
       SI
        |
        v
    +-------+    +-------+    +-------+    +-------+
    | D-FF  |    | D-FF  |    | D-FF  |    | D-FF  |
    |  Q3   |--->|  Q2   |--->|  Q1   |--->|  Q0   |
    +-------+    +-------+    +-------+    +-------+
        |            |            |            |
       Q[3]         Q[2]         Q[1]         Q[0]

          All flip-flops share the same CLK
```

## 4. Truth Table

The register shifts data on every rising edge of CLK.

|       CLK      |  SI | Q[3] (Next) | Q[2] (Next) | Q[1] (Next) | Q[0] (Next) |
| :------------: | :-: | :---------: | :---------: | :---------: | :---------: |
|        ↑       |  0  |      0      |     Q[3]    |     Q[2]    |     Q[1]    |
|        ↑       |  1  |      1      |     Q[3]    |     Q[2]    |     Q[1]    |
| No rising edge |  X  |     Q[3]    |     Q[2]    |     Q[1]    |     Q[0]    |

**Note:** The table shows the next state. Each bit receives the previous value of the bit immediately to its left.



### Code Explanation

| Code                    | Explanation                                                              |
| ----------------------- | ------------------------------------------------------------------------ |
| `output reg [3:0] Q`    | Declares a 4-bit register to store the data.                             |
| `always @(posedge CLK)` | Performs the shifting operation at every rising clock edge.              |
| `Q[3] <= SI`            | Loads the serial input into the most significant bit.                    |
| `Q[2] <= Q[3]`          | Transfers the previous value of Q[3] to Q[2].                            |
| `Q[1] <= Q[2]`          | Transfers the previous value of Q[2] to Q[1].                            |
| `Q[0] <= Q[1]`          | Transfers the previous value of Q[1] to Q[0].                            |
| `<=`                    | Non-blocking assignment, which allows all bits to update simultaneously. |

## 6. Working Principle

At every rising edge of the clock, the input data enters Q[3], and the previously stored bits shift one position toward Q[0].

For example, assume the initial register value is `0000` and the serial input sequence is `1, 0, 1, 1`.

| Clock Edge |  SI | Q[3:0] |
| :--------: | :-: | :----: |
|   Initial  |  -  |  0000  |
|      1     |  1  |  1000  |
|      2     |  0  |  0100  |
|      3     |  1  |  1010  |
|      4     |  1  |  1101  |

After four clock cycles, the register contains `1101`.

The oldest bit moves toward Q[0], while each new bit enters through Q[3].

## 7. Timing Diagram

```text
CLK  ____|‾|____|‾|____|‾|____|‾|____

SI   ____1______0______1______1______

Q3   ____1______0______1______1______

Q2   ____0______1______0______1______

Q1   ____0______0______1______0______

Q0   ____0______0______0______1______
```

### Timing Diagram Explanation

* At the first rising edge, SI = 1, so Q becomes `1000`.
* At the second rising edge, SI = 0, and the previous data shifts to `0100`.
* At the third rising edge, SI = 1, resulting in `1010`.
* At the fourth rising edge, SI = 1, resulting in `1101`.

All four bits update simultaneously at each rising edge.

## 8. Applications

* Serial-to-parallel data conversion.
* Temporary data storage.
* Digital communication systems.
* Data transfer between digital circuits.

## Key Takeaways

* A 4-bit shift register stores four bits of data.
* It accepts data serially through SI.
* Data shifts one position on every rising clock edge.
* The output is available in parallel through Q[3:0].
* Non-blocking assignments ensure that all bits shift simultaneously.
* This design has no reset, so its initial state is unknown in simulation unless initialized.
