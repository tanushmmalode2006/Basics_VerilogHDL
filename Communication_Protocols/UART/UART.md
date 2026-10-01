# 🔌 Communication Protocols

We'll begin with **UART**, because it is one of the simplest protocols to understand and implement in Verilog, and it will make good use of the **FSM + counters + registers** you've just learned.

## UART — Part 1: Basic Concept

Before writing Verilog, let's understand **what UART actually does**.

### 1. What is communication?

Suppose two digital systems need to exchange data:

```text
Microcontroller A  ───────────→  Microcontroller B
                       Data
```

They need some agreed method for:

* How data is sent
* When data starts
* When data ends
* How fast data is sent
* How the receiver knows which bits belong to the data

That agreed method is a **communication protocol**.

Examples you'll learn:

```text
UART
SPI
I²C
```

---

# 2. Parallel vs Serial Communication

There are two basic ways to send multiple bits.

### Parallel

Send several bits at the same time:

```text
        D3 ───────────────→
        D2 ───────────────→
        D1 ───────────────→
        D0 ───────────────→

             4 bits
```

For example, a 4-bit value:

```text
1011
```

can be transmitted simultaneously.

### Serial

Send one bit at a time:

```text
1 → 0 → 1 → 1
```

over a single data line.

```text
TX ─────────────────────→ RX
          1 0 1 1
```

UART uses **serial communication**.

---

# 3. What does UART stand for?

**UART = Universal Asynchronous Receiver/Transmitter**

The important word initially is:

### Asynchronous

UART normally does **not send a separate clock signal** along with the data.

Compare:

```text
Synchronous:

DATA ───────────────→
CLK  ───────────────→
```

versus:

```text
UART:

DATA ───────────────→
```

Both transmitter and receiver instead agree beforehand on a timing rate called the **baud rate**.

---

# 4. UART has TX and RX

UART generally has two data signals:

```text
        DEVICE A                 DEVICE B

       TX  ───────────────────→  RX
       RX  ←───────────────────  TX
```

So:

### TX

**Transmitter**

Sends data.

### RX

**Receiver**

Receives data.

This gives us **full-duplex communication**: both sides can transmit and receive.

For example:

```text
ESP32 TX ─────────→ FPGA RX
ESP32 RX ←───────── FPGA TX
```

This is particularly useful in embedded systems.

---

# 5. What does UART actually transmit?

Suppose we want to send:

```text
10101010
```

UART doesn't simply put:

```text
10101010
```

on the wire.

It adds special bits around the data.

A simplified UART frame looks like:

```text
Idle   Start    Data bits        Stop
 1       0      D0 D1 D2 ... D7    1
```

For a typical **8N1 UART**:

```text
1 Start bit
8 Data bits
0 Parity bits
1 Stop bit
```

So:

```text
┌──────┬────────────────┬──────┐
│START │    8 DATA BITS │STOP  │
│  0   │ D0 D1 ... D7   │  1   │
└──────┴────────────────┴──────┘
```

Notice that the data is usually transmitted **LSB first**.

For example, if the byte is:

```text
10110010
```

where:

```text
D7 D6 D5 D4 D3 D2 D1 D0
 1  0  1  1  0  0  1  0
```

UART sends:

```text
D0 → D1 → D2 → D3 → D4 → D5 → D6 → D7

 0    1    0    0    1    1    0    1
```

We'll come back to this carefully.

---

# 6. UART line when nothing is being transmitted

An important point:

When UART is idle, the TX line is normally:

```text
TX = 1
```

So the basic sequence is:

```text
IDLE
  │
  │ TX = 1
  ↓
START
  │
  │ TX = 0
  ↓
DATA
  │
  │ D0 → D7
  ↓
STOP
  │
  │ TX = 1
  ↓
IDLE
```

This is already looking like an **FSM**.

And that's exactly why your FSM knowledge is useful here.

---

