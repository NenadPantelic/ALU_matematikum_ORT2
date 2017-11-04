`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:46:53 02/07/2017 
// Design Name: 
// Module Name:    matematikum 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module matematikum(
input add,
input sub,
input revert,
input [3:0] button ,
input clk,
input rst,
output reg [6:0] segment ,
output reg [3:0] an 
    );
reg overflow_1 = 0;
reg overflow_2 = 0;	 
reg [14:0] counter;
reg [1:0] display;

reg [3:0] x1;
reg [3:0] y1;

reg [3:0] x2;
reg [3:0] y2;


reg [3:0] a = 0 ;
reg [3:0] b = 0;
reg [3:0] c = 0;
reg [3:0] d  = 0;
reg [3:0] over_1;
reg [3:0] over_2;


reg [3:0] p = 0,q = 0,r = 0,s = 0,loan = 0;
reg borrowed = 0;


reg [3:0] p1 = 0,q1 = 0,r1 = 0,s1 = 0,loan1 = 0;
reg borrowed1 = 0;
reg [3:0] x1_,y1_,x2_,y2_;
reg [3:0] val;

always @(posedge clk)
begin
if (counter < 15'b111111111111111)
	counter <= counter + 1;
else if (rst == 1)
	counter <= 15'b000000000000000;
else
		counter <= 15'b000000000000000;
		
end

always @(*)
   display <= counter[14:13];



always @(posedge button[0])

	if (y2 < 4'b1001) 
		y2 <= y2+1;
	
always @(posedge button[1])

	if (y1 < 4'b1001) 
		y1 <= y1+1;
		
always @(posedge button[2])

	if (x2 < 4'b1001) 
		x2 <= x2+1;
	 
always @(posedge button[3])

	if (x1 < 4'b1001) 
		x1 <= x1+1;

always @(*)
begin
overflow_1 <= (x2+y2)>9 ? 1:0;
over_1 <= (x2+y2)>9 ? 10:0;
overflow_2 <= (x1+y1+overflow_1)>9 ? 1:0;
over_2 <= (x1+y1+overflow_1) > 9 ? 10:0;
end


always @(*)


begin

	
	x2_ <= y2;
	x1_ <= y1;
	y2_ <= x2;
	y1_ <= x1;

end


always @(*)
begin
loan1<= (x2_< y2_) ? 10:0;
borrowed1 <= (x2_< y2_) ? 1:0;

end

always @(*)
	begin
	
s1 <= loan1+x2_-y2_;
r1 <= x1_-y1_-borrowed1;
end

always @(*)
begin
loan<= (x2<y2) ? 10:0;
borrowed <= (x2<y2) ? 1:0;

end

always @(*)
	begin
	
s <= loan+x2-y2;
r <= x1-y1-borrowed;
end

always @(*)
begin

d <= x2+y2-over_1;
c <= x1+y1+overflow_1-over_2;
b<= overflow_2;
end




always @(*)
begin	
if (~add & ~sub)
	case(display)
    
   2'b00 : 
    begin
	  val <= y2;
     an <= 4'b1110;
    end
    
   2'b01:
    begin
	  val <= y1;
     an <= 4'b1101;
    end
    
   2'b10:
    begin
     val <= x2 ; 
     an <= 4'b1011;
    end
     
   2'b11:
    begin
     val <= x1; 
     an <= 4'b0111;
    end
  endcase
 
 
 else if (add)
 
 
case(display)
    
   2'b00 : 
    begin
	  val <= d;
     an <= 4'b1110;
    end
    
   2'b01:
    begin
	  val <= c;
     an <= 4'b1101;
    end
    
   2'b10:
    begin
     val <= b ; 
     an <= 4'b1011;
    end  
	  
   2'b11:
    begin
     val <= a; 
     an <= 4'b0111;
    end
  endcase	
else if (sub & ~revert)

case(display)
    
   2'b00 : 
    begin
	  val <= s;
     an <= 4'b1110;
    end
    
   2'b01:
    begin
	  val <= r;
     an <= 4'b1101;
    end
    
   2'b10:
    begin
     val <= q ; 
     an <= 4'b1011;
    end  
	  
   2'b11:
    begin
     val <= p; 
     an <= 4'b0111;
    end
  endcase	
  
  else if (sub & revert)
 
 
case(display)
    
   2'b00 : 
    begin
	  val <= s1;
     an <= 4'b1110;
    end
    
   2'b01:
    begin
	  val <= r1;
     an <= 4'b1101;
    end
    
   2'b10:
    begin
     val <= 10 ; 
     an <= 4'b1011;
    end  
	  
   2'b11:
    begin
     val <= p1; 
     an <= 4'b0111;
    end
  endcase	
end

 


	
always @(*)
 begin
  case(val)
   4'b0000 : segment = 7'b1000000; // 0
   4'b0001 : segment = 7'b1111001; // 1
   4'b0010 : segment = 7'b0100100; // 2
   4'b0011 : segment = 7'b0110000; // 3
   4'b0100 : segment = 7'b0011001; // 4
   4'b0101 : segment = 7'b0010010; // 5
   4'b0110 : segment = 7'b0000010; // 6
   4'b0111 : segment = 7'b1111000; // 7
   4'b1000 : segment = 7'b0000000; // 8
   4'b1001 : segment = 7'b0010000; // 9
	4'b1010:segment = 7'b0111111;
	default: segment = 7'b0000000;
	endcase
end





	




	
	

endmodule

