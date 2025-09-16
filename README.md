static void Main(string[] args)
{
    if (Environment.UserInteractive || args.Contains("--console"))
    {
        // Run service logic directly for testing
        var svc = new YourServiceClass();
        try {
            svc.StartForConsole();    // call method that triggers OnStart behavior / timer
            Console.WriteLine("Running in console mode. Press Enter to exit.");
            Console.ReadLine();
            svc.StopForConsole();
        }
        catch (Exception ex) {
            Console.WriteLine(ex);
        }
    }
    else
    {
        ServiceBase.Run(new ServiceBase[] { new YourServiceClass() });
    }
}
