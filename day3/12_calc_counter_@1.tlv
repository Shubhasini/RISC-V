//calc_counter_@1.tlv

//https://myth1.makerchip.com/sandbox/02kfkhByV/0wjhG08#

\m4_TLV_version 1d: tl-x.org
\SV
   // This code can be found in: https://github.com/stevehoover/RISC-V_MYTH_Workshop
   
   m4_include_lib(['https://raw.githubusercontent.com/stevehoover/RISC-V_MYTH_Workshop/9c5b893e6e8b317e9c9b1c0158d2cd07c65f1378/tlv_lib/calculator_shell_lib.tlv'])

\SV
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)

\TLV
   |calc
      @0
         $reset = *reset;
      @1 
         //$reset = *reset;
         $val1[31:0] = >>1$out[31:0];
         $val2[31:0] = $rand2[3:0];     //to use 4 bit input only
         $sum[31:0]  = $val1[31:0] + $val2[31:0]; //addition
         $diff[31:0] = $val1[31:0] - $val2[31:0];  //difference
         $prod[31:0] = $val1[31:0] * $val2[31:0];  //product
         $quot[31:0] = $val1[31:0] / $val2[31:0];   //division  
         $cnt = $reset ? 0 : >>1$cnt + 1;
         //using multiplexer to get the desired calculated output
         $out[31:0] = $reset ? 0 :
                        ($op[0]?
                          ($op[1] ? $quot[31:0] : $diff[31:0]) 
                          : ($op[1] ? $prod[31:0] : $sum[31:0]));  

         

      // Macro instantiations for calculator visualization(disabled by default).
      // Uncomment to enable visualisation, and also,
      // NOTE: If visualization is enabled, $op must be defined to the proper width using the expression below.
      //       (Any signals other than $rand1, $rand2 that are not explicitly assigned will result in strange errors.)
      //       You can, however, safely use these specific random signals as described in the videos:
      //  o $rand1[3:0]
      //  o $rand2[3:0]
      //  o $op[x:0]
      
   m4+cal_viz(@3) // Arg: Pipeline stage represented by viz, should be atleast equal to last stage of CALCULATOR logic.

   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
   

\SV
   endmodule
