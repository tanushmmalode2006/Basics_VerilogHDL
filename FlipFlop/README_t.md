# T Flip-Flop (Verilog HDL)

## 1. Objective

To design and implement a positive-edge-triggered T Flip-Flop using Verilog HDL, which holds or toggles its output depending on the T input.

## 2. Introduction

A **T (Toggle) Flip-Flop** is an edge-triggered sequential circuit that stores one bit of data. Its output changes only at the active clock edge.

It has two inputs:

* **T (Toggle):** Controls whether the output holds or toggles.
* **CLK (Clock):** Determines when the output is updated.

It has one output:

* **Q:** Stores the current state.

The T flip-flop has two operating modes: **Hold** and **Toggle**. It is commonly used in binary counters and frequency-divider circuits.

## 3. Block Diagram

```text
             +----------------+
       T --->| T              |
             |                |
 CLK ------->| CLK    T-FF    |----> Q
             |                |
             +----------------+
```

**Inputs:** T, CLK
**Output:** Q

## 4. Truth Table

The output is updated only at the rising edge of the clock.

|       CLK      |  T  | Q (Next State) | Operation |
| :------------: | :-: | :------------: | --------- |
|        ↑       |  0  |  Q (Previous)  | Hold      |
|        ↑       |  1  |  Q̅ (Previous) | Toggle    |
| No rising edge |  X  |  Q (Previous)  | Hold      |

**Note:**

* `↑` represents the rising edge of the clock.
* `Q̅` represents the complement of the previous output.
* `X` represents either 0 or 1.



### Code Syntax Explanation

| Code                    | Explanation                                                     |
| ----------------------- | --------------------------------------------------------------- |
| `module t_ff`           | Declares a module named `t_ff`.                                 |
| `input T`               | Declares the toggle input.                                      |
| `input CLK`             | Declares the clock input.                                       |
| `output reg Q`          | Declares Q as a procedural output variable.                     |
| `always @(posedge CLK)` | Executes the block at every rising edge of the clock.           |
| `if (T == 1'b0)`        | Checks whether T is LOW.                                        |
| `Q <= Q;`               | Retains the previous output value.                              |
| `else`                  | Executes when T is not equal to 0 in a known binary simulation. |
| `Q <= ~Q;`              | Inverts the current output value.                               |
| `endmodule`             | Marks the end of the module.                                    |

### Important Verilog Concepts

* **`posedge CLK`:** Triggers the block on the rising edge of the clock.
* **`==`:** Compares two values for equality.
* **`~Q`:** Performs bitwise inversion. For a 1-bit known value, it changes 0 to 1 and 1 to 0.
* **`<=`:** Non-blocking assignment, used for sequential logic.

## 6. Working Principle

The T flip-flop checks the value of T at every rising edge of the clock.

**Case 1: T = 0 — Hold**

When T is LOW, the flip-flop retains its previous output. No state change occurs.

**Case 2: T = 1 — Toggle**

When T is HIGH, the flip-flop complements its previous output at the rising edge of the clock.

* If Q was 0, it becomes 1.
* If Q was 1, it becomes 0.

Therefore, when T remains HIGH, Q toggles at every rising clock edge.

When T is LOW, Q remains unchanged, regardless of the number of clock edges.

## 7. Timing Diagram

```text
CLK  ____|‾‾‾‾|____|‾‾‾‾|____|‾‾‾‾|____|‾‾‾‾|____|‾‾‾‾|____

T    ____|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|________|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾

Q    ____|‾‾‾‾‾‾‾‾|_____|‾‾‾‾‾‾‾‾|________|‾‾‾‾‾‾‾‾
          Toggle   Toggle   Hold     Toggle
```

### Timing Diagram Explanation

* Initially, assume Q = 0.
* At the first rising edge, T = 1, so Q toggles from 0 to 1.
* At the second rising edge, T = 1, so Q toggles from 1 to 0.
* At the third rising edge, T = 0, so Q retains its previous value.
* At the fourth rising edge, T = 1, so Q toggles from 0 to 1.

The output changes only at the rising edges of CLK. Changes in T between clock edges do not directly affect Q.

*Note: This is a conceptual timing diagram illustrating the behavior of the T flip-flop. Actual waveforms depend on the testbench and initial state.*

---

## Key Takeaways

* A T flip-flop is a positive-edge-triggered, 1-bit storage element.
* It has two operating modes: Hold and Toggle.
* When T = 0, the output retains its previous value.
* When T = 1, the output toggles at every rising clock edge.
* It is commonly used in binary counters and frequency dividers.
* The non-blocking assignment (`<=`) models sequential behavior.

**Implementation note:** This design does not include a reset input. Therefore, Q may initially be unknown in simulation until it receives a known value.
