// Writing Direct Testing:

module tb;
  bit clk;
  bit [31:0] datain;
  bit wr_rd;
  wire [31:0] dataout;
  
  //Taking Instance of DUT
  A_FIFO DUT(.clk(clk),.datain(datain),.wr_rd(wr_rd),.dataout(dataout));
  
  //generation of clk
  initial begin
    forever begin
      #5 clk = ~clk;
    end
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
    monitor();
    repeat(20) begin
      datain <= $urandom_range(10,50);
      wr_rd  <= $random;
      @(posedge clk);
    end
    @(posedge clk);
    $finish;
  end
  
  task monitor();
    $monitor($time,"datain=%0d, addr=%0d, wr_rd=%0b, dataout=%0d, empty=%0b, full=%0b",datain,DUT.addr,wr_rd,dataout,DUT.empty,DUT.full);
  endtask
  
endmodule