# DutyCounter
This is a simple Verilog project to measure the duty of a PWM wave.  
这是一个检测PWM波形占空比的Verilog项目。
## To begin with
程序利用Artix-7开发板上自带的100MHz时钟，使用两个计数器分别记录PWM波形输入高电平和低电平的时间，并由此算出周期。 
程序将会在FPGA开发板（本样例中使用Basys3）的JA1针脚读取输入的波形，并在JB1针脚输出高电平时间，在JB2针脚输出周期。  
通过以上的两个输出值即可计算出占空比，占空比计算公式为 ![Duty](https://github.com/Minaduki-Shigure/DutyCounter/blob/master/Duty.gif?raw=true) 。  
项目包含四个主要的源文件，为`top.v`、`out.v`、`para2serial.v`和`PWM_cnt.v`,同时包含一个仿真文件`DutyCounter_tb.v`.
## About `top.v`
该文件为项目的顶层文件，输入为`CLK`(连接到板上时钟)和`PWM_in`(连接到外部输入波形)，输出为`High_time`和`Cycle_time`，即高电平时间和总周期。  
## About `PWM_cnt.v`
该文件为核心的计数代码，由于最长的周期为1s，最大的占空比为90%，因此，最长的计数应当为90M个时钟周期，对应二进制`‭0101_0101_1101_0100_1010_1000_0000‬`，
因此需要27位计数器，最长的周期为100M个时钟周期，对应`‭0101_1111_0101_1110_0001_0000_0000‬`，也需要27位寄存器来存储。  
当输入波形发生跳变时，开始对应状态的计时器，并且将另一状态的计时结果送入缓冲区，然后清零。输出的计数值与缓冲区的值同步。
## About `para2serial.v`
计数器输出的值为并行输出，输出高达27位，而如果要同时传输高电平时间和总周期需要54位并行传输，这是不现实的，由于最大要求能够辨识的频率也只要5MHz，所以
完全可以选择使用串行的方式输出。  
该文件为将并行信号转为串行信号的模块，输出开始的信号为load，将由下一个文件进行定义。。  
本文件可以自定义输入并行信号的位宽，默认为27位。闲置时，输出恒为低电平，当输出开始时，输出一个高电平作为输出开始的标志，之后的N位为输出内容。  
## About `out.v`
该文件负责控制开始串行转换并传输输出信号的时机。  
由于`High_time`和`Cycle_time`的输出彼此之间是并行的，因此传输完一次需要28个时钟周期。所以选择每50个时钟周期周期发送一次。
_如果要将输出改为全串行，则发送周期最小为100个时钟周期。_  
当计时器计满50后，在下一个周期将flag_reg置为1，同时与之同步的flag也会产生一个脉冲，控制串行转换模块开始工作。
## About `DutyCounter_tb.v` (Test Bench)
仿真环境中，将CLK设置为`#5 CLK = ~CLK;` 即时钟周期为10ns。  
输入的PWM波形为一个周期为2000ns，占空比为75%的PWM波。  
![DutyCounter_tb_result](https://github.com/Minaduki-Shigure/DutyCounter/blob/master/TestBench.png?raw=true)  
观察下图示波器图像，可以看出输出的串行传输的值和输出的周期均符合要求。  
![DutyCounter_tb_scope](https://github.com/Minaduki-Shigure/DutyCounter/blob/master/TestBench_1.png?raw=true)  
通过下图变量窗口可以看到电路内部并行传输的中间值，其中高电平时间为150个时钟周期，低电平时间为50个时钟周期，总周期为200个时钟周期，与输入波形相符。  
![DutyCounter_tb_variables](https://github.com/Minaduki-Shigure/DutyCounter/blob/master/TestBench_2.png?raw=true)  
综上所述，本项目基本满足要求。
