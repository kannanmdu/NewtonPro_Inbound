codeunit 51000 "Allocate Reserv Ship Type" implements "Allocate Reservation"
{




    var
        DescriptionTxt: Label 'Distribution based on Ship  Type field in the Sales Order. The program will automatically fulfill all demands when the existing stock is sufficient. In cases of insufficient quantities, the system will prioritize supplying orders with the highest priority by Ship Type.';


    procedure Allocate(var ReservationWkshLine: Record "Reservation Wksh. Line")
    var
        ReservWkshLine: Record "Reservation Wksh. Line";
        SalesHeaderRec: Record "Sales Header";
    begin
        Message('Allocate');
        SalesHeaderRec.SetFilter("No.", ReservationWkshLine."Source ID");
        if SalesHeaderRec.FindFirst() then begin
            ReservationWkshLine."Ship Type" := SalesHeaderRec."Ship Type";
            ReservWkshLine.Copy(ReservationWkshLine);
            ReservWkshLine.FilterGroup := 2;
            ReservWkshLine.SetFilter("Item No.", ReservationWkshLine.GetFilter("Item No."));
            ReservWkshLine.SetFilter("Variant Code", ReservationWkshLine.GetFilter("Variant Code"));
            ReservWkshLine.SetFilter("Location Code", ReservationWkshLine.GetFilter("Location Code"));
            ReservWkshLine.FilterGroup := 0;
            ReservWkshLine.SetCurrentKey("Journal Batch Name", "Item No.", "Variant Code", "Location Code", "Ship Type");
            ReservWkshLine.Ascending(false);
            if not ReservWkshLine.FindSet(true) then
                exit;

            repeat
                ReservWkshLine.SetRange("Item No.", ReservWkshLine."Item No.");
                ReservWkshLine.SetRange("Variant Code", ReservWkshLine."Variant Code");
                ReservWkshLine.SetRange("Location Code", ReservWkshLine."Location Code");
                ReservWkshLine.SetRange("Ship Type", ReservWkshLine."Ship Type");
                ReservWkshLine.CalcSums("Qty. to Reserve (Base)", "Rem. Qty. to Reserve (Base)");
                if ReservWkshLine."Qty. to Reserve (Base)" + ReservWkshLine."Avail. Qty. to Reserve (Base)" >= ReservWkshLine."Rem. Qty. to Reserve (Base)"
                then begin
                    ReservWkshLine.FindSet(true);
                    repeat
                        if not ReservWkshLine.Accept then begin
                            ReservWkshLine.Validate("Qty. to Reserve", ReservWkshLine."Remaining Qty. to Reserve");
                            ReservWkshLine.Modify(true);
                        end;
                    until ReservWkshLine.Next() = 0;
                end else
                    if ReservWkshLine."Rem. Qty. to Reserve (Base)" = 0 then
                        exit;
                ReservWkshLine.FindLast();
                ReservWkshLine.SetRange("Item No.");
                ReservWkshLine.SetRange("Variant Code");
                ReservWkshLine.SetRange("Location Code");
                ReservWkshLine.SetRange("Ship Type");
            until ReservWkshLine.Next() = 0;
        end;
    end;

    procedure AllocationCompleted(var ReservationWkshLine: Record "Reservation Wksh. Line"): Boolean
    var
        ReservWkshLine: Record "Reservation Wksh. Line";
    begin
        ReservWkshLine.Copy(ReservationWkshLine);
        ReservWkshLine.SetRange(Accept, false);
        exit(ReservWkshLine.IsEmpty());
    end;

    procedure DeleteAllocation(var ReservationWkshLine: Record "Reservation Wksh. Line")
    begin

    end;

    procedure GetDescription(): Text
    begin
        exit(DescriptionTxt);
    end;



}
