`include "./agent/driver.sv"
`include "./agent/sequencer.sv"
`include "./agent/monitor.sv"
class dff_agent extends uvm_agent;
  `uvm_component_utils(dff_agent)
  
  dff_drv drv;
  dff_seq seq;
  dff_monitor mon;
  
  function new(string name = "dff_agent", uvm_component parent=null);
    super.new(name,parent);
    `uvm_info("AGENT CLASS", "constructor", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    drv = dff_drv::type_id::create("drv", this);
    seq = dff_seq::type_id::create("seq", this);
    mon = dff_monitor::type_id::create("mon", this);
  endfunction
  
  //connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("AGENT CLASS", "connect phase", UVM_MEDIUM);
    
    //connecting drv seq using TLM ports
    drv.seq_item_port.connect(seq.seq_item_export);
  endfunction
    
endclass