# 7. What is Baud Rate?

This is one of the most important UART concepts.

**Baud rate** tells us the symbol transmission rate.

For the common UART case where one symbol represents one bit:

```text
9600 baud ≈ 9600 bits/second
```

Similarly:

```text
115200 baud ≈ 115200 bits/second
```

Common values include:

```text
9600
19200
38400
57600
115200
```

---

# 8. Why does the receiver need the baud rate?

Imagine TX sends:

```text
1 0 1 1 0 0 1 0
```

The receiver needs to know **when to sample each bit**.

For example:

```text
        bit 0      bit 1      bit 2
          ↓          ↓          ↓
TX ────────┬──────────┬──────────┬────
           │          │          │
          sample     sample     sample
```

So the receiver uses its clock and baud-rate timing to determine when to sample the incoming signal.

---

# 9. Important distinction: Clock vs Baud Rate

Suppose your FPGA clock is:

```text
50 MHz
```

but UART is configured for:

```text
115200 baud
```

You **cannot** simply use one FPGA clock cycle for one UART bit.

Instead, you use a counter:

```text
50 MHz system clock
        ↓
Baud-rate counter
        ↓
UART bit timing
        ↓
TX/RX
```

This counter will be an important part of our UART RTL.

---

# 10. The UART transmitter we'll build

Eventually we'll make something like:

```text
             ┌─────────────────────┐
data[7:0] ──→│                     │
start ──────→│   UART TRANSMITTER  │────→ TX
CLK ────────→│                     │
             └─────────────────────┘
```

Internally:

```text
             ┌──────────────┐
             │     FSM      │
             └──────┬───────┘
                    │
             ┌──────▼───────┐
             │ Baud Counter  │
             └──────┬───────┘
                    │
             ┌──────▼───────┐
             │ Shift/Data   │
             │   Register   │
             └──────┬───────┘
                    │
                    ▼
                   TX
```


Good. 👍 Let's continue with the next UART concept.

# UART — Part 2: Understanding the UART Frame

Before writing the transmitter, you should be completely comfortable with **what actually appears on the TX wire**.

---

## 1. UART frame

For the common **8N1 configuration**:

```text
8  → 8 data bits
N  → No parity
1  → 1 stop bit
```

The frame is:

```text
IDLE    START       DATA BITS              STOP
  1       0       D0 D1 D2 D3 D4 D5 D6 D7   1
  │       │          │                       │
  │       │          └── 8 data bits         │
  │       └── Start bit                      │
  └── Line idle                              └── Stop bit
```

So one UART frame contains:

```text
1 Start + 8 Data + 1 Stop = 10 bits
```

---

# 2. Let's transmit an actual byte

Suppose we want to send:

```text
0x53
```

Convert hexadecimal to binary:

```text
0x53 = 0101 0011
```

Therefore:

```text
D7 D6 D5 D4 D3 D2 D1 D0
 0  1  0  1  0  0  1  1
```

But UART sends **LSB first**.

So the transmission order is:

```text
D0 → D1 → D2 → D3 → D4 → D5 → D6 → D7
```

which gives:

```text
1 → 1 → 0 → 0 → 1 → 0 → 1 → 0
```

---

# 3. Complete frame for `0x53`

Add the start and stop bits:

```text
Start     Data                     Stop
  0     1 1 0 0 1 0 1 0              1
  │     └──────────────┘              │
  │          8 bits                   │
  └───────────────────────────────────┘
```

Therefore the TX line sends:

```text
0 → 1 → 1 → 0 → 0 → 1 → 0 → 1 → 0 → 1
```

Remember:

**This is the order in which the bits appear on the wire.**

---

# 4. What happens before transmission?

When UART is doing nothing:

```text
TX = 1
```

So imagine the TX waveform like this:

```text
             8N1 frame
              ┌───────────────────────────────┐
              │                               │
TX ───────────┘                               └────────
       IDLE    0  1  1  0  0  1  0  1  0  1   IDLE
               ↑                          ↑
             START                       STOP
```

