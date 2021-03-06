class cache_env extends uvm_env;
    `uvm_component_utils(cache_env)

    cpu_agent         cpu_agnt;
    mem_agent         mem_agnt;
    cache_scoreboard  cache_scorebd;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), {"\t\tcache_env constructor\t\t", get_full_name()}, UVM_LOW)
    endfunction : new

    function void build_phase(uvm_phase phase);
        `uvm_info(get_type_name(), {"\t\tcache_env build_phase \t\t", get_full_name()}, UVM_LOW)
        super.build_phase(phase);
        cpu_agnt        = cpu_agent::type_id::create("cpu_agent", this);
        mem_agnt        = mem_agent::type_id::create("mem_agent", this); 
        cache_scorebd   = cache_scoreboard::type_id::create("cache_scorebd", this);
    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(), "=============================================================================", UVM_LOW) 
        `uvm_info(get_type_name(), "\t\tAll components and objects are created", UVM_LOW) 
        `uvm_info(get_type_name(), "=============================================================================\t", UVM_LOW) 

        `uvm_info(get_type_name(), {"\t\tcache_env connect_phase \t\t", get_full_name()}, UVM_LOW)
        cpu_agnt.monitor.item_collected_port_cpu.connect(cache_scorebd.cpu_item_export);
        mem_agnt.monitor.item_collected_port_mem.connect(cache_scorebd.mem_item_export);
    endfunction : connect_phase

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), {"\t\tcache_env: start of simulation for \t\t", get_full_name()}, UVM_LOW)
    endfunction : start_of_simulation_phase  

endclass : cache_env