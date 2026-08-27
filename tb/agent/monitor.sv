class dff_monitor extends uvm_monitor;
  `uvm_component_utils(dff_monitor)
  
  virtual dff_intf intf;
  uvm_analysis_port #(dff_seq_item) item_collected_port;
  
  function new(string name = "dff_monitor", uvm_component parent=null);
    super.new(name,parent);
    `uvm_info("MONITOR CLASS", "constructor", UVM_MEDIUM)
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    item_collected_port = new("item_collected_port",this);
    `uvm_info("MONITOR CLASS", "build phase", UVM_MEDIUM)
    
    
    
    if(!(uvm_config_db#(virtual dff_intf)::get(this, "","vif", intf)))
      `uvm_fatal("no intf in monitor", "vif get failed");
  endfunction 
  
  virtual task run_phase(uvm_phase phase);
    dff_seq_item tx;
    forever begin
      @(posedge intf.clk);
      #1;
      tx = dff_seq_item::type_id::create("tx");
      tx.rst = intf.rst;
      tx.d   = intf.d;
      tx.q   = intf.q;
      item_collected_port.write(tx);
    end
  endtask
  
endclass
