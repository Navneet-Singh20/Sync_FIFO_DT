//RTL Code for Synchronous FIFO

module A_FIFO(input clk,
              input [31:0] datain,
              input wr_rd,
              output reg [31:0] dataout);
  
  //variable to declare queue is FULL
  logic full=0;
  //variable to declare queue is EMPTY
  logic empty=1;
  //variable for address location of queue
  logic [2:0] addr=0;
  
  //I am declaring queue type array
  bit [31:0] queue[8];
  
  always@(posedge clk) begin
    #0 $display($time,"queue=%p",queue);
  end
 
  //Write logic
  always@(posedge clk) begin
    if((full==0)&&(wr_rd)) begin
      queue[addr] <= datain;
      addr = addr + 1;
    end else if((full==1)&&(wr_rd)) begin
      $error("Queue is Full");
    end
  end
  
  //Read logic
  always@(posedge clk) begin
    if((empty==0)&&(!wr_rd)) begin
      addr = addr - 1;
      dataout <= queue[addr];
      //addr <= addr - 1;
    end else if((empty==1)&&(!wr_rd)) begin
      $error("Queue is Empty");
    end
  end
  
  //Full logic
  always@(posedge clk) begin
    if(addr==7) begin
      full=1;
    end else begin
      full=0;
    end
  end
  
  //Empty logic
  always@(posedge clk) begin
    if(addr==0) begin
      empty=1;
    end else begin
      empty=0;
    end
  end
      
endmodule