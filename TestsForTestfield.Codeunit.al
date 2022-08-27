codeunit 50101 "TestsForTestfield"
{
    Description = 'Tests for test field';
    Subtype = Test;

    var
        Assert: Codeunit Assert;
        LibraryRandom: Codeunit "Library - Random";
        LibrarySetupStorage: Codeunit "Library - Setup Storage";
        LibraryTestInitialize: Codeunit "Library - Test Initialize";
        IsInitialized: Boolean;

    [Test]
    procedure TestFieldOnFirstCustomerTest()
    var
        TestFieldErrorCreator: Codeunit TestFieldErrorCreator;
    begin
        Initialize();
        asserterror TestFieldErrorCreator.TestFieldOnFirstCustomer('TestValue');
        Assert.ExpectedError('No. must be equal to ''TESTVALUE'' in Customer: No.=10000. Current value is ''10000''.');
    end;


    trigger OnRun();
    begin
        IsInitialized := false;
    end;

    local procedure Initialize();
    begin
        LibraryTestInitialize.OnTestInitialize(Codeunit::TestsForTestfield);
        ClearLastError();
        LibrarySetupStorage.Restore();
        if IsInitialized then
            exit;

        LibraryTestInitialize.OnBeforeTestSuiteInitialize(Codeunit::TestsForTestfield);

        LibraryRandom.Init();

        // CUSTOMIZATION: Prepare setup tables etc. that are used for all test functions


        IsInitialized := true;
        Commit();

        // CUSTOMIZATION: Add all setup tables that are changed by tests to the SetupStorage, so they can be restored for each test function that calls Initialize.
        // This is done InMemory, so it could be run after the COMMIT above
        //   LibrarySetupStorage.Save(DATABASE::"[SETUP TABLE ID]");

        LibraryTestInitialize.OnAfterTestSuiteInitialize(Codeunit::TestsForTestfield);
    end;
}