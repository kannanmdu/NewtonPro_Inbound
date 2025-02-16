page 51001 "Purchase Order Scan Page"
{
    ApplicationArea = All;
    Caption = 'Purchase Order Scan Page';
    PageType = Document;
    SourceTable = "Purchase Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Purchase Order Information';

                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    Editable = false;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ToolTip = 'Specifies the date when the order was created.';
                    Editable = false;
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    ToolTip = 'Specifies the name of the vendor who delivers the products.';
                    Editable = false;
                }
                field("Verifier"; Rec.Scanner)
                {
                    ApplicationArea = All;
                    Caption = 'Verifier';
                    Editable = false;
                }
                field("Scan Products"; "Scan Products")
                {
                    ApplicationArea = All;
                    Caption = 'Scan Product';
                    Editable = true;
                    trigger OnValidate()
                    begin
                        ValidateScannedProduct("Scan Products");
                        Clear("Scan Products")
                    end;

                }
                field(Bin; Rec.Bin)
                {
                    ApplicationArea = all;
                    Caption = 'Bin';
                    Editable = False;
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

            part(PurchaseOrderScanLines; "Purch. Order Scan Line Page")
            {
                ApplicationArea = all;
                Caption = 'Purchase Order Lines';
                SubPageLink = "Document No." = field("No.");
            }
        }

    }



    var
        "Scan Products": Text[100];
        "Verifier": Text[50];



    local procedure ValidateScannedProduct("Scan products": Text) "Line No.": Integer
    var

        PurchaseLineRec: Record "Purchase Line";
        PurchaseHeaderRec: Record "Purchase Header";

        InboundScanPage: Page "Inbound Scan Page";
        ItemNoTxt: text[100];
    begin
        CurrPage.SetFieldFocus.SetFocusOnField('Scan Products');


        if "Scan Products" = '' then
            Error('Product is required');
        ItemNoTxt := GetItemCodeFromBarcodeTxt("Scan Products");
        PurchaseLineRec.SetRange(PurchaseLineRec."Document No.", Rec."No.");
        PurchaseLineRec.SetRange(PurchaseLineRec."Document Type", PurchaseLineRec."Document Type"::Order);
        PurchaseLineRec.SetRange("No.", ItemNoTxt);
        if PurchaseLineRec.FindSet() then begin
            if not ((PurchaseLineRec."Qty. to Receive" + PurchaseLineRec."Outstanding Quantity") = PurchaseLineRec.Quantity) then begin
                //Message('Scan Completed');
                PurchaseLineRec.ShowReservation();
                Clear("Scan Products")
            end;
        end;
        repeat
            PurchaseLineRec."Qty. to Receive" := PurchaseLineRec."Qty. to Receive" + 1;
            PurchaseLineRec.Validate(PurchaseLineRec."Qty. to Receive");
            if (PurchaseLineRec."Qty. to Receive" + PurchaseLineRec."Outstanding Quantity") > PurchaseLineRec.Quantity then begin
                PurchaseLineRec.Modify();
                Clear("Scan Products")
            end
        until PurchaseLineRec.next() = 0;
        Clear("Scan products");
    end;
    //     Clear("Scan Products")
    // end;

    local procedure GetItemCodeFromBarcodeTxt(ScanProducts: Text) ReturnItemNo: Text[100]
    var
        ItemVariantRec: Record "Item Variant";
        PurchaseLineRec1: Record "Purchase Line";
    begin
        ItemVariantRec.reset();
        ItemVariantRec.setrange("UPC Code", ScanProducts);
        if ItemVariantRec.FindFirst() then begin
            ReturnItemNo := ItemVariantRec."Item No.";
        end
        else
            Error('Product Not Found');
    end;



}