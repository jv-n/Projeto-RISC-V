`timescale 1ns / 1ps

module BranchUnit #(
    parameter PC_W = 9
) (
    input logic [PC_W-1:0] Cur_PC,
    input logic [31:0] Imm,
    input logic Branch,
    input logic jump,
    input logic jumpreg,
    input logic Halt,
    input logic [31:0] AluResult,
    output logic [31:0] PC_Imm,
    output logic [31:0] PC_Four,
    output logic [31:0] BrPC,
    output logic PcSel
);

  logic Branch_Sel;
  logic [31:0] PC_Full;
  logic Halt_selector; 

  assign PC_Full = {23'b0, Cur_PC}; 
  assign Halt_selector = Halt;
  assign PC_Imm = (jumpreg) ? AluResult : (PC_Full + Imm); 
  assign PC_Four = PC_Full + 32'b100; 
  assign Branch_Sel = jump || (Branch && AluResult[0]);  // 0:Branch is taken; 1:Branch is not taken

  assign BrPC = (Branch_Sel) ? PC_Imm : ((Halt_selector) ? PC_Imm : 32'b0);  // Branch -> PC+Imm   // Otherwise, BrPC value is not important
  assign PcSel = Branch_Sel || jump || Halt_selector;  // 1:branch is taken; 0:branch is not taken(choose pc+4)

endmodule
