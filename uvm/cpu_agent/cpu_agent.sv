
class cpu_agent extends uvm_agent;

    cpu_driver      driver;
    cpu_sequencer   sequencer;
    cpu_if_monitor  monitor;

    `uvm_component_utils(cpu_agent)
  
    extern function      new                        ( string name, uvm_component parent );
    extern function void build_phase                ( uvm_phase phase );
    extern function void connect_phase              ( uvm_phase phase );
    extern function void start_of_simulation_phase  ( uvm_phase phase );

endclass : cpu_agent

//=================================================================================
//Implementaitions
//=================================================================================

function cpu_agent::new (string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

function void cpu_agent::build_phase( uvm_phase phase );
    super.build_phase(phase);
    monitor = cpu_if_monitor::type_id::create("cpu_monitor", this);
    if ( get_is_active() == UVM_ACTIVE ) begin
        sequencer = cpu_sequencer::type_id::create("cpu_sequencer",  this);
        driver    = cpu_driver::type_id::create   ("cpu_driver"   ,  this);
    end
endfunction : build_phase

function void cpu_agent::connect_phase( uvm_phase phase );
    if ( get_is_active() == UVM_ACTIVE )
        driver.seq_item_port.connect(sequencer.seq_item_export);
endfunction : connect_phase

function void cpu_agent::start_of_simulation_phase(uvm_phase phase);
    `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
endfunction : start_of_simulation_phase