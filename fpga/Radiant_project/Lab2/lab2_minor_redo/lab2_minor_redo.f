-L work
-reflib pmi_work
-reflib ovi_ice40up


"C:/Users/thanderson/Documents/GitHub/E155-Lab2/fpga/Radiant_project/Lab2/source/impl_1/lab1_ta_hex_seg_decoder.sv" 
"C:/Users/thanderson/Documents/GitHub/E155-Lab2/fpga/Radiant_project/Lab2/source/impl_1/lab2_ta.sv" 
"C:/Users/thanderson/Documents/GitHub/E155-Lab2/fpga/Radiant_project/Lab2/source/impl_1/lab2_ta_counter.sv" 
"C:/Users/thanderson/Documents/GitHub/E155-Lab2/fpga/Radiant_project/Lab2/source/impl_1/lab2_ta_scan.sv" 
"C:/Users/thanderson/Documents/GitHub/E155-Lab2/fpga/Radiant_project/Lab2/source/impl_1/lab2_ta_scan_tb.sv" 
"C:/Users/thanderson/Documents/GitHub/E155-Lab2/fpga/Radiant_project/Lab2/source/impl_1/lab2_ta_toplevel_tb.sv" 
-sv
-optionset VOPTDEBUG
+noacc+pmi_work.*
+noacc+ovi_ice40up.*

-vopt.options
  -suppress vopt-7033
-end

-gui
-top lab2_ta_scan_tb
-vsim.options
  -suppress vsim-7033,vsim-8630,3009,3389
-end

-do "view wave"
-do "add wave /*"
-do "run -all"
