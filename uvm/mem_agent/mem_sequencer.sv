
class mem_sequencer extends uvm_sequencer #(mem_item);
    `uvm_component_utils(mem_sequencer)

    uvm_tlm_analysis_fifo #(mem_item) mem_fifo;
    
    function new (string name, uvm_component parent);
        super.new(name, parent);
        mem_fifo = new("mem_fifo", this);
        `uvm_info(get_type_name(), {"mem_sequencer constructor ", get_full_name()}, UVM_LOW) 
    endfunction : new
  
    function void start_of_simulation_phase( uvm_phase phase );
        `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_LOW)
    endfunction : start_of_simulation_phase

endclass : mem_sequencer