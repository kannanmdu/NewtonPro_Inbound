tableextension 51001 "Reservation Wksh. Line" extends "Reservation Wksh. Line"
{
    fields
    {
        field(51000; "Ship Type"; Option)
        {
            Caption = '"Ship Type"';
            DataClassification = ToBeClassified;
            OptionMembers = "Office Ship","Cross Ship","Drop Ship";
        }
    }



}
