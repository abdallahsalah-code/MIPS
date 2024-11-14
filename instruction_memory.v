module inst_mem #(parameter n=32)(input [n-1:0]address
		,output [n-1:0]instruct
);
reg [n-1:0] mem [2^(n-2):0];

initial 
begin 
$readmemh("C:/altera/15.1/MIPS/program1.txt",mem);
end
assign instruct=mem[address[n-1:2]];
endmodule

module inst_tb();
wire [31:0]instruct; 
reg [31:0]add; 
inst_mem m0(add,instruct);
integer i;
initial begin 
add=32'b0;
for(i=0;i<1024;i=i+1)begin
#4 add=add+32'd4;
end 
end
endmodule
