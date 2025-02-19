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
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        BinRec: Record Bin;
                        BinListPage: Page "Bin Lookup";
                    begin
                        BinRec.Reset();
                        BinRec.SetRange(BinRec.Assigned, false);
                        BinRec.SetRange(BinRec."Receiving Bin", true);
                        BinListPage.SetTableView(BinRec);
                        if page.RunModal(Page::"Bin Lookup", BinRec) = Action::LookupOK then
                            SelectBin := BinRec.Code;
                        Rec.Bin := BinRec.Code;
                        Page.Run(Page::"Purchase Order Scan Page", Rec, Rec."No.");
                        Rec.Validate("Bin");

                    end;

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