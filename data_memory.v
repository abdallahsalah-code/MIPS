module data_memory (
    input  clk,rst,MemWrite
    ,input [31:0]WriteData,address
    ,output reg [31:0]ReadData
    ,output reg [15:0]test_value
);
integer i;
reg [31:0] mem[255:0];
always@(posedge clk,negedge rst) begin
if(!rst)begin
        for (i = 0; i < 256; i = i + 1) begin
            mem[i] <= 32'b0;
        end
 end else if (MemWrite) begin
        mem[address[31:2]] <= WriteData;
end
end
always@(*)begin
ReadData=mem[address[31:2]];
test_value=mem[0][15:0];
end
endmodule 

module data_tb();
reg clk;
reg rst;
reg [31:0] address;
reg [31:0] WriteData;
reg MemWrite;
wire [15:0]test_value;
wire [31:0] ReadData;
data_memory m0(clk,rst,MemWrite,WriteData,address,ReadData,test_value);
always begin
    #3 clk = ~clk; // Toggle clock every 5 time units
end

initial begin
    // Initialize signals
    clk = 0;
    rst = 0;
    address = 0;
    WriteData = 0;
    MemWrite = 0;

    // Apply reset
    #10 rst = 1;

    // Write data to memory
    #10 address = 32'h00000000; WriteData = 32'hDEADBEEF; MemWrite = 1;
    #10 MemWrite = 0;

    // Read data from memory
    #10 address = 32'h00000000;

    // Wait and finish simulation
    #20 $finish;
end
endmodule 
