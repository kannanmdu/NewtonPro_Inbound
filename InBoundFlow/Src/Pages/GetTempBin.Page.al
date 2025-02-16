page 51003 "Get Temp Bin"
{
    ApplicationArea = All;
    Caption = 'Get Temp Bin';
    PageType = StandardDialog;
    SourceTable = "Purchase Header";

    layout
    {
        area(Content)
        {
            group("Bin Selection")

            {
                Caption = 'Bin Selection';


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

