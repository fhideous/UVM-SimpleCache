`uvm_analysis_imp_decl(_cpu)
`uvm_analysis_imp_decl(_mem)

class cache_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(cache_scoreboard)
  
    uvm_analysis_imp_cpu#(cpu_item, cache_scoreboard) cpu_item_export;
    uvm_analysis_imp_mem#(mem_item, cache_scoreboard) mem_item_export;
 
    // new - constructor
    function new (string name, uvm_component parent);
      super.new(name, parent);
        `uvm_info(get_type_name(), {"cache_scorebd constructor ", get_full_name()}, UVM_LOW) 
    endfunction : new
 
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      cpu_item_export = new("cpu_item_export", this);
      mem_item_export = new("mem_item_export", this);
    endfunction: build_phase
   
    // write
    virtual function void write_cpu(cpu_item pkt);
      $display("SCB:: cpu_pkt recived");
      pkt.print();
    endfunction : write_cpu
 
    virtual function void write_mem(mem_item pkt);
      $display("SCB:: mem_pkt recived");
      pkt.print();
    endfunction : write_mem

endclass : cache_scoreboard