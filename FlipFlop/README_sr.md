# SR Flip-Flop (Verilog HDL)

## 1. Objective

To design and implement a positive-edge-triggered SR Flip-Flop using Verilog HDL to store one bit of data based on the Set and Reset inputs.

## 2. Introduction

An **SR (Set-Reset) Flip-Flop** is an edge-triggered sequential circuit that stores one bit of data. It updates its output only at the active clock edge.

It has three inputs:

* **S (Set):** Sets the output Q to 1.
* **R (Reset):** Resets the output Q to 0.
* **CLK (Clock):** Controls when the output is updated.

It has one output:

* **Q:** Stores the current state.

Unlike an SR latch, which responds to input levels, an SR flip-flop responds to the Set and Reset inputs only at the specified clock edge.

## 3. Block Diagram

```text
             +----------------+
       S --->| S              |
             |                |
       R --->| R    SR-FF     |----> Q
             |                |
 CLK ------->| CLK            |
             +----------------+
```

**Inputs:** S, R, CLK
**Output:** Q

## 4. Truth Table

The output is updated only at the rising edge of the clock.

|       CLK      |  S  |  R  | Q (Next State) | Operation |
| :------------: | :-: | :-: | :------------: | --------- |
|        ↑       |  0  |  0  |  Q (Previous)  | Hold      |
|        ↑       |  0  |  1  |        0       | Reset     |
|        ↑       |  1  |  0  |        1       | Set       |
|        ↑       |  1  |  1  |        X       | Invalid   |
| No rising edge |  X  |  X  |  Q (Previous)  | Hold      |

**Note:**

* `↑` represents the rising edge of CLK.
* `X` represents an unknown or undefined value.
* When S and R are both HIGH, the output is assigned `X` to represent the invalid input condition.



### Code Syntax Explanation

| Code                    | Explanation                                                 |
| ----------------------- | ----------------------------------------------------------- |
| `module sr_ff`          | Defines a module named `sr_ff`.                             |
| `input S`               | Declares the Set input.                                     |
| `input R`               | Declares the Reset input.                                   |
| `input CLK`             | Declares the clock input.                                   |
| `output reg Q`          | Declares Q as a procedural output variable.                 |
| `always @(posedge CLK)` | Executes the block only at the rising edge of CLK.          |
| `S && !R`               | Checks whether Set is HIGH and Reset is LOW.                |
| `Q <= 1'b1;`            | Sets the output to 1.                                       |
| `!S && R`               | Checks whether Set is LOW and Reset is HIGH.                |
| `Q <= 1'b0;`            | Resets the output to 0.                                     |
| `!S && !R`              | Checks whether both inputs are LOW.                         |
| `Q <= Q;`               | Retains the previous output value.                          |
| `Q <= 1'bx;`            | Assigns an unknown value for the invalid input combination. |
| `endmodule`             | Marks the end of the module.                                |

### Important Verilog Operators

| Operator | Meaning                 |
| -------- | ----------------------- |
| `&&`     | Logical AND             |
| `!`      | Logical NOT             |
| `<=`     | Non-blocking assignment |
| `1'b1`   | 1-bit binary value 1    |
| `1'b0`   | 1-bit binary value 0    |
| `1'bx`   | 1-bit unknown value     |

## 6. Working Principle

The SR flip-flop evaluates the Set and Reset inputs at every rising edge of the clock.

**Case 1: S = 0, R = 0 — Hold**

Neither input is active. The flip-flop retains its previous output.

**Case 2: S = 0, R = 1 — Reset**

The Reset input is active. At the rising edge of CLK, Q becomes 0.

**Case 3: S = 1, R = 0 — Set**

The Set input is active. At the rising edge of CLK, Q becomes 1.

**Case 4: S = 1, R = 1 — Invalid**

Both Set and Reset are active. The code assigns `1'bx` to Q to represent the undefined condition.

**Between clock edges:** Changes in S and R do not affect Q. The output retains its previously stored value until the next rising edge.

## 7. Timing Diagram

```text
CLK  ____|‾‾‾‾|____|‾‾‾‾|____|‾‾‾‾|____|‾‾‾‾|____

S    ____|‾‾‾‾|________|‾‾‾‾|____________________

R    __________|‾‾‾‾|________________|‾‾‾‾|______

Q    ____|‾‾‾‾‾‾‾‾|_____|‾‾‾‾‾‾‾‾‾‾‾‾|_____|‾‾‾
          SET     RESET     SET        RESET
```

### Timing Diagram Explanation

* At the first rising edge, S = 1 and R = 0, so Q is set to 1.
* At the second rising edge, S = 0 and R = 1, so Q is reset to 0.
* At the third rising edge, S = 1 and R = 0, so Q becomes 1 again.
* At the fourth rising edge, S = 0 and R = 1, so Q becomes 0.
* Between rising edges, Q retains its previous value.

*Note: This is a conceptual timing diagram illustrating valid Set and Reset operations. It assumes Q has been initialized and does not show the invalid input condition.*

---

## Key Takeaways

* An SR flip-flop is a clocked, edge-triggered storage element.
* It stores one bit of data.
* Set makes Q = 1, while Reset makes Q = 0.
* When both inputs are LOW, the flip-flop retains its previous state.
* When both inputs are HIGH, the provided code assigns an unknown value (`X`).
* The `posedge CLK` construct ensures that the output is updated only on the rising edge.
* The non-blocking assignment (`<=`) is used to model sequential behavior.

**Implementation note:** `Q <= 1'bx` is useful for simulation to indicate an invalid input combination. However, `X` is not a physical logic level. Actual hardware behavior for simultaneous Set and Reset depends on the flip-flop implementation.
