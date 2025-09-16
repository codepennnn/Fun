if (!string.IsNullOrWhiteSpace(emailTo))
{
    foreach (var addr in emailTo.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries))
    {
        mail.To.Add(addr.Trim());
    }
}
