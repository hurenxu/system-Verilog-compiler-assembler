//This file defines the parameters used in the alu
package definitions;
// Instruction map
    const logic [3:0]kMOVE  = 4'b0000;
    const logic [3:0]kADDI  = 4'b0001;
    const logic [3:0]kADDR  = 4'b0010;
    const logic [3:0]kSUBR  = 4'b0011;
    const logic [3:0]kSL    = 4'b0100;
    const logic [3:0]kSLR   = 4'b0101;
    const logic [3:0]kSNE   = 4'b0110;
    const logic [3:0]kSEQ   = 4'b0111;
    const logic [3:0]kSLT   = 4'b1000;
    const logic [3:0]kBEO   = 4'b1001;
    const logic [3:0]kBEZ   = 4'b1010;
    const logic [3:0]kLOAD  = 4'b1011;
    const logic [3:0]kSTORE = 4'b1100;
    const logic [3:0]kJUMP  = 4'b1101;
    const logic [3:0]kHALT  = 4'b1110;
    const logic [3:0]kOR  = 4'b1111;
    
    typedef enum logic[3:0] {
        MOVE  = 4'b0000,
        ADDI  = 4'b0001,
        ADDR  = 4'b0010,
        SUBR  = 4'b0011,
        SL    = 4'b0100,
        SLR   = 4'b0101,
        SNE   = 4'b0110,
        SEQ   = 4'b0111,
        SLT   = 4'b1000,
        BEO   = 4'b1001,
        BEZ   = 4'b1010,
        LOAD  = 4'b1011,
        STORE = 4'b1100,
        JUMP  = 4'b1101,
        HALT  = 4'b1110,
        OR  = 4'b1111
    } op_mne;
endpackage // defintions
