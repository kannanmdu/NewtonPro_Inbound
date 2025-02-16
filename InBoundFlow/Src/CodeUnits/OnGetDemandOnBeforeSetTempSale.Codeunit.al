codeunit 51001 OnGetDemandOnBeforeSetTempSale
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Get Demand To Reserve", 'OnGetDemandOnBeforeSetTempSalesLine', '', false, false)]
    local procedure OnGetDemandOnBeforeSetTempSalesLine(var SalesLine: Record "Sales Line"; var IsHandled: Boolean)

    var

        SalesHeaderRec: Record "Sales Header";

    begin

        SalesHeaderRec.SetFilter("No.", Salesline."Document No.");
        if SalesHeaderRec.FindFirst() then begin
            SalesLine."Ship Type" := SalesHeaderRec."Ship Type";
            SalesLine.Modify();

        end;



    end;


}
