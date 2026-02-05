`timescale 1ns/1ps

// -----------------------------------------------------------------------------
// Common streaming interface for the shared FIFO DUT
// -----------------------------------------------------------------------------
// This interface is used by the UVM driver/monitor in Module 4+ to connect
// to the stream_fifo DUT. It models a simple valid/ready/data handshake.
//
// - 'master' modport: drives valid/data, observes ready
// - 'slave'  modport: observes valid/data, drives ready
//
interface stream_if #(
  parameter int DATA_WIDTH = 8
) (
  input  logic clk,
  input  logic rst_n
);

  logic                  valid;
  logic                  ready;
  logic [DATA_WIDTH-1:0] data;

  // Source drives valid/data, sink drives ready
  modport master (
    input  clk,
    input  rst_n,
    output valid,
    output data,
    input  ready
  );

  modport slave (
    input  clk,
    input  rst_n,
    input  valid,
    input  data,
    output ready
  );

endinterface

