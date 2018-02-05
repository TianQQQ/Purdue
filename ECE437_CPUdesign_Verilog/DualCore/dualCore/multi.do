onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/iload
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dload
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/dstore
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/iaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ccwait
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ccinv
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ccwrite
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/cctrans
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ccsnoopaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramWEN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramREN
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramaddr
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramstore
add wave -noupdate -expand -group ccif /system_tb/DUT/CPU/ccif/ramload
add wave -noupdate -expand -group scif /system_tb/DUT/CPU/scif/ramREN
add wave -noupdate -expand -group scif /system_tb/DUT/CPU/scif/ramWEN
add wave -noupdate -expand -group scif /system_tb/DUT/CPU/scif/ramaddr
add wave -noupdate -expand -group scif /system_tb/DUT/CPU/scif/ramstore
add wave -noupdate -expand -group scif /system_tb/DUT/CPU/scif/ramload
add wave -noupdate -expand -group scif /system_tb/DUT/CPU/scif/ramstate
add wave -noupdate -expand -group scif /system_tb/DUT/CPU/scif/memREN
add wave -noupdate -expand -group scif /system_tb/DUT/CPU/scif/memWEN
add wave -noupdate -expand -group scif /system_tb/DUT/CPU/scif/memaddr
add wave -noupdate -expand -group scif /system_tb/DUT/CPU/scif/memstore
add wave -noupdate -expand -group ccstate /system_tb/DUT/CPU/CC/CLK
add wave -noupdate -expand -group ccstate /system_tb/DUT/CPU/CC/nRST
add wave -noupdate -expand -group ccstate /system_tb/DUT/CPU/CC/ccstate
add wave -noupdate -expand -group ccstate /system_tb/DUT/CPU/CC/ccnxt_state
add wave -noupdate -expand -group ccstate /system_tb/DUT/CPU/CC/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {655770 ns} {656770 ns}
