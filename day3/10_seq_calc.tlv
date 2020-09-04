//seq_calc.tlv
//https://myth1.makerchip.com/sandbox/02kfkhByV/0Rghvrx#

\m4_TLV_version 1d: tl-x.org
\SV

   // =========================================
   // Welcome!  Try the tutorials via the menu.
   // =========================================

   // Default Makerchip TL-Verilog Code Template
  // input val1
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   $reset = *reset;
  $val1[31:0] = >>1$out[31:0];
  $val2[31:0] = $rand2[3:0];     //to use 4 bit input only
  $sum[31:0]  = $val1[31:0] + $val2[31:0]; //addition
  $diff[31:0] = $val1[31:0] - $val2[31:0];  //difference
  $prod[31:0] = $val1[31:0] * $val2[31:0];  //product
  $quot[31:0] = $val1[31:0] / $val2[31:0];   //division
  
  //using multiplexer to get the desired calculated output
   $out[31:0] = $reset ? 0 
                       :($op[0]?($op[1] ? $quot[31:0] 
                                        : $diff[31:0]) 
                               : ($op[1] ? $prod[31:0] 
                                         : $sum[31:0]));  
  //$out[31:0] = $op[0]?($op[1] ? $div[31:0] : $diff[31:0]) 
  //                   : ($op[1] ? $prod[31:0] : $sum[31:0]) ; 
  // op[0:1] = 00, out = sum; 
  // op[0:1]= 01, out = diff;
  // op[0:1]= 10, out = prod;
  // op[0:1]= 11, out = div;
  
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
