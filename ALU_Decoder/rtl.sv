module aludec(
    input  logic        opb5,
    input  logic [2:0]  funct3,
    input  logic        funct7b5,
    input  logic [1:0]  ALUOp,
    output logic [2:0]  ALUControl
);

    logic RtypeSub;
    assign RtypeSub = funct7b5 & opb5; // True for R-type subtract

    always_comb begin
        case (ALUOp)
            2'b00: ALUControl = 3'b000; // Addition (LW, SW)
            2'b01: ALUControl = 3'b001; // Subtraction (BEQ)
            default: begin // 2'b10: R-type or I-type ALU
                case (funct3)
                    3'b000: begin
                        if (RtypeSub)
                            ALUControl = 3'b001; // SUB
                        else
                            ALUControl = 3'b000; // ADD, ADDI
                    end
                    3'b010: ALUControl = 3'b101; // SLT, SLTI
                    3'b110: ALUControl = 3'b011; // OR, ORI
                    3'b111: ALUControl = 3'b010; // AND, ANDI
                    default: ALUControl = 3'b000;
                endcase
            end
        endcase
    end

endmodule
