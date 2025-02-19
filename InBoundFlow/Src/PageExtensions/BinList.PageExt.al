pageextension 51002 "Bin List" extends "Bin List"
{
    layout
    {
        addafter(Description)
        {
            field("Temp Bin"; Rec."Temp Bin")
            {
                ApplicationArea = All;
                Caption = 'Temp Bin';
                ToolTip = 'Specifies the value of the "Temp Bin" field.', Comment = '%';
                Editable = true;
            }
            field("Receiving Bin"; Rec."Receiving Bin")
            {
                ApplicationArea = All;
                Caption = 'Receiving Bin';
                ToolTip = 'Specifies the value of the "Assignment Bin" field.', Comment = '%';
                Editable = true;
            }
            field(Assigned; Rec.Assigned)
            {
                ApplicationArea = All;
                Caption = 'Assigned';
                ToolTip = 'Specifies the value of the Assigned field.', Comment = '%';
                Editable = true;
            }
        }
    }
}
