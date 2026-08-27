class dff_seq_item extends uvm_sequence_item;
  `uvm_object_utils(dff_seq_item)
  
  rand logic rst;
  rand logic d;
  logic q;
  
  constraint rst_dist_c {
    rst dist {0 := 80, 1 := 20}; // 80% normal operation, 20% reset
  }
  
  function new(string name = "dff_seq_item");
    super.new(name);
    `uvm_info("SEQUENCE ITEM CLASS", "constructor", UVM_MEDIUM)
  endfunction
endclass
