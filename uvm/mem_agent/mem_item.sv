class mem_item extends uvm_sequence_item;

  `uvm_object_utils(mem_item)
  
    mem_data_type        mem_data;
    mem_req_type         mem_req;

    rand bit            packet_delay;

    function new (string name = "mem_item");
      super.new(name);
        `uvm_info(get_type_name(), {"mem_item constructor ", get_full_name()}, UVM_LOW)
    endfunction : new

    constraint packet_constr { packet_delay >= 0; packet_delay < 20;   }

    // extern virtual function cpu_req_type cpu_req_pack();
    // extern virtual function void cpu_req_unpack(const ref cpu_req_type cpu_req);
    extern virtual function void display();

    function void post_randomize();
    endfunction : post_randomize

endclass: mem_item

//==============================================
//Implementation
//==============================================

function void mem_item::display();
    $display(   "---------- MEM_PACKET ---------- "   );
    $display(   "data:\t %h ",          mem_data.data   );
    $display(   "data_ready:\t %d ",    mem_data.ready  );
    $display(   "---------- request ---------- "      );
    $display(   "addr:\t %h ",       mem_req.addr       );
    $display(   "data:\t %h ",       mem_req.data       );
    $display(   "rw:\t %h ",         mem_req.rw         );
    $display(   "valid:\t %h ",      mem_req.valid      );
    $display(   "------------ END ------------ \n"      );
endfunction : display