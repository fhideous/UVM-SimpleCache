/*cache finite state machine*/

import cache_def::*;
module dm_cache_fsm(
    input bit               clk_i, 
    input bit               reset_i,

    input cpu_req_type      cpu_req, //CPU request input (CPU->cache)
    input mem_data_type     mem_data, //memory response (memory->cache)
    output mem_req_type     mem_req, //memory request (cache->memory)
    output cpu_result_type  cpu_res //cache result (cache->CPU)
 );

typedef enum { IDLE, COMPARE_TAG, ALLOCATE, WRITE_BACK  } cache_state_type;
/*FSM state register*/
cache_state_type state, next_state;
/*interface signals to tag memory*/
cache_tag_type tag_read; //tag read result
cache_tag_type tag_write; //tag write data
cache_req_type tag_req; //tag request
/*interface signals to cache data memory*/
cache_data_type data_read; //cache line read data
cache_data_type data_write; //cache line write data
cache_req_type  data_req; //data req
/*temporary variable for cache controller result*/
cpu_result_type v_cpu_res;
/*temporary variable for memory controller request*/
mem_req_type    v_mem_req;

assign mem_req = v_mem_req; //connect to output ports
assign cpu_res = v_cpu_res; 

always_ff @(posedge clk_i) begin
  if (reset_i)
    next_state <= IDLE; //reset to IDLE state
  else
    next_state <= state;
end

 always_comb begin
    /*-------------------------default values for all signals------------*/
    state       = next_state;
    v_cpu_res   = '{0, 0}; 
    tag_write   = '{0, 0, 0};
    tag_req.we  = '0;
    tag_req.index   = cpu_req.addr[13:4];
   
    data_req.we     = '0;
    data_req.index  = cpu_req.addr[13:4];
    data_write      = data_read;
    case(cpu_req.addr[3:2])
        2'b00:data_write[31:0]   = cpu_req.data;
        2'b01:data_write[63:32]  = cpu_req.data;
        2'b10:data_write[95:64]  = cpu_req.data;
        2'b11:data_write[127:96] = cpu_req.data;
    endcase
   
    case(cpu_req.addr[3:2])
        2'b00:v_cpu_res.data = data_read[31:0];
        2'b01:v_cpu_res.data = data_read[63:32];
        2'b10:v_cpu_res.data = data_read[95:64];
        2'b11:v_cpu_res.data = data_read[127:96];
    endcase
    
    v_mem_req.addr  = cpu_req.addr;
    v_mem_req.data  = data_read;
    v_mem_req.rw    = '0;

//------------------------------------Cache FSM-------------------------
    case(next_state)
        IDLE : begin
            if (cpu_req.valid)
                state = COMPARE_TAG;
        end
        COMPARE_TAG : begin
            if (cpu_req.addr[TAGMSB:TAGLSB] == tag_read.tag && tag_read.valid) begin
                v_cpu_res.ready = '1;
                if (cpu_req.rw) begin
                    tag_req.we      = '1;
                    data_req.we     = '1;
                    tag_write.tag   = tag_read.tag;
                    tag_write.valid = '1;
                    tag_write.dirty = '1;
                end
                state = IDLE;
            end
            else begin
                tag_req.we      = '1;
                tag_write.valid = '1;
                tag_write.tag   = cpu_req.addr[TAGMSB:TAGLSB];
                tag_write.dirty = cpu_req.rw;
                v_mem_req.valid = '1;     
                if (tag_read.valid == 1'b0 || tag_read.dirty == 1'b0)
                    state = ALLOCATE;
                else begin
                    v_mem_req.addr  = {tag_read.tag, cpu_req.addr[TAGLSB-1:0]};
                    v_mem_req.rw    = '1;
                    state = WRITE_BACK;
                end
            end
        end
        ALLOCATE: begin
            if (mem_data.ready) begin
                state       = COMPARE_TAG;
                data_write  = mem_data.data;
                data_req.we = '1;
            end
        end
        WRITE_BACK   : begin
            if (mem_data.ready) begin
                v_mem_req.valid = '1;
                v_mem_req.rw    = '0;
                state           = ALLOCATE;
            end
        end
    endcase
end

dm_cache_data cdata (
    .clk_i       ( clk_i        ),
    .data_req    ( data_req      ),
    .data_write  ( data_write    ),
    .data_read   ( data_read     )
);

dm_cache_tag  ctag  (
    .clk_i      ( clk_i         ),
    .tag_req    ( tag_req       ),
    .tag_write  ( tag_write     ),
    .tag_read   ( tag_read      )
);

endmodule
