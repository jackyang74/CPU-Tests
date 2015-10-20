# CPU-Tests 

* 安装MIPS-GCC，在[https://www.mentor.com/embedded-software/sourcery-tools/sourcery-codebench/editions/lite-edition/]下载MIPS Processors GNU/LINUX Release，选择Windows或Linux版本均可。
* 在single-cycle文件夹中，
	* start.S为起始汇编代码，_reset为CPU reset后的入口地址，可以在此编写自己的汇编测试代码。
	* ram-board.ld为链接脚本文件，控制输出文件内各部分在内地址空间中的布局，如果你的存储器地址范围不是从0开始，你需要修改SECTIONS字段。
	* Makefile会寻找当前目录下所有的*.S和\*.C件，编译生成boot可执行文件，是基于MIPS指令的可执行文件。boot.bin是从boot中抽取的二进制信息。code.txt为反汇编文件，这个在后面编译C语言程序时会用到。ram.txt是我编写的python小程序讲boot.bin转换为verilog可以接受的文本形式。这样，就可以在存储器代码中，使用$readmemh为你的存储器赋予初始值，这些初始值可以用来仿真，也可以下载到板子上。
* 测试说明
	* 修改start.S 文件为自己的汇编测试代码
	* 在single-cycle目录下，执行make命令。查看用code.txt中反汇编信息是否正确，同时将ram.txt中的内容复制到自己的ram初始化文件中。

