onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -expand -group ramif /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/dcif/halt
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/dcif/ihit
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/dcif/imemREN
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/dcif/imemaddr
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/dcif/dhit
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/dcif/datomic
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/dcif/dmemREN
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/dcif/dmemWEN
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/dcif/flushed
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/dcif/dmemload
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/dcif/dmemstore
add wave -noupdate -expand -group dcif /system_tb/DUT/CPU/dcif/dmemaddr
add wave -noupdate /system_tb/DUT/CPU/DP/RF/regs
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/CLK
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/nRST
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/state
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/Next_state
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/flushReg
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/Next_flushReg
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/tag
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/index
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/tag_checking1
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/tag_checking2
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/valid_checking1
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/valid_checking2
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/dirty_checking_1
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/dirty_checking_2
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/data_store0
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/data_store1
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/data_stored
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/same_tag
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/accociate_map
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/Next_accociate_map
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/other_addr
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/dcacheReg
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/Next_dcacheReg
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/hitCount
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/Next_hitCount
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/cnt_to_16
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/Next_cnt_to_16
add wave -noupdate -group dcache /system_tb/DUT/CPU/CM/DCACHES/i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {663090000 ps} 0}
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
WaveRestoreZoom {2088370 ns} {2089370 ns}
