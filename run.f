-uvmhome $UVMHOME

// include directory for uvm files
-incdir ./uvm/
-incdir ./uvm/cpu_agent 
-incdir ./uvm/mem_agent 
-incdir ./uvm/tests

// default timescale
-timescale 1ns/1ns

//-access +rwc -linedebug -gui -s -input my_waveform_here.tcl

// UVM options
//+UVM_TESTNAME=base_test
//+UVM_TESTNAME=short_packet_test 
//+UVM_TESTNAME=all_outputs
+UVM_TESTNAME=cache_base_test

+UVM_VERBOSITY=UVM_FULL
//+UVM_VERBOSITY=UVM_LOW

+SVSEED=random

//Package
./rtl/cache_def.sv
./uvm/cpu_if.sv
./uvm/mem_if.sv
./uvm/cache_pkg.sv

// testbench
./tb/cache_tb_top.sv

// RTL
./rtl/dm_memory.sv
./rtl/dm_cache_data.sv
./rtl/dm_cache_fsm.sv
./rtl/dm_cache_tag.sv
