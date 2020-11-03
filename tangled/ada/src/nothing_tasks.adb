with System.Multiprocessors;
use System.Multiprocessors;
with System.Multiprocessors.Dispatching_Domains;
use System.Multiprocessors.Dispatching_Domains;

with Ada.Task_Identification;
use Ada.Task_Identification;
with Ada.Text_IO;
use Ada.Text_IO;

procedure Nothing_Tasks is

task type Nothing_Task is
    --  Uncomment the following pragma tu run all tasks on the second CPU.
    --  pragma CPU (2);
    --  pragma Priority (2);
    --  pragma Dispatching_Domain (The_Domain);
end Nothing_Task;

task body Nothing_Task is
    I : Positive;
begin
    loop
        --  Do just the same... nothing!
        I := 1;
        I := I + 1;
    end loop;
end Nothing_Task;

Nothing : array (1 .. 10) of Nothing_Task;

begin
    Put_Line ("Main thread");

    Put_Line ("CPU detected: "
                & CPU'Image (Number_Of_CPUs));

    for I of Nothing loop
        Put ("Task " & Image (I'Identity) & ": ");
        if Get_CPU (I'Identity) = Not_A_Specific_CPU then
            Put_Line ("CPU assigned: Not specified (0 value)");
        else
            Put_Line ("CPU assigned:" & CPU'Image (Get_CPU (I'Identity)));
        end if;
    end loop;

    Put_Line ("End of main thread");
end Nothing_Tasks;
