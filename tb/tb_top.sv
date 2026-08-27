`include "uvm_macros.svh"
import uvm_pkg::*;
`include "interface.sv"
`include "test.sv"
module top();
  
  logic clk;
  
  dff_intf intf(.clk(clk));
  
  initial begin
    uvm_config_db#(virtual dff_intf )::set(null,"*","vif",intf);
    run_test("dff_test");
  end
  
  dff dut(.d(intf.d),
          .clk(intf.clk),
          .rst(intf.rst),
          .q(intf.q)
         );
  
  initial begin
    clk = 0;
    forever #10 clk = ~clk;
  end

  
endmodule
