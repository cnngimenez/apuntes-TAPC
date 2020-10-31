with Ada.Containers.Vectors;
with Ada.Text_IO;
use Ada.Text_IO;

procedure Producer_Consumer is

package Data_Vectors is new Ada.Containers.Vectors
  (Element_Type => Integer,
   Index_Type => Positive);

task type Consumer_Task is
    entry Initialize (The_Id : Integer);
end Consumer_Task;

task type Producer_Task is
    entry Initialize (The_Id : Integer);
end Producer_Task;

Maximum_Element : constant Integer := 10000;
Data : Data_Vectors.Vector;
Current_Element : Integer := Maximum_Element;

task body Consumer_Task is
    Element : Integer;
    Id : Integer;
begin

accept Initialize (The_Id : Integer) do
    Id := The_Id;
    Put_Line ("T" & Id'Image & "> Consumer initialized.");
end Initialize;

while Current_Element > 0 loop
    Element := Data.First_Element;
    Data.Delete_First;

    Put_Line ("T" & Id'Image & "> Consumed element:");
    Put_Line ("    " & Element'Image);
end loop;

Set_Colour (Green);
    Put_Line ("T" & Id'Image & "> Consumer ended.");
    Default_Colour;

end Consumer_Task;

task body Producer_Task is
    Id : Integer;
begin

accept Initialize (The_Id : Integer) do
    Id := The_Id;
    Put_Line ("T" & Id'Image & "> Producer initialized.");
end Initialize;

while Current_Element > 0 loop
    Data.Append (Current_Element);

    Put_Line ("T" & Id'Image & "> Produced element:");
    Put_Line ("    " & Current_Element'Image);

    Current_Element := Current_Element - 1;
end loop;

Put_Line ("T" & Id'Image & "> Producer ended.");

end Producer_Task;

Producers : array (1 .. 20) of Producer_Task;
    Consumers : array (1 .. 20) of Consumer_Task;
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
end Producer_Consumer;
