class dff_seq extends uvm_sequencer#(dff_seq_item);
  `uvm_component_utils(dff_seq)
  
  function new(string name = "dff_seq", uvm_component parent);
    super.new(name,parent);
    `uvm_info("SEQUENCER CLASS", "constructor", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction 
  
endclass
