module sync_fifo_tb();
reg clk, rst_n, w_en, r_en;
reg [15:0] data_in;
wire full,empty;
wire [15:0] data_out;

sync_fifo S1(clk,rst_n,w_en,r_en,data_in, data_out, full, empty);

always #2 clk = ~clk;

initial 
begin
clk = 1'b0; rst_n = 1'b0;
w_en = 1'b0;
r_en = 1'b0; 

#10 rst_n = 1'b1;
drive(20);
drive(40);
$finish;
end

task push();
    if(!full)
    begin
    w_en = 1;
    data_in = $random;
    #1 w_en = 0;
    end
endtask

task pop();
    if(!empty)
    begin
    r_en =1;
    #1 r_en = 0;
    end
endtask

task drive(input integer delay);
begin
    w_en =0; r_en=0;
    fork
        begin
        repeat(20) begin @(posedge clk) push();end
        w_en = 0;
        end
        begin
        #delay;
        repeat(20) begin @(posedge clk) pop(); end
        r_en = 0;
        end
    join
 end
endtask

  
 initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end


endmodule

