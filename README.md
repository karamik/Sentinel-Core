
# Sentinel Core | Hardware Security Framework (v11.0)
**A high-assurance silicon-integrity framework designed for FIPS 140-3 Level 4 compliance paths.**
## 🛡️ Overview
**Sentinel Core** is an open-architecture hardware security suite (RTL) designed to protect FPGA/ASIC-based systems from physical intrusion, side-channel attacks (SCA), and unauthorized firmware modification.
Unlike standard software-based security, Sentinel Core integrates directly into the silicon fabric, providing a **Root of Trust (RoT)** that is physically bound to the specific instance of the hardware.
### 🧪 Technical Pillars
 * **Silicon Fingerprinting (PUF):** Entropy extraction via Ring Oscillator (RO) jitter.
 * **Active Kinetic Defense:** Sub-120ns response to physical tampering (Active Mesh).
 * **SCA Mitigation:** Real-time logic migration and thermal monitoring to thwart power analysis and laser probing.
 * **Zero-Trust I/O:** Hardware-level gating (Oracle Shield) for all data entering the secure enclave.
## 📊 Technical Specifications & Target Compliance
| Parameter | Performance | Compliance Design Path |
|---|---|---|
| **Tamper Response** | < 120 ns | FIPS 140-3 Level 4 (Physical) |
| **Logic Migration** | < 850 ns | ISO/IEC 17825 (SCA Resistance) |
| **PUF Uniqueness** | 50.02% (μ) | NIST SP 800-22 (Statistical Totality) |
| **Security Lifecycle** | Active Zeroization | FIPS 140-3 Level 4 (Zeroization) |
> **Disclaimer:** This repository contains the **Sentinel Lite** (Reference Implementation). While the architecture is designed for FIPS 140-3 Level 4, official certification requires physical auditing of the final integrated circuit (IC) and proprietary stabilization modules.
> 
## 📂 Repository Structure (Lite vs. Armored)
This public release provides a **TRL-6 functional prototype** for evaluation and academic research.
| Module | Status | Description |
|---|---|---|
| rtl/sentinel_puf_engine.v | **Reference** | RO-based entropy source. *Note: Requires HDA for production stability.* |
| rtl/sentinel_logic_migrator.v | **Functional** | Demonstrates dynamic path switching for SCA mitigation. |
| rtl/sentinel_oracle_shield.v | **Verified** | Hardware-gate I/O filtering logic. |
| docs/COMPLIANCE_GUIDE.md | **Draft** | Mapping of Sentinel Core features to NIST/FIPS requirements. |
### 🔬 Important Notes on PUF Simulation
The provided sentinel_puf_engine.v uses behavioral Verilog for RO loops.
 1. **Simulation:** Results are deterministic in standard simulators. Unique Hamming Distance (50%) is only measurable on physical silicon.
 2. **Synthesis:** Requires manual placement constraints (DONT_TOUCH, ALLOW_COMBINATORIAL_LOOPS) to prevent CAD tool optimization.
## 🚀 Roadmap to Production (Commercial)
The **Sentinel Armored** suite (Proprietary) includes the mission-critical components for industrial deployment:
 1. **Helper Data Algorithms (HDA):** High-performance BCH/Reed-Solomon error correction for PUF stability across extreme temperatures (-40°C to +125°C).
 2. **Fuzzy Extractors:** Cryptographic-grade key derivation from noisy physical sources.
 3. **Bitstream Armor:** AES-256 encrypted bitstream configuration for Xilinx/Intel FPGAs.
 4. **Hardware-in-the-Loop (HIL) Testing:** Validated datasets against DPA/SPA attacks.
## 🤝 Licensing & Engagement
 * **Lite Modules:** Released under the **MIT License**.
 * **Commercial Modules:** Available for government, defense, and high-fintech integrators under a value-based licensing model.
**Contact:** karam1975l@proton.me
**Identity:** International Group of Developers.
*Proof of Funds (PoF) and NDA are required for access to the Full Certification Audit Package.*
© 2026 Sentinel Core | **In Physics We Trust. In Silicon We Verify.**

