# 4-Bit Register (Verilog HDL)

## 1. Objective

To design a 4-bit register using Verilog HDL that stores 4-bit input data on the rising edge of the clock and supports synchronous reset.

## 2. Introduction

A **4-bit register** is a sequential circuit used to store 4 bits of binary data. It consists of four flip-flops that share a common clock and reset signal.

The register has:

* **D[3:0]:** 4-bit data input.
* **CLK:** Clock signal that controls data storage.
* **RESET:** Synchronous reset that clears the register.
* **Q[3:0]:** 4-bit output containing the stored data.

Since all four bits are stored simultaneously, the register is useful for temporarily holding binary data in digital systems.

## 3. Block Diagram

```text
          +----------------------+
 D[3:0] ->|                      |
          |                      |
 CLK ---->|     4-BIT REGISTER   |----> Q[3:0]
          |                      |
 RESET -->|                      |
          +----------------------+
```

All four bits share the same clock and reset signals.

## 4. Truth Table

The output is updated only at the rising edge of the clock.

|       CLK      | RESET | D[3:0] | Q[3:0] (Next State) |
| :------------: | :---: | :----: | :-----------------: |
|        ↑       |   1   |  XXXX  |         0000        |
|        ↑       |   0   |  0000  |         0000        |
|        ↑       |   0   |  0101  |         0101        |
|        ↑       |   0   |  1010  |         1010        |
|        ↑       |   0   |  1111  |         1111        |
| No rising edge |   X   |  XXXX  |      Previous Q     |

**Note:**

* `↑` represents the rising edge of the clock.
* `XXXX` means the input data can have any value.
* When RESET is HIGH at the rising edge, the register is cleared, regardless of D.
* When RESET is LOW, the input data is stored.



### Code Explanation

| Code                    | Description                                                 |
| ----------------------- | ----------------------------------------------------------- |
| `input [3:0] D`         | Declares a 4-bit data input, from D[3] to D[0].             |
| `input CLK`             | Declares the clock input.                                   |
| `input RESET`           | Declares the synchronous reset input.                       |
| `output reg [3:0] Q`    | Declares a 4-bit output assigned inside the `always` block. |
| `always @(posedge CLK)` | Executes the block at every rising edge of the clock.       |
| `if (RESET)`            | Checks whether the reset signal is HIGH.                    |
| `Q <= 4'b0000;`         | Clears all four bits of the register.                       |
| `else Q <= D;`          | Stores the input data when reset is LOW.                    |

**Important:** `4'b0000` represents a 4-bit binary value. The reset is synchronous because it is checked only at the rising edge of CLK.

## 6. Working Principle

The register stores or clears all four bits simultaneously, depending on the RESET signal.

1. **RESET = 1:** At the rising edge of CLK, all four output bits become 0.
2. **RESET = 0:** At the rising edge of CLK, the 4-bit input D is copied to Q.
3. **Between clock edges:** Q retains its previously stored value, even if D or RESET changes.

For example, if D = `1010` and RESET = 0 at a rising clock edge, Q becomes `1010`. If RESET becomes HIGH before the next rising edge, Q remains `1010` until that edge, when it is cleared to `0000`.

## 7. Timing Diagram

```text
CLK    ____|‾‾‾‾|____|‾‾‾‾|____|‾‾‾‾|____|‾‾‾‾|____

RESET  ‾‾‾‾‾‾‾‾‾‾|________________|‾‾‾‾‾‾‾‾‾‾‾‾

D      1010       1100             0111

Q      0000       1100             0111       0000
          ↑          ↑                ↑          ↑
        Reset      Store            Store      Reset
```

### Timing Diagram Explanation

* At the first rising edge, RESET is HIGH, so Q is cleared to `0000`.
* At the second rising edge, RESET is LOW and D is `1100`, so Q stores `1100`.
* At the third rising edge, D is `0111`, so Q updates to `0111`.
* At the fourth rising edge, RESET is HIGH, so Q becomes `0000`.

The output changes only at the rising edge of the clock. Changes in D between clock edges do not affect the stored data.

*Note: The waveform is illustrative and assumes the register is initialized through a clock edge with RESET asserted.*

## 8. Applications

* Temporary data storage in digital systems.
* Buffering data between processing stages.
* Storing intermediate results in arithmetic circuits.
* Holding data in processors and digital controllers.

## Key Takeaways

* A 4-bit register stores four bits of data simultaneously.
* It uses a common clock for all four bits.
* The synchronous reset clears the register only at the rising edge of CLK.
* When RESET is LOW, the register captures D at the rising edge.
* The output remains unchanged between clock edges.
* This design can be extended to wider registers by changing the data width.
