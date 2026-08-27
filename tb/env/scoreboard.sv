`include "sequencer_item.sv"
class dff_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(dff_scoreboard)
  
  dff_seq_item tx_q[$];
  logic expected_q = 0;
  
  uvm_analysis_imp#(dff_seq_item,dff_scoreboard) item_collected_export;
  
  function new(string name = "dff_scoreboard", uvm_component parent=null);
    super.new(name,parent);
    `uvm_info("SCOREBOARD CLASS", "constructor", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new("item_collected_export", this);	
    `uvm_info("SCOREBOARD CLASS", "build phase", UVM_MEDIUM)
  endfunction 
  
  function void write(dff_seq_item tx);
  tx_q.push_back(tx);

  if (tx.rst) begin
    expected_q = 1'b0;
    `uvm_info("SBD", $sformatf("RESET DETECTED: expected_q reset to 0"), UVM_LOW)
  end else begin
    if (tx.q === expected_q) begin
      `uvm_info("SBD", $sformatf("PASS: expected=%0b, actual=%0b", expected_q, tx.q), UVM_LOW)
    end else begin
      `uvm_error("SBD", $sformatf("FAIL: expected=%0b, actual=%0b", expected_q, tx.q))
    end
    expected_q = tx.d;
  end
endfunction
  
endclass
