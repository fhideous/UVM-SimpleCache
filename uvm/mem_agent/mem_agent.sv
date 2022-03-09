
class mem_agent extends uvm_agent;

    mem_driver      driver;
    mem_sequencer   sequencer;
    mem_if_monitor     monitor;

    `uvm_component_utils(mem_agent)
  
    extern function      new                        ( string name, uvm_component parent );
    extern function void build_phase                ( uvm_phase phase );
    extern function void connect_phase              ( uvm_phase phase );
    extern function void start_of_simulation_phase  ( uvm_phase phase );

endclass : mem_agent

//=================================================================================
//Implementaitions
//=================================================================================

    function mem_agent::new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void mem_agent::build_phase( uvm_phase phase );
        super.build_phase(phase);

        monitor = mem_if_monitor::type_id::create("mem_monitor", this);
        if ( get_is_active() == UVM_ACTIVE ) begin
            sequencer = mem_sequencer::type_id::create("mem_sequencer",  this);
            driver    = mem_driver::type_id::create   ("mem_driver"   ,  this);
        end
    endfunction : build_phase

    function void mem_agent::connect_phase( uvm_phase phase );
        if ( get_is_active() == UVM_ACTIVE )
            driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction : connect_phase

    function void mem_agent::start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
    endfunction : start_of_simulation_phase