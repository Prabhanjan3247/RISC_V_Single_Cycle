module maindec(
    input  logic [6:0] op,
    output logic [1:0] ResultSrc,
    output logic       MemWrite,
    output logic       Branch,
    output logic       ALUSrc,
    output logic       RegWrite,
    output logic       Jump,
    output logic [1:0] ImmSrc,
    output logic [1:0] ALUOp
);

    logic [10:0] controls;

    assign {ResultSrc, MemWrite, Branch, ALUSrc, RegWrite, Jump, ImmSrc, ALUOp} = controls;

    always_comb begin
        case (op)
            // R-type
            7'b0110011: controls = 11'b00_0_0_0_1_0_00_10;

            // I-type ALU
            7'b0010011: controls = 11'b00_0_0_1_1_0_00_10;

            // Load (LW)
            7'b0000011: controls = 11'b01_0_0_1_1_0_00_00;

            // Store (SW)
            7'b0100011: controls = 11'b00_1_0_1_0_0_01_00;

            // Branch (BEQ)
            7'b1100011: controls = 11'b00_0_1_0_0_0_10_01;

            // Jump (JAL)
            7'b1101111: controls = 11'b10_0_0_0_1_1_11_00;

            default:    controls = 11'b00_0_0_0_0_0_00_00;
        endcase
    end

endmodule
