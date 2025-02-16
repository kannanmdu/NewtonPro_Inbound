enumextension 51000 "Allocation Policies" extends "Allocation Rules Impl."
{

    value(51000; "By Ship Type")
    {
        Caption = 'By Ship Type';
        Implementation = "Allocate Reservation" = "Allocate Reserv Ship Type";
    }
}
