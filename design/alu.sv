`timescale 1ns / 1ps

module alu#(
        parameter DATA_WIDTH = 32,
        parameter OPCODE_LENGTH = 4
        )
        (
        input logic [DATA_WIDTH-1:0]    SrcA,
        input logic [DATA_WIDTH-1:0]    SrcB,

        input logic [OPCODE_LENGTH-1:0]    Operation,
        output logic[DATA_WIDTH-1:0] ALUResult
        );
    
        always_comb
        begin
            case(Operation)
            4'b0000:        // AND
                    ALUResult = SrcA & SrcB;
            4'b0001:        // OR
                    ALUResult = SrcA | SrcB;
            4'b0101:        // ADD
                    ALUResult = SrcA + SrcB;
            4'b0011:        // SUB
                    ALUResult = SrcA - SrcB;
            4'b0100:        // XOR
                    ALUResult = SrcA ^ SrcB;
            4'b1000:        // Equal (beq)
                    ALUResult = (SrcA == SrcB) ? 1 : 0;
            4'b1001:        // Not Equal (bne)
                    ALUResult = (SrcA != SrcB) ? 1 : 0;
            4'b1010:        // Less than (blt)
                    ALUResult = (SrcA < SrcB) ? 1 : 0;
            4'b1011:        // Greater than or equal
                    ALUResult = (SrcA >= SrcB) ? 1 : 0;
            4'b1100:        // Shift right (SRLI)
                    ALUResult = SrcA >> SrcB;
            4'b1101:        // Shift left (SLLI)
                    ALUResult = SrcA << SrcB;
            4'b1110:
                
            4'b1111:
                        
            default:
                    ALUResult = 0;
            endcase
        end
endmodule
