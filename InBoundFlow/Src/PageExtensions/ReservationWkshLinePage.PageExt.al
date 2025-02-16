pageextension 51001 "Reservation Wksh. Line Page" extends "Reservation Worksheet"
{
    layout
    {
        addafter("Variant Code")
        {
            field("Ship Type"; Rec."Ship Type")
            {
                ApplicationArea = All;
                Caption = 'Ship Type';
                ToolTip = 'Specifies the value of the "Ship Type" field.', Comment = '%';
                trigger OnValidate()
                var
                    SalesHeaderRec: Record "Sales Header";
                begin

                    SalesHeaderRec.SetRange(SalesHeaderRec."No.", rec."Source ID");
                    if SalesHeaderRec.FindSet() then
                        Rec."Ship Type" := SalesHeaderRec."Ship Type";

                end;
            }
        }
    }
}
