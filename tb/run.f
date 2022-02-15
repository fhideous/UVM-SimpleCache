 //-uvmhome $UVMHOME

// include directory for sv files
-incdir ../rtl

// default timescale
-timescale 1ns/1ns

// options
//+UVM_TESTNAME=base_test
//+UVM_TESTNAME=short_packet_test 
//+UVM_TESTNAME=all_outputs

//+UVM_VERBOSITY=UVM_FULL
//+UVM_VERBOSITY=UVM_LOW

+SVSEED=random

//Package
../rtl/cache_def.sv

// testbench
hw_top.sv

// RTL
../rtl/dm_cache_data.sv
../rtl/dm_cache_fsm.sv
../rtl/dm_cache_tag.sv
