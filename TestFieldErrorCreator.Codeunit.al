codeunit 50100 "TestFieldErrorCreator"
{
    procedure TestFieldOnFirstCustomer(CustomerNo: Code[20])
    var
        Customer: Record Customer;
    begin
        Customer.FindFirst();
        Customer.TestField("No.", CustomerNo);
    end;
}