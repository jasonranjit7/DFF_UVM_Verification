class dff_drv extends uvm_driver#(dff_seq_item);
  `uvm_component_utils(dff_drv)
  
  virtual dff_intf intf;
  dff_seq_item tx;
  
  
  function new(string name = "dff_drv", uvm_component parent=null);
    super.new(name,parent);
    `uvm_info("DRV CLASS", "constructor", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("DRV CLASS", "build phase", UVM_MEDIUM)
    
    if(!(uvm_config_db#(virtual dff_intf)::get(this, "", "vif", intf)))
         `uvm_fatal("no intf in driver", "vif get failed")
  endfunction 
  
  task drive(dff_seq_item tx);
    @(posedge intf.clk);
    intf.rst<=tx.rst;
    intf.d<=tx.d;
  endtask
  
  task run_phase(uvm_phase phase);
    `uvm_info("DRV CLASS", "run phase", UVM_MEDIUM)
    forever begin      
      seq_item_port.get_next_item(tx);
      
      drive(tx);
      
      seq_item_port.item_done();
    end
  endtask
    
  
endclass
