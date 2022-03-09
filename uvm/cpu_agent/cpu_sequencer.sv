
class cpu_sequencer extends uvm_sequencer #(cpu_item);
    
    `uvm_component_utils(cpu_sequencer)
  
    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void start_of_simulation_phase( uvm_phase phase );
        `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
    endfunction : start_of_simulation_phase

endclass : cpu_sequencer