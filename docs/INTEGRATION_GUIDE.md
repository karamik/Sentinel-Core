# Sentinel Core — Integration Guide

**Target Audience:** Hardware engineers, FPGA developers, system integrators

---

## 1. FPGA Integration (Xilinx / Intel / Lattice)

### 1.1 Prerequisites
- Vivado / Quartus / Radiant toolchain
- License for Sentinel Core bitstream (provided after purchase)

### 1.2 Integration Steps
1. **Add Sentinel Core IP to project** — import provided `.dcp` (Xilinx) or `.qxp` (Intel) file.
2. **Connect interfaces:**
   - `clk` — 100 MHz reference clock
   - `reset_n` — active low reset
   - `temp_sensors[7:0]` — temperature sensor inputs (I2C/SPI)
   - `mesh_ok` — active high when mesh intact
   - `key_out[255:0]` — derived PUF key
   - `alarm` — tamper detected
3. **Configure thresholds** — set temperature and voltage limits via `config_reg`.
4. **Synthesize and place** — ensure mesh inputs are routed to physical pins.

### 1.3 Example (Xilinx Vivado)
```tcl
add_files sentinel_core.dcp
create_ip -name sentinel_core -vendor igd -library security -version 1.0
set_property -dict [list CONFIG.TEMP_HIGH {105} CONFIG.TEMP_LOW {-40}] [get_ips sentinel_core]
