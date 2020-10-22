FibonacciBinarySystem
=====================
Fibonacci/Zeckendorf Representation System

## Usage
Install ModelSim SE, create a new Verilog project, add files to the project.

* Module: \*.v, the source modules
* Testbench: tb_\*.v, top_\*_vlg_tst.v, or \*.vt, the testbench files.

The *.log files are output logs

## Directory Structure 
    .
    ├─1_CalculateFibonacci
    │  ├─Testbench
    │  └─Module
    ├─2_CanonicalEncoder
    │  ├─Testbench
    │  └─Module
    ├─3_Encoder
    │  ├─Testbench
    │  └─Module
    ├─4_Decoder
    │  ├─Testbench
    │  └─Module
    ├─5_Adder
    │  ├─Testbench
    │  └─Module
    ├─6_Subtractor
    │  ├─Testbench
    │  └─Module
    ├─7_Multiplier
    │  ├─Testbench
    │  └─Module
    ├─8_Divider
    │  ├─Testbench
    │  └─Module
    ├─AvalancheEffect
    │  ├─obfus_128bit
    │  │  ├─Module
    │  │  │  └─AES
    │  │  └─Testbench
    │  └─obfus_64bit
    │      ├─Module
    │      │  └─DES
    │      └─Testbench
    ├─StreamCipher
    │  ├─RC4
    │  │  ├─Testbench
    │  │  └─Module
    │  └─FibonacciStreamCipher
    │      ├─Testbench
    │      └─Module
    └─SecureTransmission
        ├─DES
        │  ├─Testbench
        │  └─Module
        └─DES-Concatenated-Fibonacci
            ├─Testbench
            └─Module

