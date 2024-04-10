report 50000 "Customers_PRUEBA_CURSO"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    DefaultLayout = RDLC;

    RDLCLayout = '.\\ReportsLayout\Customers.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(TypeC; 'Customer')
            {

            }
            column(NameC; Name)
            {

            }
            column(Facturas; Factura)
            {

            }
            dataitem("Sales Header"; "Sales Header")
            {
                DataItemLink = "Sell-to Customer No." = field("No.");
                DataItemTableView = where("Document Type" = const(Order));
                column(No_; "No.")
                {

                }
            }
            trigger OnPreDataItem()
            begin
                "Customer".SetFilter("No.", tCustomer);
            end;

            trigger OnAfterGetRecord()
            var
                rInvoice: Record "Sales Invoice Header";

            begin
                rInvoice.SetRange("Sell-to Customer No.", Customer."No.");
                dFacturas := rInvoice.Count();

            end;
        }

        dataitem(Vendor; Vendor)
        {
            column(TypeV; 'Vendor')
            {

            }
            column(NameV; Name)
            {

            }
        }

    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(FIlterCustomer; tCustomer)
                    {
                        Caption = 'Customer filter', Comment = ' ESP = " Filtro CLiente"';
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }



    var
        tCustomer: Text;
        dFacturas: Decimal;

}