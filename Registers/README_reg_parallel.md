# 4-Bit Parallel Register (Verilog HDL)

## 1. Objective

To design a 4-bit parallel register using four D flip-flops, allowing all four input bits to be stored simultaneously on the rising edge of the clock, with a synchronous reset.

## 2. Introduction

A **4-bit parallel register** is a sequential circuit that stores four bits of data simultaneously. It is constructed using four individual D flip-flops connected to a common clock and reset.

Each flip-flop stores one bit of the input data. Since all four flip-flops operate on the same clock edge, the entire 4-bit input is captured simultaneously.

**Key features:**

* Parallel data input and output.
* Four D flip-flops.
* Common clock and synchronous reset.
* Simultaneous storage of four bits.

## 3. Block Diagram

```text
             4-BIT PARALLEL REGISTER

       D[0] ──────┐
                  ▼
              ┌────────┐
       CLK ───►│ D-FF 0 │────► Q[0]
       RESET ─►│        │
              └────────┘

       D[1] ──────┐
                  ▼
              ┌────────┐
       CLK ───►│ D-FF 1 │────► Q[1]
       RESET ─►│        │
              └────────┘

       D[2] ──────┐
                  ▼
              ┌────────┐
       CLK ───►│ D-FF 2 │────► Q[2]
       RESET ─►│        │
              └────────┘

       D[3] ──────┐
                  ▼
              ┌────────┐
       CLK ───►│ D-FF 3 │────► Q[3]
       RESET ─►│        │
              └────────┘
```

All four flip-flops share the same CLK and RESET signals.

## 4. Truth Table

The register updates its outputs only at the rising edge of the clock.

|       CLK      | RESET | D[3:0] | Q[3:0] (Next State) | Operation |
| :------------: | :---: | :----: | :-----------------: | --------- |
|        ↑       |   1   |  XXXX  |         0000        | Reset     |
|        ↑       |   0   |  0000  |         0000        | Store     |
|        ↑       |   0   |  0101  |         0101        | Store     |
|        ↑       |   0   |  1010  |         1010        | Store     |
|        ↑       |   0   |  1111  |         1111        | Store     |
| No rising edge |   X   |  XXXX  |      Previous Q     | Hold      |

**Note:**

* `↑` represents the rising edge of CLK.
* `XXXX` represents any 4-bit input combination.
* The reset clears all four output bits simultaneously.
* When RESET is LOW, the register captures the input data.


## 6. Code Explanation

### A. D Flip-Flop

The `d_ff` module implements a single positive-edge-triggered D flip-flop with a synchronous reset.

| Code                    | Explanation                                      |
| ----------------------- | ------------------------------------------------ |
| `input D`               | Data input for the flip-flop.                    |
| `input CLK`             | Clock input that determines when data is stored. |
| `input RESET`           | Synchronous reset input.                         |
| `output reg Q`          | Stores the output value.                         |
| `always @(posedge CLK)` | Executes the block at the rising edge of CLK.    |
| `if (RESET)`            | Checks whether reset is HIGH.                    |
| `Q <= 1'b0`             | Clears the output when reset is asserted.        |
| `Q <= D`                | Stores the input data when reset is LOW.         |

### B. Parallel Register

The `regparallel` module connects four instances of the D flip-flop.

**Important concepts:**

* **Module instantiation:** Each `d_ff` instance represents one physical flip-flop in the design.
* **Named port mapping:** Connections such as `.D(D[0])` connect the corresponding input bit to a flip-flop.
* **Output `wire`:** The output `Q` is declared as a `wire` because it is driven by the outputs of the four instantiated flip-flops.
* **Bit-wise connections:** Each flip-flop receives one input bit and drives one output bit.

| Instance | Input  | Output |
| -------- | ------ | ------ |
| `ff0`    | `D[0]` | `Q[0]` |
| `ff1`    | `D[1]` | `Q[1]` |
| `ff2`    | `D[2]` | `Q[2]` |
| `ff3`    | `D[3]` | `Q[3]` |

All four instances receive the same clock and reset signals.

## 7. Working Principle

The parallel register stores four bits simultaneously using four independent D flip-flops.

1. **Data input:** Each flip-flop receives one bit of the 4-bit input.
2. **Clock synchronization:** All four flip-flops respond to the same rising edge of CLK.
3. **Data storage:** When RESET is LOW, each flip-flop captures its corresponding input bit.
4. **Synchronous reset:** When RESET is HIGH at a rising edge, all four outputs become 0.
5. **Data retention:** Between rising clock edges, all four flip-flops retain their stored values.

**Example:**

Suppose the input is `D = 1011` and RESET = 0.

At the rising edge of CLK:

* `ff3` stores 1.
* `ff2` stores 0.
* `ff1` stores 1.
* `ff0` stores 1.

Therefore, the output becomes `Q = 1011`.

All four bits are captured at the same clock edge, rather than one after another.

## 8. Timing Diagram

```text
CLK    ____|‾‾‾‾|____|‾‾‾‾|____|‾‾‾‾|____|‾‾‾‾|____

RESET  ‾‾‾‾‾‾‾‾‾‾|________________|‾‾‾‾‾‾‾‾‾‾‾‾

D      1010       1100             0111

Q      0000       1100             0111       0000
          ↑          ↑                ↑          ↑
        Reset      Store            Store      Reset
```

### Timing Diagram Explanation

* At the first rising edge, RESET is HIGH, so all four flip-flops are cleared.
* At the second rising edge, RESET is LOW and D is `1100`. All four flip-flops capture their respective bits.
* At the third rising edge, D is `0111`, so the output updates to `0111`.
* At the fourth rising edge, RESET is HIGH, clearing all four outputs to `0000`.

The output remains unchanged between clock edges, even if the input data changes.

*Note: This is a conceptual timing diagram. The actual waveform depends on the testbench and initial state.*

## 9. Applications

* Temporary storage of binary data.
* Data buffering in digital systems.
* Intermediate data storage in processors.
* Pipelined digital circuits.
* Data transfer between synchronous processing stages.

## Key Takeaways

* A parallel register stores multiple bits simultaneously.
* This design uses four D flip-flops to store four bits.
* All flip-flops share a common clock and synchronous reset.
* Each flip-flop stores one bit of the input.
* Module instantiation allows a single D flip-flop design to be reused.
* The `wire` output connects the outputs of the instantiated flip-flops to the top-level register output.
* The design can be extended to any number of bits by adding more flip-flop instances.
