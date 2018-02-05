onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/CLK
add wave -noupdate /system_tb/DUT/nRST
add wave -noupdate /system_tb/DUT/halt
add wave -noupdate /system_tb/DUT/CPUCLK
add wave -noupdate /system_tb/DUT/count
add wave -noupdate /system_tb/DUT/RAM/CLK
add wave -noupdate /system_tb/DUT/RAM/nRST
add wave -noupdate /system_tb/DUT/RAM/count
add wave -noupdate /system_tb/DUT/RAM/rstate
add wave -noupdate /system_tb/DUT/RAM/q
add wave -noupdate /system_tb/DUT/RAM/addr
add wave -noupdate /system_tb/DUT/RAM/wren
add wave -noupdate /system_tb/DUT/RAM/en
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/data_or_instruction_next
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/lw_hazard
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/lw_hazard_next
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/branch
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_Instr_IF
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_nextPC_IF
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_Instr_IF
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_MemToReg_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_PcToReg_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_Memwrite_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_jump_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_RegDst_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_RegWen_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_ALUSrc1_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_ALUSrc2_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_RegDat2_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_ALUOP_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_care_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_halt_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_hazard_Reg_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_nextPC_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_Instr_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_ALUSrc1_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_ALUSrc2_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_ALUOP_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_jump_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_RegDst_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_care_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_halt_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_hazard_Reg_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_RegDat2_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_MemToReg_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_Memwrite_ID
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_Wdata_EX
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_RegDst_EX
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_Result_EX
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_Result_EX
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_Wdata_EX
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_RegDst_EX
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_RegWen_EX
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_MemToReg_EX
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_Memwrite_EX
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/input_ReadData_MEM
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_PcToReg_MEM
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_nextPC_MEM
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_MemToReg_MEM
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_RegDst_MEM
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_RegWen_MEM
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_ReadData_MEM
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_CalcData_MEM
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/output_halt_MEM
add wave -noupdate -group latches /system_tb/DUT/CPU/DP/plif/lw_hazard
add wave -noupdate -expand -group hazard /system_tb/DUT/CPU/DP/hzif/dhit
add wave -noupdate -expand -group hazard /system_tb/DUT/CPU/DP/hzif/ihit
add wave -noupdate -expand -group hazard /system_tb/DUT/CPU/DP/hzif/data_or_instruction_next
add wave -noupdate -expand -group hazard /system_tb/DUT/CPU/DP/hzif/lw_instr
add wave -noupdate -expand -group hazard /system_tb/DUT/CPU/DP/hzif/lw_instr_next
add wave -noupdate -expand -group hazard /system_tb/DUT/CPU/DP/hzif/output_Instr_ID_RS
add wave -noupdate -expand -group hazard /system_tb/DUT/CPU/DP/hzif/output_Instr_ID_RD
add wave -noupdate -expand -group hazard /system_tb/DUT/CPU/DP/hzif/output_RegDst_MEM
add wave -noupdate -expand -group hazard /system_tb/DUT/CPU/DP/hzif/output_RegWen_MEM
add wave -noupdate -expand -group hazard /system_tb/DUT/CPU/DP/hzif/src1_hazard_t
add wave -noupdate -expand -group hazard /system_tb/DUT/CPU/DP/hzif/src2_hazard_t
add wave -noupdate -expand -group hazard /system_tb/DUT/CPU/DP/hzif/stall_for_load
add wave -noupdate -expand -group Reg /system_tb/DUT/CPU/DP/RF/CLK
add wave -noupdate -expand -group Reg /system_tb/DUT/CPU/DP/RF/nRST
add wave -noupdate -expand -group Reg -expand /system_tb/DUT/CPU/DP/RF/regs
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/alif/input_a
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/alif/input_b
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/alif/out
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/alif/neg
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/alif/overflow
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/alif/zero
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/alif/aluop
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/memstore
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {220849 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {2100 ns}
