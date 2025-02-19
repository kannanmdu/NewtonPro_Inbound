tableextension 51000 "Purchase Header" extends "Purchase Header"
{
    fields
    {
        field(50100; Scanner; Text[100])
        {
            Caption = 'Scanner';
            DataClassification = ToBeClassified;
        }
        field(50101; Bin; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Bin';
            TableRelation = Bin.Code;
            ValidateTableRelation = true;

        }
        field(50102; OrderType; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = ,Backorder,Replenishment,"Backorder-DS";
        }

    }
}
