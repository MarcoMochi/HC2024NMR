# HC2024NMR
Repository containing the rescheduling ASP encoding and instances of the paper "Nuclear Medicine Rescheduling Problem: A Logic-based approach"

# Clingo Installation 
Installation instructions for different Operating Systems building from sources or using Anaconda for Clingo v5.6.2 can be found here: https://github.com/potassco/clingo/blob/master/INSTALL.md, https://potassco.org/clingo/, https://github.com/potassco/clingo/releases/tag/v5.6.2


There are 2 main folders, one containing the ASP encoding and the other the instances.
Inside the Encoding folder, there is the ASP encoding as presented in the paper.
Inside the Input folder, there are 3 subfolders, each corresponding to one Scenario: low, medium, and high. There are 9 instances in each folder. The instances are named following this schema: "input_N-REG_N-EXAM.lp", where N-REG and N-EXAM are the numbers of new registrations and patients with delay, respectively. E.g. input_0_1.lp means that in the instance there are no new registrations and one patient with delay. 

To run the file you can execute the following command: 

```./clingo Encoding/reschedule.lp Input/SCENARIO/input_N-REG_N-EXAM.lp --opt-strategy=usc --parallel-mode 4```
