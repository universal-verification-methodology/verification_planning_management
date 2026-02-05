`timescale 1ns/1ps

// -----------------------------------------------------------------------------
// UVM-based testbench for the common stream_fifo DUT
// -----------------------------------------------------------------------------
//
// This top-level testbench:
// - Instantiates the shared DUT: common_dut/rtl/stream_fifo.sv
// - Instantiates two stream_if interfaces (source and sink)
// - Connects interfaces to DUT ports
// - Puts the virtual interfaces into the UVM config DB
// - Calls run_test("stream_test") defined in stream_pkg.sv
//

`include "uvm_macros.svh"
import uvm_pkg::*;

// Import the UVM components for this bench
`include "stream_if.sv"
`include "stream_pkg.sv"

module tb_stream_fifo_uvm;

  localparam int DATA_WIDTH = 8;
  localparam int DEPTH      = 4;

  // Clock and reset
  logic clk;
  logic rst_n;

  // Source and sink interfaces
  stream_if #(.DATA_WIDTH(DATA_WIDTH)) s_if (.*);
  stream_if #(.DATA_WIDTH(DATA_WIDTH)) m_if (.*);

  // Status from DUT
  logic [$clog2(DEPTH+1)-1:0] level;
  logic                       overflow;
  logic                       underflow;

  // DUT instance
  stream_fifo #(
    .DATA_WIDTH (DATA_WIDTH),
    .DEPTH      (DEPTH)
  ) dut (
    .clk       (clk),
    .rst_n     (rst_n),
    // source side
    .s_valid   (s_if.valid),
    .s_data    (s_if.data),
    .s_ready   (s_if.ready),
    // sink side
    .m_valid   (m_if.valid),
    .m_data    (m_if.data),
    .m_ready   (m_if.ready),
    // status
    .level     (level),
    .overflow  (overflow),
    .underflow (underflow)
  );

  // Clock generation
  initial begin
    clk = 1'b0;
    forever #5 clk = ~clk; // 100 MHz
  end

  // Reset generation
  initial begin
    rst_n = 1'b0;
    #25;
    rst_n = 1'b1;
  end

  // Default sink ready behavior (always ready)
  initial begin
    m_if.ready = 1'b0;
    wait (rst_n === 1'b1);
    @(posedge clk);
    m_if.ready = 1'b1;
  end

  // UVM run
  initial begin
    // Put virtual interfaces into config DB
    uvm_config_db#(virtual stream_if.master)::set(null, "uvm_test_top.env.drv", "vif_src", s_if);
    uvm_config_db#(virtual stream_if.slave )::set(null, "uvm_test_top.env.mon", "vif_snk", m_if);

    run_test("stream_test");
  end

endmodule

