page 51004 "Assign Bin"
{
    ApplicationArea = All;
    Caption = 'Assign Bin';
    PageType = StandardDialog;
    SourceTable = "Purchase Header";

    layout
    {
        area(Content)
        {
            group("Bin Selection")
            {
                Caption = 'Bin Selection';

                label(InfoLabel)
                {
                    Caption = 'Please select a bin from the list below:';
                    ApplicationArea = all;
                    Style = Strong;
                    ToolTip = 'This label provides instructions for selecting a bin.';
                }

                field(SelectBin; SelectBin)
                {
                    Visible = true;
                    ApplicationArea = all;
                    Editable = True;
                    TableRelation = Bin.Code;
                    DrillDownPageId = "Bin List";
                    trigger OnValidate()
                    begin
                        Rec.Bin := SelectBin;
                        Rec.Modify(false);
                        Page.Run(Page::"Purchase Order Scan Page", Rec, Rec."No.");
                    end;
                }
            }
        }
    }

    var
        SelectBin: Code[20];
}