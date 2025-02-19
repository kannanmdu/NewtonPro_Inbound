pageextension 51000 "Purchase Order" extends "Purchase Order"
{
    layout
    {
        addafter("Quote No.")
        {
            field("Scan Products"; "Scan Products")
            {
                ApplicationArea = All;
                Caption = 'Scan Product';
                Editable = true;
                trigger OnValidate()
                var
                    ItemRec: Record Item;
                    PurchaseLineRec: Record "Purchase Line";
                    PurchaseHeaderRec: Record "Purchase Header";
                    InboundScanPage: Page "Inbound Scan Page";
                begin
                    CurrPage.SetFieldFocus.SetFocusOnField('Scan Products');



                    if "Scan Products" = '' then
                        Error('Product is required');
                    PurchaseLineRec.SetRange("Document Type", Rec."Document Type"::Order);
                    PurchaseLineRec.SetRange(Type, PurchaseLineRec.Type::Item);
                    PurchaseLineRec.SetRange("Document No.", Rec."No.");
                    PurchaseLineRec.SetRange("No.", "Scan Products");
                    if PurchaseLineRec.FindSet() then begin
                        repeat
                            Message('Line No. %1', PurchaseLineRec."Line No.");
                        until PurchaseLineRec.Next() = 0;
                        Clear("Scan Products");
                    end
                    else
                        Error('Product not found');

                end;
            }
            field("Verifier"; "Verifier")
            {
                ApplicationArea = All;
                Caption = 'Receiver';
                Editable = true;

            }
            field(Bin; Rec.Bin)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Bin field.', Comment = '%';
                Caption = 'Bin';
                Editable = False;
            }
            field(OrderType; Rec.OrderType)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the OrderType field.', Comment = '%';
                Caption = 'Order Type';
                Editable = true;
            }



            usercontrol(SetFieldFocus; SetFieldFocus)
            {
                ApplicationArea = All;
                trigger Ready()
                begin
                    CurrPage.SetFieldFocus.SetFocusOnField('Scan Products');
                end;
            }

        }
    }
    var
        "Scan Products": Text[100];
        "Verifier": Text[50];
}
