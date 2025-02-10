page 51002 "Purch. Order Scan Line Page"
{
    ApplicationArea = All;
    Caption = 'Purch. Order Scan Line Page';
    PageType = ListPart;
    SourceTable = "Purchase Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the blanket purchase order.';
                }
                field(Color; Rec.Color)
                {
                    ToolTip = 'Specifies the value of the Color field.', Comment = '%';
                }
                field("Base Curve "; Rec."Base Curve ")
                {
                    ToolTip = 'Specifies the value of the Base Curve field.', Comment = '%';
                }
                field(Diameter; Rec.Diameter)
                {
                    ToolTip = 'Specifies the value of the Diameter field.', Comment = '%';
                }
                field(Power; Rec.Power)
                {
                    ToolTip = 'Specifies the value of the Power field.', Comment = '%';
                }
                field(Cylinder; Rec.Cylinder)
                {
                    ToolTip = 'Specifies the value of the Cylinder field.', Comment = '%';
                }
                field(Axis; Rec.Axis)
                {
                    ToolTip = 'Specifies the value of the Axis field.', Comment = '%';
                }
                field("Add Power"; Rec."Add Power")
                {
                    ToolTip = 'Specifies the value of the Add Power field.', Comment = '%';
                }
                field("Add Type"; Rec."Add Type")
                {
                    ToolTip = 'Specifies the value of the Add Type field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the quantity of the purchase order line.';
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    ToolTip = 'Specifies the quantity of items that remains to be received.';
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ToolTip = 'Specifies how many units of the item on the line have been posted as received.';
                }
            }
        }
    }
}
