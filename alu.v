module ALU (
    input [31:0] A,         // First operand
    input [31:0] B,         // Second operand
    input [2:0] ALUcontrol,      // ALU operation selector
    output reg [31:0] Result, // Result of the ALU operation
    output reg Zero         // Zero flag
);

    // ALU operation codes
    parameter ADD  = 3'b010, SUB  = 3'b100, AND  = 3'b000, OR   = 3'b001, SLT  = 3'b110, MUL  = 3'b101; 

    always @(*) begin

        case (ALUcontrol)
            ADD:  Result = A + B;
            SUB:  Result = A - B;
            AND:  Result = A & B;
            OR:   Result = A | B;
            MUL:  Result = A * B;
            SLT:  Result = (A < B); 
            default: Result = 32'b0;
        endcase
        
        // Set Zero flag
        Zero = (Result == 32'b0);
    end

endmodule

module alu_tb();
wire [31:0]Result;
wire zero;
reg [31:0]A,B;
reg [2:0]ALU_control;
ALU m0(A,B,ALU_control,Result,zero);
initial begin
A=32'd5;
B=32'd5;
#4 ALU_control=010;
#4 ALU_control=100;
#4 ALU_control=001;
#4 ALU_control=010;
#4 ALU_control=101;
#4 A=32'd3;
B=32'd15;
#4 ALU_control=100;
end 
endmodule
