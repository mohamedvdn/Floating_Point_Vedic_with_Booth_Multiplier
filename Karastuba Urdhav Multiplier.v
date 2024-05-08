module Karastuba_Urdhau_Multiplier_FP (X,Y,Mul_Out);
   input [13:0]X; 
   input [13:0] Y;
   output [27:0] Mul_Out;
   wire [15:0]X_In,Y_In;
   wire [31:0]Mul;
   
   assign X_In={2'b00,X};
   assign Y_In={2'b00,Y};
   assign Mul_Out=Mul[27:0];
     
   
   New_karastuba_16 MM0 (
	.X(X_In),
	.Y(Y_In),
	.Mul_Out(Mul)
	);
	
	 
endmodule