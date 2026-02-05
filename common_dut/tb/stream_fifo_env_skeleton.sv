// -----------------------------------------------------------------------------
// UVM environment skeleton for stream_fifo (Module 2)
// -----------------------------------------------------------------------------
//
// This file sketches the UVM env structure for the common_dut stream_fifo.
// Components are stubbed; full implementation lives in module4/tb (stream_pkg.sv
// and related) or can be expanded here in later modules.
//
// Purpose: Satisfy Module 2 checklist — "UVM env skeleton in common_dut/tb/
//          is sketched (even if stubbed)".
//

`ifndef STREAM_FIFO_ENV_SKELETON_SV
`define STREAM_FIFO_ENV_SKELETON_SV

`include "uvm_macros.svh"
import uvm_pkg::*;

// -----------------------------------------------------------------------------
// Stub agent: placeholder for source/sink agents (driver, sequencer, monitor)
// -----------------------------------------------------------------------------

class stream_fifo_agent_skeleton extends uvm_agent;

  `uvm_component_utils(stream_fifo_agent_skeleton)

  function new(string name = "stream_fifo_agent_skeleton", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    // Stub: add driver, sequencer, monitor in later modules
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // Stub: connect driver to sequencer, etc.
  endfunction

  task run_phase(uvm_phase phase);
    // Stub: no stimulus; full implementation in module4+
  endtask

endclass

// -----------------------------------------------------------------------------
// UVM env skeleton: contains source and sink agent stubs
// -----------------------------------------------------------------------------

class stream_fifo_env_skeleton extends uvm_env;

  stream_fifo_agent_skeleton src_agent;
  stream_fifo_agent_skeleton snk_agent;

  `uvm_component_utils(stream_fifo_env_skeleton)

  function new(string name = "stream_fifo_env_skeleton", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    src_agent = stream_fifo_agent_skeleton::type_id::create("src_agent", this);
    snk_agent = stream_fifo_agent_skeleton::type_id::create("snk_agent", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    // Stub: connect agents to virtual interfaces, scoreboard, etc. in later modules
  endfunction

endclass

`endif
