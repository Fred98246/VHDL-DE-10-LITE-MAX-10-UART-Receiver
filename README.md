# VHDL-DE-10-LITE-MAX-10-UART-Receiver
VHDL UART receiver for the DE10-Lite (MAX 10) FPGA, decoding and displaying incoming PC serial data on 7-segment displays.
# VHDL UART Receiver for DE10-Lite

The main function of this project is to read the ASCII characters of each keyboard key you press and display them instantly on the 7-segment displays of the DE10-Lite board. 

## How it works:
The whole thing is coded in VHDL using state machines for passing to different blocks.

<img width="1024" height="572" alt="image" src="https://github.com/user-attachments/assets/0ba36f3b-f6ed-4f79-93cc-567d6e5c13e6" />

I built this using a hierarchical file structure to keep things clean. `UART_R_TOP` is the main file that acts as the boss, and the rest of the VHDL files (like the receiver and the hex decoder) are used as entities or blocks that get plugged into the top level. The entire project was built and compiled in Intel Quartus for the MAX 10 board.

## Hardware Setup
To get this working, you can't just use a normal USB cable. You need a **USB to UART converter** wired to the FPGA. 
1. Connect the **TX pin** from your converter to the **RX pin** on the board, and tie the grounds (GND) together.
2. Open up **Tera Term** on your PC.
3. Start typing! Tera Term acts as the terminal passing the 7-bit/8-bit UART data (ASCII characters) straight to the board. 

## Pin Planner Settings (Intel MAX 10)
If you are setting this up in Quartus for the MAX 10 board, here is the exact pin planner configuration I used based on the DE 10 lite manual. Make sure the I/O standard for everything is set to **3.3-V LVTTL**.

* **Clock (`i_clk`)**: `PIN_P11`
* **UART RX (`UART_RX_PIN`)**: `PIN_AB5`

**HEX0 Display (Right)**
* `HEX0[0]`: `PIN_C18`
* `HEX0[1]`: `PIN_D18`
* `HEX0[2]`: `PIN_E18`
* `HEX0[3]`: `PIN_B16`
* `HEX0[4]`: `PIN_A17`
* `HEX0[5]`: `PIN_A18`
* `HEX0[6]`: `PIN_B17`

**HEX1 Display (Left)**
* `HEX1[0]`: `PIN_C14`
* `HEX1[1]`: `PIN_E15`
* `HEX1[2]`: `PIN_C15`
* `HEX1[3]`: `PIN_C16`
* `HEX1[4]`: `PIN_E16`
* `HEX1[5]`: `PIN_D17`
* `HEX1[6]`: `PIN_C17`
