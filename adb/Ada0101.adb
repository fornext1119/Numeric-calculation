with TEXT_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;
use  TEXT_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;

procedure Ada0101 is
begin
    Put(3 + 5);              New_Line;
    Put(3 + 5,   Width=> 0); New_Line;
    Put(3 * 5,   Width=> 0); New_Line;
    Put(3 ** 5,  Width=> 0); New_Line;
    Put(5 / 3,   Width=> 0); New_Line;
    Put(5 mod 3, Width=> 0); New_Line;
    Put(5 rem 3, Width=> 0); New_Line;
    
    Put(Float(5) / Float(3)                          ); New_Line;
    Put(Float(5) / Float(3),                   Exp=>0); New_Line;
    Put(Float(5) / Float(3),          Aft=>10, Exp=>0); New_Line;
    Put(Float(5) / Float(3), Fore=>5, Aft=>10, Exp=>0); New_Line;
end Ada0101;
