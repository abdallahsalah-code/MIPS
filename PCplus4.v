module PCplus4 (
              input [31:0]address 
              ,output [31:0]next 
);
assign next=address+4;

endmodule 
