# JK Flip-Flop (Verilog HDL)

## 1. Objective

To design and implement a positive-edge-triggered JK Flip-Flop using Verilog HDL, supporting Hold, Set, Reset, and Toggle operations.

## 2. Introduction

A **JK Flip-Flop** is an edge-triggered sequential circuit that stores one bit of data. It is an improved version of the SR flip-flop, with no invalid input combination.

It has three inputs:

* **J:** Set input.
* **K:** Reset input.
* **CLK:** Clock signal that controls when the output changes.

It has one output:

* **Q:** Stores the current state.

The JK flip-flop has four operating modes: Hold, Reset, Set, and Toggle. When both J and K are HIGH, the output toggles to its complementary value.

## 3. Block Diagram

```text
             +----------------+
       J --->| J              |
             |                |
       K --->| K    JK-FF     |----> Q
             |                |
 CLK ------->| CLK            |
             +----------------+
```

**Inputs:** J, K, CLK
**Output:** Q

## 4. Truth Table

The output is updated only at the rising edge of the clock.

|       CLK      |  J  |  K  | Q (Next State) | Operation |
| :------------: | :-: | :-: | :------------: | --------- |
|        ↑       |  0  |  0  |  Q (Previous)  | Hold      |
|        ↑       |  0  |  1  |        0       | Reset     |
|        ↑       |  1  |  0  |        1       | Set       |
|        ↑       |  1  |  1  |  Q̅ (Previous) | Toggle    |
| No rising edge |  X  |  X  |  Q (Previous)  | Hold      |

**Note:** `Q̅` represents the complement of the previous output. `X` represents either 0 or 1.



### Code Syntax Explanation

| Code                    | Explanation                                           |
| ----------------------- | ----------------------------------------------------- |
| `module jk_ff`          | Declares a module named `jk_ff`.                      |
| `input J, K`            | Declares the Set and Reset control inputs.            |
| `input CLK`             | Declares the clock input.                             |
| `output reg Q`          | Declares Q as a procedural output variable.           |
| `always @(posedge CLK)` | Executes the block at every rising edge of the clock. |
| `J == 1'b0`             | Checks whether J is equal to binary 0.                |
| `K == 1'b1`             | Checks whether K is equal to binary 1.                |
| `&&`                    | Performs a logical AND operation.                     |
| `Q <= Q`                | Retains the previous output value.                    |
| `Q <= 1'b0`             | Resets Q to 0.                                        |
| `Q <= 1'b1`             | Sets Q to 1.                                          |
| `Q <= ~Q`               | Assigns the complement of the previous Q value.       |
| `endmodule`             | Marks the end of the module.                          |

### Important Verilog Concepts

* **`posedge CLK`:** Triggers the sequential block on the rising edge of the clock.
* **`==`:** Compares two values for equality.
* **`&&`:** Performs a logical AND operation.
* **`~Q`:** Bitwise inversion of Q. Since Q is one bit wide, it produces the complementary value for known binary states.
* **`<=`:** Non-blocking assignment, commonly used in sequential circuits.

## 6. Working Principle

The JK flip-flop evaluates J and K at every rising edge of the clock. Depending on their values, it performs one of four operations.

**Case 1: J = 0, K = 0 — Hold**

The flip-flop retains its previous output. No change occurs in Q.

**Case 2: J = 0, K = 1 — Reset**

The flip-flop resets its output to 0 at the rising edge of CLK.

**Case 3: J = 1, K = 0 — Set**

The flip-flop sets its output to 1 at the rising edge of CLK.

**Case 4: J = 1, K = 1 — Toggle**

The output changes to its complement at the rising edge of CLK.

For example:

* If the previous Q is 0, the next Q becomes 1.
* If the previous Q is 1, the next Q becomes 0.

Unlike an SR flip-flop, the JK flip-flop has a defined operation for all four binary input combinations.

## 7. Timing Diagram

```text
CLK  ____|‾‾‾‾|____|‾‾‾‾|____|‾‾‾‾|____|‾‾‾‾|____

J    ____|‾‾‾‾|________|‾‾‾‾|________|‾‾‾‾|____

K    __________|‾‾‾‾|________|‾‾‾‾|____|‾‾‾‾|__

Q    ____|‾‾‾‾‾‾‾‾|_____|‾‾‾‾‾‾‾‾|_____|‾‾‾‾‾
          SET     RESET   SET     RESET  TOGGLE
```

### Timing Diagram Explanation

The diagram illustrates the four operating modes at successive rising clock edges.

* **First rising edge:** J = 1, K = 0. Q is set to 1.
* **Second rising edge:** J = 0, K = 1. Q is reset to 0.
* **Third rising edge:** J = 1, K = 0. Q is set to 1.
* **Fourth rising edge:** J = 1, K = 1. Q toggles from 1 to 0.

Q retains its value between rising clock edges, regardless of changes in J and K.

*Note: This is a conceptual timing diagram. Actual simulation waveforms depend on the input sequence and initial state.*

---

## Key Takeaways

* A JK flip-flop is a positive-edge-triggered, 1-bit storage element.
* It supports four operations: Hold, Reset, Set, and Toggle.
* When J = K = 1, the output toggles.
* Unlike the SR flip-flop, the JK flip-flop has no invalid binary input combination.
* `posedge CLK` ensures that the output changes only at the rising edge of the clock.
* Non-blocking assignment (`<=`) is used to model sequential behavior.
* JK flip-flops are commonly used in counters and frequency-divider circuits.

**Implementation note:** This code models the logical behavior of a JK flip-flop. It does not include a reset input, so Q may initially be unknown in simulation until it is assigned a known value.
