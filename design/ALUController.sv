`timescale 1ns / 1ps
// 0000 - AND
// 0001 - OR
// 0010 - ADD/ADDI
// 0011 - SUB 
// 0100 - XOR 
// 0101 - 
// 0110 -
// 0111 -
// 1000 - BEQ
// 1001 - BNE
// 1010 - BLT
// 1011 - BGE
// 1100 - SLT/SLTI
// 1101 - SLLI
// 1110 -
// 1111 -


module ALUController (
    //Inputs
    input logic [1:0] ALUOp,  // 2-bit opcode field from the Controller--00: LW/SW/AUIPC; 01:Branch; 10: Rtype/Itype; 11:JAL/LUI
    input logic [6:0] Funct7,  // bits 25 to 31 of the instruction
    input logic [2:0] Funct3,  // bits 12 to 14 of the instruction

    //Output
    output logic [3:0] Operation  // operation selection for ALU
);

  assign Operation[0] = ((ALUOp == 2'b01) && (Funct3 == 3'b001)) ||  // BNE
      ((ALUOp == 2'b01) && (Funct3 == 3'b101)) || //BGE
      ((ALUOp == 2'b10) && (Funct3 == 3'b110) && (Funct7 == 7'b0000000)) ||  // R\I-or
    //   ((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0000000)) ||  // R\I->>
    //   ((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0100000)) ||// R\I->>>
      ((ALUOp == 2'b10) && (Funct3 == 3'b000) && (Funct7 == 7'b0100000)) || // R\I-sub
      ((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0000000)) ||//SRLI
      ((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0100000)); //SRAI

  assign Operation[1] = (ALUOp == 2'b00) ||  // Load/store
      ((ALUOp == 2'b01) && (Funct3 == 3'b100)) ||  // BLT
      ((ALUOp == 2'b01) && (Funct3 == 3'b101)) || //BGE
      ((ALUOp == 2'b10) && (Funct3 == 3'b000) && (Funct7 == 7'b0000000))||  // R\I-add
      ((ALUOp == 2'b10) && (Funct3 == 3'b000) && (Funct7 != 7'b0100000))|| //ADDI
   //   ((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0100000)) || // R\I->>>
      ((ALUOp == 2'b10) && (Funct3 == 3'b000) && (Funct7 == 7'b0100000)) || // R\I-sub
      ((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0100000)) || //SRAI
      ((ALUOp == 2'b10) && (Funct3 == 3'b010) && (Funct7 == 7'b0000000)) || //slt  
      ((ALUOp == 2'b10) && (Funct3 == 3'b010) && (Funct7 != 7'b0000000));// SLTI // R\I-<

  assign Operation[2] =  ((ALUOp==2'b10) && (Funct3==3'b101) && (Funct7==7'b0000000)) || // R\I->>
      //((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0100000)) ||  // R\I->>>
      //((ALUOp == 2'b10) && (Funct3 == 3'b001)) ||  // R\I-<<
     // ((ALUOp == 2'b10) && (Funct3 == 3'b010)) ||  // R\I-<
      ((ALUOp == 2'b10) && (Funct3 == 3'b100) && (Funct7 == 7'b0000000)) || // R\I-xor
      ((ALUOp == 2'b10) && (Funct3 == 3'b010) && (Funct7 == 7'b0000000)) || //slt  
      ((ALUOp == 2'b10) && (Funct3 == 3'b010) && (Funct7 != 7'b0000000)) || // SLTI // R\I-<
      ((ALUOp == 2'b10) && (Funct3 == 3'b001) && (Funct7 == 7'b0000000)) || //SLLI
      ((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0000000))|| //SRLI
      ((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0100000)); //SRAI

  assign Operation[3] = ((ALUOp == 2'b01) && (Funct3 == 3'b000)) ||  // BEQ
        ((ALUOp == 2'b01) && (Funct3 == 3'b001)) ||  // BNE
        ((ALUOp == 2'b01) && (Funct3 == 3'b100)) ||  // BLT
        ((ALUOp == 2'b01) && (Funct3 == 3'b101)) || //BGE
        ((ALUOp == 2'b10) && (Funct3 == 3'b010) && (Funct7 == 7'b0000000)) || //slt  
        ((ALUOp == 2'b10) && (Funct3 == 3'b010) && (Funct7 != 7'b0000000)) || // SLTI // R\I-<
        ((ALUOp == 2'b10) && (Funct3 == 3'b001) && (Funct7 == 7'b0000000)) || //SLLI
        ((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0000000))|| //SRLI
        ((ALUOp == 2'b10) && (Funct3 == 3'b101) && (Funct7 == 7'b0100000)); //SRAI
endmodule
