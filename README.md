# HomeWork3_Part3

You are going to create parts of a Synchronization FIFO.
- Create a 16-bit x 1K (1024) Simple Dual-Port RAM (SDPRAM) by inferring it (rather than instantiating it from the vendor libraries). In this SDPRAM we are going to have a read clock rd_clk and a write clock wr_clk. Look for how to infer RAM for Polarfire devices. We are going to assume that we cannot read and write at the same time. So you will need to create a RAM attribute to indicate “no_rw_check”.Again, this should be in the same document.
- Taking as a reference the FIFO synchronizer in slice 135, create a Write side of the logic that when the RAM is not “busy”, passes a 1-bit signal to indicate that a 16-bit word was written. Then, pass this signal to the read domain and synchronize it using a 3 flip-flop bit synchronizer. On the read side, use this signal to read the value. At the same time, send back the read control bit to the write domain (as in a handshake synchronizer) to indicate that the RAM is not busy any longer. A RAM needs addresses, you should start writing to 0, and increment on each write. Likewise for the read domain.
- Note that the resets are asynchronous are need to be synchronized. The resets are used for the pointer and control logic. NOT for the RAM.

The original diagram to implement is
![](https://github.com/rafacc1414/HomeWork3_Part3/blob/main/Images/P3OriginalScheme.png)

What we are actually going to implement after a long time thinking about the behaviour of these diagram is what we see in the next figure. 
![](https://github.com/rafacc1414/HomeWork3_Part3/blob/main/Images/P3Diagram.JPG)


Apart from that, I created some directories which I am going to explain: 
- Codigos_VHD: This folder contains the esential VHDL code to sinthesise the project 
- FMS_Address: Contains just these component with its testbench to verifies its behaiviour
- Images: Contains all the images used in this github project
- rev1: It has the files that synplify creates automatically after sinthethise.
- Sinchroniser: It has just the Sinchroniser component with its testbench
- WriteController: It contains the WriteController component with its testbench

Apart from that, the files __implementarion.prd__ and __implementation.prj__ are the ones created by the synplify. 
__implementation.prj__  can be open as a project in synplify.
