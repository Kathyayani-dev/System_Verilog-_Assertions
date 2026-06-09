# code for JK_ff.sv


  ...
  module jk_ff;
	bit j,k,clk,rst,q;
	always@(posedge clk)
	begin
	if(rst)
		q<=0;
	else
	  begin
		case ({j,k})
			2'b00:q<=q;
			2'b01:q<=0;
			2'b10:q<=1;
			2'b11:q<=~q;
		endcase
	    end
	end
property RST;
 @(posedge clk) $rose(rst) |=> (q==0);
endproperty
assert property (RST);
cover property (RST);

property NC;
 @(posedge clk) ((!j) && (!k) |=> (q == $stable(q));
endproperty
assert property(NC);
cover property(NC);

property RESET;
 @(posedge clk) ((!j) && (k)) |=> (q==0);
endproperty
assert property (RESET);
cover property (RESET);

property SET;
 @(posedge clk) (j) && (!k) |=> (q==1);
endproperty
assert property (SET);
cover property (SET);

property TOGGLE;
 @(posedge clk) ((j) && (k)) |=> (q==!q);
endproperty
assert property (TOGGLE);
cover property (TOGGLE);


endmodule
...





