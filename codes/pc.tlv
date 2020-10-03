\m4_TLV_version 1d: tl-x.org
\SV  
   m4_include_lib(['https://raw.githubusercontent.com/stevehoover/RISC-V_MYTH_Workshop/fb7f86ff81ea48036bfc8da83be17f2ed3260949/tlv_lib/risc-v_shell_lib.tlv'])

\SV
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV

   |cpu
      @0
         $reset = *reset;
         $pc[31:0] = >>1$reset ? 32'b0 : >>1$pc + 32'd4;
   
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
   
     //url: https://makerchip.com/sandbox/00Rf2hWpR/0j2hn5B                  
\SV
   endmodule
