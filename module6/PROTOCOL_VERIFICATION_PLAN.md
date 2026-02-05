# Protocol Verification Plan (Module 6)

> **Purpose**: Define how you will verify protocol correctness (e.g., AXI-like, custom bus) using agents, checkers, coverage, and tests.  
> **Module**: 6 – Complex Multi-Agent & Protocol Testbenches (SV/UVM)

> **Instructions**: Fill in this document for your design. Copy from `module6/templates/` if needed, or edit the file in `module6/` directly. Reference: `module6/.solutions/`.

## 1. Protocol Overview

<!-- TODO: Protocol name, key characteristics (channels, handshakes, ordering, error/response semantics). How the protocol is used by the DUT (roles, traffic patterns). -->

## 2. Protocol Agent Strategy

<!-- TODO: Table of Agent Name, Role (master/slave/passive), Channels Handled, Notes. Active vs passive; reuse. -->

## 3. Protocol Rules and Checkers

### 3.1 Rule Inventory

<!-- TODO: Table of Rule ID, Description, Type (safety/order/timing), Related Req IDs, Notes. -->

### 3.2 Checker Design

<!-- TODO: Table of Checker ID, Location, Inputs, Rules Enforced. Placement and error reporting. -->

## 4. Protocol Coverage

### 4.1 Functional Coverage for Protocol

<!-- TODO: Coverage IDs, purpose, placement/sampling. Link to module3/COVERAGE_DESIGN.md. -->

## 5. Test Mapping for Protocol Verification

<!-- TODO: Which tests exercise which protocol rules; mapping to test_plan.md. -->

## 6. Integration with Multi-Agent Env and Scoreboards

<!-- TODO: How protocol checkers and scoreboards work together; integration points. -->

## 7. Open Issues and Next Steps

<!-- TODO: Open items and planned actions. -->

## 8. Revision History

<!-- TODO: Document revisions. -->
