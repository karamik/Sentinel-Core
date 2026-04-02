# EVALUATION GUIDE | Sentinel Core v8.2
**Hardware-in-the-Loop (HIL) Verification Protocol**

---

## 1. Introduction
This guide provides the procedure for verifying the **Sentinel Core** TRL-6 status using the provided Evaluation Bitstream. The goal is to measure the **Logic Migration Latency** and **Tamper Response Time** on the customer's local hardware.

## 2. Hardware Requirements
* **Platform:** Xilinx Zynq UltraScale+ (tested on ZU3EG/ZU9EG) or Intel Stratix 10.
* **Testing Gear:** Mixed Signal Oscilloscope (MSO) with >2GHz bandwidth.
* **Trigger Source:** High-precision Pulse Generator or Thermal/Laser injection rig.

## 3. Deployment Steps
1.  **Bitstream Loading:** Flash the provided `.bit` (Xilinx) or `.rbf` (Intel) file using JTAG. 
    * *Note: Evaluation bitstreams are Node-Locked to your Device DNA.*
2.  **Pin Configuration:** Map the following debug headers:
    * `PIN_A1`: **TRIGGER_IN** (Input for simulated attack).
    * `PIN_B1`: **MIGRATION_STATUS** (High = Logic Shift Active).
    * `PIN_C1`: **TAMPER_ALARM** (High = Scorched Earth Triggered).

## 4. Verification Procedures

### 4.1. Logic Migration Latency Test
1.  Apply a 3.3V pulse to `TRIGGER_IN`.
2.  Measure the delay between the rising edge of `TRIGGER_IN` and the rising edge of `MIGRATION_STATUS`.
3.  **Expected Result:** The delta (Δt) must be **< 850 ns**.

### 4.2. Active Mesh Integrity Test (Simulation)
1.  Monitor the `TAMPER_ALARM` pin.
2.  Disconnect or ground the specialized Mesh-Monitor trace (provided in the board overlay).
3.  **Expected Result:** The pin must transition to HIGH within **< 120 ns**.
4.  **Verification:** Internal key registers (accessible via debug UART) must return `0x00...00` (Zeroized).

## 5. Success Metrics
The evaluation is considered successful if the following thresholds are met:
* **PUF Hamming Distance (HD):** 49.8% - 50.2% across power cycles.
* **SCA Resistance:** No detectable EM leak during logic migration cycles.
* **Latency Compliance:** All hardware interrupts processed under 1 microsecond.

---

## 🔐 Support & Audit Access
For deep-dive RTL review or custom ASIC integration reports, please refer to the **[Sales Protocol](./SALES_PROTOCOL.md)** regarding the **Total Protocol** licensing tier.

**Contact:** [karam1975l@proton.me](mailto:karam1975l@proton.me)
