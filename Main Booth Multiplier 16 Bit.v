module Booth_9 (X,Y,P);
  input [8:0]X,Y;
  output [17:0]P;
  wire [15:0]Xi,Yi;  
  wire [31:0]Product;
  
  assign Xi={7'd0,X};
  assign Yi={7'd0,Y}; 
  assign P=Product[17:0];
  
  
  Radix_8_16_bit_Multiplier M0 (Xi,Yi,Product);
  
endmodule

module Radix_8_16_bit_Multiplier (X,Y,Product);
  input [15:0]X,Y;
  output [31:0]Product;
  wire [31:0]PP0,PP1,PP2,PP3,PP4,PP5;
  
  Main_PP_Block_16 Partial_Product (
    .X(X), 
    .Y(Y), 
    .PP0(PP0), 
    .PP1(PP1), 
    .PP2(PP2), 
    .PP3(PP3), 
    .PP4(PP4), 
    .PP5(PP5)
    );

Adder_Part_1 Adder_Part (
    .PP0(PP0), 
    .PP1(PP1), 
    .PP2(PP2), 
    .PP3(PP3), 
    .PP4(PP4), 
    .PP5(PP5), 
    .P(Product)
    );

endmodule


module Main_PP_Block_16 (X,Y,PP0,PP1,PP2,PP3,PP4,PP5);
  input [15:0]X,Y;
  output [31:0]PP0,PP1,PP2,PP3,PP4,PP5;
  wire [18:0]Y_N;

  assign Y_N={2'b0,Y,1'b0};
  
  SD_Booth_Encoder_PP_Block_16 SD_PP0 (
    .X(X),
    .Y(Y_N[3:0]),
    .PP(PP0)
    );
    
  SD_Booth_Encoder_PP_Block_16 SD_PP1 (
    .X(X),
    .Y(Y_N[6:3]),
    .PP(PP1)
    );    

  SD_Booth_Encoder_PP_Block_16 SD_PP2 (
    .X(X),
    .Y(Y_N[9:6]),
    .PP(PP2)
    );

  SD_Booth_Encoder_PP_Block_16 SD_PP3 (
    .X(X),
    .Y(Y_N[12:9]),
    .PP(PP3)
    );    

  SD_Booth_Encoder_PP_Block_16 SD_PP4 (
    .X(X),
    .Y(Y_N[15:12]),
    .PP(PP4)
    );    

  SD_Booth_Encoder_PP_Block_16 SD_PP5(
    .X(X),
    .Y(Y_N[18:15]),
    .PP(PP5)
    );    

endmodule

module SD_Booth_Encoder_PP_Block_16 (X,Y,PP);
  input [15:0]X;
  input [3:0]Y;
  output [31:0]PP;
  reg [31:0]PP;
  
  wire  [31:0]X_4,X_4b,X_3,X_3b,X_2,X_1,X_2b,X_1b;


  assign X_1=X*'d1;
  assign X_1b=X*-'d1;    

  assign X_2=X*'d2;
  assign X_2b=X*-'d2;    
  
  assign X_3=X*'d3;
  assign X_3b=X*-'d3;      
  
  assign X_4=X*'d4;
  assign X_4b=X*-'d4;    

  always @ (*)
  begin
  case (Y)
    4'b0000: PP=32'd0;                    
    4'b0001: PP=X_1;
    4'b0010: PP=X_1;
    4'b0011: PP=X_2;
    4'b0100: PP=X_2;
    4'b0101: PP=X_3;
    4'b0110: PP=X_3;
    4'b0111: PP=X_4;                    
    4'b1000: PP=X_4b;                    
    4'b1001: PP=X_3b;
    4'b1010: PP=X_3b;
    4'b1011: PP=X_2b;
    4'b1100: PP=X_2b;
    4'b1101: PP=X_1b;
    4'b1110: PP=X_1b;
    4'b1111: PP=32'd0;                    
  endcase
  end  
  
endmodule



module Adder_Part_1 (PP0,PP1,PP2,PP3,PP4,PP5,P);
  input [31:0]PP0;
  input [31:0]PP1;
  input [31:0]PP2;  
  input [31:0]PP3;  
  input [31:0]PP4;    
  input [31:0]PP5;    
  output [31:0]P;
  
  wire [4:0]W4,W5,W6,W7,W8,W9,W10,W11,W12,W13,W14,W15,W16,W17,W18,W19,W20,W21,W22,W23,W24,W25,W26,W27,W28,W29,W30;
  
       assign P[0]=PP0[0];
       assign P[1]=PP0[1];
       assign P[2]=PP0[2];
  assign {W3,P[3]}=PP0[3]+PP1[0];  
  assign {W4,P[4]}=PP0[4]+PP1[1]+W3;
  assign {W5,P[5]}=PP0[5]+PP1[2]+W4;
  assign {W6,P[6]}=PP0[6]+PP1[3]+PP2[0]+W5;
  assign {W7,P[7]}=PP0[7]+PP1[4]+PP2[1]+W6;        
  assign {W8,P[8]}=PP0[8]+PP1[5]+PP2[2]+W7;        
  assign {W9,P[9]}=PP0[9]+PP1[6]+PP2[3]+PP3[0]+W8;        
assign {W10,P[10]}=PP0[10]+PP1[7]+PP2[4]+PP3[1]+W9;        
assign {W11,P[11]}=PP0[11]+PP1[8]+PP2[5]+PP3[2]+W10;        
assign {W12,P[12]}=PP0[12]+PP1[9]+PP2[6]+PP3[3]+PP4[0]+W11;        
assign {W13,P[13]}=PP0[13]+PP1[10]+PP2[7]+PP3[4]+PP4[1]+W12;         
assign {W14,P[14]}=PP0[14]+PP1[11]+PP2[8]+PP3[5]+PP4[2]+W13;         
assign {W15,P[15]}=PP0[15]+PP1[12]+PP2[9]+PP3[6]+PP4[3]+PP5[0]+W14;         
assign {W16,P[16]}=PP0[16]+PP1[13]+PP2[10]+PP3[7]+PP4[4]+PP5[1]+W15;         
assign {W17,P[17]}=PP0[17]+PP1[14]+PP2[11]+PP3[8]+PP4[5]+PP5[2]+W16;         
assign {W18,P[18]}=PP0[18]+PP1[15]+PP2[12]+PP3[9]+PP4[6]+PP5[3]+W17;           
assign {W19,P[19]}=PP0[19]+PP1[16]+PP2[13]+PP3[10]+PP4[7]+PP5[4]+W18;           
assign {W20,P[20]}=PP0[20]+PP1[17]+PP2[14]+PP3[11]+PP4[8]+PP5[5]+W19;             
assign {W21,P[21]}=PP0[21]+PP1[18]+PP2[15]+PP3[12]+PP4[9]+PP5[6]+W20;             
assign {W22,P[22]}=PP0[22]+PP1[19]+PP2[16]+PP3[13]+PP4[10]+PP5[7]+W21;               
assign {W23,P[23]}=PP0[23]+PP1[20]+PP2[17]+PP3[14]+PP4[11]+PP5[8]+W22;               
assign {W24,P[24]}=PP0[24]+PP1[21]+PP2[18]+PP3[15]+PP4[12]+PP5[9]+W23;               
assign {W25,P[25]}=PP0[25]+PP1[22]+PP2[19]+PP3[16]+PP4[13]+PP5[10]+W24;                 
assign {W26,P[26]}=PP0[26]+PP1[23]+PP2[20]+PP3[17]+PP4[14]+PP5[11]+W25;                 
assign {W27,P[27]}=PP0[27]+PP1[24]+PP2[21]+PP3[18]+PP4[15]+PP5[12]+W26;                   
assign {W28,P[28]}=PP0[28]+PP1[25]+PP2[22]+PP3[19]+PP4[16]+PP5[13]+W27;                   
assign {W29,P[29]}=PP0[29]+PP1[26]+PP2[23]+PP3[20]+PP4[17]+PP5[14]+W28;                   
assign {W30,P[30]}=PP0[30]+PP1[27]+PP2[24]+PP3[21]+PP4[18]+PP5[15]+W29;                   
assign {W31,P[31]}=PP0[31]+PP1[28]+PP2[25]+PP3[22]+PP4[19]+PP5[16]+W30;                   

endmodule


module ECW (PP0,PP1,PP2,PP3,PP4,PP5,New_PP0,New_PP1,New_PP2,New_PP3,New_PP4,New_PP5);
  input [16:0]PP0,PP1,PP2,PP3,PP4,PP5;
  output [20:0]New_PP0;
  output [19:0]New_PP1;
  output [19:0]New_PP2;  
  output [19:0]New_PP3;  
  output [18:0]New_PP4;    
  output [16:0]New_PP5;    
  
  
  assign New_PP0={~PP0[16],PP0[16],PP0[16],PP0[16],PP0};
  assign New_PP1={1'b1,1'b1,~PP1[16],PP1};
  assign New_PP2={1'b1,1'b1,~PP2[16],PP2};
  assign New_PP3={1'b1,1'b1,~PP3[16],PP3};  
  assign New_PP4={1'b1,~PP2[16],PP4};  
  assign New_PP5=PP5;  
  
endmodule