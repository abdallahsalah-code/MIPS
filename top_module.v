module MUX(
input sel,
input [31:0] A,B,
output reg [31:0]C
);
always@(*) begin
case(sel)
 0: C=A;
 1: C=B;
default:C=32'b0; 
endcase
end
endmodule


module signex(
input [15:0]A,
output [31:0]B
);
assign B={16'b0,A};
endmodule
module ( 
)