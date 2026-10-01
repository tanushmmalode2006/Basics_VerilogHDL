# D Flip-Flop (Verilog HDL)

## 1. Objective

To design and implement a positive-edge-triggered D Flip-Flop using Verilog HDL to store one bit of data on the rising edge of the clock.

## 2. Introduction

A **D (Data) Flip-Flop** is an edge-triggered sequential circuit that stores one bit of information.

It has two inputs:

* **D (Data):** The data to be stored.
* **CLK (Clock):** Controls when the data is captured.

It has one output:

* **Q:** Stores the captured data.

Unlike a D latch, which is level-sensitive, a D flip-flop responds only to a specific clock transition. In this design, data is captured on the **positive (rising) edge** of the clock.

## 3. Block Diagram

```text
             +----------------+
       D --->| D              |
             |                |
 CLK ------->| CLK    D-FF    |----> Q
             |                |
             +----------------+
```

**Inputs:** D, CLK
**Output:** Q

## 4. Truth Table

| CLK Transition |  D  | Q (Next State) |
| :------------: | :-: | :------------: |
|        ↑       |  0  |        0       |
|        ↑       |  1  |        1       |
| No rising edge |  X  |  Q (Previous)  |

**Note:**

* `↑` represents a rising edge of the clock (transition from 0 to 1).
* `X` represents either 0 or 1.
* Q changes only at the rising edge of CLK.


### Code Syntax Explanation

| Code                    | Explanation                                                       |
| ----------------------- | ----------------------------------------------------------------- |
| `module d_ff`           | Declares a module named `d_ff`.                                   |
| `input D`               | Declares the data input.                                          |
| `input CLK`             | Declares the clock input.                                         |
| `output reg Q`          | Declares Q as a procedural variable that stores the output value. |
| `always @(posedge CLK)` | Executes the block only when CLK changes from LOW to HIGH.        |
| `Q <= D;`               | Captures the value of D and schedules it to be assigned to Q.     |
| `endmodule`             | Marks the end of the module.                                      |

**Important Verilog concepts:**

* `posedge` detects the positive (rising) edge of a signal.
* `<=` is the non-blocking assignment operator, commonly used for sequential logic.
* `Q` retains its value between clock edges.

## 6. Working Principle

The D flip-flop operates based on the rising edge of the clock.

1. **Before the rising edge:** Changes in D do not affect Q.
2. **At the rising edge:** The flip-flop captures the current value of D.
3. **After the rising edge:** Q updates to the captured value.
4. **Between clock edges:** Q retains its previous value, regardless of changes in D.

For example, if D is 1 at the rising edge of CLK, Q becomes 1. If D changes to 0 before the next rising edge, Q remains 1 until the next rising edge.

This allows the flip-flop to synchronize data storage with a clock signal.

## 7. Timing Diagram

```text
CLK  ____|‾‾‾‾|____|‾‾‾‾|____|‾‾‾‾|____

D    __|‾‾‾‾‾‾|_____|‾‾‾‾‾‾‾‾|________

Q    ______|‾‾‾‾‾‾‾‾|_____|‾‾‾‾‾‾‾‾‾‾
          ↑         ↑      ↑
       Capture   Capture  Capture
```

### Timing Diagram Explanation

* At the first rising edge, D is 1, so Q becomes 1.
* At the second rising edge, D is 0, so Q becomes 0.
* At the third rising edge, D is 1, so Q becomes 1.
* Changes in D between rising edges do not affect Q.

*Note: The diagram is a conceptual illustration. Actual simulation waveforms may include propagation delays and depend on the testbench.*

---

## Key Takeaways

* A D flip-flop is an edge-triggered, 1-bit storage element.
* It captures data only on the rising edge of the clock.
* `posedge CLK` specifies positive-edge triggering.
* The non-blocking assignment (`<=`) is used for sequential logic.
* The output remains unchanged between clock edges.
* Unlike a D latch, a D flip-flop does not continuously follow its input.
