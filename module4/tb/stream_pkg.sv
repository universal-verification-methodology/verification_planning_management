`timescale 1ns/1ps

`include "uvm_macros.svh"
import uvm_pkg::*;

// -----------------------------------------------------------------------------
// UVM transaction: stream_item
// -----------------------------------------------------------------------------

class stream_item extends uvm_sequence_item;

  rand bit [7:0] data;

  `uvm_object_utils(stream_item)

  function new(string name = "stream_item");
    super.new(name);
  endfunction

  // Optional: pretty-print for logs
  function string convert2string();
    return $sformatf("data=0x%0h", data);
  endfunction

endclass

// -----------------------------------------------------------------------------
// UVM sequence: stream_seq
// -----------------------------------------------------------------------------

class stream_seq extends uvm_sequence #(stream_item);

  rand int unsigned num_items;

  `uvm_object_utils(stream_seq)

  function new(string name = "stream_seq");
    super.new(name);
    num_items = 16;
  endfunction

  task body();
    stream_item tr;

    `uvm_info(get_type_name(),
              $sformatf("Starting stream_seq with %0d items", num_items),
              UVM_MEDIUM)

    repeat (num_items) begin
      tr = stream_item::type_id::create("tr");
      assert(tr.randomize());
      start_item(tr);
      finish_item(tr);
    end

    `uvm_info(get_type_name(), "Completed stream_seq", UVM_MEDIUM)
  endtask

endclass

// -----------------------------------------------------------------------------
// UVM driver: stream_driver
// -----------------------------------------------------------------------------

class stream_driver extends uvm_driver #(stream_item);

  `uvm_component_utils(stream_driver)

  virtual stream_if.master vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  task run_phase(uvm_phase phase);
    stream_item tr;

    if (vif == null) begin
      `uvm_fatal(get_type_name(), "vif is null; did you set it via config DB?")
    end

    // Initialize interface
    vif.valid <= 1'b0;
    vif.data  <= '0;

    forever begin
      seq_item_port.get_next_item(tr);

      // Drive one transaction using valid/ready handshake
      @(posedge vif.clk);
      vif.data  <= tr.data;
      vif.valid <= 1'b1;
      // Wait until sink is ready
      do @(posedge vif.clk); while (!vif.ready);

      // One beat has been accepted
      vif.valid <= 1'b0;

      `uvm_info(get_type_name(),
                $sformatf("Drove transaction: %s", tr.convert2string()),
                UVM_LOW)

      seq_item_port.item_done();
    end
  endtask

endclass

// -----------------------------------------------------------------------------
// UVM monitor: stream_monitor
// -----------------------------------------------------------------------------

class stream_monitor extends uvm_component;

  `uvm_component_utils(stream_monitor)

  virtual stream_if.slave vif;
  uvm_analysis_port #(stream_item) ap;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    ap = new("ap", this);
  endfunction

  task run_phase(uvm_phase phase);
    stream_item tr;

    if (vif == null) begin
      `uvm_fatal(get_type_name(), "vif is null; did you set it via config DB?")
    end

    forever begin
      @(posedge vif.clk);
      if (vif.valid && vif.ready) begin
        tr = stream_item::type_id::create("tr_mon");
        tr.data = vif.data;
        `uvm_info(get_type_name(),
                  $sformatf("Observed transaction: %s", tr.convert2string()),
                  UVM_LOW)
        ap.write(tr);
      end
    end
  endtask

endclass

// -----------------------------------------------------------------------------
// UVM scoreboard (minimal placeholder)
// -----------------------------------------------------------------------------

class stream_scoreboard extends uvm_component;

  `uvm_component_utils(stream_scoreboard)

  uvm_analysis_imp #(stream_item, stream_scoreboard) imp_in;

  int unsigned num_seen;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    imp_in = new("imp_in", this);
    num_seen = 0;
  endfunction

  // Called for each transaction seen by the monitor
  function void write(stream_item t);
    num_seen++;
    `uvm_info(get_type_name(),
              $sformatf("Scoreboard saw txn #%0d: %s", num_seen, t.convert2string()),
              UVM_LOW)
    // TODO: add real checking vs reference model if desired.
  endfunction

endclass

// -----------------------------------------------------------------------------
// UVM environment: stream_env
// -----------------------------------------------------------------------------

class stream_env extends uvm_env;

  `uvm_component_utils(stream_env)

  stream_driver     drv;
  stream_monitor    mon;
  stream_scoreboard sb;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    drv = stream_driver    ::type_id::create("drv", this);
    mon = stream_monitor   ::type_id::create("mon", this);
    sb  = stream_scoreboard::type_id::create("sb",  this);

    // Get virtual interfaces from config DB
    if (!uvm_config_db#(virtual stream_if.master)::get(this, "", "vif_src", drv.vif)) begin
      `uvm_fatal(get_type_name(), "Failed to get vif_src for driver from config DB")
    end
    if (!uvm_config_db#(virtual stream_if.slave)::get(this, "", "vif_snk", mon.vif)) begin
      `uvm_fatal(get_type_name(), "Failed to get vif_snk for monitor from config DB")
    end
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    mon.ap.connect(sb.imp_in);
  endfunction

endclass

// -----------------------------------------------------------------------------
// UVM test: stream_test
// -----------------------------------------------------------------------------

class stream_test extends uvm_test;

  `uvm_component_utils(stream_test)

  stream_env env;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = stream_env::type_id::create("env", this);
  endfunction

  task run_phase(uvm_phase phase);
    stream_seq seq;

    phase.raise_objection(this, "Starting stream_test");

    seq = stream_seq::type_id::create("seq");
    seq.start(env.drv.seq_item_port);

    phase.drop_objection(this, "Completed stream_test");
  endtask

endclass

