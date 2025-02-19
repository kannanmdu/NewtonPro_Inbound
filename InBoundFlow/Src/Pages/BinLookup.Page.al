page 51005 "Bin Lookup"
{
    ApplicationArea = All;
    Caption = 'Bin Lookup';
    PageType = List;
    SourceTable = Bin;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies a code that uniquely describes the bin.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies a description of the bin.';
                }
                field("Receiving Bin"; Rec."Receiving Bin")
                {
                    ToolTip = 'Specifies the value of the "Assignment Bin" field.', Comment = '%';
                }
                field("Temp Bin"; Rec."Temp Bin")
                {
                    ToolTip = 'Specifies the value of the "Temp Bin" field.', Comment = '%';
                }
            }
        }
    }
}
