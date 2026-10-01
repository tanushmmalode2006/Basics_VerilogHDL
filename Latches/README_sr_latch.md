# SR Latch (Verilog HDL)

## 1. Objective

To design and implement an SR latch using Verilog HDL that stores one bit of data based on the Set (S) and Reset (R) inputs.

## 2. Introduction

An **SR (Set-Reset) Latch** is a level-sensitive sequential circuit used to store one bit of information.

It has two control inputs:

* **S (Set):** Sets the output Q to 1.
* **R (Reset):** Resets the output Q to 0.

It has one output, **Q**, which stores the current state.

The latch retains its previous state when neither input is asserted. In this implementation, Set has priority over Reset when both inputs are HIGH.

## 3. Block Diagram

```text
             +-------------+
       S --->|             |
             |  SR LATCH   |----> Q
       R --->|             |
             +-------------+
```

**Inputs:** S, R
**Output:** Q

## 4. Truth Table

|  S  |  R  | Q (Next State) | Operation      |
| :-: | :-: | :------------: | -------------- |
|  0  |  0  |  Q (Previous)  | Hold           |
|  0  |  1  |        0       | Reset          |
|  1  |  0  |        1       | Set            |
|  1  |  1  |        1       | Set (priority) |

**Note:** Unlike a conventional cross-coupled NOR SR latch, this behavioral implementation gives Set priority when both S and R are HIGH. It does not model the conventional SR latch's invalid input condition.


### Code Syntax Explanation

| Code              | Explanation                                              |
| ----------------- | -------------------------------------------------------- |
| `module sr_latch` | Defines a module named `sr_latch`.                       |
| `input S`         | Declares the Set input.                                  |
| `input R`         | Declares the Reset input.                                |
| `output reg Q`    | Declares Q as a procedural output variable.              |
| `always @(*)`     | Executes the block whenever an input used in it changes. |
| `if (S)`          | Checks whether the Set input is HIGH.                    |
| `Q = 1'b1;`       | Sets Q to logic 1.                                       |
| `else if (R)`     | Checks Reset only when Set is LOW.                       |
| `Q = 1'b0;`       | Resets Q to logic 0.                                     |
| `endmodule`       | Marks the end of the module.                             |

**Important Verilog concepts:**

* `1'b1` represents a 1-bit binary value of 1.
* `1'b0` represents a 1-bit binary value of 0.
* The `if-else if` structure gives priority to S over R.
* The absence of a final `else` allows Q to retain its previous value when both inputs are LOW.

## 6. Working Principle

The SR latch operates according to the Set and Reset inputs.

**Case 1: S = 0, R = 0 (Hold)**

Neither input is active. The latch retains its previous output.

**Case 2: S = 0, R = 1 (Reset)**

The Reset input is active, so Q becomes 0.

**Case 3: S = 1, R = 0 (Set)**

The Set input is active, so Q becomes 1.

**Case 4: S = 1, R = 1 (Set Priority)**

Both inputs are HIGH. Since S is checked first in the Verilog code, Q becomes 1.

The output remains at its current value until an input causes it to change.

## 7. Timing Diagram

```text
S   ____|‾‾‾‾|________|‾‾‾‾|________

R   __________|‾‾‾‾|________________

Q   ____|‾‾‾‾‾‾‾‾‾‾|_____|‾‾‾‾‾‾‾‾‾
```

### Timing Diagram Explanation

* Initially, Q retains its previous value.
* When S becomes HIGH, Q is set to 1.
* When both S and R are LOW, Q holds its previous state.
* When R becomes HIGH while S is LOW, Q is reset to 0.
* When S becomes HIGH again, Q returns to 1.

The waveform illustrates the behavior of the provided code, assuming Q was initially 0.

---

## Key Takeaways

* An SR latch is a level-sensitive, 1-bit storage element.
* S sets the output, while R resets it.
* When both inputs are LOW, the latch holds its previous state.
* This implementation gives Set priority over Reset.
* The incomplete assignment in the `always` block infers storage behavior during synthesis.
* This behavioral implementation is not identical to a conventional gate-level SR latch.
