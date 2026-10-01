# D Latch (Verilog HDL)

## 1. Objective

To design and implement a **D Latch** using Verilog HDL, where the output follows the input when the enable signal is HIGH and retains its previous state when the enable signal is LOW.

## 2. Introduction

A D Latch is a **level-sensitive sequential circuit** that stores one bit of data.

It has two inputs:

* **D (Data):** The input data to be stored.
* **EN (Enable):** Controls when the latch is transparent.

It has one output:

* **Q:** The stored data.

Unlike a flip-flop, a D latch does not require a clock edge. Its output responds to the enable signal's logic level.

## 3. Block Diagram

```text
             +-------------+
       D --->|             |
             |   D LATCH   |----> Q
      EN --->|             |
             +-------------+
```

**Inputs:** D, EN
**Output:** Q

## 4. Truth Table

|  EN |  D  | Q (Next State) |
| :-: | :-: | :------------: |
|  0  |  0  |  Q (Previous)  |
|  0  |  1  |  Q (Previous)  |
|  1  |  0  |        0       |
|  1  |  1  |        1       |

**Note:**

* When `EN = 1`, Q follows D.
* When `EN = 0`, Q retains its previous value, regardless of D.


### Code Syntax Explanation

| Code             | Explanation                                                         |
| ---------------- | ------------------------------------------------------------------- |
| `module d_latch` | Declares a module named `d_latch`.                                  |
| `input D`        | Declares the data input.                                            |
| `input EN`       | Declares the enable input.                                          |
| `output reg Q`   | Declares Q as a procedural output variable.                         |
| `always @(*)`    | Executes the procedural block whenever an input used in it changes. |
| `if (EN)`        | Checks whether the enable signal is HIGH.                           |
| `Q = D;`         | Assigns the input data to the output when EN is HIGH.               |
| `endmodule`      | Marks the end of the module.                                        |

**Important:** There is no `else` statement. When `EN = 0`, Q is not assigned a new value, so it retains its previous value. This behavior describes a latch.

## 6. Working Principle

The D latch operates in two modes:

**Mode 1: Transparent (EN = 1)**

* The latch is enabled.
* The output Q follows the input D.
* Any change in D is reflected at Q.

**Mode 2: Hold (EN = 0)**

* The latch is disabled.
* The output Q retains the last value stored.
* Changes in D do not affect Q.

The latch therefore stores one bit of information and updates it only while the enable signal is HIGH.

## 7. Timing Diagram

```text
EN  ____|‾‾‾‾‾‾‾|________|‾‾‾‾‾‾‾|____

D   ____|‾‾|____|‾‾‾‾‾‾‾|____|‾‾‾‾|____

Q   ____|‾‾|____|‾‾‾‾‾‾‾|____|‾‾‾‾|____
```

**Timing Diagram Explanation:**

* When EN is HIGH, Q follows changes in D.
* When EN goes LOW, Q holds the last value of D.
* When EN becomes HIGH again, Q resumes following D.

*Note: The diagram is a conceptual illustration of latch behavior. Actual waveforms depend on the input transitions and simulation timing.*

---

## Key Takeaways

* A D latch is a **level-sensitive storage element**.
* It stores one bit of data.
* `EN = 1`: The latch is transparent.
* `EN = 0`: The latch holds its previous value.
* An incomplete assignment in a combinational `always` block can infer a latch during synthesis.
* Unlike a D flip-flop, a D latch is not triggered by a clock edge.
