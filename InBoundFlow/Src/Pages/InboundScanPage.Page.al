page 51000 "Inbound Scan Page"
{
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Inbound Scan Page';
    PageType = Card;
    Editable = true;



    layout
    {
        area(Content)
        {
            grid(General)
            {
                GridLayout = Rows;
                Caption = '';
                field("Scan Verifier Name"; "Scan Verifier Name")
                {
                    ApplicationArea = All;
                    Caption = 'Verifier Name';
                    Editable = true;

                    trigger OnValidate()

                    begin
                        if "Scan Verifier Name" = '' then
                            Error('Verifier Name is required');



                    end;
                }


                field("Scan Purchase Order"; "Scan Purchase Order")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Caption = 'Purchase Order';
                    trigger OnValidate()
                    var

                        PurchaseHeaderRec: Record "Purchase Header";
                        PurchaseOrderPage: Page "Purchase Order";

                    begin
                        if "Scan Purchase Order" = '' then
                            Error('Purchase Order is required');
                        PurchaseHeaderRec.SetRange(PurchaseHeaderRec."Document Type", PurchaseHeaderRec."Document Type"::Order);
                        PurchaseHeaderRec.SetRange(PurchaseHeaderRec."No.", "Scan Purchase Order");
                        if not PurchaseHeaderRec.FindFirst() then
                            Error('Purchase Order not found');
                        if PurchaseHeaderRec."Status" <> PurchaseHeaderRec.Status::Released then
                            Error('Purchase Order is not released');
                        if PurchaseHeaderRec."Status" = PurchaseHeaderRec.Status::Released then begin
                            PurchaseHeaderRec.Init();
                            PurchaseHeaderRec.Scanner := "Scan Verifier Name";
                            Page.RunModal(Page::"Purchase Order Scan Page", PurchaseHeaderRec, PurchaseHeaderRec."No.");
                        end;
                    end;

                }

            }
        }
    }
    var

        "Scan Verifier Name": Text[50];
        "Scan Purchase Order": Text[100];
}
