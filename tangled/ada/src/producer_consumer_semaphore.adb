with Ada.Containers.Vectors;
with Ada.Text_IO;
use Ada.Text_IO;
with GNAT.Semaphores;
use GNAT.Semaphores;

procedure Producer_Consumer_Semaphore is

Consumers_Count : constant Positive := 20;
Producers_Count : constant Positive := 20;
Maximum_Element : constant Integer := 10000;

Data_Semaphore : Counting_Semaphore
  (Initial_Value => 0,
  Ceiling => Default_Ceiling);
Current_Element_Semaphore : Binary_Semaphore
  (Initially_Available => True,
   Ceiling => Default_Ceiling);

package Data_Vectors is new Ada.Containers.Vectors
  (Element_Type => Integer,
   Index_Type => Positive);

Data : Data_Vectors.Vector;

task type Consumer_Task is
    --  Give an ID to the Task instance.
    entry Initialize (The_Id : Integer);
end Consumer_Task;

task type Producer_Task is
    --  Give an ID to the Task instance.
    entry Initialize (The_Id : Integer);
end Producer_Task;

task type Count_Task is
    entry Add_Consumer (Id : Integer);
end Count_Task;

Counter : Count_Task;

task body Consumer_Task is
    Element : Integer;
    Id : Integer;

    procedure Consume_Element;
    procedure Show (S : String);

    procedure Consume_Element is
    begin
        Element := Data.First_Element;
        Data.Delete_First;

        Show ("Consumed element:" & Element'Image);
    end Consume_Element;

    procedure Show (S : String) is
    begin
        Put_Line ("C" & Id'Image & "> " & S);
    end Show;
begin

accept Initialize (The_Id : Integer) do
    Id := The_Id;
    Show ("Consumer initialized.");
end Initialize;

loop
    Data_Semaphore.Seize;

Current_Element_Semaphore.Seize;
exit when Current_Element <= Consumers_Count and then
  Natural (Data.Length) <= Consumers_Count;
Current_Element_Semaphore.Release;

Consume_Element;
    Data_Semaphore.Release;
end loop;

Current_Element_Semaphore.Release;

    Consume_Element;

    Counter.Add_Consumer (Id);
    Show ("Consumer ended.");
end Consumer_Task;

task body Count_Task is
    Counter : Natural := 0;
begin

loop
    accept Add_Consumer (Id : Integer) do
        Put_Line ("Counter> Consumer " & Id'Image
                    & " registered.");
        Counter := Counter + 1;
        Put_Line ("Counter> Number: " & Counter'Image
                    & "/" & Consumers_Count'Image);

    end Add_Consumer;

    exit when Counter = Consumers_Count;
end loop;

Put_Line ("Counter> All consumer endings registered.");
    Put_Line ("Counter> Data not consumed:" & Data.Length'Image);
end Count_Task;

task body Producer_Task is
    Id : Integer;

    procedure Show (S : String);
    procedure Produce_Element;

    procedure Produce_Element is
    begin
        Data.Append (Current_Element);
        Show ("Produced element:" & Current_Element'Image);

        Current_Element := Current_Element - 1;
    end Produce_Element;

    procedure Show (S : String) is
    begin
        Set_Colour (Red);
        Put_Line ("P" & Id'Image & "> " & S);
        Default_Colour;
    end Show;

begin

accept Initialize (The_Id : Integer) do
    Id := The_Id;
    Show ("Producer initialized.");
end Initialize;

Current_Element_Semaphore.Seize;

if Current_Element <= 0 then
    Show ("Exiting");
    Current_Element_Semaphore.Release;

    --  enough data produced! get out of the loop!
    exit when Current_Element <= 0;
end if;

Produce_Element;

    Data_Semaphore.Release;
    Current_Element_Semaphore.Release;
end loop;

Show ("Producer ended.");
end Producer_Task;

Producers : array (1 .. Producers_Count) of Producer_Task;
    Consumers : array (1 .. Consumers_Count) of Consumer_Task;
    I : Integer := 0;
begin
    Put_Line ("Main thread");

for Producer of Producers loop
    Producer.Initialize (I);
    I := I + 1;
end loop;

for Consumer of Consumers loop
    Consumer.Initialize (I);
    I := I + 1;
end loop;

Put_Line ("End of main thread");
end Producer_Consumer_Semaphore;

Current_Element : Integer := Maximum_Element;
