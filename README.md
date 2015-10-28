# CPU-Tests 

* 安装MIPS-GCC，在[https://www.mentor.com/embedded-software/sourcery-tools/sourcery-codebench/editions/lite-edition/]下载MIPS Processors GNU/LINUX Release，选择Windows或Linux版本均可。
* 在single-cycle文件夹中，
	* start.S为起始汇编代码，_reset为CPU reset后的入口地址，可以在此编写自己的汇编测试代码。
	* ram-board.ld为链接脚本文件，控制输出文件内各部分在内地址空间中的布局，如果你的存储器地址范围不是从0开始，你需要修改SECTIONS字段。
	* Makefile会寻找当前目录下所有的*.S和*.C件，编译生成目标文件。
* 测试说明
	* 将自己的汇编测试代码添加到start.S中
	* 在single-cycle目录下，执行make命令，会生成boot、boot.bin、code.txt、ram.txt等文件。boot是基于MIPS指令的可执行文件，boot.bin是从boot文件中抽取的二进制信息。code.txt为反汇编文件，可以检查编译后的代码是否符合要求。ram.txt为存储器数据初始化文件，由python程序utils/bin2text.py将boot.bin转换得到。将ram.txt中的数据复制到你的存储器初始化文件中，使用$readmemh为你的存储器赋予初始值。这些初始值可以用来仿真，也可以下载到板子上。


