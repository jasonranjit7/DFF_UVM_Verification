module dff(input logic d,
           input logic clk,
           input logic rst,
           output logic q);
  
  always_ff @(posedge clk) begin
    if(rst)
      q<=0;
    else
      q<=d;
  end
endmodule
