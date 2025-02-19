tableextension 51002 Bin extends Bin
{
    fields
    {
        field(51000; "Temp Bin"; Boolean)
        {
            Caption = 'Temp Bin';
            DataClassification = ToBeClassified;
        }
        field(51001; "Receiving Bin"; Boolean)
        {
            Caption = 'Receiving Bin';
            DataClassification = ToBeClassified;
        }
        field(51002; Assigned; Boolean)
        {
            Caption = 'Assigned';
            DataClassification = ToBeClassified;
        }
    }
}
