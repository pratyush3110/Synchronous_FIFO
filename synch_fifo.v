module sync_fifo(clk, rst, w_en, rd_en, data_in, data_out, full, empty);
input clk, rst, w_en, rd_en;
input data_in;
output full, empty;
output reg data_out;
reg [7:0] fifo;
reg [3:0] w_ptr, rd_ptr;

// resetting the Synchronous_FIFO
always @(posedge clk)
begin
  if (rst==1) 
  begin
    w_ptr<=0;
    rd_ptr<=0;
    data_out<=0;
  end
 end

 // write operation
 always@(posedge clk)
 begin
  if(!full && w_en)
  begin
    fifo[w_ptr]<=data_in;
    w_ptr<=w_ptr+1;
  end
 end
 
 // read operation
 always@(posedge clk)
 begin
  if(!empty && rd_en)
  begin
    data_out<=fifo[rd_ptr];
    rd_ptr<=rd_ptr+1;
  end
 end
 assign full=(w_ptr==rd_ptr);
 assign empty=((w_ptr[2:0]==rd_ptr[2:0])&&(w_ptr[3]>rd_ptr[3]));
endmodule