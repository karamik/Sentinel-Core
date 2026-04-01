# Sentinel Core — Technical Whitepaper

**Version:** 1.0  
**Classification:** Public / Proprietary  
**Date:** April 2026

---

## Abstract

Sentinel Core is a hardware‑level security architecture that protects computing devices from physical tampering, laser probing, cryogenic attacks, and reverse engineering. By combining Physical Unclonable Functions (PUF), adaptive logic migration, active tamper mesh, and irreversible key destruction, Sentinel Core creates a hardware root of trust that cannot be cloned, extracted, or bypassed.

---

## 1. Physical Unclonable Function (PUF)

### 1.1 Principle
Each silicon chip has microscopic manufacturing variations that are random and impossible to replicate. Sentinel Core exploits these variations to generate a **unique, uncloneable device identity**.

### 1.2 Implementation
- **Ring Oscillator PUF:** An array of 128–256 identical inverters connected in rings. Due to manufacturing variations, each ring oscillates at a slightly different frequency.
- **Frequency comparison:** A comparator measures the frequency difference between two rings, producing a single bit. Repeating this across 256 ring pairs yields a 256‑bit unique identifier.
- **Key derivation:** The PUF output is fed through a fuzzy extractor to generate a stable cryptographic key. The key is never stored — only derived on demand.

### 1.3 Security Properties
| Property | Description |
|----------|-------------|
| **Uncloneable** | Physical variations cannot be reproduced, even with the original mask set |
| **Non‑volatile** | Key is re‑generated at each power‑on — no storage required |
| **Tamper‑sensitive** | Attempts to probe the chip alter the PUF response |

---

## 2. Thermal Guard & Logic Migration

### 2.1 Threat Model
Adversaries may use:
- **Laser probing:** Localized heating to alter transistor behavior
- **Cryogenic attacks:** Cooling the chip to freeze memory contents
- **Hot air rework:** Desoldering the chip for analysis

### 2.2 Implementation
- **Temperature sensors:** Distributed across the die (8–16 sensors) with <0.5°C resolution.
- **Thresholds:** Hard‑coded lower limit (-40°C) and upper limit (+105°C). Crossing either triggers Scorched Earth.
- **Local overheating detection:** If a single sensor rises >10°C above neighboring sensors (laser probe), **Logic Migration** is triggered.

### 2.3 Logic Migration
- Critical computational tasks are **relocated** to a different area of the die within **<1 microsecond**.
- The relocation is done by switching clock domains and routing data through different logic blocks.
- The original area is powered down, making it impossible for an attacker to probe active gates.

---

## 3. Oracle Shield — Hardware‑Level Data Verification

### 3.1 Threat Model
- **Firmware injection:** Malicious code loaded through legitimate interfaces
- **Zero‑day exploits:** Attacks that bypass software security
- **Side‑channel injection:** Malformed packets designed to trigger hardware faults

### 3.2 Implementation
- **Inline verification:** All incoming data passes through a hardware verification engine before reaching the CPU/OS.
- **Signature matching:** Each packet is checked against allowed signatures derived from the PUF.
- **Replay protection:** Timestamps and sequence numbers are validated in hardware.

### 3.3 Security Properties
- No software involvement — cannot be bypassed even if OS is compromised
- Verification latency <10 ns per packet
- Blocked packets are logged and the port is temporarily locked

---

## 4. Active Mesh & Tamper Detection

### 4.1 Physical Construction
- A multi‑layer polymer film with printed conductive traces (<10 µm width) is wrapped around the chip and critical components.
- The mesh forms a continuous electrical circuit with known resistance and capacitance.

### 4.2 Monitoring
- Resistance and capacitance are measured continuously (<10 ns intervals).
- Any deviation (drill, mill, chemical attack, laser ablation) triggers an immediate response.

### 4.3 Response
- Active mesh breach triggers **Scorched Earth** with <100 ns latency.

---

## 5. Scorched Earth — Irreversible Key Destruction

### 5.1 Trigger Conditions
| Event | Action |
|-------|--------|
| Active mesh breach | Immediate Scorched Earth |
| Temperature < -40°C or > +105°C | Immediate Scorched Earth |
| Voltage glitch >5% deviation | Immediate Scorched Earth |
| Manual override (operator) | Scorched Earth after confirmation |

### 5.2 Execution
1. **Entropy flood:** QRNG (if present) or hardware noise source overwrites all register banks.
2. **BBRAM power cut:** Volatile key storage loses power — keys vanish in nanoseconds.
3. **eFuse blow:** 60+ eFuses are blown, permanently disabling JTAG, debug ports, and boot ROM.
4. **Result:** The chip becomes a permanent brick. No forensic recovery is possible.

---

## 6. Performance Summary

| Parameter | Value |
|-----------|-------|
| PUF entropy | >256 bits |
| Temperature monitoring resolution | <0.5°C |
| Logic migration time | <1 µs |
| Active mesh response | <100 ns |
| Scorched Earth completion | <100 µs |
| Power consumption (active) | <500 mW |
| Power consumption (standby) | <10 mW |

---

## 7. Integration

Sentinel Core is available as:
- **FPGA bitstream** for Xilinx, Intel, Lattice FPGAs
- **IP block** for ASIC integration (Verilog / VHDL)
- **Turnkey hardware module** (custom ASIC)

---

## 8. Compliance

| Standard | Status |
|----------|--------|
| FIPS 140‑3 (Level 3) | Target |
| Common Criteria (EAL 6+) | Target |
| ITAR / Export Control | Applicable |

---

## 9. References

1. Gassend, B., et al. "Silicon Physical Random Functions." ACM CCS 2002.
2. Suh, G. E., Devadas, S. "Physical Unclonable Functions for Device Authentication." DAC 2007.
3. Skorobogatov, S. "Physical Attacks on Security ICs." Cambridge University, 2005.
4. NIST SP 800‑90B — Entropy Sources.

---

*This document is a public overview. Full implementation details are available under NDA.*
