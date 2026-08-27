`include "environment.sv"
`include "sequence.sv"
class dff_test extends uvm_test;
  `uvm_component_utils(dff_test)
  dff_env env;
  dff_sequence seq;
  
  //constructor
  function new(string name = "dff_test", uvm_component parent=null);
    super.new(name,parent);
    `uvm_info("TEST CLASS", "constructor", UVM_MEDIUM)
  endfunction
  
  //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    env = dff_env::type_id::create("env", this);
    seq = dff_sequence::type_id::create("seq");
  endfunction
  
  //connect phase
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("TEST CLASS", "connect phase", UVM_MEDIUM)
  endfunction
  
  //end of elaboration phase
  virtual function void end_of_elaboration();
    `uvm_info("TEST CLASS", "EO Elab phase", UVM_MEDIUM)
    print();
  endfunction
  
  //run phase
  task run_phase(uvm_phase phase);
    `uvm_info("TEST CLASS", "run phase", UVM_MEDIUM)
    
    phase.raise_objection(this);//stay in run phase till test drops objection
    
    seq.start(env.agent.seq);
    phase.drop_objection(this);
  endtask
  
endclass
