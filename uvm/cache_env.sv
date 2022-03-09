class cache_env extends uvm_env;
    `uvm_component_utils(cache_env)

    cpu_agent         env_cpu_agent;
    mem_agent         env_mem_agent;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), {"You are in the env:", get_full_name()}, UVM_LOW)
        super.build_phase(phase);
        env_cpu_agent = cpu_agent::type_id::create("cpu_agent", this);
        env_mem_agent = mem_agent::type_id::create("mem_agent", this); 
    endfunction : build_phase

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_HIGH)
    endfunction : start_of_simulation_phase  

endclass : cache_env