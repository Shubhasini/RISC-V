//calc_with_memory_and_op.tlv

//https://myth1.makerchip.com/sandbox/02kfkhByV/0KOh28z#


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
         $val1[31:0] = >>2$out[31:0];
         $val2[31:0] = $rand2[3:0];     //to use 4 bit input only
         $valid = $reset ? 0 : >>1$valid + 1;
         $reset_or_valid = $reset | $valid ;
      ?$reset_or_valid
         @1
            $sum[31:0]  = $val1[31:0] + $val2[31:0]; //addition
            $diff[31:0] = $val1[31:0] - $val2[31:0];  //difference
            $prod[31:0] = $val1[31:0] * $val2[31:0];  //product
            $quot[31:0] = $val1[31:0] / $val2[31:0];   //division 
         @2
            //$valid = $cnt ;
            //using multiplexer to get the desired calculated output
            //$reset1 = $reset | ~$valid; 
            $out[31:0] = $reset ? 0 :
                                ($op == 3'h0) ? $sum[31:0] :
                                ($op == 3'h1) ? $diff[31:0]:
                                ($op == 3'h2) ? $prod[31:0]:
                                ($op == 3'h3) ? $quot[31:0]:
                                ($op == 3'h4) ? >>2$mem[31:0]:
                                 >>2$out;
           $mem[31:0] = $reset ? 0 :
                                ($op == 3'h5) ? $val1:
                                 >>2$mem;

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
