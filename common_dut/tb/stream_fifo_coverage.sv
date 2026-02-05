// -----------------------------------------------------------------------------
// Functional coverage for stream_fifo (Module 3)
// -----------------------------------------------------------------------------
//
// Covergroups aligned with module3/COVERAGE_DESIGN.md.
// Instantiate this class in stream_fifo_monitor (or equivalent) and call
// sample() on the appropriate events (e.g., posedge clk).
//

`ifndef STREAM_FIFO_COVERAGE_SV
`define STREAM_FIFO_COVERAGE_SV

class stream_fifo_coverage;

  // Inputs to be set by monitor before sample()
  bit [31:0] level;        // Current FIFO occupancy (0..DEPTH)
  bit [1:0]  op_type;      // 0=idle, 1=push, 2=pop, 3=push_and_pop
  bit        overflow;
  bit        underflow;
  int        depth;        // DEPTH parameter for bin bounds

  // -------------------------------------------------------------------------
  // CG_OPS: Operation types per cycle
  // -------------------------------------------------------------------------
  covergroup cg_ops;
    option.per_instance = 1;
    cp_op_type: coverpoint op_type {
      bins idle          = { 0 };
      bins push_only     = { 1 };
      bins pop_only      = { 2 };
      bins push_and_pop  = { 3 };
    }
  endgroup

  // -------------------------------------------------------------------------
  // CG_LEVEL: Occupancy levels (empty / low / mid / high / full)
  // -------------------------------------------------------------------------
  covergroup cg_level;
    option.per_instance = 1;
    cp_level: coverpoint level {
      bins empty = { 0 };
      bins low   = { [1 : (depth*25)/100] };
      bins mid   = { [(depth*26)/100 : (depth*75)/100] };
      bins high  = { [(depth*76)/100 : depth-1] };
      bins full  = { depth };
    }
  endgroup

  // -------------------------------------------------------------------------
  // CG_FLAGS: Overflow and underflow set/clear
  // -------------------------------------------------------------------------
  covergroup cg_flags;
    option.per_instance = 1;
    cp_overflow:  coverpoint overflow { bins set = {1}; bins clear = {0}; }
    cp_underflow: coverpoint underflow { bins set = {1}; bins clear = {0}; }
    cross_overflow_underflow: cross cp_overflow, cp_underflow;
  endgroup

  function new(int depth_param = 16);
    depth = depth_param;
    cg_ops   = new();
    cg_level = new();
    cg_flags = new();
  endfunction

  // Call from monitor on posedge clk after driving level, op_type, overflow, underflow
  function void sample();
    cg_ops.sample();
    cg_level.sample();
    cg_flags.sample();
  endfunction

endclass

`endif
