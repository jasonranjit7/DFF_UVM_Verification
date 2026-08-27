
class dff_sequence extends uvm_sequence;
  `uvm_object_utils(dff_sequence)
  
  dff_seq_item tx,req;
  
  function new(string name = "dff_sequence");
    super.new(name);
    `uvm_info("SEQUENCE CLASS", "constructor", UVM_MEDIUM)
  endfunction
  
  virtual task body();
    req = dff_seq_item::type_id::create("req");
    start_item(req);
    req.rst = 1'b1;
    req.d = 1'b0;
    finish_item(req);
    
    repeat(5) begin
      
      tx = dff_seq_item::type_id::create("tx");
      
      wait_for_grant();
      tx.randomize();
      send_request(tx);
      wait_for_item_done();
    end
  endtask
endclass
