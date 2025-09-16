string emailTo = string.Join(", ",
    new[] { row["EMAIL_ID"].ToString(), row["V_Email"].ToString() }
    .Where(s => !string.IsNullOrWhiteSpace(s))
);
