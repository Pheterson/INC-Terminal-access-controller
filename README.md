# Digital Systems Design - Project
## Terminal access controller
---

**Author:** Peter Koprda <xkoprd00@stud.fit.vutbr.cz>

---

### Overview
This project is a simple **Terminal Access Controller** implemented using a **Finite State Machine (FSM)** in VHDL. The system checks user-entered codes against two predefined access codes and either grants or denies access.

---

### Features
- **Finite State Machine Design:**
  - Validates each digit of the code sequentially.
  - Handles both correct and incorrect inputs.
  - Provides states for access granted, denied, and reset.

- **Predefined Access Codes:**
  - Code 1: `3450756460`
  - Code 2: `3450702584`

- **State Descriptions:**
  - **Validation States** (`S1` to `S10` for Code 1, `S1_P` to `S4_P` for Code 2)**:** Check individual digits of the input.
  - **GOOD State:** Indicates the entered code matches one of the predefined codes.
  - **BAD State:** Indicates invalid input.
  - **ACCESS_GRANTED State:** Confirms successful code validation.
  - **ACCESS_DENIED State:** Indicates incorrect code entry.
  - **FINISH State:** Resets the FSM for the next input attempt.
