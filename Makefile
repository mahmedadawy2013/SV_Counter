all: 	compile sim

compile:
		vlib work
		vlog -sv tb.sv intf.sv counter.sv
compile_counter:
		vlib work
		vlog -sv counter.sv
compile_intf:
		vlib work
		vlog -sv intf.sv 
compile_transaction:
		vlib work
		vlog -sv transaction.sv
compile_generator:
		vlib work
		vlog -sv generator.sv
compile_driver:
		vlib work
		vlog -sv driver.sv 
compile_monitor:
		vlib work
		vlog -sv monitor.sv 
compile_scoreboard:
		vlib work
		vlog -sv scoreboard.sv
compile_subscriber:
		vlib work
		vlog -sv subscriber.sv 
sim:
		vsim -logfile sim.log -c -do "run -all" work.tb

wave:
		vsim work.tb -voptargs=+acc
