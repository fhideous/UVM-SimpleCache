
class cpu_sequencer extends uvm_sequencer #(cpu_item);
    
    `uvm_component_utils(cpu_sequencer)
  
    function new (string name, uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), {"cpu_sequencer constructor ", get_full_name()}, UVM_LOW) 
    endfunction : new

    function void start_of_simulation_phase( uvm_phase phase );
        `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_LOW)
    endfunction : start_of_simulation_phase

endclass : cpu_sequencer