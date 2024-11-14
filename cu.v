module cu(
    input [5:0] opcode,    // Instruction opcode field
    input [5:0] funct,     // funct field for R-type instructions
    output reg jump,       // Jump signal
    output reg memwrite,   // Memory Write signal
    output reg regwrite,   // Register Write signal
    output reg regdst,    // Register Destination select signal
    output reg alusrc,     // ALU Source select signal
    output reg memtoreg,   // Memory to Register select signal
    output reg branch,     // Branch signal
    output reg [2:0] ALUControl // ALU Control signal
);

reg [1:0] aluop;  // Intermediate signal between Main Decoder and ALU Decoder

// Main Decoder Logic
always @(*) begin
    case (opcode)
        6'b10_0011: begin // lw
            jump     = 1'b0;
            aluop    = 2'b00;
            memwrite = 1'b0;
            regwrite = 1'b1;
            regdst  = 1'b0;
            alusrc   = 1'b1;
            memtoreg = 1'b1;
            branch   = 1'b0;
        end
        6'b10_1011: begin // sw
            jump     = 1'b0;
            aluop    = 2'b00;
            memwrite = 1'b1;
            regwrite = 1'b0;
            regdst  = 1'b0;
            alusrc   = 1'b1;
            memtoreg = 1'b1; // Don't care
            branch   = 1'b0;
        end
        6'b00_0000: begin // R-type
            jump     = 1'b0;
            aluop    = 2'b10;
            memwrite = 1'b0;
            regwrite = 1'b1;
            regdst  = 1'b1;
            alusrc   = 1'b0;
            memtoreg = 1'b0;
            branch   = 1'b0;
        end
        6'b00_1000: begin 
            jump     = 1'b0;
            aluop    = 2'b00;
            memwrite = 1'b0;
            regwrite = 1'b1;
            regdst  = 1'b0;
            alusrc   = 1'b1;
            memtoreg = 1'b0;
            branch   = 1'b0;
        end
        6'b00_0100: begin // beq
            jump     = 1'b0;
            aluop    = 2'b01;
            memwrite = 1'b0;
            regwrite = 1'b0;
            regdst  = 1'b0;
            alusrc   = 1'b0;
            memtoreg = 1'b0;
            branch   = 1'b1;
        end
        6'b00_0010: begin // Jal or j
            jump     = 1'b1;
            aluop    = 2'b00;
            memwrite = 1'b0;
            regwrite = 1'b0;
            regdst  = 1'b0;
            alusrc   = 1'b0;
            memtoreg = 1'b0;
            branch   = 1'b0;
        end
        default: begin
            jump     = 1'b0;
            aluop    = 2'b00;
            memwrite = 1'b0;
            regwrite = 1'b0;
            regdst  = 1'b0;
            alusrc   = 1'b0;
            memtoreg = 1'b0;
            branch   = 1'b0;
        end
    endcase
end

// ALU Decoder Logic
always @(*) begin
    case (aluop)
        2'b00: ALUControl = 3'b010; // Add operation
        2'b01: ALUControl = 3'b100; // Subtract operation
        2'b10: begin
            case (funct)
                6'b10_0000: ALUControl = 3'b010; // ADD
                6'b10_0010: ALUControl = 3'b100; // SUB
                6'b10_1010: ALUControl = 3'b110; // SLT
                6'b01_1100: ALUControl = 3'b101; // MUL
                default:    ALUControl = 3'b010; // Default - Add operation
            endcase
        end
        default: ALUControl = 3'b010; // Default - Add operation
    endcase
end

endmodule
