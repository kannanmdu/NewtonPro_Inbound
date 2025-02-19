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
                    Caption = 'Select Bin';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        BinRec: Record Bin;
                        BinListPage: Page "Bin Lookup";
                    begin
                        BinRec.Reset();
                        BinRec.SetRange(BinRec.Assigned, false);
                        BinRec.SetRange(BinRec."Temp Bin", true);
                        BinListPage.SetTableView(BinRec);
                        if page.RunModal(Page::"Bin Lookup", BinRec) = Action::LookupOK then
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