Each bit occupies approximately **one bit period**.

---

# 5. What is a bit period?

Suppose baud rate is:

```text
9600 baud
```

Approximately:

```text
1 bit = 1 / 9600 seconds
```

which is about:

```text
104.17 µs
```

So each UART bit remains on the TX line for about **104 µs**.

For 8N1:

```text
10 bits × 104.17 µs
≈ 1.042 ms
```

So transmitting one complete frame takes approximately **1.04 ms**, excluding any additional idle time.

---

# 6. What if baud rate is 115200?

Now:

```text
1 bit = 1 / 115200
     ≈ 8.68 µs
```

And one 8N1 frame:

```text
10 × 8.68 µs
≈ 86.8 µs
```

So increasing the baud rate means the bits are transmitted faster.

---

# 7. Why does UART use LSB first?

UART conventionally transmits the **least significant bit first**.

For:

```text
0x53
```

we have:

```text
Binary:

01010011
│      │
D7     D0
```

Transmission:

```text
D0 D1 D2 D3 D4 D5 D6 D7

1  1  0  0  1  0  1  0
```

This is something you should remember for interviews.

> **UART typically transmits data LSB first.**

---

# 8. Where does the FSM come in?

Now you can see why the FSM we just studied is useful.

Our UART transmitter can have states such as:

```text
IDLE
  ↓
START
  ↓
DATA
  ↓
STOP
  ↓
IDLE
```

More explicitly:

```text
        start
IDLE ─────────→ START
 ↑                │
 │                │ 1 bit
 │                ↓
 │              DATA
 │                │
 │           8 bits sent
 │                ↓
 │              STOP
 │                │
 │             1 bit
 │                ↓
 └────────────── IDLE
```

Inside the `DATA` state, we'll use a **counter** to keep track of which data bit we're sending:

```text
bit_count = 0 → D0
bit_count = 1 → D1
bit_count = 2 → D2
...
bit_count = 7 → D7
```

And another counter will handle the baud timing.

So our final UART TX architecture will look like:

```text
                    ┌─────────────┐
                    │     FSM     │
                    │             │
                    │ IDLE        │
                    │ START       │
                    │ DATA        │
                    │ STOP        │
                    └──────┬──────┘
                           │
              ┌────────────┴────────────┐
              │                         │
       ┌──────▼──────┐           ┌──────▼──────┐
       │ Baud Counter│           │ Bit Counter │
       └─────────────┘           └─────────────┘
              │                         │
              └──────────┬──────────────┘
                         ↓
                  Data Register
                         ↓
                        TX
```

This is a **real RTL design pattern**: FSM + counters + registers.

---

# 9. One important concept: Parity

We are initially using:

```text
8N1
```

The `N` means **No parity**.

Other configurations exist, such as:

```text
8N1
8E1
8O1
```

where:

```text
N = No parity
E = Even parity
O = Odd parity
```

We don't need to implement parity yet.

We'll first build a simple **8N1 UART transmitter**.

---

# 🎯 What you should know before coding UART TX

Make sure these are clear:

| Concept   | Meaning                               |
| --------- | ------------------------------------- |
| UART      | Asynchronous serial communication     |
| TX        | Transmit                              |
| RX        | Receive                               |
| Idle      | TX = 1                                |
| Start     | 0                                     |
| Data      | Usually 8 bits                        |
| Order     | LSB first                             |
| Stop      | 1                                     |
| 8N1       | 8 data, no parity, 1 stop             |
| Baud rate | Bit transmission rate                 |
| Frame     | Start + data + optional parity + stop |

### Next step

We'll now build the **UART Transmitter in Verilog**, but **not jump directly into the full code**.

First we'll make the **baud-rate counter**, understand exactly how it works with your FPGA clock, and then connect it to the UART FSM.
