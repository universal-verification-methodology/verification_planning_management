`timescale 1ns/1ps

// Simple parameterizable streaming FIFO with ready/valid handshakes.
//
// This module is intended as a common DUT for the verification planning
// exercises. It exposes:
// - An input (source) interface: s_valid/s_ready/s_data
// - An output (sink) interface: m_valid/m_ready/m_data
// - Status: current fill level, sticky overflow/underflow flags
//
// Behavior:
// - When s_valid && s_ready, s_data is written into the FIFO.
// - s_ready is high when there is at least one free entry in the FIFO.
// - When m_valid && m_ready, the oldest entry is popped.
// - m_valid is high when there is at least one entry in the FIFO.
// - If s_valid is high while FIFO is full (s_ready == 0), overflow is set.
// - If m_ready is high while FIFO is empty (m_valid == 0), underflow is set.
// - overflow/underflow are sticky until reset.
//
module stream_fifo #(
  parameter int DATA_WIDTH = 8,
  parameter int DEPTH      = 16
) (
  input  logic                     clk,
  input  logic                     rst_n,

  // Source (input) interface
  input  logic                     s_valid,
  input  logic [DATA_WIDTH-1:0]    s_data,
  output logic                     s_ready,

  // Sink (output) interface
  output logic                     m_valid,
  output logic [DATA_WIDTH-1:0]    m_data,
  input  logic                     m_ready,

  // Status
  output logic [$clog2(DEPTH+1)-1:0] level,     // number of entries stored
  output logic                      overflow,   // sticky overflow flag
  output logic                      underflow   // sticky underflow flag
);

  // Internal storage
  logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];
  logic [$clog2(DEPTH)-1:0] wr_ptr;
  logic [$clog2(DEPTH)-1:0] rd_ptr;
  logic [$clog2(DEPTH+1)-1:0] count;

  // Write and read enables
  logic push;
  logic pop;

  assign s_ready = (count < DEPTH);
  assign m_valid = (count != 0);
  assign level   = count;

  // Determine when to push/pop
  always_comb begin
    push = s_valid && s_ready;
    pop  = m_valid && m_ready;
  end

  // FIFO storage and pointers
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      wr_ptr    <= '0;
      rd_ptr    <= '0;
      count     <= '0;
      m_data    <= '0;
      overflow  <= 1'b0;
      underflow <= 1'b0;
    end else begin
      // Write path
      if (push) begin
        mem[wr_ptr] <= s_data;
        wr_ptr      <= wr_ptr + 1;
      end else begin
        wr_ptr <= wr_ptr;
      end

      // Pop path
      if (pop) begin
        rd_ptr <= rd_ptr + 1;
      end

      // Update count
      unique case ({push, pop})
        2'b10: count <= count + 1;  // push only
        2'b01: count <= count - 1;  // pop only
        default: count <= count;    // no change or push+pop
      endcase

      // Output data
      if (pop) begin
        m_data <= mem[rd_ptr];
      end

      // Overflow / underflow detection (sticky)
      if (push && !s_ready) begin
        overflow <= 1'btrue;
      end
      if (pop && !m_valid) begin
        underflow <= 1'btrue;
      end
    end
  end

endmodule

